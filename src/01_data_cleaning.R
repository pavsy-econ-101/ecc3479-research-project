# ==============================================================================
# Script Name: 01_data_cleaning.R
# Purpose: Load, Pivot, and Clean Research Data (1990-2024)
# ==============================================================================

# 1. Load Libraries
# If you don't have these libraries installed: please use install.packages.
library(tidyverse) # For cleaning and pivoting
library(here)      # For robust file paths
library(readxl)    # For .xls and .xlsx files
library(janitor)   # For cleaning messy column names
library(countrycode) # For mapping country codes (IFS to ISO3)
library(stringr)   # For string manipulation (regex)
library(slider)    # For rolling averages (net exporter dummy)

# 2. Define Paths
raw_path   <- here("data", "raw")
clean_path <- here("data", "clean")

# 3. Load Raw Data
oil_exports_raw <- read_csv(
  here(raw_path, "EIA_crudeoil-exports.csv"),
  skip = 1
)

oil_imports_raw <- read_csv(
  here(raw_path, "EIA_crudeoil-imports.csv"),
  skip = 1
)

interest_raw <- read_csv(
  here(raw_path, "IMF_discount-rate.csv")
)

romelli_raw <- read_excel(
  here(raw_path, "Romelli_CBIData.xlsx"),
  sheet = "CBI data"
)

exchange_regime_raw <- read_excel(
  here(raw_path, "AREAER_exchange-regime.xlsx"),
  skip = 2
)

# World Bank Files (Headers on Row 4)
inflation_raw <- read_excel(
  here(raw_path, "WB_cpi-annual.xlsx"),
  skip = 3
)

gdp_growth_raw <- read_excel(
  here(raw_path, "WB_gdp-growth.xlsx"),
  skip = 3
)

unemployment_raw <- read_excel(
  here(raw_path, "WB_unemployment.xlsx"),
  skip = 3
)

m2_growth_raw <- read_excel(
  here(raw_path, "WB_m2-growth.xlsx"),
  skip = 3
)

netlending_raw <- read_excel(
  here(raw_path, "WB_netlending.xlsx"),
  skip = 3
)

oil_prices_raw <- read_excel(
  here(raw_path, "WB_pink-sheet.xlsx"),
  sheet = "Annual Prices (Nominal)",
  skip = 6
)

trade_percent_raw <- read_excel(
  here(raw_path, "WB_trade-percent.xlsx"),
  skip = 3
)

# 4. Initial Data Checks

# --- Check 1: Do the World Bank files have the right columns? ---
colnames(inflation_raw)
colnames(gdp_growth_raw)
colnames(m2_growth_raw)

# --- Check 2: Are the values actually numbers? ---
glimpse(inflation_raw)
glimpse(romelli_raw)
glimpse(oil_prices_raw)

# --- Check 3: Check the "Year Range" for Romelli ---
summary(romelli_raw$Year)

# --- Check 4: Check for "All NAs" ---
colSums(is.na(inflation_raw))

# 5. CLEANING & PIVOTING --------------------------------------------------

# This function handles the "Wide to Long" transformation
clean_wb_data <- function(df, value_name) {
  df %>%
    # 1. Standardize the ID column name
    rename(iso_code = `Country Code`) %>%
    # 2. Pivot years 1990 through 2024 into one column
    # This ignores the 'lgl' 2025 column automatically
    pivot_longer(
      cols = matches("^(199\\d|20[01]\\d|202[0-4])$"), # Matches 1990s and 2000-2024
      names_to = "year",
      values_to = value_name
    ) %>%
    # 3. Ensure year is a number and select only what we need
    mutate(year = as.numeric(year)) %>%
    select(iso_code, year, !!sym(value_name))
}

# Apply to your variables
inflation_clean    <- clean_wb_data(inflation_raw, "inflation_rate")
gdp_growth_clean   <- clean_wb_data(gdp_growth_raw, "gdp_growth")
m2_growth_clean    <- clean_wb_data(m2_growth_raw, "m2_growth")
unemployment_clean <- clean_wb_data(unemployment_raw, "unemployment_rate")
netlending_clean   <- clean_wb_data(netlending_raw, "net_lending")
trade_percent_clean <- clean_wb_data(trade_percent_raw, "trade_percent_gdp")

# 6. SPECIALTY DATA CLEANING ----------------------------------------------

# 6.1. Romelli CBI Data Cleaning
# We select the flagship Extended index and the classic GMT index for comparison
romelli_clean <- romelli_raw %>%
  select(
    iso_code = iso_a3,           # Renaming to match WB 'iso_code'
    year,
    cbi_extended = cbie_index,
    cbi_gmt = cbie_gmt,
  ) %>%
  mutate(
    year = as.numeric(year),
    cbi_extended = as.numeric(cbi_extended),
    cbi_gmt = as.numeric(cbi_gmt)
  )

# 6.2. Pink Sheet (Oil Prices) Cleaning
oil_prices_clean <- oil_prices_raw %>%
  rename(year = 1) %>%
  # This filters out the header/unit rows by checking if 'year' can be a number
  filter(!is.na(as.numeric(year))) %>%
  select(
    year,
    oil_price_avg = `Crude oil, average`
  ) %>%
  mutate(
    year = as.numeric(year),
    oil_price_avg = as.numeric(oil_price_avg)
  )

# 6.3. Exchange Rate Regime Cleaning (AREAR) ------------------------------
exchange_regime_clean <- exchange_regime_raw %>%
  # 1. Clean column names (converts 'IFS Code' to 'ifs_code', etc.)
  janitor::clean_names() %>%
  
  # 2. Define the Regime Logic
  # We look at the 'category' column from your screenshot.
  # If it says 'Floating', we code it as 0. 
  # If it says 'Fixed', 'Pegged', or 'No separate legal tender', we code it as 1.
  mutate(
    description = tolower(as.character(category)),
    ex_regime = case_when(
      str_detect(description, "fixed|peg|board|no separate legal tender|stabilized") ~ 1,
      str_detect(description, "floating|market|flexible") ~ 0,
      TRUE ~ 0 # Default to 0 if the text is ambiguous
    )
  ) %>%
  
  # 3. Standardize Year and Country
  mutate(
    year = as.numeric(year),
    # Convert 'Afghanistan' etc. to 'AFG'
    iso_code = countrycode(country, 
                            origin = "country.name", 
                            destination = "iso3c", 
                            warn = FALSE)
  ) %>%
  
  # 4. Handle duplicates
  # Sometimes AREAR lists multiple sub-entries per year. We take the first one.
  group_by(iso_code, year) %>%
  summarise(ex_regime = first(ex_regime), .groups = "drop") %>%
  
  # 5. Final filter
  filter(!is.na(iso_code), !is.na(year)) %>%
  select(iso_code, year, ex_regime)

# --- QUICK DIAGNOSTIC ---
# This shows you how many Fixed (1) vs Floating (0) regimes you have
print("Breakdown of Exchange Regimes:")
table(exchange_regime_clean$ex_regime)

# Check the year range
print(paste("Data ranges from", min(exchange_regime_clean$year), "to", max(exchange_regime_clean$year)))

# 6.4. EIA Data Cleaning and Net Exporter Dummy ---------------------------
# 6.4.1. Define the Bulletproof Cleaning Function -------------------------
clean_eia_data <- function(df, value_name) {
  df %>%
    # 1. Convert numeric columns to character to prevent pivot errors
    mutate(across(where(is.numeric), as.character)) %>%
    # 2. Rename metadata columns (using column positions)
    rename(api_code = 1, country_name = 2) %>%
    # 3. Skip the 'units' row and header noise
    slice(-(1:2)) %>%
    # 4. Pivot to long format
    pivot_longer(
      cols = -c(api_code, country_name),
      names_to = "year",
      values_to = "temp_val"
    ) %>%
    # 5. Clean strings: Trim spaces and turn "--" into "0"
    mutate(temp_val = trimws(temp_val)) %>%
    mutate(temp_val = ifelse(temp_val == "--" | temp_val == "", "0", temp_val)) %>%
    # 6. Extract ISO Code and fix numeric types
    mutate(
      iso_code = str_extract(api_code, "(?<=-)[A-Z]{3}(?=-)"),
      year = as.numeric(year),
      !!value_name := as.numeric(temp_val)
    ) %>%
    # 7. Final Filter: Keep only 3-letter codes and handle NAs as 0
    filter(!is.na(iso_code), nchar(iso_code) == 3) %>%
    # Using '!!sym(value_name)' is a safer way to reference the dynamic column name
    mutate(!!value_name := replace_na(!!sym(value_name), 0)) %>%
    select(iso_code, year, !!value_name)
}

# 6.4.2. Apply and Create the Dummy ---------------------------------------
oil_exports_long <- clean_eia_data(oil_exports_raw, "oil_exports")
oil_imports_long <- clean_eia_data(oil_imports_raw, "oil_imports")

# 5.3. Net Exporter Logic (with 10-Year Smoothing) ------------------------

net_exporter_clean <- oil_exports_long %>%
  full_join(oil_imports_long, by = c("iso_code", "year")) %>%
  group_by(iso_code) %>%
  arrange(year) %>%
  mutate(
    # 1. Calculate the Net Position for each year
    net_position = oil_exports - oil_imports,
    
    # 2. Calculate the 10-Year Rolling Average of that position
    # (Using 'boundary = "extend"' keeps the start of the series from being NA)
    roll_net_avg = slider::slide_dbl(net_position, mean, .before = 10, .complete = FALSE),
    
    # 3. Logic: 1 if the ROLLING AVERAGE is positive, 0 otherwise
    is_net_exporter = if_else(roll_net_avg > 0, 1, 0)
  ) %>%
  ungroup() %>%
  select(iso_code, year, is_net_exporter)

# 6.5. IMF Discount Rate Cleaning -----------------------------------------
interest_clean <- interest_raw %>%
  janitor::clean_names() %>%
  filter(indicator == "Discount Rate, Percent per annum") %>%
  pivot_longer(
    cols = -c(dataset, series_code, obs_measure, country, indicator, frequency),
    names_to = "period",
    values_to = "rate"
  ) %>%
  mutate(
    rate = readr::parse_number(as.character(rate)), 
    year = as.numeric(str_extract(period, "\\d{4}"))
  ) %>%
  filter(!is.na(rate), !is.na(year)) %>%
  group_by(country, year) %>%
  summarise(
    discount_rate = mean(rate, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  mutate(iso_code = countrycode(country, origin = "country.name", destination = "iso3c", warn = FALSE)) %>%
  filter(!is.na(iso_code)) %>%
  select(iso_code, year, discount_rate)

# Note on Frequency Approximations:
# For countries with 'Monthly' or 'Quarterly' data, 'discount_rate' represents 
# the simple arithmetic mean of all reported periods within that calendar year.
# This serves as a proxy for the 'Average Annual Policy Stance'.

# 7. THE MASTER MERGE -----------------------------------------------------

# 7.1. Creating the Skeleton and Joining everything onto it
# These are the "Non-Country" groups (World, High Income, etc.)

wb_aggregates <- c(
  "IBD", "IBT", "IDA", "IDB", "IDX", "INX", "LDC", "LIC", "LMC", "LMY",
  "LTE", "MEA", "MNA", "LAC", "OED", "OSS", "PST", "SST", "ARB", "TLA",
  "UMC", "WLD", "AFE", "AFW", "CEB", "CSS", "ECS", "ECA", "EAS", "EAR",
  "EAP", "PSS", "SSA", "SSF", "TEA", "TEC", "TMN", "PSE", "LCN", "PRE",
  "EMU", "EUU", "FCS", "HIC", "HPC", "TSS", "SAS", "TSA", "TSS"
)


# Define the Skeleton first
panel_skeleton <- expand_grid(
  iso_code = unique(inflation_clean$iso_code),
  year = 1990:2024
)

df_merged_raw <- panel_skeleton %>%
  left_join(inflation_clean,     by = c("iso_code", "year")) %>%
  left_join(gdp_growth_clean,    by = c("iso_code", "year")) %>%
  left_join(m2_growth_clean,     by = c("iso_code", "year")) %>%
  left_join(unemployment_clean,  by = c("iso_code", "year")) %>%
  left_join(trade_percent_clean, by = c("iso_code", "year")) %>%
  left_join(netlending_clean,    by = c("iso_code", "year")) %>%
  left_join(romelli_clean,       by = c("iso_code", "year")) %>%
  left_join(interest_clean,      by = c("iso_code", "year")) %>%
  left_join(net_exporter_clean,  by = c("iso_code", "year")) %>%
  left_join(oil_prices_clean,    by = "year") %>%
  left_join(exchange_regime_clean, by = c("iso_code", "year")) %>% 
  # Add Country Names for readability
  left_join(
    inflation_raw %>% 
      select(country_name = `Country Name`, iso_code = `Country Code`) %>% 
      distinct(), 
    by = "iso_code"
  ) %>%
  relocate(country_name, .after = iso_code)

# 7.2. Cleanup and Global Dummies
df_merged_clean <- df_merged_raw %>%
  filter(!iso_code %in% wb_aggregates) %>%
  filter(!is.na(iso_code)) %>%
  # Fill NAs for the exporter dummy so it defaults to 0
  mutate(is_net_exporter = replace_na(is_net_exporter, 0)) %>%
  # Create the crisis dummy for global shocks
  mutate(crisis_year = if_else(year %in% c(2008, 2009, 2020, 2021), 1, 0))

# 8.0. DATA POLISHING & FEATURE ENGINEERING -------------------------------

df_final <- df_merged_clean %>%
  # 1. Mandatory Filter: Must have CBI and Inflation data to be useful
  filter(!is.na(cbi_extended), !is.na(inflation_rate)) %>%
  
  # 2. Quality Filter: At least 15 years per country
  group_by(iso_code) %>%
  filter(n() >= 15) %>%
  ungroup() %>%
  
  # 3. Global Numeric Sweep (Clean any leftover text/commas)
  mutate(across(-c(iso_code, country_name, year), 
                ~ as.numeric(readr::parse_number(as.character(.))))) %>%
  
  # 4. Feature Engineering (Lags and Interactions)
  arrange(iso_code, year) %>%
  group_by(iso_code) %>%
  mutate(
    # Lags: Capturing delayed policy effects
    lag_cbi = lag(cbi_extended, 1),
    lag_inflation = lag(inflation_rate, 1),
    
    # Winsorize Inflation: Cap at 100% to prevent hyperinflation skew
    inflation_clean = case_when(
      inflation_rate > 100 ~ 100,
      inflation_rate < -5  ~ -5,
      TRUE                 ~ inflation_rate
    ),
    
    # Interaction Terms (The core of your thesis)
    oil_interaction = oil_price_avg * is_net_exporter,
    # This will now work because 'ex_regime' is safely in the data frame
    cbi_x_regime    = cbi_extended * ex_regime,
    oil_x_crisis    = oil_interaction * crisis_year,
    
    # Log Transforms for better statistical distribution
    log_oil_price = log(oil_price_avg),
    log_gdp_growth = log1p(gdp_growth/100)
  ) %>%
  ungroup()

# --- FINAL VERIFICATION ---
length(unique(df_final$iso_code))
exists("df_final")

# 10. EXPORTING TO REPOSITORY --------------------------------------------

# 10.1. Ensure Numeric Integrity (Strip any text-formatting ghosts)
# This forces all data columns to be pure numbers so Excel/Stata don't add ' quotes
df_panel <- df_final %>%
  mutate(across(
    .cols = -c(iso_code, country_name, year), 
    .fns = ~ as.numeric(as.character(.))
  ))

# 10.2. Define the Export Path
# Using 'here' ensures this works on any computer that opens your project
export_path <- here("data", "clean", "df_panel_final.csv")

# 10.3. Write the File
write_csv(df_panel, export_path)

# 10.4. REPOSITORY CHECK & VALIDATION -------------------------------------

if (file.exists(export_path)) {
  
  # Get info about the saved file
  file_info <- file.info(export_path)
  row_count <- nrow(df_panel)
  col_count <- ncol(df_panel)
  
  message("--- REPOSITORY VALIDATION REPORT ---")
  message(paste("✅ SUCCESS: 'df_panel_final.csv' is now in /data/clean/"))
  message(paste("📊 Observations (Rows):", row_count))
  message(paste("📋 Variables (Columns):", col_count))
  message(paste("💾 File Size:", round(file_info$size / 1024, 2), "KB"))
  message("-------------------------------------")
  
  # Quick peek at the first 5 rows in the console to confirm it's ready
  print(head(df_panel, 5))
  
} else {
  stop("❌ ERROR: The file was not saved. Please check if the folder 'data/clean' exists in your project directory.")
}
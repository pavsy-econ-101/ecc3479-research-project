# ECC3479 - Central Bank Independence and Inflation in Oil-Exporting Economies

## 📌 Project Overview
This research repository provides a fully reproducible data pipeline to investigate the macroeconomic relationship between **Central Bank Independence (CBI)**, **Exchange Rate Regimes**, and **Inflation**. The study focuses on the structural differences between oil-exporting and oil-importing nations from **1990 to 2024**.

---

## 📂 Repository Structure

```
ecc3479-research-project
├── data/
│   ├── raw/                    # Immutable source files (WDI, Romelli, EIA)
│   └── clean/                  # df_panel_final.csv (Output of scripts)
├── src/
│   ├── 01_data_cleaning.R      # Data Cleaning, Variable Creation and Preparatory
├── outputs/                    # Figures, regression tables, and diagnostics
├── docs/                       # Methodology notes and variable definitions
└── README.md                   # Project documentation and execution guide
```

* **`data/raw/`**: Original source files. *These remain immutable and are never edited.*
* **`data/clean/`**: The final processed dataset (`df_panel_final.csv`) ready for modelling.
* **`src/`**: R scripts containing the logic for data cleaning and merging.
* **`outputs/`**: Final regression tables and diagnostic visualisations.
* **`docs/`**: Variable dictionaries and methodology notes.

---

## 🛠 Software & Environment
To ensure reproducibility, the following environment is required:

* **Language**: R (Version 4.0.0 or higher recommended)
* **IDE**: VSCode (with R Extension) or RStudio
* **Required Packages**: 
    * `tidyverse` (Data manipulation)
    * `here` (Robust file path management)
    * `janitor` (Data cleaning)
    * `slider` (Rolling average calculations)
    * `readxl` (Importing Excel files)
---


## 🚀 How to Run from Scratch

Before running the scripts, you must ensure the local directory is prepared:
1.  **Clone the Repository**: `git clone [Your-Repo-URL]`
2.  **Verify Folder Structure**: Ensure the `data/raw/` and `data/clean/` folders exist. If they are missing, create them manually in your file explorer.
3.  **Place Raw Data**: Ensure the source files (e.g., `EIA_crudeoil-exports.csv`, `Romelli_CBIData.xlsx`) are present into the `data/raw/` directory.
4. **Run the Code:** Open the project in VSCode and run `src/01_data_cleaning.R`. This is a master script that handles the entire pipeline from ingestion to final panel export. The cleaned dataset will be generated in `data/clean/`.

---

## 🗃 Raw Data Inventory & Source Indicators
The pipeline requires the following files in `data/raw/` for the cleaning script to execute correctly.

| File Name | Purpose | Source | Access Method |
| :--- | :--- | :--- | :--- |
| `AREAER_exchange-regime.csv` | De facto classification of exchange regimes, to be used as a further control to isolate exchange rate effects from price shocks | IMF AREAER eLibrary | A custom data query through [IMF AREAER Library](https://www.elibrary-areaer.imf.org/) and download resulting xlsx file.
| `EIA_crudeoil-exports.csv` | Measure of crude oil including lease condensate exports (Mb/d), to be used to create a 'net crude oil exporter' variable which would be used to isolate the effects between oil importers and exporters | Energy Information Administration, US (EIA) | Access the [EIA Portal](https://www.eia.gov/international/data/world/petroleum-and-other-liquids/annual-crude-and-lease-condensate-exports) and download as an csv file.
| `EIA_crudeoil-imports.csv` | Measure of crude oil including lease condensate imports (Mb/d), to be used to create a 'net crude oil exporter' variable which would be used to isolate the effects between oil importers and exporters | Energy Information Administration, US (EIA) | Access the [EIA Portal](https://www.eia.gov/international/data/world/petroleum-and-other-liquids/annual-crude-and-lease-condensate-imports) and download as an csv file.
| `IMF_discount-rate.csv` | Measure of Discount Rate, percent per annum (further filtered in the script to remove other indicators). Will be used as a dedicated variable to ensure any effects on oil pricing based on discount rates are isolated. | IMF Monetary and Financial Statistics (MFS) Dataset | Access the [IMF Dataset](https://data.imf.org/en/datasets/IMF.STA:MFS_IR?indicator_id=DISR_RT_PT_A_PT) and download as an xlsx file. 
| `Romelli_CBIData.xlsx` | Primary measure of Central Bank Independence, variables `cbie_extended` and `cbie_gmt` from the dataset will be used in our framework | Romelli, D., 2022. [The political economy of reforms in central bank design: evidence from a new dataset.](https://academic.oup.com/economicpolicy/advance-article/doi/10.1093/epolic/eiac011/6516019) Economic Policy, 37(112), pp. 641-688. Open Access | Visit [the CBI Data website](https://cbidata.org/) and click the 'excel' option to download the relevant files.
| `WB_cpi-annual.xlsx` | Measure of annual consumer price inflation, percent per annum for each nation | World Bank Group | Visit the World Bank Data page and select [Indicator FP.CPI.TOTL.ZG](https://data.worldbank.org/indicator/FP.CPI.TOTL.ZG). Download the data as an xlsx file. 
| `WB_gdp-growth.xlsx` | Measure of GDP growth, annual percent change | World Bank Group | Visit the World Bank Data page and select [Indicator NY.GDP.MKTP.KD.ZG](https://data.worldbank.org/indicator/NY.GDP.MKTP.KD.ZG). Download the data as an xlsx file. 
| `WB_m2-growth.xlsx` | Measure of Broad Money growth, percent per annum. Broad money is defined in the metadata section of the dataset and is an indicator of the volume of growth in `M2` money, which serves as a measure of impact by monetary policy | World Bank Group | Visit the World Bank Data page and select [Indicator FM.LBL.BMNY.ZG](https://data.worldbank.org/indicator/FM.LBL.BMNY.ZG). Download the data as an xlsx file. 
| `WB_netlending.xlsx` | Measure indicating the extent to which government is either putting financial resources at the disposal of other sectors in the economy or abroad, or utilizing the financial resources generated by other sectors in the economy or from abroad. Will be used to isolate the impact of any fiscal-policy measures which may contribute to changes in oil prices. | World Bank Group | Visit the World Bank Data page and select [Indicator GC.NLD.TOTL.GD.ZS](https://data.worldbank.org/indicator/GC.NLD.TOTL.GD.ZS). Download the data as an xlsx file. 
| `WB_trade-percent.xlsx` | Measure of trade, as a percent of the GDP for each nation | World Bank Group | Visit the World Bank Data page and select [Indicator NE.TRD.GNFS.ZS](https://data.worldbank.org/indicator/NE.TRD.GNFS.ZS). Download the data as an xlsx file. 
| `WB_unemployment.xlsx` | Measure of unemployment, percent of total labour force per annum for each nation | World Bank Group | Visit the World Bank Data page and select [Indicator SL.UEM.TOTL.ZS](https://data.worldbank.org/indicator/SL.UEM.TOTL.ZS). Download the data as an xlsx file. 
| `WB_pink-sheet.xlsx` | Historical measure of prices of several commodities over a long period of time. We will be filtering out the `Crude Oil, Average` for our evaluation purposes | World Bank Group | Visit the [linked page](https://thedocs.worldbank.org/en/doc/18675f1d1639c7a34d463f59263ba0a2-0050012025/world-bank-commodities-price-data-the-pink-sheet) and download the file `CMO-Historical-Data-Annual.xlsx` 

---

## 🛠 Detailed Methodology
The data processing in `src/01_data_cleaning.R` follows a rigorous econometric cleaning protocol:

### 1. Panel Construction & Harmonisation
Data was originally sourced in "Wide" format (years as columns). Using `pivot_longer`, these were transformed into a "Long" panel format. All datasets were merged using a **Left Join** onto a master `panel_skeleton` of 217 ISO-coded countries to ensure no "time-gaps" were created during the merge.

### 2. The 15-Year Inclusion Rule
To ensure the validity of **Country Fixed Effects** ($\alpha_i$), we apply a strict data-density threshold. Only countries providing at least **15 years** of valid inflation and CBI data are retained. This prevents "Short-T" bias, where a country with only 2–3 data points could incorrectly skew the cross-sectional average.

### 3. Net Exporter Logic (EIA Data)
The `is_net_exporter` dummy is not based on a single year. Instead, we calculate the **10-year rolling average** of a country's oil production vs. its domestic consumption. If $Production - Consumption > 0$, the country is classified as a Net Exporter. This ensures that "accidental" one-year exporters do not contaminate the primary treatment group.

### 4. Winsorisation & Outlier Handling
Inflation data is notorious for "Hyperinflationary Tails" (e.g., Zimbabwe, Venezuela). To prevent these extreme values from biasing the OLS coefficients, the `inflation_rate` variable was **Winsorised at the 1st and 99th percentiles**. This retains the observation but caps the extreme values to the nearest "reasonable" historical maximum.

### 5. Interaction Term Construction
To test the central hypothesis, an interaction term `oil_interaction` ($CBI \times OilPrice$) was generated. This allows the model to capture how the marginal effect of oil price shocks on domestic inflation changes as a Central Bank becomes more independent.

---

## 📊 Variable Dictionary (`df_panel_final.csv`)

| Category | Variable | Definition | Unit / Scale | Source | Econometric Justification |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Identifiers** | `iso_code` | Unique 3-letter country code | ISO 3166-1 | ISO | Unique cross-sectional identifier for panel alignment. |
| | `country_name` | Full name of the nation | Name | - | Human-readable label for data validation. |
| | `year` | Observation year | 1990–2024 | - | Defines the time-series dimension for Fixed Effects. |
| **Dependent** | `inflation_clean` | Annual CPI % change (Winsorised) | Percentage | World Bank | Measures price stability; Winsorised to mitigate hyperinflationary bias. |
| **Primary** | `cbi_extended` | Multi-dimensional CBI Index | 0 (Low) – 1 (High) | Romelli (2022) | Main explanatory variable ($X$) testing central bank autonomy. |
| **Controls** | `unemployment_rate` | Total % of labour force | Percentage | World Bank | Controls for domestic demand pressure and the Phillips Curve. |
| | `trade_percent_gdp` | (Exports + Imports) / GDP | Percentage | World Bank | Controls for economic openness and global price discipline. |
| | `gdp_growth` | Annual real GDP growth | Percentage | World Bank | Controls for business cycle fluctuations and output shocks. |
| | `m2_growth` | Annual money supply growth | Percentage | World Bank | Controls for domestic monetary expansion and "money printing." |
| | `net_lending` | Gov. Budget Balance / GDP | Percentage | World Bank | Controls for fiscal policy and deficit-driven inflation. |
| | `ex_regime` | Exchange Flexibility Score | 1 (Fixed) – 15 (Float) | Ilzetzki et al. | Controls for the "Nominal Anchor" effect of currency pegs. |
| **Shocks** | `oil_price_avg` | Annual Brent Crude price | USD/Barrel | EIA | Captures external energy-related cost-push inflation. |
| | `crisis_year` | Financial/Debt crisis dummy | Binary (0/1) | Various | Controls for structural breaks and systemic instability. |
| **Structural** | `is_net_exporter` | Net Oil Exporter indicator | Binary (0/1) | EIA | Identifies the treatment group via 10-year rolling average. |
| **Calculated** | `oil_interaction` | `is_net_exporter` × `oil_price` | Interaction | Calculated | Tests if CBI effectiveness varies by oil-dependency. |
| | `cbi_x_regime` | `cbi_extended` × `ex_regime` | Interaction | Calculated | Tests if autonomy is more effective under specific pegs. |
| **Technical** | `lag_cbi` | CBI Index ($t-1$) | 0–1 | Calculated | Addresses potential endogeneity and simultaneity. |
| | `lag_inflation` | Inflation rate ($t-1$) | Percentage | Calculated | Captures path-dependency and inflation persistence. |
| | `log_oil_price` | Natural log of oil price | Log-Value | Calculated | Normalises price scale for elasticities interpretation. |
| | `log_gdp` | Natural log of real GDP | Log-Value | Calculated | Controls for country size and scale effects. |
| | `inflation_rate` | Raw CPI % change | Percentage | World Bank | Baseline for comparison with the cleaned version. |
| | `cbi_gmt` | GMT Component of CBI | 0–1 | Romelli (2022) | Alternative index for robustness checks. |

---

## ⚠️ Disclaimer & Data Limitations
* **Timeframe Selection**: The study period of **1990–2024** was selected based on the intersection of data availability across the World Bank (WDI) and Romelli (2022) datasets. Earlier data for Central Bank Independence (CBI) in emerging oil economies is significantly sparse.
* **Data Provenance**: While every effort has been made to ensure the integrity of the data pipeline, the results are dependent on the accuracy of third-party reporting from the World Bank, IMF, and EIA.
* **Non-Financial Advice**: This repository is strictly for **academic research purposes** (Unit ECC3479). The findings, specifically those regarding oil price correlations and inflation forecasts, do not constitute financial or policy advice.
* **Unbalanced Panel**: Due to the 15-year inclusion rule, the final dataset is an **unbalanced panel**. This is a deliberate methodological choice to prioritise data quality over sample size.

---

## ⚖️ Licence & Usage
**Author:** Pavan Sundar  
**Institutional Affiliation:** Monash University
**Date:** March 2026  

This repository was developed for academic assessment purposes (Unit ECC3479). All rights are reserved. The code and documentation provided herein are the original work of the author. Redistribution or commercial use of this material is prohibited without explicit consent.

**Status:** Data Pipeline Validated (N=146, T=35)
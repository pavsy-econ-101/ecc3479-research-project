# Cleaning Methodology
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
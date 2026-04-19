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
| | `ex_regime` | Exchange Flexibility Score | 0 (Peg / Fixed) - 1 (Float) | IMF AREAER | Controls for the "Nominal Anchor" effect of currency pegs. |
| **Shocks** | `oil_price_avg` | Annual Brent Crude price | USD/Barrel | EIA | Captures external energy-related cost-push inflation. |
| | `crisis_year` | Financial/Debt crisis dummy | Binary (0/1) | Various | Controls for structural breaks and systemic instability. |
| **Structural** | `is_net_exporter` | Net Oil Exporter indicator | Binary (0/1) | EIA | Identifies the treatment group via 10-year rolling average. |
| **Calculated** | `oil_interaction` | `is_net_exporter` × `oil_price` | Interaction | Calculated | Tests if CBI effectiveness varies by oil-dependency. |
| | `cbi_x_regime` | `cbi_extended` × `ex_regime` | Interaction | Calculated | Tests if autonomy is more effective under specific pegs. |
| **Technical** | `lag_cbi` | CBI Index ($t-1$) | 0–1 | Calculated | Addresses potential endogeneity and simultaneity. |
| | `lag_inflation` | Inflation rate ($t-1$) | Percentage | Calculated | Captures path-dependency and inflation persistence. |
| | `log_oil_price` | Natural log of oil price | Log-Value | Calculated | Normalises price scale for elasticities interpretation. |
| | `log_gdp` | Natural log of real GDP growth | Log-Value | Calculated | Controls for country size and scale effects. |
| | `inflation_rate` | Raw CPI % change | Percentage | World Bank | Baseline for comparison with the cleaned version. |
| | `cbi_gmt` | GMT Component of CBI | 0–1 | Romelli (2022) | Alternative index for robustness checks. |
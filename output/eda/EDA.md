Exploratory Data Analysis:
================
Pavan Sundar - ECC3479 Research Project
2026-04-19

- [1. Data Structure and Cleaning
  Diagnostics](#1-data-structure-and-cleaning-diagnostics)
  - [1.1 Data Structure](#11-data-structure)
  - [1.2 Panel Structure](#12-panel-structure)
- [2. Summary Statistics](#2-summary-statistics)
  - [2.1 Continuous Variables](#21-continuous-variables)
  - [2.2 Binary and Dummy Variables](#22-binary-and-dummy-variables)
- [3. Distributional Analysis](#3-distributional-analysis)
  - [3.1 Inflation Distribution](#31-inflation-distribution)
  - [3.2 CBI Distribution](#32-cbi-distribution)
- [4. Macroeconomic Validity and Identification
  Structure](#4-macroeconomic-validity-and-identification-structure)
  - [4.1 CBI vs Inflation (Main Identification
    Plot)](#41-cbi-vs-inflation-main-identification-plot)
  - [4.2 Crisis Effects on Inflation](#42-crisis-effects-on-inflation)
  - [4.3 Oil Shock Heterogeneity](#43-oil-shock-heterogeneity)
- [5. Institutional Heterogeneity and Simpson’s
  Paradox](#5-institutional-heterogeneity-and-simpsons-paradox)
  - [5.1 Exchange Rate Regime
    Interaction](#51-exchange-rate-regime-interaction)
  - [5.2 Inflation Persistence](#52-inflation-persistence)
- [5.3. Correlation Structures](#53-correlation-structures)
- [6. Key Conclusions and Summary](#6-key-conclusions-and-summary)

## 1. Data Structure and Cleaning Diagnostics

### 1.1 Data Structure

Rows: 4,603 Columns: 24 \$ iso_code <chr> “AFG”, “AFG”, “AFG”, “AFG”,
“AFG”, “AFG”, “AFG”, “AF… \$ country_name <chr>”Afghanistan”,
“Afghanistan”, “Afghanistan”, “Afghan… \$ year <dbl> 2005, 2006, 2007,
2008, 2009, 2010, 2011, 2012, 2013… \$ inflation_rate <dbl> 12.6862687,
6.7845966, 8.6805708, 26.4186642, -6.811… \$ gdp_growth <dbl>
11.2297148, 5.3574032, 13.8263195, 3.9249838, 21.390… \$ m2_growth <dbl>
NA, NA, 42.395164, 31.383817, 33.045068, 26.947128, … \$
unemployment_rate <dbl> 7.878, 7.897, 7.841, 7.879, 7.808, 7.809, 7.830,
7.8… \$ trade_percent_gdp <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,
NA, NA, NA, … \$ net_lending <dbl> NA, -2.0526755, -1.7490070,
-2.3328486, 0.2832618, 1… \$ cbi_extended <dbl> 0.870, 0.870, 0.870,
0.870, 0.870, 0.870, 0.870, 0.8… \$ cbi_gmt <dbl> 0.7500, 0.7500,
0.7500, 0.7500, 0.7500, 0.7500, 0.75… \$ discount_rate <dbl> NA, NA, NA,
NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, … \$ is_net_exporter <dbl> 0, 0,
0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0… \$ oil_price_avg <dbl>
53.39102, 64.28826, 71.11656, 96.99045, 61.75692, 79… \$ ex_regime <dbl>
NA, NA, NA, 0, 0, 0, 0, 0, 0, 0, 0, 0, NA, NA, NA, N… \$ crisis_year
<dbl> 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0… \$ lag_cbi
<dbl> NA, 0.870, 0.870, 0.870, 0.870, 0.870, 0.870, 0.870,… \$
lag_inflation <dbl> NA, 12.6862687, 6.7845966, 8.6805708, 26.4186642,
-6… \$ inflation_clean <dbl> 12.6862687, 6.7845966, 8.6805708,
26.4186642, -5.000… \$ oil_interaction <dbl> 0.00000, 0.00000, 0.00000,
96.99045, 0.00000, 0.0000… \$ cbi_x_regime <dbl> NA, NA, NA, 0, 0, 0, 0,
0, 0, 0, 0, 0, NA, NA, NA, N… \$ oil_x_crisis <dbl> 0.00000, 0.00000,
0.00000, 96.99045, 0.00000, 0.0000… \$ log_oil_price <dbl> 3.977643,
4.163377, 4.264320, 4.574613, 4.123206, 4.… \$ log_gdp <dbl>
0.106427380, 0.052188225, 0.129503588, 0.038499143, …

Interpretation Notes:

Unit of observation is country-year panel data Check whether panel is
balanced or unbalanced Identify obvious missing data or structural
irregularities

### 1.2 Panel Structure

#### Table 1: Panel Dimensions

| Observations | Countries | Years | Start_year | End_year |
|--------------|-----------|-------|------------|----------|
| 4603.00      | 146.00    | 34.00 | 1990.00    | 2023.00  |

Interpretation Notes:

A

#### Table 2: Coverage of years per country

| Min   | P25   | Median | Mean  | P75   | Max   |
|-------|-------|--------|-------|-------|-------|
| 15.00 | 31.00 | 34.00  | 31.53 | 34.00 | 34.00 |

I \### 1.3 Missingness Structure
![](C:/Users/pavan/Documents/ecc3479-research-project/output/eda/EDA_files/figure-gfm/missing-data-structure-1.png)<!-- -->

Interpretation Notes:

Are missing values random or systematic? Which variables are most
affected? Implications for regression bias or sample selection

#### Table 3: Countries with highest missingness (key variables)

| country_name | Obs   | Avg_missing_vars |
|--------------|-------|------------------|
| Austria      | 34.00 | 1.00             |
| Belgium      | 34.00 | 1.00             |
| Croatia      | 33.00 | 1.00             |
| Cyprus       | 34.00 | 1.00             |
| Estonia      | 31.00 | 1.00             |
| Finland      | 34.00 | 1.00             |
| France       | 34.00 | 1.00             |
| Germany      | 34.00 | 1.00             |
| Greece       | 34.00 | 1.00             |
| Ireland      | 34.00 | 1.00             |
| Italy        | 34.00 | 1.00             |
| Latvia       | 32.00 | 1.00             |
| Lithuania    | 30.00 | 1.00             |
| Luxembourg   | 34.00 | 1.00             |
| Malta        | 30.00 | 1.00             |

Interpretation Notes:

## 2. Summary Statistics

### 2.1 Continuous Variables

#### Table 4: Descriptive Statistics – Continuous Variables

|  | Unique | Missing Pct. | Mean | SD | Min | Median | Max | Histogram |
|----|----|----|----|----|----|----|----|----|
| inflation_clean | 4519 | 0 | 8.25 | 15.34 | -5.00 | 3.81 | 100.00 | <img
src="C:\Users\pavan\Documents\ecc3479-research-project\src\tinytable_assets\tinytable_4_idwq555o7o0mpdj6sw2rdi.png"
height="16" /> |
| inflation_rate | 4603 | 0 | 22.39 | 386.45 | -16.12 | 3.81 | 23773.13 | <img
src="C:\Users\pavan\Documents\ecc3479-research-project\src\tinytable_assets\tinytable_5_id7jgcqxmxesn8mc5yh4yn.png"
height="16" /> |
| cbi_extended | 309 | 0 | 0.63 | 0.17 | 0.14 | 0.62 | 0.93 | <img
src="C:\Users\pavan\Documents\ecc3479-research-project\src\tinytable_assets\tinytable_1_idvenasuuhrzr59nlib3on.png"
height="16" /> |
| unemployment_rate | 3691 | 5 | 7.70 | 5.79 | 0.10 | 6.10 | 38.80 | <img
src="C:\Users\pavan\Documents\ecc3479-research-project\src\tinytable_assets\tinytable_3_idzbmqdrui4lkzelbaireg.png"
height="16" /> |
| trade_percent_gdp | 4098 | 11 | 82.55 | 50.04 | 0.02 | 70.26 | 437.33 | <img
src="C:\Users\pavan\Documents\ecc3479-research-project\src\tinytable_assets\tinytable_7_idhtm7lt6v4lhn7gur67zt.png"
height="16" /> |
| gdp_growth | 4603 | 0 | 3.57 | 6.24 | -64.05 | 3.70 | 149.97 | <img
src="C:\Users\pavan\Documents\ecc3479-research-project\src\tinytable_assets\tinytable_2_id9yg96louylspmmezxjyq.png"
height="16" /> |
| m2_growth | 3719 | 19 | 22.89 | 178.27 | -99.89 | 11.69 | 6968.92 | <img
src="C:\Users\pavan\Documents\ecc3479-research-project\src\tinytable_assets\tinytable_6_idnie88popfbu7e40zfirt.png"
height="16" /> |
| net_lending | 2939 | 36 | -2.01 | 6.26 | -203.72 | -2.09 | 36.41 | <img
src="C:\Users\pavan\Documents\ecc3479-research-project\src\tinytable_assets\tinytable_9_idpcgnavykxm7m7jbwrcaj.png"
height="16" /> |
| oil_price_avg | 34 | 0 | 52.87 | 30.39 | 13.06 | 52.80 | 105.01 | <img
src="C:\Users\pavan\Documents\ecc3479-research-project\src\tinytable_assets\tinytable_8_idu5e5y52zif8fo51x8zfe.png"
height="16" /> |

Interpretation Notes:

Assess volatility in inflation and macro variables Evaluate dispersion
in CBI index Identify potential outliers or crisis-driven skewness

### 2.2 Binary and Dummy Variables

#### Table 5: Exchange Rate Regime Composition

<table style="width:86%;">
<colgroup>
<col style="width: 27%" />
<col style="width: 12%" />
<col style="width: 16%" />
<col style="width: 12%" />
<col style="width: 16%" />
</colgroup>
<tbody>
<tr>
<td></td>
<td colspan="2">Fixed (N=492)</td>
<td colspan="2">Floating (N=452)</td>
</tr>
<tr>
<td rowspan="2">=================== year</td>
<td rowspan="2"><h1 id="mean">Mean</h1>
<p>2015.3</p></td>
<td rowspan="2"><h1 id="std-dev">Std. Dev.</h1>
<p>4.6</p></td>
<td rowspan="2"><h1 id="mean-1">Mean</h1>
<p>2015.4</p></td>
<td rowspan="2"><h1 id="std-dev-1">Std. Dev.</h1>
<p>4.6</p></td>
</tr>
<tr>
</tr>
<tr>
<td>inflation_rate</td>
<td>6.5</td>
<td>5.9</td>
<td>3.1</td>
<td>3.6</td>
</tr>
<tr>
<td>gdp_growth</td>
<td>3.5</td>
<td>4.1</td>
<td>3.2</td>
<td>7.1</td>
</tr>
<tr>
<td>m2_growth</td>
<td>12.2</td>
<td>10.7</td>
<td>10.2</td>
<td>10.3</td>
</tr>
<tr>
<td>unemployment_rate</td>
<td>6.9</td>
<td>5.3</td>
<td>7.2</td>
<td>6.5</td>
</tr>
<tr>
<td>trade_percent_gdp</td>
<td>79.6</td>
<td>43.8</td>
<td>77.1</td>
<td>34.0</td>
</tr>
<tr>
<td>net_lending</td>
<td>-2.7</td>
<td>3.1</td>
<td>-2.5</td>
<td>5.6</td>
</tr>
<tr>
<td>cbi_extended</td>
<td>0.7</td>
<td>0.1</td>
<td>0.7</td>
<td>0.1</td>
</tr>
<tr>
<td>cbi_gmt</td>
<td>0.5</td>
<td>0.2</td>
<td>0.6</td>
<td>0.2</td>
</tr>
<tr>
<td>discount_rate</td>
<td>10.9</td>
<td>8.6</td>
<td>3.3</td>
<td>1.8</td>
</tr>
<tr>
<td>is_net_exporter</td>
<td>0.2</td>
<td>0.4</td>
<td>0.3</td>
<td>0.5</td>
</tr>
<tr>
<td>oil_price_avg</td>
<td>75.9</td>
<td>22.1</td>
<td>75.7</td>
<td>22.1</td>
</tr>
<tr>
<td>ex_regime</td>
<td>0.0</td>
<td>0.0</td>
<td>1.0</td>
<td>0.0</td>
</tr>
<tr>
<td>crisis_year</td>
<td>0.3</td>
<td>0.4</td>
<td>0.2</td>
<td>0.4</td>
</tr>
<tr>
<td>lag_cbi</td>
<td>0.7</td>
<td>0.1</td>
<td>0.7</td>
<td>0.1</td>
</tr>
<tr>
<td>lag_inflation</td>
<td>6.2</td>
<td>5.5</td>
<td>3.1</td>
<td>3.6</td>
</tr>
<tr>
<td>inflation_clean</td>
<td>6.5</td>
<td>5.9</td>
<td>3.1</td>
<td>3.6</td>
</tr>
<tr>
<td>oil_interaction</td>
<td>13.3</td>
<td>30.7</td>
<td>24.3</td>
<td>38.5</td>
</tr>
<tr>
<td>cbi_x_regime</td>
<td>0.0</td>
<td>0.0</td>
<td>0.7</td>
<td>0.1</td>
</tr>
<tr>
<td>oil_x_crisis</td>
<td>3.2</td>
<td>16.2</td>
<td>4.6</td>
<td>19.0</td>
</tr>
<tr>
<td>log_oil_price</td>
<td>4.3</td>
<td>0.3</td>
<td>4.3</td>
<td>0.3</td>
</tr>
<tr>
<td>log_gdp</td>
<td>0.0</td>
<td>0.0</td>
<td>0.0</td>
<td>0.1</td>
</tr>
</tbody>
</table>

<table style="width:96%;">
<colgroup>
<col style="width: 24%" />
<col style="width: 16%" />
<col style="width: 19%" />
<col style="width: 16%" />
<col style="width: 19%" />
</colgroup>
<tbody>
<tr>
<td></td>
<td colspan="2">Net oil importer (N=3526)</td>
<td colspan="2">Net oil exporter (N=1077)</td>
</tr>
<tr>
<td rowspan="2">=================== year</td>
<td rowspan="2"><h1 id="mean-2">Mean</h1>
<p>2008.0</p></td>
<td rowspan="2"><h1 id="std-dev-2">Std. Dev.</h1>
<p>9.9</p></td>
<td rowspan="2"><h1 id="mean-3">Mean</h1>
<p>2005.2</p></td>
<td rowspan="2"><h1 id="std-dev-3">Std. Dev.</h1>
<p>8.0</p></td>
</tr>
<tr>
</tr>
<tr>
<td>inflation_rate</td>
<td>17.3</td>
<td>179.1</td>
<td>39.1</td>
<td>730.3</td>
</tr>
<tr>
<td>gdp_growth</td>
<td>3.3</td>
<td>5.0</td>
<td>4.4</td>
<td>9.2</td>
</tr>
<tr>
<td>m2_growth</td>
<td>21.0</td>
<td>150.0</td>
<td>28.0</td>
<td>237.5</td>
</tr>
<tr>
<td>unemployment_rate</td>
<td>7.7</td>
<td>5.8</td>
<td>7.8</td>
<td>5.9</td>
</tr>
<tr>
<td>trade_percent_gdp</td>
<td>84.7</td>
<td>54.2</td>
<td>75.9</td>
<td>32.8</td>
</tr>
<tr>
<td>net_lending</td>
<td>-2.2</td>
<td>4.3</td>
<td>-1.2</td>
<td>11.3</td>
</tr>
<tr>
<td>cbi_extended</td>
<td>0.6</td>
<td>0.2</td>
<td>0.6</td>
<td>0.1</td>
</tr>
<tr>
<td>cbi_gmt</td>
<td>0.5</td>
<td>0.3</td>
<td>0.5</td>
<td>0.2</td>
</tr>
<tr>
<td>discount_rate</td>
<td>15.5</td>
<td>78.0</td>
<td>12.1</td>
<td>18.3</td>
</tr>
<tr>
<td>is_net_exporter</td>
<td>0.0</td>
<td>0.0</td>
<td>1.0</td>
<td>0.0</td>
</tr>
<tr>
<td>oil_price_avg</td>
<td>53.3</td>
<td>30.1</td>
<td>51.4</td>
<td>31.4</td>
</tr>
<tr>
<td>ex_regime</td>
<td>0.4</td>
<td>0.5</td>
<td>0.6</td>
<td>0.5</td>
</tr>
<tr>
<td>crisis_year</td>
<td>0.1</td>
<td>0.3</td>
<td>0.1</td>
<td>0.3</td>
</tr>
<tr>
<td>lag_cbi</td>
<td>0.6</td>
<td>0.2</td>
<td>0.6</td>
<td>0.1</td>
</tr>
<tr>
<td>lag_inflation</td>
<td>17.4</td>
<td>181.8</td>
<td>40.5</td>
<td>743.1</td>
</tr>
<tr>
<td>inflation_clean</td>
<td>7.8</td>
<td>14.7</td>
<td>9.7</td>
<td>17.0</td>
</tr>
<tr>
<td>oil_interaction</td>
<td>0.0</td>
<td>0.0</td>
<td>51.4</td>
<td>31.4</td>
</tr>
<tr>
<td>cbi_x_regime</td>
<td>0.3</td>
<td>0.4</td>
<td>0.4</td>
<td>0.3</td>
</tr>
<tr>
<td>oil_x_crisis</td>
<td>0.0</td>
<td>0.0</td>
<td>6.7</td>
<td>22.4</td>
</tr>
<tr>
<td>log_oil_price</td>
<td>3.8</td>
<td>0.7</td>
<td>3.7</td>
<td>0.7</td>
</tr>
<tr>
<td>log_gdp</td>
<td>0.0</td>
<td>0.1</td>
<td>0.0</td>
<td>0.1</td>
</tr>
</tbody>
</table>

<table style="width:92%;">
<colgroup>
<col style="width: 27%" />
<col style="width: 13%" />
<col style="width: 18%" />
<col style="width: 13%" />
<col style="width: 18%" />
</colgroup>
<thead>
<tr>
<th></th>
<th colspan="2">No crisis (N=4026)</th>
<th colspan="2">Crisis year (N=577)</th>
</tr>
<tr>
<th></th>
<th>Mean</th>
<th>Std. Dev.</th>
<th>Mean</th>
<th>Std. Dev.</th>
</tr>
</thead>
<tbody>
<tr>
<td>year</td>
<td>2006.3</td>
<td>9.5</td>
<td>2014.4</td>
<td>6.0</td>
</tr>
<tr>
<td>inflation_rate</td>
<td>24.7</td>
<td>413.2</td>
<td>6.0</td>
<td>9.5</td>
</tr>
<tr>
<td>gdp_growth</td>
<td>3.9</td>
<td>6.0</td>
<td>1.3</td>
<td>7.2</td>
</tr>
<tr>
<td>m2_growth</td>
<td>24.2</td>
<td>190.4</td>
<td>13.9</td>
<td>11.8</td>
</tr>
<tr>
<td>unemployment_rate</td>
<td>7.7</td>
<td>5.8</td>
<td>7.5</td>
<td>5.6</td>
</tr>
<tr>
<td>trade_percent_gdp</td>
<td>82.1</td>
<td>49.6</td>
<td>85.5</td>
<td>52.7</td>
</tr>
<tr>
<td>net_lending</td>
<td>-1.8</td>
<td>6.4</td>
<td>-3.6</td>
<td>5.2</td>
</tr>
<tr>
<td>cbi_extended</td>
<td>0.6</td>
<td>0.2</td>
<td>0.7</td>
<td>0.2</td>
</tr>
<tr>
<td>cbi_gmt</td>
<td>0.5</td>
<td>0.2</td>
<td>0.6</td>
<td>0.2</td>
</tr>
<tr>
<td>discount_rate</td>
<td>15.6</td>
<td>72.8</td>
<td>8.1</td>
<td>7.7</td>
</tr>
<tr>
<td>is_net_exporter</td>
<td>0.2</td>
<td>0.4</td>
<td>0.2</td>
<td>0.4</td>
</tr>
<tr>
<td>oil_price_avg</td>
<td>50.8</td>
<td>31.1</td>
<td>67.3</td>
<td>20.0</td>
</tr>
<tr>
<td>ex_regime</td>
<td>0.5</td>
<td>0.5</td>
<td>0.5</td>
<td>0.5</td>
</tr>
<tr>
<td>crisis_year</td>
<td>0.0</td>
<td>0.0</td>
<td>1.0</td>
<td>0.0</td>
</tr>
<tr>
<td>lag_cbi</td>
<td>0.6</td>
<td>0.2</td>
<td>0.7</td>
<td>0.2</td>
</tr>
<tr>
<td>lag_inflation</td>
<td>25.3</td>
<td>420.7</td>
<td>5.8</td>
<td>7.2</td>
</tr>
<tr>
<td>inflation_clean</td>
<td>8.6</td>
<td>16.1</td>
<td>5.9</td>
<td>8.2</td>
</tr>
<tr>
<td>oil_interaction</td>
<td>12.0</td>
<td>26.1</td>
<td>12.5</td>
<td>29.5</td>
</tr>
<tr>
<td>cbi_x_regime</td>
<td>0.3</td>
<td>0.4</td>
<td>0.3</td>
<td>0.3</td>
</tr>
<tr>
<td>oil_x_crisis</td>
<td>0.0</td>
<td>0.0</td>
<td>12.5</td>
<td>29.5</td>
</tr>
<tr>
<td>log_oil_price</td>
<td>3.7</td>
<td>0.7</td>
<td>4.2</td>
<td>0.3</td>
</tr>
<tr>
<td>log_gdp</td>
<td>0.0</td>
<td>0.1</td>
<td>0.0</td>
<td>0.1</td>
</tr>
</tbody>
</table>

Interpretation Notes:

What share of countries are floating vs pegged? How frequent are crisis
periods? Is sample composition balanced or skewed?

## 3. Distributional Analysis

### 3.1 Inflation Distribution

#### Table 8: Inflation Winsorisation Diagnostics

<table style="width:82%;">
<colgroup>
<col style="width: 13%" />
<col style="width: 15%" />
<col style="width: 16%" />
<col style="width: 16%" />
<col style="width: 19%" />
</colgroup>
<tbody>
<tr>
<td rowspan="2"><h1 id="min_raw">Min_raw</h1>
<p>-16.12</p></td>
<td rowspan="2"><h1 id="max_raw">Max_raw</h1>
<p>23773.13</p></td>
<td rowspan="2"><h1 id="min_clean">Min_clean</h1>
<p>-5.00</p></td>
<td rowspan="2"><h1 id="max_clean">Max_clean</h1>
<p>100.00</p></td>
<td rowspan="2"><h1 id="pct_changed">Pct_changed</h1>
<p>1.87</p></td>
</tr>
<tr>
</tr>
</tbody>
</table>

Interpretation Notes:

Skewness indicates presence of extreme inflation episodes Justifies
winsorisation strategy Check for fat tails / crisis clustering

### 3.2 CBI Distribution

![](C:/Users/pavan/Documents/ecc3479-research-project/output/eda/EDA_files/figure-gfm/cbi-distribution-1.png)<!-- -->

Interpretation Notes:

Is institutional reform gradual or stepwise? Are countries clustered at
low/high independence?

## 4. Macroeconomic Validity and Identification Structure

### 4.1 CBI vs Inflation (Main Identification Plot)

![](C:/Users/pavan/Documents/ecc3479-research-project/output/eda/EDA_files/figure-gfm/cbi-inflation-relationship-1.png)<!-- -->

Interpretation Notes:

Does higher CBI reduce inflation? Linear vs non-linear structure
Evidence for credibility theory

### 4.2 Crisis Effects on Inflation

![](C:/Users/pavan/Documents/ecc3479-research-project/output/eda/EDA_files/figure-gfm/crisis-inflation-1.png)<!-- -->

Interpretation Notes:

Crisis increases mean inflation? Higher variance during crises?

### 4.3 Oil Shock Heterogeneity

![](C:/Users/pavan/Documents/ecc3479-research-project/output/eda/EDA_files/figure-gfm/oil-shock-heterogeneity-1.png)<!-- -->

Interpretation Notes:

Do exporters hedge oil shocks better? Asymmetric pass-through effects?

## 5. Institutional Heterogeneity and Simpson’s Paradox

### 5.1 Exchange Rate Regime Interaction

![](C:/Users/pavan/Documents/ecc3479-research-project/output/eda/EDA_files/figure-gfm/ex-regime-interaction-1.png)<!-- -->

Interpretation Notes:

Does regime alter CBI effectiveness? Evidence of Simpsons paradox?

### 5.2 Inflation Persistence

#### Table 9: Inflation Persistence Diagnostics

<table style="width:35%;">
<colgroup>
<col style="width: 19%" />
<col style="width: 15%" />
</colgroup>
<tbody>
<tr>
<td rowspan="2"><h1 id="correlation">Correlation</h1>
<p>0.265</p></td>
<td rowspan="2"><h1 id="n">N</h1>
<p>4457.000</p></td>
</tr>
<tr>
</tr>
</tbody>
</table>

| crisis_year | Correlation | N        |
|-------------|-------------|----------|
| 0.000       | 0.269       | 3882.000 |
| 1.000       | 0.593       | 575.000  |

Interpretation Notes:

Strong persistence suggests dynamic panel model Justifies lagged
dependent variable

## 5.3. Correlation Structures

#### Table 11: Correlation matrix — Key Variables

<table style="width:96%;">
<colgroup>
<col style="width: 14%" />
<col style="width: 12%" />
<col style="width: 10%" />
<col style="width: 14%" />
<col style="width: 14%" />
<col style="width: 9%" />
<col style="width: 8%" />
<col style="width: 11%" />
</colgroup>
<tbody>
<tr>
<td rowspan="2">=================== inflation_clean</td>
<td rowspan="2"><h1 id="inflation_clean">inflation_clean</h1>
<p>1</p></td>
<td rowspan="2"><h1 id="cbi_extended">cbi_extended</h1>
<p>.</p></td>
<td rowspan="2"><h1 id="unemployment_rate">unemployment_rate</h1>
<p>.</p></td>
<td rowspan="2"><h1 id="trade_percent_gdp">trade_percent_gdp</h1>
<p>.</p></td>
<td rowspan="2"><h1 id="gdp_growth">gdp_growth</h1>
<p>.</p></td>
<td rowspan="2"><h1 id="m2_growth">m2_growth</h1>
<p>.</p></td>
<td rowspan="2"><h1 id="oil_price_avg">oil_price_avg</h1>
<p>.</p></td>
</tr>
<tr>
</tr>
<tr>
<td>cbi_extended</td>
<td>-.15</td>
<td>1</td>
<td>.</td>
<td>.</td>
<td>.</td>
<td>.</td>
<td>.</td>
</tr>
<tr>
<td>unemployment_rate</td>
<td>.04</td>
<td>.11</td>
<td>1</td>
<td>.</td>
<td>.</td>
<td>.</td>
<td>.</td>
</tr>
<tr>
<td>trade_percent_gdp</td>
<td>-.12</td>
<td>.19</td>
<td>-.04</td>
<td>1</td>
<td>.</td>
<td>.</td>
<td>.</td>
</tr>
<tr>
<td>gdp_growth</td>
<td>-.12</td>
<td>-.03</td>
<td>-.10</td>
<td>.07</td>
<td>1</td>
<td>.</td>
<td>.</td>
</tr>
<tr>
<td>m2_growth</td>
<td>.33</td>
<td>-.04</td>
<td>-.02</td>
<td>-.04</td>
<td>-.05</td>
<td>1</td>
<td>.</td>
</tr>
<tr>
<td>oil_price_avg</td>
<td>-.18</td>
<td>.30</td>
<td>-.04</td>
<td>.14</td>
<td>.04</td>
<td>-.06</td>
<td>1</td>
</tr>
</tbody>
</table>

Interpretation Notes:

Multicollinearity risk? Structural relationships between macro
variables?

## 6. Key Conclusions and Summary

#### Table 11: Sample size under Common Restrictions

| Sample                      | Observations |
|-----------------------------|--------------|
| Full Dataset                | 4603.00      |
| Non-missing Inflation       | 4603.00      |
| Non-missing Inflation & CBI | 4603.00      |
| Baseline Regression Sample  | 3718.00      |

Key Findings (TO BE WRITTEN IN PROSE):

Inflation exhibits \[skewed / stable / volatile\] distribution patterns
CBI is \[clustered / uniform\], suggesting institutional rigidity or
reform waves Preliminary evidence suggests a \[negative / weak /
nonlinear\] relationship between CBI and inflation Crisis periods
significantly increase inflation volatility Oil price shocks exhibit
heterogeneous effects across exporter status Inflation is strongly
persistent, justifying dynamic modelling approaches END OF EDA

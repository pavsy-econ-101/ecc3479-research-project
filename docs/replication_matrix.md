# Figure & Table Replication Matrix

This document acts as an explicit mapping index to connect every empirical table, figure, and diagnostic plot presented in the final PDF paper back to its respective automated R source script and localized output folder.

---

## 📊 1. Main Text Tables & Figures

| Paper Element | Component Description | Generation Source Script | Output Artifact Filename / Location |
| :--- | :--- | :--- | :--- |
| **Table 1** | Sample Selection Attrition Hierarchy | `src/01_data_cleaning.R` | *Printed directly to the R console log during execution* |
| **Table 2** | Baseline Summary Statistics Table | `src/02_eda_analysis.Rmd` | `outputs/eda/` (Embedded within compiled HTML) |
| **Table 3** | Main Panel FE Regression Results | `src/03_econometric_analysis.Rmd`| `outputs/econometric_analysis/` (Main results matrix) |
| **Figure 1** | Binned Scatterplot: Baseline OLS | `src/03_econometric_analysis.Rmd`| `outputs/econometric_analysis/` |
| **Figure 2** | Interaction Marginal Effects Plot | `src/03_econometric_analysis.Rmd`| `outputs/econometric_analysis/` |

---

## 📈 2. Appendix B: Additional Plots & Diagnostic Figures

*Note: As per the script pipeline architecture, figures related to Exploratory Data Analysis (EDA) are exported via `02_eda_analysis.Rmd`, while baseline macroeconomic associations are handled inside the primary econometric module (`03_econometric_analysis.Rmd`).*

| Paper Element | Component Description | Generation Source Script | Output Artifact Filename / Location |
| :--- | :--- | :--- | :--- |
| **Figure B.1** | Spatiotemporal Missing Data Matrix | `src/02_eda_analysis.Rmd` | `outputs/eda_figures/` |
| **Figure B.2a**| Univariate Inflation Kernel Density | `src/02_eda_analysis.Rmd` | `outputs/eda_figures/` |
| **Figure B.2b**| Univariate CBI Metric Density | `src/02_eda_analysis.Rmd` | `outputs/eda_figures/` |
| **Figure B.3a**| Unconditioned Bivariate Association| `src/03_econometric_analysis.Rmd`| `outputs/econometric_analysis/` |
| **Figure B.3b**| Historical Inflation Shock Chronology| `src/03_econometric_analysis.Rmd`| `outputs/econometric_analysis/` |

---

## 🧪 3. Appendix C: Additional Robustness Tests

*Note: All robustness configurations, scale transformations (IHS), structural sub-sample splits, and parameter vulnerability diagnostics are compiled through the dedicated robustness script.*

| Paper Element | Component Description | Generation Source Script | Output Artifact Filename / Location |
| :--- | :--- | :--- | :--- |
| **Table C.1** | Subset Regression Matrix (Cols 1, 3, 8)| `src/04_robustness.Rmd` | `outputs/robustness_analysis/` (Columns 1, 3, 8 subset) |
| **Figure C.1a**| Inverse Hyperbolic Sine Check | `src/04_robustness.Rmd` | `outputs/robustness_analysis/` |
| **Figure C.1b**| Recursive Parameter Stability Output | `src/04_robustness.Rmd` | `outputs/robustness_analysis/` |
| **Figure C.2a**| Pass-Through: Net Energy Importers | `src/04_robustness.Rmd` | `outputs/robustness_analysis/` |
| **Figure C.2b**| Pass-Through: Fixed Currency Regimes | `src/04_robustness.Rmd` | `outputs/robustness_analysis/` |
| **Figure C.3** | Consolidated Coefficient Forest Plot | `src/04_robustness.Rmd` | `outputs/robustness_analysis/` |

---

## 🛠️ Execution Context & Quick Reproduction

1. To reconstruct the source files under pinning these figures, execute `src/01_data_cleaning.R` first to populate the `data/clean/df_panel_final.csv` dataframe matrix.
2. Knocking down the `.Rmd` files sequentially using `rmarkdown::render()` as shown in the primary `README.md` will cleanly populate all the associated sub-directories listed above.
3. If checking standard output coefficients, remember that standard errors are **clustered at the country level** across all modelling frames (`fixest::feols(..., cluster = ~country)`).
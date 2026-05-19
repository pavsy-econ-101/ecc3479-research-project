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
│   ├── 01_data_cleaning.R              # Data cleaning and construction of final panel
    ├── 02_eda_analysis.Rmd             # Exploratory Data Analysis (source)
    ├── 03_econometric_analysis.Rmd     # Econometric Analysis (source)
│   └── 04_robustness.Rmd               # Robustness Analysis (source)
├── outputs/                    # Figures, regression tables, and diagnostics
│   ├── econometric_analysis/   # Explanatory Notes and Visuals used in the Primary Econometric Analysis
│   ├── eda/                    # Explanatory Notes for the EDA Analysis conducted
    ├── eda_figures/            # Exploratory data analysis (Graphs and Visual Outputs)
│   └── robustness_analysis/    # Explanatory Notes and Visuals used in the Robustness Analysis
├── docs/                       # Methodology Notes
├── Presentation Slides.pdf     # Presentation Slides to be delivered on 26 May 2026 (pdf) 
├── Project Report.pdf          # Final Paper (pdf)
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
    * `countrycode` (Importing ISO-A3 country codes for standardisation)
    * `modelsummary` (Helps in creating professional summaries and tables)
    * `scales` (Scaling Infrastructure to create customised plots)
    * `naniar` (Helps in identifying and visualising missing variables and data points)
    * `GGally` (Developing Correlation Matrices and Heatmaps)
    * `fixest` (High‑dimensional fixed‑effects regression modeling)
    * `marginaleffects` (Interpreting models via marginal effects)
    * `gt` (Creating polished, publication‑ready tables)
    * `binsreg` (Binned scatterplots with formal inference)
    * `kableExtra` (Styling and enhancing kable‑based tables)
    * `patchwork` (Combining multiple ggplots into layouts)
    * `broom` (Cleaning Data into tibbles and dataframes)
    * `rmarkdown` (Converting and Managing Rmarkdown files)
---

## 📊 Empirical Replication Matrix
Because the automated R pipeline scripts export image assets and output matrices using their baseline econometric/variable names, their filenames may differ from the stylized, editorial layout numbering of the final compiled PDF paper.

👉 **[Click Here to View the Figure & Table Replication Matrix (replication_matrix.md)](docs/replication_matrix.md)**

This standalone guide explicitly maps every table, figure, and appendix asset in our paper back to its exact generation script and output path.

---

## 🚀 How to Run from Scratch

Please run the files in the order as they have been listed below to ensure you are able to review the entire analysis workflow, from cleaning raw data to the exploratory data analysis, and the econometric methods and robustness checks used throughout this Project. 

### 🚀 `01_data_cleaning.R`

Before running the scripts, you must ensure the local directory is prepared:
1.  **Clone the Repository**: `git clone [Your-Repo-URL]`
2.  **Verify Folder Structure**: Ensure the `data/raw/` and `data/clean/` folders exist. If they are missing, create them manually in your file explorer.
3.  **Place Raw Data**: Ensure the source files (e.g., `EIA_crudeoil-exports.csv`, `Romelli_CBIData.xlsx`) are present into the `data/raw/` directory.
4. **Run the Code:** Open the project in VSCode and run `src/01_data_cleaning.R`. This is a master script that handles the entire pipeline from ingestion to final panel export. The cleaned dataset will be generated in `data/clean/`.

*Note: When the script is run, it ocassionally produces `object not found.` errors. If it does so, please run `1. Load libraries` code block first, and then run the rest of the code afterwards.`*

### 🚀 `02_eda_analysis.Rmd`

*Note: If you review the `output` folder, you can find the entire .pdf explanatory document and all associated figures and visual outputs with the EDA in there. These instructions apply if you wish to reproduce the entire EDA process on your own.*

1. **Clone the repository and open R in the project root:** `r   getwd()` The working directory should be the project’s top-level folder.
2. **Render the EDA Document:**
`Rrmarkdown::render(`
`input = "src/02_eda_analysis.Rmd",`  
`output_file = "EDA.html",`  
`output_dir  = "output/eda")`
3. **Open** `output/eda/EDA.html` to read the EDA. All figures are saved in `output/eda_figures/`.

### 🚀 `03_econometric_analysis.Rmd`

*Note: If you review the `output` folder, you can find the entire .pdf explanatory document and all associated figures and visual outputs with the Primary Econometric Analysis in there. These instructions apply if you wish to reproduce it on your own.*

1. **Clone the repository and open R in the project root:** `r   getwd()` The working directory should be the project’s top-level folder.
2. **Render the  Document:**
`Rrmarkdown::render(`
`input = "src/03_econometric_analysis.Rmd",`  
`output_file = "Primary Econometric Analysis.html",`  
`output_dir  = "output/econometric_analysis)"`
3. **Open** `output/econometric_analysis/Primary Econometric Analysis.html` to read the analysis document. All figures are saved in `output/econometric_analysis/`.
---

### 🚀 `04_robustness.Rmd`

*Note: If you review the `output` folder, you can find the entire .pdf explanatory document and all associated figures and visual outputs with the Robustness Analysis in there. These instructions apply if you wish to reproduce it on your own.*

1. **Clone the repository and open R in the project root:** `r   getwd()` The working directory should be the project’s top-level folder.
2. **Render the  Document:**
`Rrmarkdown::render(`
`input = "src/04_robustness.Rmd",`  
`output_file = "Robustness Analysis.html",`  
`output_dir  = "output/robustness_analysis)"`
3. **Open** `output/robustness_analysis/Robustness Analysis.html` to read the analysis document. All figures are saved in `output/robustness_analysis/`.
---

## 🗃 Data Inventory & Source Indicators

### Raw Data Source
Please review `docs/data_guide.md` for detailed instructions on accessing the data points.

### Clean Data for Analysis
Please review `data/clean/data_codebook.md` for a complete set of variables contained in `df_panel_final.csv` and its interpretations.

### Data Cleaning Methodology
Please review `docs/econometric_cleaning.md` for details surrounding the processes involved in cleaning the raw data. 

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

**Last updated:** 20 May 2026  

This repository was developed for academic assessment purposes (Unit ECC3479). All rights are reserved. The code and documentation provided herein are the original work of the author. Redistribution or commercial use of this material is prohibited without explicit consent.
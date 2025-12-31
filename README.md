Riparian Environmental Trend Analysis (2000–2020)

This repository contains a fully reproducible R workflow for analyzing long-term temporal trends in riparian environmental variables using:

Mann–Kendall trend test

Sen’s slope estimator

Multi-panel time-series visualization

The workflow is designed for transparent, reproducible environmental analysis and follows best practices for open science.

1.Data Availability

The dataset used in this study is openly available on Zenodo:

Akanlo Anankansa, E., & Amfo, B. (2025).
Annual time series of riparian vegetation and climate variables in the Black Volta Basin, Ghana (2000–2020).
Zenodo. https://doi.org/10.5281/zenodo.18103076

2.Automatic Data Download

You do not need to manually download the dataset.

The R script automatically:

Downloads the dataset from Zenodo

Saves it in the local data/ directory

Loads it into the analysis environment

This ensures full computational reproducibility across systems.

3.Project Structure
riparian-trend-analysis/
│
├── data/
│   └── riparian_data.csv        # Auto-downloaded from Zenodo
│
├── scripts/
│   └── analysis.R               # Main analysis script
│
├── output/
│   ├── figures/                 # Generated plots
│   └── tables/                  # Statistical outputs
│
└── README.md

4 How to Run the Analysis

Clone the repository

git clone https://github.com/Elisha-Anankansa/riparian-trend-analysis.git
cd riparian-trend-analysis


Open RStudio and set the project directory (optional)

Run the analysis

source("scripts/analysis.R")


The script will:

Download the dataset from Zenodo

Compute Mann–Kendall trends and Sen’s slopes

Generate publication-ready figures

Save all outputs in the output/ directory
 
5. Outputs

Trend statistics: output/tables/trend_statistics.csv

Multi-panel trend figure: output/figures/Combined_Temporal_Trends.png

6. Reproducibility

This repository ensures:

No hard-coded file paths

Fully automated data acquisition

Transparent statistical workflow

The analysis can be reproduced on any system with R ≥ 4.0.


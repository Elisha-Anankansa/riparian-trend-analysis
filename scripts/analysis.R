# ============================================================
# Reproducible Trend Analysis of Riparian Environmental Variables
# Author: Elisha Akanlo Anankansa
# ============================================================

# ----------------------------
# 1. Load Required Libraries
# ----------------------------
required_pkgs <- c("trend", "dplyr", "ggplot2", "tidyr")

for (pkg in required_pkgs) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg)
    library(pkg, character.only = TRUE)
  }
}

# ----------------------------
# 2. Load Dataset
# ----------------------------
# ----------------------------
# 2. Download & Load Dataset from Zenodo
# ----------------------------

data_dir <- "data"
data_file <- "riparian_data.csv"
data_path <- file.path(data_dir, data_file)

# Zenodo direct download link (update filename if different)
zenodo_url <- "https://zenodo.org/record/18103076/files/riparian_data.csv"

# Create data directory if it doesn't exist
if (!dir.exists(data_dir)) {
  dir.create(data_dir, recursive = TRUE)
}

# Download dataset only if not already present
if (!file.exists(data_path)) {
  message("Downloading data from Zenodo...")
  download.file(zenodo_url, destfile = data_path, mode = "wb")
} else {
  message("Using local copy of dataset.")
}

# Load dataset
df <- read.csv(data_path)

# ----------------------------
# 3. Trend Analysis (Mann–Kendall & Sen's Slope)
# ----------------------------
trend_vars <- c("NDVI_Mean", "MNDWI_Mean", "Precipitation_Mean", "Temperature_Mean")

trend_results <- lapply(trend_vars, function(var) {
  mk <- mk.test(df[[var]])
  ss <- sens.slope(df[[var]])
  
  data.frame(
    Variable = var,
    MK_Tau = round(mk$statistic[1], 3),
    MK_PValue = round(mk$p.value, 4),
    Sen_Slope = round(ss$estimates[1], 4)
  )
})

trend_table <- bind_rows(trend_results)

# Save trend statistics
write.csv(trend_table, "C:/Users/user/Downloads/riparian-trend-analysis/output/tables/trend_statistics.csv", row.names = FALSE)

# ----------------------------
# 4. Prepare Data for Plotting
# ----------------------------
df_long <- df %>%
  select(Year, all_of(trend_vars)) %>%
  pivot_longer(
    cols = -Year,
    names_to = "Variable",
    values_to = "Value"
  ) %>%
  left_join(trend_table, by = "Variable")

# ----------------------------
# 5. Combined Temporal Plot
# ----------------------------
p_combined <- ggplot(df_long, aes(x = Year, y = Value)) +
  geom_line(color = "steelblue", linewidth = 1) +
  geom_point(color = "darkblue", size = 1.8) +
  geom_smooth(method = "lm", se = FALSE, color = "red", linetype = "dashed") +
  geom_text(
    aes(
      label = paste0("Sen's slope = ", Sen_Slope,
                     "\nP-value = ", MK_PValue)
    ),
    x = -Inf, y = Inf,
    hjust = -0.05, vjust = 1.2,
    size = 3.6,
    inherit.aes = FALSE
  ) +
  facet_wrap(~Variable, scales = "free_y", ncol = 2) +
  labs(
    title = "Temporal Trends of Environmental Variables (2000–2020)",
    subtitle = "Mann–Kendall Trend Test and Sen’s Slope Analysis",
    x = "Year",
    y = "Observed Value"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    strip.text = element_text(face = "bold"),
    plot.title = element_text(face = "bold")
  )

# ----------------------------
# 6. Save Output
# ----------------------------
ggsave(
  filename = "C:/Users/user/Downloads/riparian-trend-analysis/output/figures/Combined_Temporal_Trends.png",
  plot = p_combined,
  width = 12,
  height = 8,
  dpi = 300
)

0
print("Analysis complete. Outputs saved in /output directory.")


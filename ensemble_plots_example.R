######################################
# 10.02.2019
# Emsemble plots example
# BISC 481
######################################

## Install packages
# Bioconductor
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install()
# DNAshapeR
BiocManager::install("DNAshapeR")

# Initialization
library(DNAshapeR)
workingPath <- "/Users/jianichen/Desktop/in_vitro_data_analysis/CTCF/"

# Extract sample sequences
fn <- system.file(workingPath, "", package = "DNAshapeR")

# Predict DNA shapes
pred <- getShape(fn)

# Generate ensemble plots
plotShape(pred$MGW)
heatShape(pred$ProT, 20)

######################################
# 12.16.2023
# prediction models for in vitro data
# QBIO 481
######################################

## Install packages
# Bioconductor
# https://www.bioconductor.org/install/
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install(version = "3.18")

# DNAshapeR (non developer version)
# https://www.bioconductor.org/packages/release/bioc/html/DNAshapeR.html
BiocManager::install("DNAshapeR")

# Caret
# https://github.com/topepo/caret?tab=readme-ov-file
install.packages("caret")

# glmnet: Lasso and Elastic-Net Regularized Generalized Linear Models
# https://rdrr.io/cran/glmnet/
install.packages("glmnet")

## Initialization
library(DNAshapeR)
library(caret)
workingPath <- "/Users/jianichen/Desktop/in_vitro_data_analysis/gcPBM/"

## Predict DNA shapes
fn_fasta <- paste0(workingPath, "Max.txt.fa")
pred <- getShape(fn_fasta)

## Encode feature vectors
featureType <- c("1-mer", "1-shape")
featureVector <- encodeSeqShape(fn_fasta, pred, featureType)
head(featureVector)

## Build MLR model by using Caret
# Data preparation
fn_exp <- paste0(workingPath, "Max.txt")
exp_data <- read.table(fn_exp)
df <- data.frame(affinity=exp_data$V2, featureVector)

# Arguments setting for Caret
trainControl <- trainControl(method = "cv", number = 10, savePredictions = TRUE)

# Prediction without L2-regularized
model <- train (affinity~ ., data = df, trControl=trainControl, 
                method = "lm", preProcess=NULL)
summary(model)

# Prediction with L2-regularized
model2 <- train(affinity~., data = df, trControl=trainControl, 
               method = "glmnet", tuneGrid = data.frame(alpha = 0, lambda = c(2^c(-15:15))))
model2
result <- model2$results$Rsquared[1]
result


# Extract sample sequences
fn <- system.file("extdata", "Max.txt.fa", package = "DNAshapeR")

# Predict DNA shapes
pred <- getShape(fn)

# Generate ensemble plots
plotShape(pred$MGW)
heatShape(pred$ProT, 20)

# in_vitro_data_analysis

Jiani Chen \
version 1.0.0 \
date 12/16/2023 

This is the optional homework assignment for 
QBIO 481: Structural Bioinformatics from Atoms to Cells (Fall 2023)

## High-throughput binding assays

## _in vitro_ experiments SELEX-seq and PBM

**SELEX-seq** is a new experimental and computational platform used in _in vitro_ datasets to test the hypothesis that Hox family of homeodomain transcription factors have similar DNA-binding preferences as monomers, yet carry out distinct functions in vivo by characterizing DNA binding specificities of Hox-based multiprotein complexes. (Riley et al., 2014)

Source: [SELEX-seq, a method for characterizing the complete repertoire of binding site preferences for transcription factor complexes](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4265583/)

Laser irradiation can induce a **photobiomodulatory (PBM)** effect on cells and tissues, contributing to a directed modulation of cell behaviors, enhancing the processes of tissue repair. Photobiomodulation (PBM), also known as low-level laser therapy (LLLT), can induce cell proliferation and enhance stem cell differentiation. (Dompe et al., 2020)

Source: [Photobiomodulation—Underlying Mechanism and Clinical Applications](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7356229/)

## _in vivo_ experiment ChIP-seq
**ChIP-Seq**, which combines chromatin immunoprecipitation (ChIP) with ultra high-throughput massively parallel sequencing, is increasingly being used for mapping protein–DNA interactions in-vivo on a genome scale. (Raja et al., 2008)

Source: [Genome-wide identification of in vivo protein–DNA binding sites from ChIP-Seq data](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2532738/)

### Advantages and Disadvantages
**SELEX-seq**, in theory, the binding affinity for any K-mer and its reverse complement should be identical, as they represent two equivalent ways of referring to the same double-stranded DNA molecule. However, in practice, the presence of remaining strand-specific biases and sample error will give rise to small deviations from this symmetry. (Riley et al., 2014)

**ChIP-Seq** have a higher number of reads may increase the sensitivity and resolution but it may not necessarily translate to accuracy, as accuracy may be depend on other factors such as antibody specificity, and how stable the protein–DNA complex is. (Raja et al., 2008)

## Installation

For macOS version 12.5 Apple M2 chip. Install the latest release of [R for macOS](https://cran.r-project.org/bin/macosx/). This is **R 4.3.2 binary for macOS 11 (Big Sur) and higher, signed and notarized packages.** Installation using this method allows the user to directly use the R GUI Console for macOS which can be accessed in Finder or Launhpad -> Applications. This method of using the R GUI Console allows for easy of managing external libraries. I have tried install R and the external libraries using homebrew `brew install R`, but cannot seem to have my R system source the external libraries from the correct directory without changing my UNIX shell to zsh. (So no thank you.)

### Installing dependencies
The external libraries for this _in vitro_ data analysis setup can now be easily downloaded through the R Console. For selecting a CRAN mirror, I have chosen 72:USA TN for National Institute for Computational Sciences, Oak Ridge, TN

```
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

# Additionally dependency for Caret:
# glmnet: Lasso and Elastic-Net Regularized Generalized Linear Models
# https://rdrr.io/cran/glmnet/
install.packages("glmnet")
```

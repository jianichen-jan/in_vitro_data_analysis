######################################
# 10.02.2019
# Retrieval of ChIP-seq data
# Generation of bound and unbound data
# BISC 481
######################################

## Install packages
# Bioconductor
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install()
BiocManager::install("AnnotationHub")
BiocManager::install("GenomicRanges")
BiocManager::install("BSgenome.Mmusculus.UCSC.mm10")


## Initialization
library(DNAshapeR)
library(AnnotationHub)
library(BSgenome.Mmusculus.UCSC.mm10)


## Data retreive
seqLength <- 50 #500
sampleSize <- 2000 #42045
workingPath <- "/Users/jianichen/Desktop/in_vitro_data_analysis/CTCF/"

# Bound (ChIP-seq)
ah <- AnnotationHub()
unique(ah$dataprovider)
query(ah, "H3K4me3")
ctcfPeaks <- ah[["AH28451"]]
seqlevelsStyle(ctcfPeaks) <- "UCSC"
getFasta( GR = sample(ctcfPeaks, sampleSize), BSgenome = Mmusculus, width = seqLength, 
          filename = paste0(workingPath, "bound.fa"))

# Unbound (random regions w/o overlapping)
chrName <- names(Mmusculus)[1:22]
chrLength <- seqlengths(Mmusculus)[1:22]
randomGr <- GRanges()

while ( length(randomGr) < sampleSize )  {
  tmpChrName <- sample(chrName, 1)
  tmpChrLength <- chrLength[tmpChrName]
  tmpGRanges <- GRanges( seqnames = tmpChrName, strand = "+",
                         IRanges(start = sample(1:tmpChrLength,1), width = seqLength) )
  if( length(findOverlaps(ctcfPeaks, tmpGRanges)) == 0 ){
    randomGr <- c( randomGr, tmpGRanges)
    print(length(randomGr))
  }else{
    print(paste(length(randomGr), "overlap"))
  }
}
randomGr

# Overlap checking
findOverlaps(ctcfPeaks, randomGr)

# Fasta file generation
getFasta(randomGr, Mmusculus, width = seqLength, 
         filename = paste0(workingPath, "unbound.fa"))

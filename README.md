# How to Use _TaxonAPG_ Package
The _TaxonAPG_ Package integrates the functionalities of _U.Taxonstand_, _U.Phylomaker_, _ggtree_, and _picante_ packages within the _tidyverse_ framework, attempting to provide a "one-stop" convenient solution for research on phylogenetic relationships in plant community ecology.
## 1 Preparation
Please install relative packages below:
```
if (!require("devtools", quietly = TRUE))
  install.packages("devtools")
devtools::install_github("ecoinfor/U.Taxonstand")
devtools::install_github("jinyizju/U.PhyloMaker")
```
```
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("ggtree")
```

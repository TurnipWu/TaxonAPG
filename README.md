# How to Use the _TaxonAPG_ Package
The _TaxonAPG_ Package integrates the functionalities of _U.Taxonstand_, _U.PhyloMaker_, _ggtree_, and _picante_ packages within the _tidyverse_ framework, attempting to provide a "one-stop" convenient solution for research on phylogenetic relationships in plant community ecology.
## 1 Preparation
Before installing the package, please ensure the installation of the following dependent packages:
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
For the reason that the above packages cannot be directly downloaded from CRAN. After that, you can download this package.
```
devtools::install_github("TurnipWu/TaxonAPG")
```
## 2 Wrokflow
### 2.1 Standardize plantlist, based on the _U.Taxonstand_ package
Use the _stand_taxon_ function to accomplish this task. The input values can be either a vector or a data frame, where the first column represents the plantlist requiring standardization.
```
StandPlantList <- stand_taxon(plantlist)
```
It is recommended here to select between “accepted names” and “logged names” based on individual requirements, to ensure that the needs for subsequent construction of the phylogenetic tree are met.
>NOTE:The “standardization” of species names employs the World Plant database (https://www.worldplants.de), and the data used for comparison is integrated from https://github.com/nameMatch/Database.
### 2.2 Construct a phylo-tree, based on the _U.PhyloMaker_ package
Use the _get_phylo_ function to accomplish this task. The requirements for input values are consistent with those specified in section 2.1.
```
PhyloTree <- get_phylo(StandPlantList)
```
By default, this approach continues the tradition of the PhyloMaker series by using the APG IV classification system to “graft” species not included in the mega-tree at the genus or family level, which is done to ensure the incorporation of the most rational understanding of plant phylogenetic relationships known to date. Additionally, other settings within the _U.PhyloMaker_ package are maintained at their default options.
>NOTE:The mega-tree file is sourced from https://github.com/megatrees, and the APG IV genus-family relationship file is obtained from https://github.com/jinyizju/genus.family.relationship.







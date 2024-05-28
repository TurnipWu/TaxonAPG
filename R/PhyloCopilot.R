#' @title Build a APG IV-based phylotree
#' @description Constructing a phylogenetic tree based on the APG IV classification system and the megatree backbone.
#'
#' @param PlantList The first column of the dataframe, or the entire vector, consists of standard Latin names recognized by the World Plants website.
#'
#' @return A phylogenetic tree constructed by U.PhyloMaker package.
#' @export

get_phylo <- function(PlantList) {
  if (!requireNamespace("U.PhyloMaker",quietly = T)){stop("Please install the U.PhyloMaker package first.")}
  data("Megatree")
  data("APG_taxonomy")
  result <- U.PhyloMaker::phylo.maker(get_taxon(PlantList), Megatree, APG_taxonomy, nodes.type = 1, scenario = 3)
  return(result)
}

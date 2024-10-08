#' @title Calculate phylo-diversity
#' @description Calculate phylogenetic diversity using picante package, based on the construction of a phylogenetic tree and a species-plot abundance matrix.
#'
#' @param PhyloTree A phylogenetic tree constructed by U.Phylomaker package.
#' @param abundance_matrix A species-plot abundance matrix.
#'
#' @return A tibble contains 3 columns: plot, NRI and NTI.
#' @export



diversity_phylo <- function(PhyloTree,abundance_matrix,null="taxa.labels",run=999){
  if (!requireNamespace("picante",quietly = T)){stop("Please install the picante package first.")}
  pd_dist <- stats::cophenetic(PhyloTree[[1]])

  colnames(abundance_matrix) <- gsub(" ","_",stringr::str_squish(colnames(abundance_matrix)))

  if(FALSE%in%(colnames(abundance_matrix)%in%PhyloTree[[1]]$tip.label)){
    print(colnames(abundance_matrix)[!colnames(abundance_matrix)%in%PhyloTree[[1]]$tip.label])
    stop("These species are not present in the phylogenetic tree.\n NOTE: Don't worry about extra underlines or spaces in your species name, for we have already revise them.")
  }

  NTI <- picante::ses.mntd(abundance_matrix,pd_dist,
                           null.model = null,
                           abundance.weighted = T,
                           runs = run,iterations = 1000)


  NRI <- picante::ses.mpd(abundance_matrix,pd_dist,
                          null.model = null,
                          abundance.weighted = T,
                          runs = run,iterations = 1000)


  PhyloDiverRes <- tibble::tibble(
    plot=row.names(abundance_matrix),
    NRI=-NRI$mpd.obs.z,
    NTI=-NTI$mntd.obs.z)

  return(PhyloDiverRes)
}

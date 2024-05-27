#' @title Get taxonomic info from APG IV
#' @description Extract genus and family information based on APG IV from space-corrected species names.
#'
#' @param PlantList Inputs could be "vector" or "dataframe" as you like!
#'
#' @return A tibble contains 3 columns: species, genus and APG-IV family.
#' @export
#' @examples get_taxon("Aa")
#' @examples get_taxon(c("Pinus massonlana","Cunninghamia lanceolata","Lindera glauca","Litsea cubeba","Sassafras tzumu"))
#' @examples get_taxon(data.frame("species"=c("Pinus massonlana","Cunninghamia lanceolata","Lindera glauca","Litsea cubeba","Sassafras tzumu")))
get_taxon <- function(PlantList) {
  if (!requireNamespace("tidyverse",quietly = T)){stop("Please install the tidyverse package first.")}
  if (class(PlantList)[1]!="tbl_df"){PlantList <- tibble::as_tibble(PlantList)}
  data("APG_taxonomy")
  PlantList <- tibble::tibble("species"=unlist(PlantList[,1]))
  genus_family_list <- PlantList|>
    purrr::map_dfr(stringr::str_squish)|>
    dplyr::rowwise()|>
    dplyr::mutate("genus"=stringr::str_split(species, " ")[[1]][1])|>
    dplyr::ungroup()|>
    dplyr::left_join(APG_taxonomy,by="genus")
  return(genus_family_list)
}

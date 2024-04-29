#' @title Get taxonomic info from APG IV
#' @description This R package extracts genus and family information based on APG IV from space-corrected species names
#'
#' @param PlantList dataframe or vector
#'
#' @return species, genus and family
#' @export
#'
#' @examples
get_taxon <- function(PlantList) {
  if (!requireNamespace("tidyverse",quietly = T)){stop("Please install the tidyverse package first.")}
  if (class(PlantList)[1]!="tbl_df"){PlantList <- tibble::as_tibble(PlantList)}
  data("APG_taxonomy")
  PlantList <- tibble::tibble("species"=unlist(PlantList[,1]))
  genus_family_list <- PlantList|>
    purrr::map_dfr(str_squish)|>
    dplyr::rowwise()|>
    dplyr::mutate("genus"=str_split(species, " ")[[1]][1])|>
    dplyr::ungroup()|>
    dplyr::left_join(APG_taxonomy,by="genus")
  return(genus_family_list)
}

#' @title WP-based species standardizer
#' @description Standardize the input list of plant species based on the World Plant Database with U.Taxonstand package.
#'
#' @param Plantlist Inputs could be "vector" or "dataframe" as you like!
#'
#' @return A tibble contains 3 columns: AcceptedName, LoggedName and Equivalence.
#' @export
#' @examples stand_taxon("Aa")
#' @examples stand_taxon(c("Pinus massonlana","Cunninghamia lanceolata","Lindera glauca","Litsea cubeba","Sassafras tzumu"))
#' @examples stand_taxon(data.frame("species"=c("Pinus massonlana","Cunninghamia lanceolata","Lindera glauca","Litsea cubeba","Sassafras tzumu")))

stand_taxon <- function(Plantlist,IsAuthor=F){
  if (!requireNamespace("U.Taxonstand",quietly = T)){stop("Please install the U.Taxonstand package first.")}
  Plantlist <-stringr::str_squish(unlist(as_tibble(Plantlist)[,1]))
  data("WorldPlantDatabase")
  StandardisedRes <- U.Taxonstand::nameMatch(spList=Plantlist,spSource=WorldPlantDatabase,
                                             author = IsAuthor,max.distance= 5)|>
    dplyr::select(AcceptedName=Accepted_SPNAME,LoggedName=Submitted_Name)|>
    dplyr::mutate(Equivalence=case_when(AcceptedName==LoggedName~TRUE,T~FALSE))|>
    suppressWarnings()

  if(TRUE%in%is.na(StandardisedRes$AcceptedName)){warning("Please check for NAs in the Accepted species name!")}

  return(StandardisedRes)
}

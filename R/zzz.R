#' @importFrom methods .onLoad

.onLoad <- function(libname, TaxonAPG) {
  data("APG_taxonomy", package = TaxonAPG)
  if (!requireNamespace("tidyverse",quietly = T)){stop("Please install the tidyverse package first.")}
}

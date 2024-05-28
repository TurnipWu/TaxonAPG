#' @title Plot a phylotree with node types
#' @description Visualizing a phylogenetic tree constructed by U.Phylomaker package, including resolution information for each node.
#'
#' @param PhyloTree A phylogenetic tree constructed by U.Phylomaker package.
#'
#' @return A visualization of a phylogenetic tree with node types.
#' @export


plot_phylo <- function(PhyloTree,NodeColor=c("#f5c88f","#b3c384","#73a66b")){
  if (class(PhyloTree[[1]])!="phylo"){stop("Please input the phylogenetic tree constructed by the U.phylomaker package.")}
  if (!requireNamespace("tidyverse",quietly = T)){stop("Please install the tidyverse package first.")}
  if (!requireNamespace("ggtree",quietly = T)){stop("Please install the ggtree package first.")}

  TreeRes <- ggtree::ggtree(ggplot2::fortify(PhyloTree[[1]])|>
                              dplyr::mutate(label=gsub("_"," ",label))|>
                              dplyr::left_join(PhyloTree[[2]][,c(1,5)],by=c("label"="species"))|>
                              dplyr::mutate(output.note=dplyr::case_when(is.na(output.note)~"present in megatree",T~output.note))|>
                              dplyr::rename("NodeType"=output.note),
                            layout = "circular",
                            branch.length = "none",color=NA,
                            linetype=1,size=2,ladderize = T,
                            show.legend=F)+
    ggtree::geom_tree(ggplot2::aes(color=NodeType),
                      linetype=1,size=2,alpha=0.75)+
    ggtree::geom_tiplab(ggplot2::aes(color=NodeType,label=label),
                        color="#484848",
                        fontface="italic",
                        offset = 0.05,
                        hjust=-0.14,
                        show.legend=F,
                        size=5)+
    ggtree::geom_tippoint(ggplot2::aes(color=NodeType,shape=NodeType),
                          size=4)+
    ggplot2::xlim(-50,NA)+
    ggplot2::scale_color_manual(values=NodeColor)+
    ggplot2::theme(plot.margin=ggplot2::unit(rep(5,5),'cm'),
                   legend.position = c(0.5,0.5))
  return(TreeRes)
}


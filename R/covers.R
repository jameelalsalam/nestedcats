# covers / overlaps

#' Does a set of nodes cover all leaf nodes?
#'
#' @export
#' @examples
#' alist <- tibble::tibble(parent = c(1, 2, 2), child = c(2, 3, 4))
#' clsr <- closure_table(alist)
#' covers(1, clsr)
covers <- function(cats, clsr_tbl) {

  isTRUE(all.equal(
    filter_root_leaf(clsr_tbl),
    filter_root_leaf(
      filter(clsr_tbl, anc %in% cats))
  ))

}


#' Does the coverage of a set reach overlapping leaves?
#'
#' @export
overlaps <- function(cats, clsr_tbl) {



}

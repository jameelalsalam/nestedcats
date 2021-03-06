% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/covers.R
\name{covers}
\alias{covers}
\title{Does a set of nodes cover all leaf nodes?}
\usage{
covers(cats, clsr_tbl)
}
\description{
Does a set of nodes cover all leaf nodes?
}
\examples{
alist <- tibble::tibble(parent = c(1, 2, 2), child = c(2, 3, 4))
clsr <- closure_table(alist)
covers(1, clsr)
}

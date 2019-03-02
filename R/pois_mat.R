#' Sample data document
#'
#' Data from a 'rpois()'.
#'
#' @docType data
#' @usage data(pois_mat)
#' @format An object of matrix with 100 rows and 100 colmns.
#' @keywords datasets
#' @references
#' \href{https://github.com/shkonishi/hello/tree/master/man}{man}
#' @examples
#' data(pois_mat)
#' brk <- pretty(pois_mat, n = nclass.Sturges(pois_mat))
#' hist(pois_mat, breaks = brk)
"pois_mat"

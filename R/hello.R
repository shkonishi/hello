#' Hello, World!
#' @description Prints 'Hello, world!'.
#' @usage hello(n)
#' @param n Number of replication
#' @return Character vector, length of n
#' @examples hello(3)
#' @export
hello <- function(n) {
  rep("Hello, world!", n)
}

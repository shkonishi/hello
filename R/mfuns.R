#' Multiple functions  
#' 
#' multi-function in an Rd file.  
#' 
#' @param x a common argument
#' @param y fun2 specific
#' @param z fun3 specific
#' 
#' @name mfuns
#' 
#' @rdname mfuns
fun1 <- function(x) x 

#' @rdname mfuns
fun2 <- function(x, y) x + y

#' @rdname mfuns
fun3 <- function(x, y, z) x + y + z

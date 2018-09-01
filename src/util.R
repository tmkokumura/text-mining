#' concatenate character
#' 
#' @param ... character
#' @return concatenated character
concat <- function(...) {
  return (paste(c(...), collapse=""))
}
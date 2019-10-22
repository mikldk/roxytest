# From roxygen2's R/utils.R:

#' @importFrom stringr str_detect
has_quotes <- function (x) {
  stringr::str_detect(x, "^('|\").*\\1$")
}
 
is_syntactic <- function (x)  {
  make.names(x) == x 
}

auto_quote <- function (x) {
  needs_quotes <- !has_quotes(x) & !is_syntactic(x)
  x[needs_quotes] <- encodeString(x[needs_quotes], quote = "\"")
  x
}


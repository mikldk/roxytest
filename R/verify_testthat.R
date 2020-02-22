verify_testthat_used <- function() {
  if (!dir.exists("tests") || 
      !file.exists(file.path("tests", "testthat.R")) ||
      !dir.exists(file.path("tests", "testthat"))) {
    stop("testthat is not currently used, please set it up, e.g. by usethis::use_testthat()")
    return(FALSE)
  }
  
  return(TRUE)
}

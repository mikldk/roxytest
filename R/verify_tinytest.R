verify_tinytest_used <- function() {
  if (!dir.exists("inst") || !dir.exists(file.path("inst", "tinytest"))) {
    stop("tinytest is not currently used, please set it up (create dir inst/tinytest)")
    return(FALSE)
  }
  
  # if (!file.exists(file.path("tests", "testthat.R"))) {
  #   return(FALSE)
  # }
  # 
  # if (!dir.exists(file.path("tests", "testthat"))) {
  #   return(FALSE)
  # }
  
  return(TRUE)
}

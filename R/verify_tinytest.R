verify_tinytest_used <- function() {
  if (!dir.exists("tests") || 
      !file.exists(file.path("tests", "tinytest.R")) ||
      !dir.exists(file.path("inst", "tinytest"))) {
    stop("tinytest is not currently used, please set it up, e.g. by tinytest::setup_tinytest()")
    return(FALSE)
  }

  return(TRUE)
}

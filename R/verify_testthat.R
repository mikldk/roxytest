verify_testthat_used <- function() {
  if (!dir.exists("tests")) {
    return(FALSE)
  }
  
  if (!file.exists(file.path("tests", "testthat.R"))) {
    return(FALSE)
  }
  
  if (!dir.exists(file.path("tests", "testthat"))) {
    return(FALSE)
  }
  
  # FIXME: Check testthat in DESCRIPTION file
  
  return(TRUE)
}

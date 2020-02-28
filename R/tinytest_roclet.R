#' Roclet: make tinytest test-files.
#'
#' @family roclets
#' @description This roclet is a workhorse of roxytest, 
#' producing the tinytest test files specified.
#' 
#' Generally you will not call this function directly
#' but will instead use [roxygen2::roxygenise()] specifying this roclet.
#' 
#' @seealso Other roclets:
#' \code{\link{param_roclet}},
#' \code{\link{examples_roclet}},
#' \code{\link{return_roclet}},    
#' \code{\link{testthat_roclet}},
#' \code{\link[roxygen2]{namespace_roclet}}, 
#' \code{\link[roxygen2]{rd_roclet}},
#' \code{\link[roxygen2]{vignette_roclet}}.
#' 
#' @importFrom roxygen2 roclet
#' 
#' @export
tinytest_roclet <- function() {
  return(roxygen2::roclet("tinytest"))
}

#' @importFrom roxygen2 roclet_process
#' @export
roclet_process.roclet_tinytest <- function(x,
                                           blocks,
                                           env,
                                           base_path) {
  
  results <- internal_tests_roclet_process(blocks,
                                           indent_code = FALSE,
                                           add_testthat_boilerplate = FALSE, 
                                           add_context_header = FALSE)
  
  return(results)
}

#' @importFrom roxygen2 roclet_output
#' @export
roclet_output.roclet_tinytest <- function(x, results, base_path, ...) {
  verify_tinytest_used()
  
  roclet_clean.roclet_tinytest(x, base_path)
  
  tinytest_path <- normalizePath(file.path(base_path, "inst", "tinytest"))
  
  # Has side-effects: writes files to disk
  paths_tests <- internal_tests_roclet_output(results = results$tests, 
                                              base_path = tinytest_path, 
                                              prefix = "test-roxytest-tests-")
  
  paths_testexamples <- internal_tests_roclet_output(results = results$testexamples, 
                                                     base_path = tinytest_path, 
                                                     prefix = "test-roxytest-testexamples-")

  paths <- c(paths_tests, paths_testexamples)
  
  return(paths)
}

#' @importFrom roxygen2 roclet_clean
#' @export
roclet_clean.roclet_tinytest <- function(x, base_path) {
  verify_tinytest_used()
  
  testfiles <- dir(path = file.path(base_path, "inst", "tinytest"), 
                   pattern = "^test-roxytest-.*\\.R$", 
                   full.names = TRUE)
  
  # Has side-effects: deletes files on disk
  internal_tests_roclet_clean(testfiles)
}

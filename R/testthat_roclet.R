#' Roclet: make testthat test-files.
#'
#' @family roclets
#' @description This roclet is a workhorse of roxytest, 
#' producing the testthat test files specified.
#' 
#' Generally you will not call this function directly
#' but will instead use [roxygen2::roxygenise()] specifying this roclet.
#' 
#' @examples
#' x <- "#' @tests\n#' expect_equal(2, 2)\nNULL\n"
#' cat(x)
#' o <- roxygen2::roc_proc_text(testthat_roclet(), x)
#' cat(o$tests[[1]])
#' 
#' @return
#' A roclet to be used e.g. with [roxygen2::roxygenise()]
#' 
#' @seealso Other roclets:
#' \code{\link{param_roclet}}, 
#' \code{\link{examples_roclet}},
#' \code{\link{return_roclet}},    
#' \code{\link{tinytest_roclet}},
#' \code{\link[roxygen2]{namespace_roclet}}, 
#' \code{\link[roxygen2]{rd_roclet}},
#' \code{\link[roxygen2]{vignette_roclet}}.
#' 
#' @importFrom roxygen2 roclet
#' 
#' @export
testthat_roclet <- function() {
  return(roxygen2::roclet("testthat"))
}

#' @importFrom roxygen2 roclet_process
#' @export
roclet_process.roclet_testthat <- function(x,
                                           blocks,
                                           env,
                                           base_path) {
  
  results <- internal_tests_roclet_process(blocks,
                                           indent_code = TRUE,
                                           add_testthat_boilerplate = TRUE,
                                           add_context_header = FALSE)
  
  return(results)
}

#' @importFrom roxygen2 roclet_output
#' @export
roclet_output.roclet_testthat <- function(x, results, base_path, ...) {
  verify_testthat_used()
  
  roclet_clean.roclet_testthat(x, base_path)
  
  testthat_path <- normalizePath(file.path(base_path, "tests", "testthat"))
  
  # Has side-effects: writes files to disk
  paths_tests <- internal_tests_roclet_output(results = results$tests, 
                                              base_path = testthat_path, 
                                              prefix = "test-roxytest-tests-")
  
  paths_testexamples <- internal_tests_roclet_output(results = results$testexamples, 
                                                     base_path = testthat_path, 
                                                     prefix = "test-roxytest-testexamples-")

  paths <- c(paths_tests, paths_testexamples)
  
  return(paths)
}

#' @importFrom roxygen2 roclet_clean
#' @export
roclet_clean.roclet_testthat <- function(x, base_path) {
  verify_testthat_used()
  
  testfiles <- dir(path = file.path(base_path, "tests", "testthat"), 
                   pattern = "^test-roxytest-.*\\.R$", 
                   full.names = TRUE)
  
  # Has side-effects: deletes files on disk
  internal_tests_roclet_clean(testfiles)
}


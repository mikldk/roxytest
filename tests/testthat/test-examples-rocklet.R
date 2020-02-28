context("examples roclet")

test_that("All good with single @example", {
  out <- roxygen2::roc_proc_text(examples_roclet(), "
    #' Summing two numbers
    #'
    #' @example f(2, 2)
    #' 
    #' @return None
    #' 
    #' @export
    f <- function(x, y) {
      x + y
    }")
  expect_null(out)
})

test_that("All good with @examples", {
  out <- roxygen2::roc_proc_text(examples_roclet(), "
    #' Summing two numbers
    #'
    #' @examples
    #' f(2, 2)
    #' 
    #' @return None
    #' 
    #' @export
    f <- function(x, y) {
      x + y
    }")
  expect_null(out)
})

test_that("Missing @examples", {
  out <- capture_output(roxygen2::roc_proc_text(examples_roclet(), "
    #' Summing two numbers
    #'
    #' @export
    f <- function(x, y) {
      x + y
    }"))
  
  out_str <- gsub("\\[.*\\]", "", out)
  expect_equal(out_str, paste0("Functions with @export but no @example(s):\n",
                               "  * Function 'f()' with title 'Summing two numbers'"))
})

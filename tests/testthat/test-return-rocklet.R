context("return roclet")

test_that("All good", {
  out <- roxygen2::roc_proc_text(return_roclet(), "
    #' Summing two numbers
    #'
    #' @return None
    #' 
    #' @export
    f <- function(x, y) {
      x + y
    }")
  expect_null(out)
})

test_that("Missing @return", {
  out <- capture_output(roxygen2::roc_proc_text(return_roclet(), "
    #' Summing two numbers
    #'
    #' @export
    f <- function(x, y) {
      x + y
    }"))
  
  out_str <- gsub("\\[.*\\]", "", out)
  expect_equal(out_str, paste0("Functions with @export but no @return:\n",
                               "  * Function 'f()' with title 'Summing two numbers'"))
})

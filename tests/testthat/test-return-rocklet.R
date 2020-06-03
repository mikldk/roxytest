context("return roclet")

test_that("All good", {
  out <- roxygen2::roc_proc_text(return_roclet(), "
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

test_that("Missing @return", {
  out <- capture_messages(roxygen2::roc_proc_text(return_roclet(), "
    #' Summing two numbers
    #'
    #' @export
    f <- function(x, y) {
      x + y
    }"))
  out <- paste0(out, collapse = "\n")
  
  out_str <- gsub("\\[.*\\]", "", out)
  
  expect_match(out_str, "Functions with @export but no @return", fixed = TRUE)
  expect_match(out_str, "Function 'f()' with title", fixed = TRUE)
})

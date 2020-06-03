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
  out <- capture_messages(roxygen2::roc_proc_text(examples_roclet(), "
    #' Summing two numbers
    #'
    #' @export
    f <- function(x, y) {
      x + y
    }"))
  out <- paste0(out, collapse = "\n")
  
  out_str <- gsub("\\[.*\\]", "", out)

  expect_match(out_str, "Functions with @export but no @example(s)", fixed = TRUE)
  expect_match(out_str, "Function 'f()' with title", fixed = TRUE)
})

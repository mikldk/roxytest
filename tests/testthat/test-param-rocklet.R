context("param roclet")

test_that("All good", {
  out <- roxygen2::roc_proc_text(param_roclet(), "
    #' Summing two numbers
    #'
    #' @param x A number
    #' @param y Another number
    f <- function(x, y) {
      x + y
    }")
  expect_null(out)
})

test_that("Missing documentation of both parameters", {
  expect_message(roxygen2::roc_proc_text(param_roclet(), "
    #' Summing two numbers
    f <- function(x, y) {
      x + y
    }"), 
                 "^Functions with @param inconsistency:.*")
})

test_that("Missing documentation of 'y' parameter", {
  expect_message(roxygen2::roc_proc_text(param_roclet(), "
    #' Summing two numbers
    #'
    #' @param x A number
    f <- function(x, y) {
      x + y
    }"), "^Functions with @param inconsistency:.*")
})

test_that("Additional documentation for 'z' parameter", {
  
  out <- capture_messages(roxygen2::roc_proc_text(param_roclet(), "
    #' Summing two numbers
    #'
    #' @param x A number
    #' @param y Another number
    #' @param z A third parameter
    f <- function(x, y) {
      x + y
    }"))
  out <- paste0(out, collapse = "\n")
  
  out_str <- gsub("\\[.*\\]", "", out)
  expect_match(out_str, "Functions with @param inconsistency:", fixed = TRUE)
  expect_match(out_str, "Function 'f()' with title", fixed = TRUE)
  expect_match(out_str, "Too many @param's: z", fixed = TRUE)
})


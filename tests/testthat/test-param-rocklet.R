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
  
  expect_equal(out, list())
})

test_that("Missing documentation of 'y' parameter", {
  
  out <- roxygen2::roc_proc_text(param_roclet(), "
    #' Summing two numbers
    #'
    #' @param x A number
    f <- function(x, y) {
      x + y
    }")
  
  expect_equal(length(out), 1L)
  
  out_str <- gsub("\\[.*\\]", "", out[[1L]])
  expect_equal(out_str, "Function 'f' with title 'Summing two numbers' : \n    - Missing @param's: y")
})

test_that("Additional documentation for 'z' parameter", {
  
  out <- roxygen2::roc_proc_text(param_roclet(), "
    #' Summing two numbers
    #'
    #' @param x A number
    #' @param y Another number
    #' @param z A third parameter
    f <- function(x, y) {
      x + y
    }")
  
  expect_equal(length(out), 1L)
  
  out_str <- gsub("\\[.*\\]", "", out[[1L]])
  expect_equal(out_str, "Function 'f' with title 'Summing two numbers' : \n    + Too many @param's: z")
})

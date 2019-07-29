context("Smoke")


test_that("@tests captures tests", {
  out <- roxygen2::roc_proc_text(roxygen2::rd_roclet(), "
    #' @name a
    #' @title a
    #'
    #' @examples a <- 2
    #'
    NULL")[[1]]
  
  out <- roxygen2::roc_proc_text(roxytest::testthat_roclet(), "
    #' @tests 
    #' a <- 2
    #'
    NULL",
                                 registry = roclet_tags.roclet_testthat())
  
  
  out <- roxygen2::roc_proc_text(roxygen2::rd_roclet(), "
    #' @name Test
    #'
    #'
    NULL")[[1]]
  
  #examples <- get_tag(out, "examples")$values
  #expect_match(examples, fixed("a <- 2"), all = FALSE)
})
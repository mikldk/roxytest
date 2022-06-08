#' Roclet: check presence of `@return` in documentation for exported functions
#' 
#' @family roclets
#' @description This roclet checks presence of `@return` that 
#' generates `\value` in `Rd` files.
#' 
#' Generally you will not call this function directly
#' but will instead use [roxygen2::roxygenise()] specifying this roclet.
#' 
#' @examples
#' x <- "#' Summing two numbers\n#'\n#' @export\nf <- function(x, y) {\n   x + y\n}\n"
#' cat(x)
#' roxygen2::roc_proc_text(return_roclet(), x)
#' 
#' @return
#' A roclet to be used e.g. with [roxygen2::roxygenise()]
#' 
#' @seealso Other roclets:
#' \code{\link{testthat_roclet}},
#' \code{\link{tinytest_roclet}},  
#' \code{\link{param_roclet}},
#' \code{\link{examples_roclet}}, 
#' \code{\link[roxygen2]{namespace_roclet}}, 
#' \code{\link[roxygen2]{rd_roclet}},
#' \code{\link[roxygen2]{vignette_roclet}}.
#' 
#' @importFrom roxygen2 roclet
#' 
#' @export
return_roclet <- function() {
  roxygen2::roclet("return")
}

#' @importFrom roxygen2 block_get_tags block_get_tag_value
#' @importFrom roxygen2 roclet_process
#' @importFrom methods formalArgs
#' 
#' @export
roclet_process.roclet_return <- function(x, blocks, env, base_path) {
  blocks <- collect_annotate_rdname(blocks)
  
  warns <- list()
  
  for (block in blocks) {
    block_obj <- block$object
    
    if (!inherits(block_obj, "function")) {
      next
    }
    
    if (length(roxygen2::block_get_tags(block, "export")) == 0L) {
      # Block does not have @export
      next
    }
    
    # Block has @export
    
    if (length(roxygen2::block_get_tags(block, "return")) > 0L) {
      # Block has @return
      next
    }
    
    # Block has @export but no @return

    func_name <- block_obj$alias
      
    file_nm <- ""
    if (!is.null(attr(block, "filename"))) {
      file_nm <- paste0(" [in '", attr(block, "filename"), "']: ")
    }
    
    block_title <- roxygen2::block_get_tag_value(block, "title")
    warn <- paste0("Function '", func_name, "()' with title '", block_title, "'", file_nm)
    warns <- c(warns, warn)
  }
  
  #print(warns)
  
  if (length(warns) > 0L) {
    message("Functions with @export but no @return:")
    message(paste0("  * ", warns, collapse = "\n"), sep = "")
  }
  
  return(NULL)
}

#' @export
roclet_output.roclet_return <- function(x, results, base_path, ...) {
  return(NULL)
}


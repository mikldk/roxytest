#' Roclet: check consistency of `param` documentation
#'
#' @family roclets
#' @description This roclet checks consistency between function arguments 
#' and the documentation. The idea is to catch such errors earlier than in 
#' an R CMD check.
#' 
#' Generally you will not call this function directly
#' but will instead use [roxygen2::roxygenise()] specifying this roclet.
#' 
#' @seealso Other roclets:
#' \code{\link{testthat_roclet}},
#' \code{\link{tinytest_roclet}},  
#' \code{\link{examples_roclet}},
#' \code{\link{return_roclet}}, 
#' \code{\link[roxygen2]{namespace_roclet}}, 
#' \code{\link[roxygen2]{rd_roclet}},
#' \code{\link[roxygen2]{vignette_roclet}}.
#' 
#' @importFrom roxygen2 roclet
#' 
#' @export
param_roclet <- function() {
  roxygen2::roclet("param")
}

#' @importFrom roxygen2 block_get_tags block_get_tag_value
#' @importFrom roxygen2 roclet_process
#' @importFrom methods formalArgs
#' 
#' @export
roclet_process.roclet_param <- function(x, blocks, env, base_path) {
  warns <- list()

  for (block in blocks) {
    block_obj <- block$object
    
    if (!inherits(block_obj, "function")) {
      next
    }
    
    fun_args <- formalArgs(block_obj$value)
    
    block_params <- roxygen2::block_get_tags(block, "param")
    block_params_names <- sort(unname(sapply(block_params, function(x) x$val$name), force = TRUE))
    
    if (!isTRUE(all.equal(fun_args, block_params_names))) {
      func_name <- block_obj$alias
      
      missing_params <- setdiff(fun_args, block_params_names)
      toomany_params <- setdiff(block_params_names, fun_args)
      msg <- ""
      if (length(missing_params) > 0) {
        msg <- paste0(msg, "\n    - Missing @param's: ", paste0(missing_params, collapse = ", "))
      }
      if (length(toomany_params) > 0) {
        msg <- paste0(msg, "\n    + Too many @param's: ", paste0(toomany_params, collapse = ", "))
      }
      
      file_nm <- ": "
      if (!is.null(attr(block, "filename"))) {
        file_nm <- paste0(" [in '", attr(block, "filename"), "']: ")
      }
      
      block_title <- roxygen2::block_get_tag_value(block, "title")
      warn <- paste0("Function '", func_name, "()' with title '", block_title, "'", file_nm, msg)
      warns <- c(warns, warn)
    }
  }
  
  if (length(warns) > 0L) {
    cat("Functions with @param inconsistency:\n")
    cat(paste0("  * ", warns, collapse = "\n"), sep = "")
    cat("\n")
  }
  
  return(NULL)
}

#' @export
roclet_output.roclet_param <- function(x, results, base_path, ...) {
  return(NULL)
}

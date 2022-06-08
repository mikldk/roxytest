# From roxygen2's R/utils.R:

has_quotes <- function (x) {
  #stringr::str_detect(x, "^('|\").*\\1$")
  grepl("^('|\").*\\1$", x)
}
 
is_syntactic <- function (x)  {
  make.names(x) == x 
}

auto_quote <- function (x) {
  needs_quotes <- !has_quotes(x) & !is_syntactic(x)
  x[needs_quotes] <- encodeString(x[needs_quotes], quote = "\"")
  x
}


# @rdname: All are added together
collect_annotate_rdname <- function(blocks) {
  
  #blocks <<- blocks
  #print(blocks)
  
  rdnameblocks <- list()
  otherblocks <- list()
  
  for (block in blocks) {
    block_rdname <- roxygen2::block_get_tags(block, "rdname")
    
    if (length(block_rdname) == 0L) {
      otherblocks[[length(otherblocks) + 1L]] <- block
      next
    }
    
    if (length(block_rdname) >= 2L) {
      stop("Did not expect two @rdname's in a block")
    }
    
    # length(block_rdname) == 1:
    block_rdname <- block_rdname[[1L]]
    
    if (is.null(rdnameblocks[[ block_rdname$val  ]])) {
      rdnameblocks[[ block_rdname$val  ]] <- block
    } else {
      rdnameblocks[[ block_rdname$val  ]]$tags <- c(
        rdnameblocks[[ block_rdname$val  ]]$tags, 
        block$tags
      )
    }
  }
  
  new_blocks <- c(rdnameblocks, otherblocks)
  
  return(new_blocks)
}

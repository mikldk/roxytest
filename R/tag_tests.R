# Adapted from roxygen2's tag_examples
tag_tests <- function(x) {
  if (x$val == "") {
    msg_extra <- ""
    
    if (x$file != "") {
      msg_extra <- paste0(" [", x$file, "#", x$line, "]")
    }
    
    msg <- paste0("[roxytest]: @", x$tag, msg_extra, ": requires a value")
    warning(msg)
    
    return(NULL)
  }
  
  x
}
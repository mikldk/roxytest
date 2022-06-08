# Based on
# https://github.com/mikldk/roxytest/issues/24
test_that("rdname", {
  out <- capture_messages(roxygen2::roc_proc_text(return_roclet(), "
    #' Who Am I?
    #'
    #' @return A tibble with user information 
    #'
    #' @export
    #' @rdname whoami
    #' @examples
    #' users_list(user = 'me')
    #' whoami()
    users_list <- function(user){
      NULL
    }
    
    #' @export
    #' @rdname whoami
    whoami <- function(){
       users_list(user = 'me')
    }"))
  #out
  
  expect_equal(0L, length(out))
})
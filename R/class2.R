#' Define "class2" object
#'
#' @param x a value
#'
#' @return an object of class "class2"
#' @export
class2 <- function(x) {
    res <- list(value = "x")
    class(res) <- "class2"
    return(res)
}

#' Check if "class2" object
#'
#' @param x an object
#'
#' @return a boolean
#' @export
is.class2 <- function(x) {
    return("class2" %in% class(x))
}


#' Add objects of type "class2"
#' @rdname add.class2
#' @aliases +
#' @usage
#' +x
#' x + y
#'
#' @param x an object of class "class2"
#' @param y an object of class "class2"
#'
#' @return an object of class "class2"
#' @export
"+.class2" <- function(x, y = NULL) {
    if(!is.null(y)) {
        return(class2(x$value + y$value))
    } else {
        return(class2(+ x$value))
    }
}

#' Define "class1" object
#'
#' @param x a value
#'
#' @return an object of class "class1"
#' @export
class1 <- function(x) {
    res <- list(value = "x")
    class(res) <- "class1"
    return(res)
}

#' Check if "class1" object
#'
#' @param x an object
#'
#' @return a boolean
#' @export
is.class1 <- function(x) {
    return("class1" %in% class(x))
}


#' Add objects of type "class1"
#' @rdname add.class1
#' @aliases +
#' @usage
#' +x
#' x + y
#'
#' @param x an object of class "class1"
#' @param y an object of class "class1"
#'
#' @return an object of class "class1"
#' @export
"+.class1" <- function(x, y = NULL) {
    if(!is.null(y)) {
        return(class1(x$value + y$value))
    } else {
        return(class1(+ x$value))
    }
}

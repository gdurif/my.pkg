# Issue when documenting new "+" S3 method with `roxygen2`

I am trying to define a new "+" S3 method in my package for a class `class1`. I use `roxygen2` to generate the function man page, and I encounter an issue when documentation the usage of the function, the issue being either a strange "Usage" section in the man page, or warnings when checking the package.

This "+" S3 method can take one or two operands like the standard addition:
```R
#' Add objects of type "class1"
#' @rdname add.class1
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
```

If I don't specify any `@usage` section in the `roxygen2` documentation chunk, when I generate the man page (with `devtools::document()`) and read the function doc (with `?"+.class1"`), I get the following in the "Usage" section of the man page (which is pretty incomprehensible to me):
```
## S3 method for class 'class1'
x + y = NULL
```

If I specify a `@usage` section in the `roxygen2` documentation chunk of the `+.class1` method, like this:
```R
#' Add objects of type "class1"
#' @rdname add.class1
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
```

I get a pretty "Usage" section in the man page:
```
+x
x + y
```

But I get a warning when checking the package:
```R
Objects in \usage without \alias in documentation object '+.class1':
  ‘+’
```

I can add an alias in the `roxygen2` documentation chunk with `@aliases +` like this:
```R
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
```

then the warning is gone, but in practice I am implementing two classes with their own "+" S3 method, then if I have a `@usage` tag (to get nice man page "Usage" section) and a `@aliases +` tag (to avoid the warning I just mentioned above) in both class `roxygen` documentation chunks (c.f. below), I get a new warning:

```
Rd files with duplicated alias '+':
  ‘add.class1.Rd’ ‘add.class2.Rd’
```

Definition of `class1` and `class2` "+" S3 methods:
```R
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
```

Sources to reproduce: https://github.com/gdurif/my.pkg

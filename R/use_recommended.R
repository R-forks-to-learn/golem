#' Add recommended elements
#' 
#' \describe{
#'   \item{use_recommended_deps}{Adds `shiny`, `DT`, `attempt`, `glue`, `golem`, `htmltools` to dependencies}
#'   \item{use_recommended_tests}{Adds a test folder and copy the golem tests}
#' }
#'
#' @inheritParams add_module
#' @param recommended A vector of recommended packages.
#' 
#' @importFrom usethis use_testthat use_package
#' @importFrom fs path_abs
#' @rdname use_recommended 
#' 
#' @export
use_recommended_deps <- function(
  pkg = get_golem_wd(),
  recommended = c("shiny","DT","attempt","glue","htmltools","golem")
){
  old <- setwd(path_abs(pkg))
  on.exit(setwd(old))
  for ( i in sort(recommended)){
    try(use_package(i))
  }
  cat_green_tick("Dependencies added")
}


#' @rdname use_recommended 
#' @export
#' @importFrom usethis use_testthat use_package
#' @importFrom utils capture.output
#' @importFrom attempt without_warning
#' @importFrom fs path_abs path
use_recommended_tests <- function (
  pkg = get_golem_wd()
){
  old <- setwd(path_abs(pkg))
  
  on.exit(setwd(old)) 
  
  if (!dir.exists(
    path(path_abs(pkg), "tests")
  )){
    without_warning(use_testthat)()
  }
  capture.output(use_package("processx"))
  
  file_copy(
    golem_sys("utils", "test-golem-recommended.R"), 
    path(old, "tests", "testthat")
  )
  cat_green_tick("Tests added")
} 



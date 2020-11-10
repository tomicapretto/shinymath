#' Launch demo shiny application
#'
#' @export
launch_demo = function() {
  shiny::runApp(shinymath_file("shiny"), display.mode = "normal")
}

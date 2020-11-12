#' Launch example shiny application
#' @export
launch_example = function() {
  shiny::runApp(shinymath_file("shiny", "example"), display.mode = "normal")
}

#' Launch shiny appl that show features
#' @export
launch_features = function() {
  shiny::runApp(shinymath_file("shiny", "features"), display.mode = "normal")
}

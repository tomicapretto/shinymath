updateMathInput = function(session = shiny::getDefaultReactiveDomain(), id, value) {
  session$sendInputMessage(id, value)
}

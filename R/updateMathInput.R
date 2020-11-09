updateMathInput = function(session = shiny::getDefaultReactiveDomain(),
                           inputId, label = NULL, value = NULL) {
  message = shiny:::dropNulls(list(label = label, value = value))
  session$sendInputMessage(inputId, message)
}

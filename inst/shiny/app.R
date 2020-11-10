library(shiny)

ui = fluidPage(
  mathInput("input1","Input a math expression"),
  mathInput("input2","Input a math expression 2"),
  verbatimTextOutput("output1"),
  verbatimTextOutput("output2"),
  actionButton("update", "Update inputs!")
)

server = function(input, output, session) {
  output$output1 = renderText(input$input1)
  output$output2 = renderText(input$input2)
  observeEvent(input$update, {
    updateMathInput(session, "input1", label = "New label", value = "x + y")
    updateMathInput(session, "input2", value = "\\frac{3}{7}")
  })
}

shinyApp(ui, server)

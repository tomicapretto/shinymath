library(shiny)

ui = fluidPage(
  mathInput("input1","Input a math expression"),
  mathInput("input2","Input a math expression 2"),
  verbatimTextOutput("output1"),
  verbatimTextOutput("output2")
)

server = function(input, output, session){
  output$output1 = renderText(input$input1)
  output$output2 = renderText(input$input2)
}

shinyApp(ui, server)

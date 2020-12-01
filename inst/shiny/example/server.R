source("server_utils.R")

function(input, output, session) {
  equations = Equations$new("x")
  observeEvent(input$btn_add, {
    expr = latex2fun_safe(input$math)
    req(is.function(expr))

    id = equations$add(input$math, expr)
    add_equation(equations, id, output, session)
    observeEvent(input[[paste0("btn_remove_", id)]], {
      removeUI(paste0("#", session$ns(paste0("div_", id))))
      equations$remove(id)
    }, ignoreInit = TRUE)
  })
}

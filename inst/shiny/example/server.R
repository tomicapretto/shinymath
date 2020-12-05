source("server_utils.R")

function(input, output, session) {

  equations = Equations$new("x",  c(-10, 10))

  observeEvent(input$btn_add, {
    expr = latex2fun_safe(input$math)
    req(is.function(expr))

    id = equations$add(input$math, expr)
    add_equation(equations, id, output, session)
    add_params(equations, id)

    observeEvent(input[[paste0("btn_remove_", id)]], {
      removeUI(paste0("#", session$ns(paste0("div_", id))))
      remove_params(equations, id)
      equations$remove(id)
    }, ignoreInit = TRUE)
  }, priority = 1)

  data = eventReactive(input$btn_add, {
    args = list("a" = 3, "b" = 5, "c" = 3)
    equations$evaluate_all(args)
  })

  output$plot = renderEcharts4r({
    data() %>%
      group_by(name) %>%
      e_charts(grid) %>%
      e_grid(top = 40, left = 50, right = 40, bottom = 50) %>%
      e_line(value, type = "line", symbol = "none", clip = TRUE) %>%
      e_x_axis(
        min = -20,
        max = 20,
        minorTick = list(show = TRUE),
        splitLine = list(
          lineStyle = list(color = '#999')
        ),
        minorSplitLine = list(
          show = TRUE,
          lineStyle = list(color = '#ddd')
        )
      ) %>%
      e_y_axis(
        min = -20,
        max = 20,
        minorTick = list(show = TRUE),
        splitLine = list(
          lineStyle = list(color = '#999')
        ),
        minorSplitLine = list(
          show = TRUE,
          lineStyle = list(color = '#ddd')
        )
      ) %>%
      e_datazoom(
        type = "inside",
        x_index = 0,
        startValue = -10,
        endValue = 10,
        toolbox = FALSE
      ) %>%
      e_datazoom(
        type = "inside",
        y_index = 0,
        startValue = -10,
        endValue = 10,
        toolbox = FALSE
      ) %>%
      e_legend(
        orient = "vertical",
        right = "10%",
        top = "10%"
      )
  })

}

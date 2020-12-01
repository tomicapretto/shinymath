latex2fun_safe = function(code) {
  tryCatch({
    latex2fun(code)
  },
  latex2r.error = function(cnd) {
    showNotification(
      paste("Error when translating to R code -", cnd$message),
      type = "error"
    )
  },
  error = function(cnd) {
    showNotification("Unexpected error", type = "error")
  })
}

delete_button = function(id) {
  actionButton(
    inputId = paste0("btn_remove_", id),
    label = "",
    icon = icon("window-close"),
    style = paste("padding: 1px 4px", "background-color: transparent",
                  "border-color: transparent", "color: #FFF",
                  "margin: 10px 5px 6px 15px", sep = ";")
  )
}

add_param_slider = function(params) {
  ids = paste0("param_", params)
  mapply(slider_input_div, ids, params, min = -5, max = 5, value = 2, step = 0.1,
         width = "100%", SIMPLIFY = FALSE, USE.NAMES = FALSE)
}

slider_input_div = function(id, ...) {
  div(
    id = paste0("div_", id),
    sliderInput(id, ...)
  )
}

add_equation = function(equations, id, output, session) {
  ns = session$ns
  insertUI(
    selector = "#equations",
    ui = div(
      id = paste0("div_", id),
      fluidRow(
        column(
          width = 9,
          uiOutput(ns(id))
        ),
        column(
          width = 1,
          delete_button(id)
        ),
        style = "margin-left:0px; margin-right:0px"
      )
    )
  )

  output[[id]] = renderUI({
    tagList(
      tags$p(equations$get_katex_code(id), style = "margin:10px 10px"),
      tags$script(
        paste0(
          'renderMathInElement(
           document.getElementById("', id, '"),
            {delimiters: [{left: "$", right: "$", display: false}]}
        );'
        )
      )
    )
  })
}

add_params = function(equations, id) {
  params = equations$get_args_unique(id)
  if (length(params) > 0) {
    insertUI(
      selector = "#parameters",
      ui = div(
        fluidRow(
          column(
            width = 12,
            add_param_slider(params)
          ),
          style = "margin-left:0px; margin-right:0px"
        )
      )
    )
  }
}

remove_params = function(equations, id) {
  params = equations$get_args_unique(id)
  if (length(params) > 0) {
    lapply(paste0("#div_param_", params), removeUI)
  }
}

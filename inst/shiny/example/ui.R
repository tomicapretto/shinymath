library(shiny)
library(shinydashboard)
library(shinymath)
library(echarts4r)
source("utils.R")

body = function() {
  dashboardBody(
    tags$head(
      tags$link(
        rel = "stylesheet",
        href = "https://cdn.jsdelivr.net/npm/katex@0.10.1/dist/katex.min.css",
        integrity = "sha384-dbVIfZGuN1Yq7/1Ocstc1lUEm+AT+/rCkibIcC/OmWo5f0EA48Vf8CytHzGrSwbQ",
        crossorigin = "anonymous"
      ),
      HTML('<script defer src="https://cdn.jsdelivr.net/npm/katex@0.10.1/dist/katex.min.js" integrity="sha384-2BKqo+exmr9su6dir+qCw08N2ZKRucY4PrGQPPWU1A7FtlCGjmEGFqXCv5nyM5Ij" crossorigin="anonymous"></script>'),
      HTML('<script defer src="https://cdn.jsdelivr.net/npm/katex@0.10.1/dist/contrib/auto-render.min.js" integrity="sha384-kWPLUVMOks5AQFrykwIup5lo0m3iMkkHrD0uJ4H5cjeGihAutqP0yW0J6dpFiVkI" crossorigin="anonymous"></script>'),
      HTML('
    <script>
      document.addEventListener("DOMContentLoaded", function() {
        renderMathInElement(document.body, {
          delimiters: [{left: "$", right: "$", display: false}]
        });
      })
    </script>')
    ),
    # Need to capture screen size and use that for height
    echarts4rOutput("plot", height = "700px")
  )
}

sidebar = function() {
  dashboardSidebar(
    width = 300,
    tags$style(
      "#sidebarItemExpanded {
            overflow: auto;
            max-height: 97.5vh;
        }"
    ),
    mathInput("math", "Write a function"),
    actionButton("btn_add", "Add function"),
    div(id = "equations"),
    div(id = "parameters")
  )
}

ui = function() {
  shinydashboard::dashboardPage(
    title = "mathInput demo",
    header = dashboardHeader(title = "mathInput demo", titleWidth = 300),
    body = body(),
    sidebar = sidebar()
  )
}

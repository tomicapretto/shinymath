shinymath_file = function(...) {
  system.file(..., package = "shinymath", mustWork = TRUE)
}

mathInputDeps = function() {
  htmltools::htmlDependency(
    name = "mathInput",
    version = "1.0.0",
    src = c(file = shinymath_file("assets")),
    script = c("mathquill.min.js", "init.js", "binding.js"),
    stylesheet = "mathquill.css"
  )
}

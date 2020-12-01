library(R6)

Equations = R6Class(
  "Equations",
  public = list(
    equations = list(),
    variable = NULL,
    initialize = function(variable) {
      self$variable = variable
    },
    add = function(expr, fun) {
      idx = self$new_idx()
      id = self$new_id()
      equation = list("idx" = idx, "expr" = expr, "fun" = fun,
                      "args" = formalArgs(fun))
      self$equations[[id]] = equation
      return(id)
    },
    remove = function(id) {
      self$equations[[id]] = NULL
    },
    new_id = function() {
      id = paste0(sample.int(9999, 1), paste(sample(letters, 4), collapse = ""))
      if (id %in% names(self$equations)) id = self$new_id()
      return(id)
    },
    new_idx = function() {
      idxs = unlist(lapply(self$equations, `[[`, "idx"), use.names = FALSE)
      idxs_seq = seq(length(self$equations))
      if (length(setdiff(idxs_seq, idxs)) > 0) {
        idx = setdiff(idxs_seq, idxs)[1]
      } else {
        idx = length(self$equations) + 1
      }
      return(idx)
    },
    get_katex_code = function(id) {
      expr = self$equations[[id]][["expr"]]
      idx = self$equations[[id]][["idx"]]
      paste0("$", "f_{", idx, "}(x) = ", expr, "$")
    },
    get_args = function(id = NULL) {
      if (is.null(id)) {
        args = unlist(lapply(self$equations, `[[`, "args"), use.names = FALSE)
      } else {
        args = self$equations[[id]][["args"]]
      }
      setdiff(args, self$variable)
    },
    get_args_without_id = function(id) {
      eqs = self$equations
      eqs[[id]] = NULL
      unlist(lapply(eqs, `[[`, "args"), use.names = FALSE)
    },
    get_args_unique = function(id = NULL) {
      setdiff(self$get_args(id), self$get_args_without_id(id))
    }
  )
)

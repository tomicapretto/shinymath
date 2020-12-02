library(R6)

Equations = R6Class(
  "Equations",
  public = list(
    equations = list(),
    variable = NULL,
    domain = NULL,
    initialize = function(variable, domain) {
      self$variable = variable
      self$domain = domain
      private$generate_grid()
    },
    add = function(expr, fun) {
      idx = self$new_idx()
      id = self$new_id()
      args = formalArgs(fun)
      name = paste0("f_{", idx, "}(x)")
      equation = list("idx" = idx, "expr" = expr, "fun" = fun, "args" = args,
                      "name" = name)
      self$equations[[id]] = equation
      return(id)
    },
    remove = function(id) {
      self$equations[[id]] = NULL
    },
    new_id = function() {
      id = paste0(paste(sample(letters, 4), collapse = ""), sample.int(9999, 1))
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
      name = self$equations[[id]][["name"]]
      paste0("$", name, " = ", expr, "$")
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
    },
    evaluate = function(id, args) {
      # 'args' must be a named list
      fun = self$equations[[id]][["fun"]]
      fun_args = self$equations[[id]][["args"]]
      # Of all the args passed, only keep the ones in the function
      args = args[setdiff(fun_args, self$variable)]
      if (self$variable %in% fun_args) {
        x_list = list(private$grid)
        names(x_list) = self$variable
        args = c(x_list, args)
      }
      do.call(fun, args)
    },
    evaluate_all = function(args) {
      output = lapply(names(self$equations), function(id, args) {
        list(
          "name" = self$equations[[id]][["name"]],
          "fun_values" =  self$evaluate(id, args)
        )
      }, args = args)
      names(output) = names(self$equations)
      c(list("grid" = private$grid), output)
    }
  ),
  private = list(
    grid = NULL,
    generate_grid = function() {
      private$grid = seq(self$domain[1], self$domain[2], length.out = 1000)
    }
  )
)

# A la hora de evaluar las funciones devuelve una grilla comun,
# y una lista que contiene listas nombradas por el "ID" de la funcion.
# Esas listas tiene un campo que es "nombre" que es el f_idx(x) y "fun" que es el valor
# de la funcion en la grilla.


**This package is under development. You can use `mathInput()` if you
want but be aware changes may come**

**Example app is not finished yet.**

# shinymath

`shinymath` is a small R package that provides a mathematical input to
shiny apps. This input is based on [Mathquill](http://mathquill.com/)
and by default returns a LaTeX expression. This package also uses
functions from [`latex2r`](https://github.com/tomicapretto/latex2r) that
make it possible to transform the LaTeX expressions to R code/functions.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("tomicapretto/shinymath")
```

## Basic usage

Within your UI, you call `mathInput()` as you would do with any other
input.

``` r
mathInput(inputId = "equation", label = "Math equation")
```

## Example

Currently, the app has a small shiny app that shows all the features of
`mathInput()` and functions exported from `latex2r` package. Use
`launch_features()` to see it.

<hr style="height:1px">

</hr>

Here I’m going to include an example of how to set up a minimal app with
`shinymath`.

``` r
library(shinymath)
# TODO
```

## Notes

While you can write any math that is accepted by Mathquill, not
everything can be translated to R. Since this package relies on the
parser in `latex2r` for translation purposes, it comes with all the
limitations there. For more information about the particularities of
`latex2r`, see [these
notes](https://github.com/tomicapretto/latex2r/blob/master/README.md#supported-latex).

However, many *common* mathematical equations can be written and
translated to R code with no problem.
[Here](https://github.com/tomicapretto/latex2r#examples-1) you have a
list of math equations in LaTeX and their corresponding translation to
R.

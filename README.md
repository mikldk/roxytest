
<!-- README.md is generated from README.Rmd. Please edit only README.Rmd! -->
<!-- badges: start -->

[![R build
status](https://github.com/mikldk/roxytest/workflows/R-CMD-check/badge.svg)](https://github.com/mikldk/roxytest/actions)
<!-- badges: end -->

# roxytest

Inline tests with
[`roxygen2`](https://cran.r-project.org/package=roxygen2) using
[`testthat`](https://cran.r-project.org/package=testthat) or
[`tinytest`](https://cran.r-project.org/package=tinytest). In addition,
there are a few roclets that aim at catching common documentation issues
during the development cycle.

See demo package using this at
[`roxytestdemo`](https://github.com/mikldk/roxytestdemo).

## Install

To build and install from Github run this command from within `R`:

    remotes::install_github("mikldk/roxytest", 
                            build_opts = c("--no-resave-data", "--no-manual"))

You can also install the package without vignettes if needed as follows:

    remotes::install_github("mikldk/roxytest")

## Documentation

Please refer to this `README` as well as the included manual pages as
well as the vignette, all also available online at
<https://mikldk.github.io/roxytest/>.

## Usage

There are a number of roclets included:

- `testthat_roclet`
- `tinytest_roclet`
- `param_roclet`
- `return_roclet`
- `examples_roclet`

Please refer to the
“[Introduction](https://mikldk.github.io/roxytest/articles/introduction.html)”
vignette for details on these.

To use the package in your own package you do not need to add any
additional dependencies in your package’s `DESCRIPTION` file. Simply add
the following lines to your package’s `DESCRIPTION` file (or any other
of the roclets mentioned above):

    Roxygen: list(roclets = c("namespace", "rd", "roxytest::testthat_roclet"))

## Notes

### Document package keyboard shortcut

In RStudio, `CTRL+SHIFT+D`/`CMD+SHIFT+D` option does not run
`devtools::document()` but only
`devtools::document(roclets=c('rd', 'collate', 'namespace'))` (possibly
with fewer depending on the project options, but not none).

Instead, you can use `devtools`’ `document()`
[addin](https://github.com/r-lib/devtools/pull/2188) (see e.g. [Rstudio
documentation](https://rstudio.github.io/rstudioaddins/)), and override
the keyboard shortcut.

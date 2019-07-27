# roxytest

Inline tests with roxygen and testthat.

See demo package using this at [roxytest-demo](https://github.com/mikldk/roxytest-demo).

## Usage

Add the following lines to your package's `DESCRIPTION` file:
```
Imports:
    roxygen2, 
    testthat,
    roxytest
Roxygen: list(roclets = c("namespace", "rd", "testthat_roclet"))
```
(Or make appropriate changes to obtain similar results.)
 

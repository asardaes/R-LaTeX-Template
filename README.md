# R-LaTeX-Template
This is just a barebone template that shows how to organize files in order to generate a LaTeX report directly from `R` 
by using the `knitr` package. The example here is for a basic thesis file, although the document class is not so important.
See [this branch](https://github.com/asardaes/R-LaTeX-Template/tree/cued) for an example with a different template.

You can use a combination of `tex` and `Rnw` files to write everything, and the compilation can be done in Windows and Linux
in 3 ways:
* By directly running the `.bat` or `.sh` scripts (double click or command line)
  + This performs any updates done to `tex` files without running any `R` code
* Calling the `.bat` or `.sh` scripts followed by `FALSE`
  + This also runs all the `R` code *sequentially*
* Calling the `.bat` or `.sh` scripts followed by `TRUE`
  + This also runs all the `R` code with *parallel* support

You must have `Rscript` on your path for the last two options. Also, you'll need the `doParallel` package for the last option.

Examples (Linux):
```
./compile-linux.sh
./compile-linux.sh FALSE
./compile-linux.sh TRUE
```

The PDF file contains more specifics and explanations of the sample content.

Used `R` packages in this sample

* xtable
* ggplot2
* reshape2
* caret
* randomForest

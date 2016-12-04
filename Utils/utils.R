# ===========================================================================================================
# Libraries
# ===========================================================================================================

library(xtable) # latex tables
library(ggplot2) # plots
library(reshape2) # for melt()
library(caret) # to train models
library(randomForest) # for rf

# ===========================================================================================================
# Default function to create and print a latex table with the 'xtable' package
# ===========================================================================================================

make_table <- function(df, ...) {
    require(xtable)
    
    dots <- list(...)
    
    if (!is.null(dots$caption) && length(dots$caption) == 1L)
        dots$caption <- c(dots$caption, strsplit(dots$caption, "[[:punct:]]")[[1L]][1L])
    
    defaults <- list(
        align = c("l", rep("c", ncol(df))),
        label = paste0("tab:", as.character(substitute(df)), collapse = ""),
        table.placement = "htbp",
        caption.placement = "top",
        caption.width = NULL,
        booktabs = TRUE
    )
    
    if (!is.null(dots$include.rownames) && !dots$include.rownames)
        defaults$align[2L] <- "l"
    
    defaults <- defaults[setdiff(names(defaults), names(dots))]
    my_args <- c(list(x = df), defaults, dots)
    table <- do.call("xtable", my_args)
    
    my_args$x <- table
    do.call("print.xtable", my_args)
}

NULL

# ===========================================================================================================
# Uncached libraries
# ===========================================================================================================

library(tools) # for md5sum()

# ===========================================================================================================
# knitr hook to load utils if needed
# ===========================================================================================================

utils_hook <- function(before, options, envir) {
    # Notice that path is relative to root file Thesis.Rnw
    if (before) source("Utils/utils.R")
    invisible(NULL)
}

# ===========================================================================================================
# seeds hook to load and restore random seeds
# ===========================================================================================================

seeds_hook <- function(before, options, envir) {
    # Notice that path is relative to root file Thesis.Rnw
    if (before) {
        if (is.null(seeds[[options$label]])) {
            seeds[[options$label]] <<- .GlobalEnv$.Random.seed
        } else {
            assign(".Random.seed", seeds[[options$label]], globalenv())
        }
    }
    
    invisible(NULL)
}

# ===========================================================================================================
# Custom MD5 function to make sure that the file exists
# ===========================================================================================================

md5 <- function(path) {
    hash <- tools::md5sum(path)
    if (is.na(hash)) stop(paste("Couldn not find file:", as.character(path)))
    hash
}

# ===========================================================================================================
# Custom cleaning function
# ===========================================================================================================

clean_workspace <- function(env = parent.frame(), exclude = character(0L), load.utils = FALSE) {
    vars <- ls(env)
    exclude <- c("md5", "clean_workspace", "seeds", exclude) # for parallel workers
    vars <- setdiff(vars, exclude)
    rm(list = vars, pos = env)
    
    # I only have two levels of folders, and this could be called from either
    if (load.utils) {
        if (file.exists("Utils/utils.R"))
            source("Utils/utils.R", local = env)
        else if (file.exists("../Utils/utils.R"))
            source("../Utils/utils.R", local = env)
        else
            stop("Could not find utils.R")
    }
    
    gc()
    invisible(TRUE)
}

NULL

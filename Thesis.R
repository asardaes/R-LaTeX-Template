library(knitr)
library(foreach)

# Read arguments
cmd_args <- commandArgs(TRUE)
file_name <- cmd_args[1L]
do_par <- isTRUE(as.logical(cmd_args[2L]))

# Load random seeds
if (file.exists("Data/seeds.RData")) {
    message("Loading existing seeds...")
    load("Data/seeds.RData")
} else {
    message("Creating new seeds...")
    seeds <- list()
}

# Helper functions that should always be loaded
source("Utils/utils-nocache.R")

# Create parallel workers
if (do_par) {
    library(doParallel)
    
    workers <- makeCluster(detectCores())
    
    invisible(clusterEvalQ(workers, source("Utils/utils-nocache.R")))
    invisible(clusterEvalQ(workers, source("Utils/utils.R")))
    
    registerDoParallel(workers)
    
} else {
    registerDoSEQ()
}

# Knit
out <- try(knit(paste0(file_name, ".Rnw"), envir = new.env()))

# If there was an error, delete temporary .tex file
if (inherits(out, "try-error") && file.exists(paste0(file_name, ".tex")))
    file.remove(paste0(file_name, ".tex"))

# Stop workers
if (do_par) stopCluster(workers)

# Save random seeds
save(seeds, file = "Data/seeds.RData")

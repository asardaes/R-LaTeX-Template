library(knitr)

cmd_args <- commandArgs(TRUE)

file_name <- cmd_args[1L]
do_par <- as.logical(cmd_args[2L])

if (isTRUE(do_par)) {
     library(doParallel)

     if (.Platform$OS.type == "windows") {
          cl <- makeCluster(detectCores())
     } else {
          cl <- makeCluster(detectCores(), "FORK")
     }

     invisible(clusterEvalQ(cl, source("Utils/utils-nocache.R")))
     invisible(clusterEvalQ(cl, source("Utils/utils.R")))

     registerDoParallel(cl)
}

out <- try(knit(paste0(file_name, ".Rnw"), envir = new.env()))

if ( inherits(out, "try-error") && file.exists(paste0(file_name, ".tex")) )
     file.remove(paste0(file_name, ".tex"))

if (isTRUE(do_par))
     stopCluster(cl)

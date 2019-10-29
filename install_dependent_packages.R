#!/usr/bin/env Rscript
"""
to run this script use following command
Rscript --vanilla install_dependent_packages.R <the folder path of the project description file>
i.e. Rscript --vanilla install_dependent_packages.R /opt/app/r-package/
"""

args = commandArgs(trailingOnly=TRUE)

if (length(args)==0) {
  print(paste("DESCRIPTION file wil be read from the current working directory: ", getwd()), call=FALSE)
} else if (length(args)==1) {
    print(paste('Current Working directory is seetting to : ', args[[1]]))
    setwd(args[[1]])
}

dsc <- desc::description$new()
dp <- dsc$get_deps()
for(i in 1:nrow(dp)){
    version = strsplit(dp[i,'version'], " ")[[1]][-1]
    devtools::install_version(dp[i,'package'], version=version, upgrade="never", repos="http://cran.us.r-project.org")
}


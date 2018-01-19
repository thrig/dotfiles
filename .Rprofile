# Along come system upgrade time:
#   update.packages(checkBuilt=TRUE, ask=FALSE)

# make prompt more unique so feed(1) can more easily match it
options(prompt="rrr> ")

.First <- function() {
  repolist = c("http://cran.fhcrc.org","http://ftp.osuosl.org/pub/cran/","http://cran.stat.ucla.edu/","http://cran.cnr.Berkeley.edu")
  u = unlist(repolist)
  options("repos" = utils::relist(u[sample(length(u))],skeleton=repolist))
}

.Last <- function () {
  if (!any(commandArgs() == '--no-readline') && interactive()) {
    require(utils)
    try(savehistory(Sys.getenv("R_HISTFILE")))
  }
}

if (Sys.getenv("R_HISTFILE") == "") {
  Sys.setenv(R_HISTFILE=file.path("~", ".Rhistory"))
}

# but this makes noise, disable output temporarily, or .. ?
#suppressPackageStartupMessages(TRUE)

# NOTE libraries in startup can be a bad idea if the library is not
# already installed...
#library(ggplot2)

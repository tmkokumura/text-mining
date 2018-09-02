# import libraries --------------------------
library(rvest)
library(dplyr)
library(magrittr)
library(RMeCab)
library(logging)

# import utils ------------------------------
source("src/scraping.R")
source("src/util/character-util.R")

# log setting -------------------------------
logReset()

LOG.FILE <- "rscript.log"  # log file name
LOGGER <- "main.logger"     # logger name
LEVEL <- "DEBUG"            # log level

formatter <- function(record) {
  msg <- record$msg
  timestamp <- record$timestamp
  levelname <- record$levelname
  sprintf("[%s][%s] %s", timestamp, levelname, msg)
}

addHandler(writeToFile, formatter = formatter, logger = LOGGER, file = LOG.FILE, level = LEVEL)

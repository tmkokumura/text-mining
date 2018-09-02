# set working directory -------------
setwd("C:/Users/okumura.tomoki/RProject/text-mining/")

# import libraries --------------------------
library(rvest)
library(dplyr)
library(magrittr)
library(RMeCab)
library(logging)

# import utils ------------------------------
source("src/func/scraping-func.R")
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

# get command args -------------------------
command.args <- commandArgs(trailingOnly=TRUE)
func.name <- command.args[1]
func.param <- command.args[2:length(command.args)]

# execute fanction -------------------------
source("src/func/frequency-table-func.R", encoding = "UTF-8")
frequencyTable()

commandArgs(trailingOnly=TRUE)

# result code-------------------------------
print(0)



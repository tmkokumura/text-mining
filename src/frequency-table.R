library(rvest)
library(dplyr)
library(magrittr)
library(RMeCab)
library(luzlogr)

source("src/scraping.R")

# log settings
FILE.THIS <- "frequency-table.R"
FILE.LOG <- paste(c("log/", FILE.THIS, ".log"), collapse = "")
LOG.DEBUG <- -1
LOG.INFO <- 0
LOG.WARN <- 1
LOG.ERROR <- 2
logfile <- openlog(FILE.LOG, loglevel = LOG.DEBUG, append = T)

# scraping parameters
URL <- "https://www.amazon.co.jp/%E3%83%8E%E3%83%AB%E3%82%A6%E3%82%A7%E3%82%A4%E3%81%AE%E6%A3%AE-%E4%B8%8A-%E8%AC%9B%E8%AB%87%E7%A4%BE%E6%96%87%E5%BA%AB-%E6%9D%91%E4%B8%8A-%E6%98%A5%E6%A8%B9/dp/4062748681/ref=sr_1_14?s=books&ie=UTF8&qid=1535732835&sr=1-14&keywords=%E6%9D%91%E4%B8%8A%E6%98%A5%E6%A8%B9"
SELECTOR <- "div.a-expander-content.a-expander-partial-collapse-content"

# io file names
FILE.REVIEW <- "data/review.txt"
FILE.FREQUENCY.TABLE <- "data/frequency_table.csv"

# docDf parameters
DOC.DF.TYPE <- 1
DOC.DF.NDF <- 1
DOC.DF.N <- 2
DOC.DF.POS1 <- c("名詞", "形容詞", "動詞")
# DOC.DF.POS2 <- c("一般", "固有名詞", "自立")
DOC.DF.POS2 <- NULL

# frequency table parameters
COL.NM.FREQUENCY <- "FREQUENCY"
COL.IDX.FREQUENCY <- DOC.DF.N + 3

# main script --------------------------------------
printlog("start [", FILE.THIS, "]")

# read html
printlog("reading :", URL, level = LOG.INFO)
review <- getTextFromHtml(URL, SELECTOR)
printlog(head(review, 10))

# write review text
printlog("writing :", FILE.REVIEW, level = LOG.INFO)
writeLines(review, FILE.REVIEW)

# get frequency table
printlog("reading :", FILE.REVIEW)
ft <- docDF(FILE.REVIEW, type = DOC.DF.TYPE, nDF = DOC.DF.NDF, N = DOC.DF.N ,pos = DOC.DF.POS1)
names(ft)[COL.IDX.FREQUENCY] <- COL.NM.FREQUENCY
printlog(head(ft, 10), level = LOG.DEBUG)

# filterd by POS2
if (!is.null(DOC.DF.POS2)) {
  ft %<>% filter(POS2 %in% DOC.DF.POS2)
  printlog(head(ft, 10), level = LOG.DEBUG)
}

# decreasing sort by frequency
ft <- ft[order(ft$FREQUENCY, decreasing = T),]
printlog(head(ft, 10), level = LOG.DEBUG)

# write frequency table
printlog("writing :", FILE.FREQUENCY.TABLE)
write.table(ft, FILE.FREQUENCY.TABLE, quote = F, col.names = T, append = F)

printlog("end [", FILE.THIS, "]", level = LOG.INFO)
closelog(sessionInfo = F)
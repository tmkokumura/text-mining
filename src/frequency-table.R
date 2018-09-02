# set working directory -------------
setwd("C:/Users/okumura.tomoki/RProject/text-mining/")

# import common script -------------
source("src/common/common.R")

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
loginfo(concat("start [", FILE.THIS, "]"), logger = LOGGER)

# read html
loginfo(concat("reading :", URL), logger = LOGGER)
review <- getTextFromHtml(URL, SELECTOR)
logdebug(head(review, 10))

# write review text
loginfo(concat("writing :", FILE.REVIEW), logger = LOGGER)
writeLines(review, FILE.REVIEW)

# get frequency table
loginfo(concat("reading :", FILE.REVIEW), logger = LOGGER)
ft <- docDF(FILE.REVIEW, type = DOC.DF.TYPE, nDF = DOC.DF.NDF, N = DOC.DF.N ,pos = DOC.DF.POS1)
names(ft)[COL.IDX.FREQUENCY] <- COL.NM.FREQUENCY
logdebug(head(ft, 10), logger = LOGGER)

# filterd by POS2
if (!is.null(DOC.DF.POS2)) {
  ft %<>% filter(POS2 %in% DOC.DF.POS2)
  logdebug(head(ft, 10), logger = LOGGER)
}

# decreasing sort by frequency
ft <- ft[order(ft$FREQUENCY, decreasing = T),]
logdebug(head(ft, 10), logger = LOGGER)

# write frequency table
loginfo(concat("writing :", FILE.FREQUENCY.TABLE), logger = LOGGER)
write.table(ft, FILE.FREQUENCY.TABLE, quote = F, col.names = T, append = F)

loginfo(concat("end [", FILE.THIS, "]"), logger = LOGGER)

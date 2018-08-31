library(rvest)
library(dplyr)
library(magrittr)
library(RMeCab)

source("src/scraping.R")

URL <- "https://www.amazon.co.jp/%E3%83%9A%E3%83%B3%E3%82%AE%E3%83%B3%E3%83%BB%E3%83%8F%E3%82%A4%E3%82%A6%E3%82%A7%E3%82%A4-%E8%A7%92%E5%B7%9D%E6%96%87%E5%BA%AB-%E6%A3%AE%E8%A6%8B-%E7%99%BB%E7%BE%8E%E5%BD%A6-ebook/dp/B00AR76UAU/ref=lp_2220134051_1_1?s=books&ie=UTF8&qid=1535713741&sr=1-1"
SELECTOR <- "div.a-expander-content.a-expander-partial-collapse-content"
FILE.REVIEW <- "data/review.txt"
FILE.FREQUENCY.TABLE <- "data/frequency_table.csv"
DOC.DF.TYPE <- 1
DOC.DF.POS1 <- c("名詞", "形容詞", "動詞")
DOC.DF.POS2 <- c("一般", "固有名詞", "自立")
COL.NM.FREQUENCY = "FREQUENCY"
COL.IDX.FREQUENCY = 4

# read html
review <- getTextFromHtml(URL, SELECTOR)

# save review text
writeLines(review)

# get frequency table
ft <- docDF(FILE.REVIEW, type = DOC.DF.TYPE, pos = DOC.DF.POS1)
names(ft)[COL.IDX.FREQUENCY] <- COL.NM.FREQUENCY

# filterd by POS2
ft %<>% filter(POS2 %in% DOC.DF.POS2)

# decreasing sort by frequency
ft <- ft[order(ft$FREQUENCY, decreasing=T),]

# save frequency table
write.table(ft, FILE.FREQUENCY.TABLE, quote=F, col.names=T, append=F)
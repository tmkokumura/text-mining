# set working directory ----------------------------
setwd("C:/Users/okumura.tomoki/RProject/text-mining/")

# import common script -----------------------------
source("src/common/common.R", encoding = "UTF-8")

# define constant ----------------------------------
# this file name
THIS.FILE = "text-mining.R"

# io file names
REVIEW.FILE <- "data/review.txt"
FREQUENCY.TABLE.FILE <- "data/frequency_table.csv"

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
loginfo(concat("start [", THIS.FILE, "]"))

# get frequency table
loginfo(concat("reading :", FILE.REVIEW))
ft <- docDF(FILE.REVIEW, type = DOC.DF.TYPE, nDF = DOC.DF.NDF, N = DOC.DF.N ,pos = DOC.DF.POS1)
names(ft)[COL.IDX.FREQUENCY] <- COL.NM.FREQUENCY
logdebug(head(ft, 10))

# filterd by POS2
if (!is.null(DOC.DF.POS2)) {
  ft %<>% filter(POS2 %in% DOC.DF.POS2)
  logdebug(head(ft, 10))
}

# decreasing sort by frequency
ft <- ft[order(ft$FREQUENCY, decreasing = T),]
logdebug(head(ft, 10))

# write frequency table
loginfo(concat("writing :", FILE.FREQUENCY.TABLE))
write.table(ft, FILE.FREQUENCY.TABLE, quote = F, col.names = T, append = F)

loginfo(concat("end [", THIS.FILE, "]"))

# result code
print(0)
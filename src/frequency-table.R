# set working directory ----------------------------
setwd("C:/Users/okumura.tomoki/RProject/text-mining/")

# import common script -----------------------------
source("src/common/common.R")

# define constant ----------------------------------
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
loginfo(concat("start [", "thisfile", "]"), logger = LOGGER)

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

loginfo(concat("end [", "thisfile", "]"), logger = LOGGER)

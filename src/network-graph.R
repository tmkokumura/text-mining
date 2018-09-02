# set working directory ----------------------------
setwd("C:/Users/okumura.tomoki/RProject/text-mining/")

# import common script -----------------------------
source("src/common/common.R")

# define constant ----------------------------------
# this file name
THIS.FILE = "network-graph.R"

# io file names
BIGRAM.FILE <- "data/frequency_table.csv"

# tkplot params
VERTEX.COLOR = "SkyBlue"
VERTEX.SIZE = 22
CANVAS.WIDTH = 600
CANVAS.HEIGHT = 450

# main script --------------------------------------
loginfo(concat("start [", THIS.FILE, "]"))

loginfo("plotting network graph")
bigram <- read.table(BIGRAM.FILE)
bigramN <- bigram %>% head(15) %>% graph_from_data_frame()
tkplot(
  bigramN,
  vertex.color = VERTEX.COLOR, 
  vertex.size = VERTEX.SIZE, 
  canvas.width = CANVAS.WIDTH, 
  canvas.height = CANVAS.HEIGHT
)

loginfo(concat("end [", THIS.FILE, "]"))

# result code
print(0)
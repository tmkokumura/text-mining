# set working directory ----------------------------
setwd("C:/Users/okumura.tomoki/RProject/text-mining/")

# import common script -----------------------------
source("src/common/common.R")

# define constant ----------------------------------
# scraping parameters
URL <- "https://www.amazon.co.jp/%E3%83%8E%E3%83%AB%E3%82%A6%E3%82%A7%E3%82%A4%E3%81%AE%E6%A3%AE-%E4%B8%8A-%E8%AC%9B%E8%AB%87%E7%A4%BE%E6%96%87%E5%BA%AB-%E6%9D%91%E4%B8%8A-%E6%98%A5%E6%A8%B9/dp/4062748681/ref=sr_1_14?s=books&ie=UTF8&qid=1535732835&sr=1-14&keywords=%E6%9D%91%E4%B8%8A%E6%98%A5%E6%A8%B9"
SELECTOR <- "div.a-expander-content.a-expander-partial-collapse-content"

# io file names
REVIEW.FILE <- "data/review.txt"

# main script --------------------------------------
# read html
txt <- read_html(URL, encoding = "UTF-8") %>% html_nodes(SELECTOR) %>% html_text()

# change encode
txt <- iconv(txt, from = "UTF-8",to = "shift-jis")

# write review text
loginfo(concat("writing :", REVIEW.FILE), logger = LOGGER)
writeLines(review, REVIEW.FILE)
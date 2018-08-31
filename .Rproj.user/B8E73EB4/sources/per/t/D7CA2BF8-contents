library(rvest)
library(dplyr)
library(magrittr)
library(RMeCab)

URL <- "https://www.amazon.co.jp/%E3%83%9A%E3%83%B3%E3%82%AE%E3%83%B3%E3%83%BB%E3%83%8F%E3%82%A4%E3%82%A6%E3%82%A7%E3%82%A4-%E8%A7%92%E5%B7%9D%E6%96%87%E5%BA%AB-%E6%A3%AE%E8%A6%8B-%E7%99%BB%E7%BE%8E%E5%BD%A6-ebook/dp/B00AR76UAU/ref=lp_2220134051_1_1?s=books&ie=UTF8&qid=1535713741&sr=1-1"
SELECTOR_REVIEW <- "div.a-expander-content.a-expander-partial-collapse-content"

# read html
penguin <- read_html(URL, encoding = "UTF-8")

# get review text
reviews <- jobs %>% html_nodes(SELECTOR_REVIEW) %>% html_text()

# change encode
reviews <- iconv(reviews,from="UTF-8",to="shift-jis")

# get morpheme
morphemes <- reviews %>% extract2(1) %>% RMeCabC() %>% unlist()

# get frequency table
ft = docDF()

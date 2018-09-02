#' Get text from html
#' 
#' @param url Url of target HTML.
#' @param selector Css selector of target text.
#' @return text
getTextFromHtml <- function(url, selector) {
  # read html
  txt <- read_html(url, encoding = "UTF-8") %>% html_nodes(selector) %>% html_text()
  
  # change encode
  txt <- iconv(txt, from = "UTF-8",to = "shift-jis")
  
  return (txt)
}
library(rtweet)
library(dplyr)
library(gt)

canpl_token <- create_token(
  app = "CanPL_Analytics_Bot",
  consumer_key = Sys.getenv("TWITTER_API_KEY"),
  consumer_secret = Sys.getenv("TWITTER_API_SECRET"),
  access_token = Sys.getenv("TWITTER_ACCESS_TOKEN"),
  access_secret = Sys.getenv("TWITTER_ACCESS_TOKEN_SECRET")
)


tweet_message <- "Testing 1, 2, 3, hey hey hey es mi alberto grande"

post_res <- post_tweet(
  status = tweet_message, 
  token = canpl_token
)


post_res$content
post_res$url
post_res$status_code
post_res$headers




cpl_team_total_2021 <- read.csv(file = "data/CPLTeamTotals2021.csv")







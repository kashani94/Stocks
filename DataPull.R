#Retrieve data from Yahoo Finance
tickers = c("GOOGL", "NFLX", "AMZN", "AAPL", "VITAX")

prices <- tq_get(tickers2,
                 from = "2019-12-01",
                 to = "2020-05-20",
                 get = "stock.prices")

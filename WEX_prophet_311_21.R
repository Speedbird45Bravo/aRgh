library(BatchGetSymbols)
library(prophet)
library(dplyr)

start <- as.Date("2019-01-01")
end <- as.Date("2021-03-12")

df <- BatchGetSymbols("WEX", first.date=start, last.date=end) %>% as.data.frame()

df <- data.frame(df$df.tickers.ref.date, df$df.tickers.price.open)
names(df) <- c("ds", "y")

model <- prophet(df)
future <- make_future_dataframe(model, periods=365)

forecast <- predict(model, future)

plot(model, forecast, xlab="Date", ylab="$USD")
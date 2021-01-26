library(quantmod)
library(magrittr)
library(broom)
library(ggplot2)

start <- as.Date("2019-01-01")
end <- as.Date("2021-01-26")
syms <- c("AAPL", "DELL", "MSFT")

getSymbols(syms, src="yahoo", from=start, to=end)
stocks <- as.xts(data.frame(AAPL=AAPL[,"AAPL.Adjusted"], DELL=DELL[,"DELL.Adjusted"], MSFT=MSFT[,"MSFT.Adjusted"]))
names(stocks) <- syms
index(stocks) <- as.Date(index(stocks))

stock_plot <- tidy(stocks) %>%
  ggplot(aes(x=index, y=value, color=series)) + geom_line() + labs(title="AAPL, DELL, MSFT", subtitle="Adj. Close 2019-2021") + ylab("$USD")

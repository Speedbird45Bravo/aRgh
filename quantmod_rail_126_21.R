library(magrittr)
library(quantmod)
library(broom)
library(ggplot2)

start <- as.Date("2017-01-01")
end <- as.Date("2021-01-26")
syms <- c("CSX", "NSC")
getSymbols(syms, src="yahoo", from=start, to=end)
rails <- as.xts(data.frame(CSX=CSX[,"CSX.Adjusted"], NSC=NSC[,"NSC.Adjusted"]))
names(rails) <- syms
index(rails) <- as.Date(index(rails))

rail_plot <- tidy(rails) %>% ggplot(aes(x=index, y=value, color=series)) + geom_line() + labs(title="CSX + NSC", subtitle="Adjusted Close 2017-2021") + ylab("$USD")

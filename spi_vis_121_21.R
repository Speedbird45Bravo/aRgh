url <- 'https://projects.fivethirtyeight.com/soccer-api/club/spi_matches.csv'
df <- read.csv(url, header=TRUE)
df <- na.omit(df)
df$spi_margin = abs(df$spi1 - df$spi2)
df$margin = abs(df$score1 - df$score2)
attach(df)
plot(margin ~ spi_margin, col=rainbow(4))
detach()
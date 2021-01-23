url <- 'https://projects.fivethirtyeight.com/soccer-api/club/spi_matches.csv'
df <- read.csv(url, header=TRUE)
df <- na.omit(df)
attach(df)
spi_margin = abs(spi1 - spi2)
margin = abs(score1 - score2)
plot(margin ~ spi_margin, col=rainbow(4))
detach()

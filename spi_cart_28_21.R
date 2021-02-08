library(caret)
library(dplyr)

url <- 'https://projects.fivethirtyeight.com/soccer-api/club/spi_matches.csv'
df <- read.csv(url) %>% na.omit()
bpl <- df[df$league=='Barclays Premier League',]
gb <- df[df$league=='German Bundesliga',]

df <- rbind(bpl, gb)
df$league <- as.factor(df$league)

idx <- createDataPartition(df$league, p=0.8, list=FALSE)
test <- df[-idx,]
train <- df[idx,]

cart <- train(league ~ ., data=df, method="rpart", metric="Accuracy", trControl=trainControl(method="repeatedcv", number=10, repeats=3))
predictions <- predict(cart, test)
confusionMatrix(predictions, test$league)
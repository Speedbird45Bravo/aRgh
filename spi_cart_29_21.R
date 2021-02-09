library(caret)
library(dplyr)

url <- 'https://projects.fivethirtyeight.com/soccer-api/club/spi_matches_latest.csv'
df <- read.csv(url) %>% na.omit()
df$result <- ifelse(abs(df$score1 - df$score2) > 0, "RESULT", "TIE") %>% as.factor()
df <- df[,7:ncol(df)]

idx <- createDataPartition(df$result, p=0.8, list=FALSE)
test <- df[-idx,]
train <- df[idx,]
train$result <- factor(train$result)

cart <- train(result ~ ., data=train, method="rpart", metric="Accuracy", trControl=trainControl(method="cv", number=10))
predictions <- predict(cart, test)
confusionMatrix(predictions, test$result)
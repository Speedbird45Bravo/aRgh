library(caret)
library(dplyr)
library(randomForest)

url <- 'https://projects.fivethirtyeight.com/soccer-api/club/spi_matches_latest.csv'
df <- read.csv(url)
df$margin <- abs(df$score1 - df$score2)
df$result <- ifelse(df$margin > 0, "RESULT", "TIE")
df <- na.omit(df)
df <- df[,7:ncol(df)]
df$result <- factor(df$result)

idx <- createDataPartition(df$result, p=0.8, list=FALSE)
test <- df[-idx,]
train <- df[idx,]

met <- "Accuracy"
tc <- trainControl(method="cv", number=10)

cart <- train(result ~ ., data=train, method="rpart", metric=met, trControl=tc)
knn <- train(result ~ ., data=train, method="knn", metric=met, trControl=tc)
lda <- train(result ~ ., data=train, method="lda", metric=met, trControl=tc)

models <- resamples(list(cart=cart, knn=knn, lda=lda))
summary(models)

predictions <- predict(cart, test)
confusionMatrix(predictions, test$result)
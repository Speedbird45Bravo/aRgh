library(caret)
library(dplyr)

url <- 'https://projects.fivethirtyeight.com/soccer-api/club/spi_matches_latest.csv'
df <- read.csv(url)
df$result <- abs(df$score1 - df$score2)
df$result <- ifelse(df$result > 0, "OUTCOME", "DRAW")
df$result <- factor(df$result)
df <- df[,7:ncol(df)]
df <- na.omit(df)

idx <- createDataPartition(df$result, p=0.8, list=FALSE)
test <- df[-idx,]
train <- df[idx,]

met <- "Accuracy"
tc <- trainControl(method="cv", number=10) 
lda <- train(result ~ ., data=train, method="lda", metric=met, trControl=tc)
dtc <- train(result ~ ., data=train, method="rpart", metric=met, trControl=tc)
n_b <- train(result ~ ., data=train, method="naive_bayes", metric=met, trControl=tc)
nb <- train(result ~ ., data=train, method="nb", metric=met, trControl=tc)
rf <- train(result ~ ., data=train, method="rf", metric=met, trControl=tc)

mods <- resamples(list(lda=lda, dtc=dtc, n_b=n_b, nb=nb, rf=rf))
summary(mods)

predictions <- predict(rf, test)
confusionMatrix(predictions, test$result)
library(caret)
library(randomForest)
library(dplyr)
library(naive_bayes)

url <- 'https://raw.githubusercontent.com/jbrownlee/datasets/master/iris.csv'
df <- read.csv(url, header=FALSE)
names(df) <- c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width", "Species")
df$Species <- as.factor(df$Species)

attach(df)

index <- createDataPartition(Species, p=0.8, list=FALSE)
test <- df[-index,]
train <- df[index,]

metric <- "Accuracy"
tc <- trainControl(method="cv", number=10)

lda <- train(Species ~ ., data=train, method="lda", metric=metric, trControl=tc)
n_b <- train(Species ~ ., data=train, method="naive_bayes", metric=metric, trControl=tc)
rf <- train(Species ~ ., data=train, method="rf", metric=metric, trControl=tc)
rpart <- train(Species ~ ., data=train, method="rpart", metric=metric, trControl=tc)

mods <- resamples(list(lda=lda, n_b=n_b, rf=rf, rpart=rpart))
summary(mods)

predictions <- predict(lda, test)
confusionMatrix(predictions, test$Species)
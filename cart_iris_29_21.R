library(caret)
library(dplyr)

url <- 'https://raw.githubusercontent.com/jbrownlee/datasets/master/iris.csv'
df <- read.csv(url, header=FALSE)
names(df) <- c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width", "Species")
df$Species <- factor(df$Species)

idx <- createDataPartition(df$Species, p=0.8, list=FALSE)
test <- df[-idx,]
train <- df[idx,]

cart <- train(Species ~ ., data=train, method="rpart", metric="Accuracy", trControl=trainControl(method="cv", number=10))
predictions <- predict(cart, test)
confusionMatrix(predictions, test$Species)
library(caret)
library(e1071)
url <- 'https://raw.githubusercontent.com/jbrownlee/datasets/master/iris.csv'
df <- read.csv(url, header=FALSE)
names(df) <- c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width", "Species")

validation_index <- createDataPartition(df$Species, p=0.8, list=FALSE)
validation <- df[-validation_index, ]
df <- df[validation_index, ]
validation$Species <- as.factor(validation$Species)

lda <- train(Species ~ ., data=df, method="lda", metric="Accuracy", trControl=trainControl(method="cv", number=10))
predictions <- predict(lda, validation)
confusionMatrix(predictions, validation$Species)
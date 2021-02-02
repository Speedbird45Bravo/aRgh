library(e1071)

url <- 'https://raw.githubusercontent.com/jbrownlee/Datasets/master/iris.csv'
df <- read.csv(url, header=TRUE)
colnames(df) <- c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width", "Species")

validation_index <- createDataPartition(df$Species, p=0.8, list=FALSE)
validation <- df[-validation_index, ]
df <- df[validation_index, ]

df$Species <- as.factor(df$Species)

control <- trainControl(method="cv", number=10)
metric <- "Accuracy"

lda <- train(Species ~ ., data=df, method="lda", metric="Accuracy", trControl=trainControl(method="cv", number=10))
predictions <- predict(lda, validation)
confusionMatrix(predictions, validation$Species)
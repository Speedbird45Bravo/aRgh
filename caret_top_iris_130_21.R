library(caret)
library(dplyr)

url <- 'https://raw.githubusercontent.com/jbrownlee/Datasets/master/iris.csv'
df <- read.csv(url, header=TRUE) %>% na.omit()
names(df) <- c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width", "Species")

set.seed(42)

split_point <- round(nrow(df) * 0.8)
train <- df[1:split_point, ]
test <- df[(split_point + 1):nrow(df), ]
model <- lm(Sepal.Length ~ ., data=train)
predictions <- predict(model, test)
error <- predictions - df[['Sepal.Length']]
rmse <- sqrt(mean(error ** 2))
model <- train(Sepal.Length ~ ., df, method="lm", trControl=trainControl(method="cv", number=10, verboseIter=TRUE))
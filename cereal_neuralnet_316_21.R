library(neuralnet)
library(caret)

# The data comes from a dataset on cereals, featuring a number of numerical variables. 
# We will fit the neural network and have it predict ratings vs.. the test data.
url <- 'https://cdn.analyticsvidhya.com/wp-content/uploads/2017/09/07122416/cereals.csv'
df <- read.csv(url)

# Train-Test Splitting.
index <- createDataPartition(df$rating, p=0.8, list=FALSE)
test <- df[-index,]
train <- df[index,]

# Scaling.
max <- apply(df, 2, max)
min <- apply(df, 2, min)
scaled <- as.data.frame(scale(df, center=min, scale=max-min))

# Generating train and test indexes.
train_nn <- scaled[index,]
test_nn <- scaled[-index,]

set.seed(2)

# Fitting the neural network.
NN <- neuralnet(rating ~ calories + protein + fat + sodium + fiber, data=train_nn, hidden=3, linear.output=TRUE)

# Computing predictions before scaling them.
predictions <- neuralnet::compute(NN, test_nn[,c(1:5)])
predictions <- (predictions$net.result * (max(df$rating) - min(df$rating))) + min(df$rating)

# Defining graphical parameters - game-changing.
def_par <- par()
par(pch=16, col='blue')

# Plotting predictions against actual with an lm regression line.
plot(predictions ~ test$rating, xlab="Actual Value", ylab="Predicted Value", main="Neural Network Computing Cereal Ratings")
abline(lm(predictions ~ test$rating))

# Printing Out RMSE all pretty and such.
RMSE <- sum((test$rating - predictions) ^ 2) / nrow(df) ^ 0.5
RMSE_title <- c("Root Mean Squared Error: ")
print(c(RMSE_title, RMSE))
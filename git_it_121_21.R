library(vcd)

sales <- c(68,41,65,80,51,61,58,80,56,82)
temp <- c(69,80,77,84,80,77,87,70,65,90)
plot(sales ~ temp)

print(mean(temp))

sales <- sales[-3]

sales <- append(sales, 16, after=2)

names <- c("Joe", "John", "Jerry")

matrix(1:10, nrow=5, ncol=2)

icSales <- data.frame(sales, temp)

str(icSales)

summary(icSales)

names(icSales)
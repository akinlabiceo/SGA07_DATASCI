# load libraries
library("rpart")
library("rpart.plot")
library("party")

# Get Iris data
data("iris")

# Explore data
str(iris)
dim(iris)
names(iris)
head(iris)

# Preprocess
indexes = sample(150, 110)
iris_train = iris[indexes,]
iris_test = iris[-indexes,]

# Model
## Formula
target = Species ~ .
tree = ctree(target, data = iris_train)
plot(tree, main="Conditional Inference Tree for Iris")

## Evaluation
table(predict(tree, iris_test), iris_test$Species)

## Pruning
tree_ms3 = rpart(target, iris_train, control = rpart.control(minsplit = 3))
tree_ms10 = rpart(target, iris_train, control = rpart.control(minsplit = 10))

par(mfcol = c(1, 2))
rpart.plot(tree_ms3, main = "minsplit=3")
text(tree_ms3, cex = 0.7)
rpart.plot(tree_ms10, main = "minsplit=10")
text(tree_ms10, cex = 0.7)
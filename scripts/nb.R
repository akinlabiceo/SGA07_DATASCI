# load libraries
library(e1071)
library(gmodels)

# Get Iris data
data("iris")

# Explore data
str(iris)
dim(iris)
names(iris)
head(iris)

# Preprocess
colnames(iris)[1:5]=c("sepal_length","sepal_width","petal_length","petal_width","class")
indexes = sample(150, 110 ,replace = FALSE)
iris_train = iris[indexes,]
iris_test = iris[-indexes,]

##creating levels 
iris_train_labels=iris[indexes,]$class
iris_test_labels=iris[-indexes,]$class

# Model
nb = naiveBayes(iris_train,iris_train_labels)

## Evaluation
iris_test_pred=predict(nb,iris_test)
CrossTable(iris_test_pred,iris_test_labels,prop.chisq = FALSE, prop.t = FALSE, 
           prop.r = FALSE, dnn = c('predicted', 'actual'))

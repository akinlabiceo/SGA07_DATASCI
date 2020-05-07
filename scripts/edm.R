# Get the data
mtcars

# Get dimension of data
dim(mtcars)

# Get names of columns/features of the data
names(mtcars)

# Get attribute type
str(mtcars)

# First 10 instances
head(mtcars)

# Last 10 instances
tail(mtcars)

# Preprocess the data
mtcars$vs <- factor(mtcars$vs)
mtcars$am <- factor(mtcars$am)

mtcars$cyl <- factor(mtcars$cyl)
mtcars$gear <- factor(mtcars$gear)
mtcars$carb <- factor(mtcars$carb)

## Counting
table(mtcars$vs)
table(mtcars$am)
table(mtcars$cyl)
table(mtcars$gear)
table(mtcars$carb)

## Summary
summary(mtcars$mpg)
summary(mtcars$disp)
summary(mtcars$hp)
summary(mtcars$drat)
summary(mtcars$wt)
summary(mtcars$qsec)

## Graphics
library("ggplot2")

### Bar chart (Categorical)
ggplot(as.data.frame(table(mtcars$vs)), aes(x=Var1, y=Freq))+geom_bar(stat="identity")
ggplot(as.data.frame(table(mtcars$am)), aes(x=Var1, y=Freq))+geom_bar(stat="identity")
ggplot(as.data.frame(table(mtcars$cyl)), aes(x=Var1, y=Freq))+geom_bar(stat="identity")
ggplot(as.data.frame(table(mtcars$gear)), aes(x=Var1, y=Freq))+geom_bar(stat="identity")
ggplot(as.data.frame(table(mtcars$carb)), aes(x=Var1, y=Freq))+geom_bar(stat="identity")

### Line chart (Numerical)
ggplot(data=mtcars, aes(x=seq(1, nrow(mtcars)), y=mpg)) + geom_line(aes(group=1))
ggplot(data=mtcars, aes(x=seq(1, nrow(mtcars)), y=disp)) + geom_line(aes(group=1))
ggplot(data=mtcars, aes(x=seq(1, nrow(mtcars)), y=hp)) + geom_line(aes(group=1))
ggplot(data=mtcars, aes(x=seq(1, nrow(mtcars)), y=drat)) + geom_line(aes(group=1))
ggplot(data=mtcars, aes(x=seq(1, nrow(mtcars)), y=wt)) + geom_line(aes(group=1))
ggplot(data=mtcars, aes(x=seq(1, nrow(mtcars)), y=qsec)) + geom_line(aes(group=1))

### Histogram
ggplot(data=mtcars, aes(x=mpg)) + geom_histogram(binwidth=.5)
ggplot(data=mtcars, aes(x=disp)) + geom_histogram(binwidth=.5)
ggplot(data=mtcars, aes(x=hp)) + geom_histogram(binwidth=.5)
ggplot(data=mtcars, aes(x=drat)) + geom_histogram(binwidth=.5)
ggplot(data=mtcars, aes(x=wt)) + geom_histogram(binwidth=.5)
ggplot(data=mtcars, aes(x=qsec)) + geom_histogram(binwidth=.5)

### Boxplot
ggplot(mtcars, aes(x=factor(mtcars$vs), y=mpg)) + geom_boxplot()
ggplot(mtcars, aes(x=factor(mtcars$vs), y=disp)) + geom_boxplot()
ggplot(mtcars, aes(x=factor(mtcars$carb), y=hp)) + geom_boxplot()
ggplot(mtcars, aes(x=factor(mtcars$vs), y=drat)) + geom_boxplot()
ggplot(mtcars, aes(x=factor(mtcars$vs), y=wt)) + geom_boxplot()
ggplot(mtcars, aes(x=factor(mtcars$vs), y=qsec)) + geom_boxplot()

### Scatter plot
ggplot(mtcars, aes(x=mpg, y=disp)) + geom_point(shape=1)
ggplot(mtcars, aes(x=mpg, y=disp, color=factor(mtcars$vs))) + geom_point(shape=1)

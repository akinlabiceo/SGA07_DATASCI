## Multiple Regression
library(ggplot2)
library(corrplot)

## GoKada Data
day_id <- seq(1, 10, 1)
distance_covered <- c(59, 66, 78, 111, 44, 77, 80, 66, 109, 76)
fuel_price <- c(3.84, 3.19, 3.78, 3.89, 3.57, 3.57, 3.03, 3.51, 3.54, 3.25)
no_delivery <- c(4, 1, 3, 6, 1, 3, 3, 2, 5, 3)
hours_travelled <- c(7, 5.4, 6.6, 7.4, 4.8, 6.4, 7, NA, NA, NA)

gokada_df <- data.frame(day_id, no_delivery, distance_covered, fuel_price, hours_travelled)

## Exploratory Analysis
dim(gokada_df)
str(gokada_df)

gokada_df$day_id <- as.factor(gokada_df$day_id)

### Univariate analysis
summary(gokada_df$distance_covered)
summary(gokada_df$fuel_price)
summary(gokada_df$no_delivery)
summary(gokada_df$hours_travelled)

ggplot(gokada_df, aes(x=distance_covered)) + geom_histogram(binwidth=.5)
ggplot(gokada_df, aes(x=fuel_price)) + geom_histogram(binwidth=.5)
ggplot(gokada_df, aes(x=no_delivery)) + geom_histogram(binwidth=.5)
ggplot(gokada_df, aes(x=hours_travelled)) + geom_histogram(binwidth=.5)

### Scatterplot Analysis
#### Independent vs Dependent
ggplot(gokada_df, aes(x=distance_covered, y=hours_travelled)) + geom_point(shape=1) + geom_smooth(method=lm)
ggplot(gokada_df, aes(x=fuel_price, y=hours_travelled)) + geom_point(shape=1) + geom_smooth(method=lm)
ggplot(gokada_df, aes(x=no_delivery, y=hours_travelled)) + geom_point(shape=1) + geom_smooth(method=lm)

#### Independent vs Independent
ggplot(gokada_df, aes(x=distance_covered, y=fuel_price)) + geom_point(shape=1) + geom_smooth(method=lm)
ggplot(gokada_df, aes(x=fuel_price, y=no_delivery)) + geom_point(shape=1) + geom_smooth(method=lm)
ggplot(gokada_df, aes(x=no_delivery, y=distance_covered)) + geom_point(shape=1) + geom_smooth(method=lm)

### Correlation Analysis
gokada_df_cor <- cor(subset(gokada_df, select=-(day_id)))

corrplot(gokada_df_cor, method = "circle")

## Prediction Analysis
train_df <- gokada_df[1:7, ]
test_df <- gokada_df[8:10, ]

### Linear Regression
model_distance <- lm(train_df$hours_travelled ~ train_df$distance_covered)
model_delivery <- lm(train_df$hours_travelled ~ train_df$no_delivery)
model_fuel <- lm(train_df$hours_travelled ~ train_df$fuel_price)

model_distance_delivery <- lm(train_df$hours_travelled ~ train_df$distance_covered + train_df$no_delivery)
model_distance_fuel <- lm(train_df$hours_travelled ~ train_df$distance_covered + train_df$fuel_price)
model_delivery_fuel <- lm(train_df$hours_travelled ~ train_df$no_delivery + train_df$fuel_price)

model_distance_delivery_fuel <- lm(train_df$hours_travelled ~ train_df$distance_covered + train_df$no_delivery + train_df$fuel_price)

summary(model_distance)

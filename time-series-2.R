## Libraries
source("movingAverage.R")
source("summaryStat.R")
library("ggplot2")
library("tidyr")

## Get Data
df <- read.csv('us_elect_price')

## Time series
df$t <- seq(1, nrow(df), 1)

## Time Factors
for(i in 1:nrow(df)) {
  df$Year[i] <- strsplit(as.character(df$Date[i]), " ")[[1]][1]
  df$Month[i] <- strsplit(as.character(df$Date[i]), " ")[[1]][2]
}

df$Year <- as.factor(df$Year)
df$Month <- as.factor(df$Month)

## Sort my dataframe
df <- df[c(3, 4, 5, 2)]
names(df) <- c('t', 'year', 'month', 'price')

## Calculate moving average
df$ma <- movingAverage(df$price, 3)

## Seasonality
df$x <- df$price / df$ma
### average each month
x_month <- summarySE(df, measurevar="x", groupvars=c("month"))
### Update dataframe
df$s <- rep(NA, nrow(df))
for(i in 1:nrow(df)) {
  for(j in 1:nrow(x_month)) {
    if (df$month[i] == x_month$month[j]) {
      df$s[i] <- x_month$x[j]
    }
  }
}
### De-seasonalise
df$price_de <- df$price / df$s

## Trend
### Regression model
summary(lm(data=df, price ~ t))
### Intercept & Slope
intercept <- summary(lm(data=df, price ~ t))$coefficients[1,1]
slope <- summary(lm(data=df, price ~ t))$coefficients[2,1]
### Trend: intercept + slope*t
df$trend <- intercept + (slope * df$t)

## Prediction
df$price_pred <- df$s * df$trend
df$error <- df$price - df$price_pred

## Visualisation
ggplot(df, aes(x=t, y=price, group=1)) + geom_line()

### Convert from wide to long
df_long <- gather(df[c(1,2,3,4,8,9,10)], condition, measurement, price:price_pred, factor_key=TRUE)
ggplot(df_long, aes(x=t, y=measurement, group=condition, color=condition)) + geom_line()

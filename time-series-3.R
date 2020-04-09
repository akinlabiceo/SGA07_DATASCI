# Library
library(forecast)
library(tseries)

## Get the Data
df <- read.csv('us_elect_price')

### Time Factors
df$t <- seq(1, nrow(df), 1)

for(i in 1:nrow(df)) {
  df$Year[i] <- strsplit(as.character(df$Date[i]), " ")[[1]][1]
  df$Month[i] <- strsplit(as.character(df$Date[i]), " ")[[1]][2]
}

df$Year <- as.factor(df$Year)
df$Month <- as.factor(df$Month)

#### Sort my dataframe
df <- df[c(3, 4, 5, 2)]
names(df) <- c('t', 'year', 'month', 'price')
df <- df[-nrow(df),]

### Convert to timeseries data
elect_price <- ts(df['price'], start = c(2001, 01), end = c(2019, 12), frequency = 12)


## Explore the Data
sum(is.na(elect_price))

summary(elect_price)

plot(elect_price)

abline(reg=lm(elect_price ~ time(elect_price)))

cycle(elect_price)

### Boxplot to show trend and seasonality
boxplot(elect_price ~ cycle(elect_price))

ddata <- decompose(elect_price, "multiplicative")

plot(ddata)


## Model the Data
model <- auto.arima(elect_price)
model

### Model diagonistics
plot.ts(model$residuals)
acf(ts(model$residuals), main='ACF Residual')
pacf(ts(model$residuals), main='PACF Residual')

### Model Prediction for 2020
elect_price_2020 <- forecast(model, level=c(95), h=12)
plot(elect_price_2020)

### Model validation
Box.test(model$resid, lag=5, type = "Ljung-Box")
Box.test(model$resid, lag=10, type = "Ljung-Box")
Box.test(model$resid, lag=15, type = "Ljung-Box")

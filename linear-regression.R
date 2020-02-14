## Linear Regression
library(ggplot2)

## FIRS Data
business_id <- seq(1, 9, 1)
total_sales <- c(34, 108, 64, 88, 99, 51, 45, 78, 123)
vat_amount <- c(5, 17, 11, 8, 14, 5, NA, NA, NA)

firs_df <- data.frame(business_id, total_sales, vat_amount)

## Exploratory Analysis
dim(firs_df)
str(firs_df)

firs_df$business_id <- as.factor(firs_df$business_id)

### Univariate analysis
summary(firs_df$total_sales)
summary(firs_df$vat_amount)

ggplot(firs_df, aes(x=total_sales)) + geom_histogram(binwidth=.5)
ggplot(firs_df, aes(x=vat_amount)) + geom_histogram(binwidth=.5)

## Prediction Analysis
train_df <- firs_df[1:6, ]
test_df <- firs_df[7:9, ]

model <- lm(firs_df$vat_amount ~ firs_df$total_sales)

summary(model)

test_df$vat_amount_hat <- (0.1462*test_df$total_sales) + -0.8203

for (i in 1:nrow(firs_df)) {
  if (is.na(firs_df$vat_amount[i])== TRUE) {
    firs_df$vat_amount[i] = (0.1462*firs_df$total_sales[i]) + -0.8203
  }
}

year <- c(1985, 1986, 1987, 1988, 1989, 1990, 1991, 1992, 1993, 1994)
income <- c(46.163, 46.998, 47.816, 48.311, 48.758, 49.164, 49.548, 48.915, 50.315, 50.768)

pc_income <- data.frame(year=year, income=income)

income_mean <- mean(pc_income$income)

pc_income$mean <- rep(income_mean, nrow(pc_income))

# x: the vector
# n: the number of samples
# centered: if FALSE, then average current sample and previous (n-1) samples
#           if TRUE, then average symmetrically in past and future. (If n is even, use one more sample from future.)
movingAverage <- function(x, n=1, centered=FALSE) {
  
  if (centered) {
    before <- floor  ((n-1)/2)
    after  <- ceiling((n-1)/2)
  } else {
    before <- n-1
    after  <- 0
  }
  
  # Track the sum and count of number of non-NA items
  s     <- rep(0, length(x))
  count <- rep(0, length(x))
  
  # Add the centered data 
  new <- x
  # Add to count list wherever there isn't a 
  count <- count + !is.na(new)
  # Now replace NA_s with 0_s and add to total
  new[is.na(new)] <- 0
  s <- s + new
  
  # Add the data from before
  i <- 1
  while (i <= before) {
    # This is the vector with offset values to add
    new   <- c(rep(NA, i), x[1:(length(x)-i)])
    
    count <- count + !is.na(new)
    new[is.na(new)] <- 0
    s <- s + new
    
    i <- i+1
  }
  
  # Add the data from after
  i <- 1
  while (i <= after) {
    # This is the vector with offset values to add
    new   <- c(x[(i+1):length(x)], rep(NA, i))
    
    count <- count + !is.na(new)
    new[is.na(new)] <- 0
    s <- s + new
    
    i <- i+1
  }
  
  # return sum divided by count
  s/count
}


pc_income$mma <- movingAverage(pc_income$income, n=3, centered=FALSE)

library(tidyr)

pc_income_long <- gather(pc_income, stat, metric, income:mma, factor_key=TRUE)

pc_income$error_mean <- pc_income$income - pc_income$mean

pc_income$error_mma <- pc_income$income - pc_income$mma

pc_income$sse_mean <- pc_income$error_mean^2

pc_income$sse_mma <- pc_income$error_mma^2

income_mse_mean <- mean(pc_income$sse_mean)

income_mse_mma <- mean(pc_income$sse_mma)

library(ggplot2)

ggplot(pc_income, aes(year, income)) + geom_line(aes(group=1))

ggplot(data=pc_income_long, aes(x=factor(year), y=metric, group=factor(stat), colour=factor(stat)))+ geom_line()

## Exponential series
library(forecast)
#Fit simple exponential smoothing model to data and show summary
fit_ses <- ses(ts(pc_income[,2], start = c(1985), end = c(1994), frequency = 1))
summary(fit_ses)
#Plot the forecasted values
plot(fit_ses)

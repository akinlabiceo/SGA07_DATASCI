set.seed(1)
d <- data.frame(year = rep(2000:2002, each = 3),
                count = round(runif(9, 0, 20)))
## Give it some missing data
d$count[2] <- NA
d$count[6] <- NA
d$count[7] <- NA

## Preprocessing (Data Cleaning)
### Ignore observations
library(tidyr)
d <- d %>% drop_na()
library('plyr')
d_mean_ignore = ddply(d, .(year), summarize, mean=mean(count))

### Fill in manually or use global constant (use 12)
d$count <- replace(d$count, is.na(d$count), 12)
d_mean_replace = ddply(d, .(year), summarize, mean=mean(count))

### Fill in with central tendency (use mean)
count_mean <- mean(d$count, na.rm=T)
d$count <- replace(d$count, is.na(d$count), count_mean)
d_mean_central = ddply(d, .(year), summarize, mean=mean(count))

### Fill in with class central tendency (use mean)
d_mean_class = ddply(d, .(year), summarize, mean=mean(count, na.rm=T))
#### Get size of observation
n <- nrow(d)
m <- nrow(d_mean_class)
#### Convert to norminal data type
d$year <- factor(d$year)
d_mean_class$year <- factor(d_mean_class$year)
#### Store value of each level
y_level <- levels(d$year)
store <- list()
store_value <- c()
for (i in  1:n) {
  if (is.na(d$count[i])) {
    for (j in 1:m) {
      if (d$year[i] == d_mean_class$year[j] ) {
        d$count[i] <- d_mean_class$mean[j]
      }
    }
  }
}
d_mean_central_class = ddply(d, .(year), summarize, mean=mean(count))


#### Compare statistics
d_compare_stat <- data.frame(year=levels(factor(d$year)),
                             not_missing = d_mean_ply$mean,
                              ignore=d_mean_ignore$mean,
                              replace=d_mean_replace$mean,
                              central=d_mean_central$mean,
                              central_class=d_mean_central_class$mean)
set.seed(1)
d <- data.frame(year = rep(2000:2002, each = 3),
                count = round(runif(9, 0, 20)))

## Get mean count of each unique year
### Using loop
#### Get size of observation
n <- nrow(d)
#### Convert to norminal data type
d$year <- factor(d$year)
#### Store value of each level
y_level <- levels(d$year)
store <- list()
store_value <- c()
for(j in 1:length(y_level)) {
  for (i in  1:n) {
    if (y_level[j] == d$year[i]) {
      store_value[i] <- d$count[i]
    }
    else {
      store_value[i] <- NA
    }
  }
  store[[j]] <- store_value
}

### Apply mean function
stat_mean <- c()
for(k in 1:length(store)) {
  stat_mean[k] <- mean(store[[k]], na.rm=T)
}

### Combine mean data together
d_mean <- data.frame(year=y_level, mean=stat_mean)

### Using plyr
library('plyr')
d_mean_ply = ddply(d, .(year), summarize, mean=mean(count))

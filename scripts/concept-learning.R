# @param dset - data.frame or matrix, ONLY positive examples
library(plyr)

findS <- function(dset){
  apply(
    dset[,1:ncol(dset)-1], 
    2, 
    function(x) { 
      if (length(unique(x)) > 1) "?" else unique(x)
    })
}

e1 = t(c("Sunny", "Warm", "Normal","Strong","Warm","Same",1))
e2 = t(c("Sunny", "Warm", "High","Strong","Warm","Same",1))
e3 = t(c("Rainy", "Cold", "High","Strong","Warm","Change",0))
e4 = t(c("Sunny", "Warm", "High","Strong","Cool","Change",1))

weather_dset_positive_only = as.data.frame(
  rbind(e1,e2,e4),
  stringsAsFactors = FALSE)

weather_dset = as.data.frame(
  rbind(e1,e2,e3, e4), 
  stringsAsFactors = FALSE)

weather_concept = findS(weather_dset_positive_only)
weather_concept
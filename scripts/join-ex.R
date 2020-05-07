# Create first data
policies <- data.frame(Policy = c(1:9), State=c(rep("GA",3), rep("FL", 3), rep("AL", 3)), Limit=c(rep(50000,3), rep(75000, 3), rep(85000, 3)))

# Create second data
limits <- data.frame(State=c("FL","GA","AL"), regulatory_limit=c(75000,75000,65000))

# left join in R - join the dataframes! 
scored_policies<-merge(x=policies,y=limits,by="State",all.x=TRUE)
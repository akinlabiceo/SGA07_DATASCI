## Example on Discretisation

## Get dataframe
Income <- c(12, 13, 14, 12, 14, 16, 18, 33, 22, 24, 46, 53, 24, 19, 25, 32, 33, 37, 21, 25)

Loan <- c("Yes", "Yes", "Yes", "No", "Yes", "Yes", "No", "Yes", "No", "No", "No", "No", "No", "No", "No", "Yes", "Yes", "No", "No", "Yes")

Loan_df <- data.frame(Income, Loan)

#Discretisation equal width
disc <- function(df, bin) {
  y <- df[!sapply(df, is.numeric)]											#Save non-numeric attributes
  df <- df[sapply(df, is.numeric)]											#Strip out non-numeric attributes
  saved.names <- names(df)												#Save names of attributes
  store <- list()																#Create empty list
  for (i in 1:ncol(df)) {														#For each numeric columns in dataset
    a <- df[,i]
    B <- max(a)															#Maximum value of non-ordinal attribute
    A <- min(a)															#Minimum value of non-ordinal attribute
    W <- (B-A)/bin														#Width interval 
    c <- seq(A, B, by = W)												#Cut values
    for (m in 1:nrow(df)) {												#For each row of non-ordinal attribute
      for (n in 1:(length(c)-1)) {											#For each cut values
        if (a[m] >= c[n] && a[m] < c[n+1]) {						#Compare row value across cut values
          a[m] <- c[n]												#Replace row value with minimum cut interval
        }
      }
    }
    store[[i]] <- a															#Insert in list after discretisation of each column in dataset
  }
  store <- do.call(cbind.data.frame, store)									#Convert list to dataframe
  names(store) <- saved.names												#Restore original names
  df <- cbind(y, store)														#Join non-numeric columns 
  return(df)
}

Loan_disc <- disc(Loan_df, 4)
store <- c()
for(i in 1:nrow(Loan_disc)){
  if (Loan_disc$Income[i] == 12.00) {
    store[i] <- 'A'
  }
  else if (Loan_disc$Income[i] == 22.25) {
    store[i] <- 'B'
  }
  else if (Loan_disc$Income[i] == 32.50) {
    store[i] <- 'C'
  }
  else if (Loan_disc$Income[i] == 42.75) {
    store[i] <- 'D'
  }
  else {
    store[i] <- 'E'
  }
}
Loan_disc$income_ca <- store

Loan_disc
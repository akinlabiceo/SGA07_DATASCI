##### Demonstrating the Chi-Squared Test of Independence in R

# Problem
# Test the hypothesis whether the gender is independent of selected ice-cream flavour at .05 significance level

# Entering the data into vectors
men = c(100, 120, 60)
women = c(350, 200, 90)

# combining the row vectors in matrices, then converting the matrix into a data frame
ice.cream.survey = as.data.frame(rbind(men, women))

# assigning column names to this data frame
names(ice.cream.survey) = c('chocolate', 'vanilla', 'strawberry')

chisq.test(ice.cream.survey)

# Answer
# As the p-value 6.938e-07 is less than the .05 significance level, we reject the null hypothesis that the gender is independent of the selected ice-cream flavour.
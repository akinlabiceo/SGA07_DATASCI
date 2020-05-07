# Create my data science profile

criteria <- c("reading", "critical_thinking", "time_management", "mathematics", "computer_progamming", "system_design", "report_writing", "listening", "teamwork", "curiosity")
score <- c(7, 9, 7, 8, 7, 6, 8, 5, 9, 10)

data_science_profile <- data.frame(criteria, score)

data_science_profile

library(ggplot2)

ggplot(data=data_science_profile, aes(x=criteria, y=score)) +
  geom_bar(stat="identity")
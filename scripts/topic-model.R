library(topicmodels)
library(tidytext)
library(ggplot2)
library(dplyr)

data("AssociatedPress")
AssociatedPress

## setting k = 2, to create a two-topic LDA model
# set a seed so that the output of the model is predictable
ap_lda <- LDA(AssociatedPress, k = 2, control = list(seed = 1234))
ap_lda

## extracting the per-topic-per-word probabilities, called β(“beta”), from the model
ap_topics <- tidy(ap_lda, matrix = "beta")
ap_topics

## find the 10 terms that are most common within each topic
ap_top_terms <- ap_topics %>%
  group_by(topic) %>%
  top_n(10, beta) %>%
  ungroup() %>%
  arrange(topic, -beta)

ap_top_terms %>%
  mutate(term = reorder_within(term, beta, topic)) %>%
  ggplot(aes(term, beta, fill = factor(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ topic, scales = "free") +
  coord_flip() +
  scale_x_reordered()

## terms that had the greatest difference in  β between topic 1 and topic 2
beta_spread <- ap_topics %>%
  mutate(topic = paste0("topic", topic)) %>%
  spread(topic, beta) %>%
  filter(topic1 > .001 | topic2 > .001) %>%
  mutate(log_ratio = log2(topic2 / topic1))

beta_spread

## examine the per-document-per-topic probabilities, called  γ(“gamma”), from the model
ap_documents <- tidy(ap_lda, matrix = "gamma")
ap_documents

## check what the most common words in that document were
tidy(AssociatedPress) %>%
  filter(document == 6) %>%
  arrange(desc(count))


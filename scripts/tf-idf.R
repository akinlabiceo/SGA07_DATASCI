library(dplyr)
library(janeaustenr)
library(tidytext)
library(ggplot2)

## Commonly used words in Jane Austen’s novels
book_words <- austen_books() %>%
  unnest_tokens(word, text) %>%
  count(book, word, sort = TRUE)

total_words <- book_words %>% 
  group_by(book) %>% 
  summarize(total = sum(n))

book_words <- left_join(book_words, total_words)

book_words

## distribution of n/total for each novel
ggplot(book_words, aes(n/total, fill = book)) +
  geom_histogram(show.legend = FALSE) +
  xlim(NA, 0.0009) +
  facet_wrap(~book, ncol = 2, scales = "free_y")

## inverse proportionality of words and ranks (Zipf's law)
freq_by_rank <- book_words %>% 
  group_by(book) %>% 
  mutate(rank = row_number(), 
         `term frequency` = n/total)

freq_by_rank

### Visualise
freq_by_rank %>% 
  ggplot(aes(rank, `term frequency`, color = book)) + 
  geom_line(size = 1.1, alpha = 0.8, show.legend = FALSE) + 
  scale_x_log10() +
  scale_y_log10()

## Bind TD-IDF function 
book_words <- book_words %>%
  bind_tf_idf(word, book, n)

book_words

## Terms with high tf-idf in Jane Austen’s works
book_words %>%
  select(-total) %>%
  arrange(desc(tf_idf))
  
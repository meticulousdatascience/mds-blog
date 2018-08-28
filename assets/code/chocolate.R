library(tidyverse)
library(ggridges)

df <- read_csv('data/flavors_of_cacao.csv')[-1,] %>%
  select(`Company
Location`, `Cocoa
Percent`) %>%
  rename(country = `Company
Location`, cocoa_percent = `Cocoa
Percent`)

top_10 <- df %>%
  group_by(country) %>%
  summarize(n = n()) %>%
  ungroup() %>%
  arrange(desc(n)) %>%
  head(10)

by_country <- df %>%
  inner_join(top_10, by = "country") %>%
  mutate(cocoa_percent = gsub("%", "", cocoa_percent)) %>%
  mutate(cocoa_percent = as.numeric(cocoa_percent)) %>%
  group_by(country) %>%
  mutate(mean_cocoa_percent = mean(cocoa_percent)) %>%
  ungroup() %>%
  arrange(mean_cocoa_percent)

order_levels <- by_country %>%
  group_by(country) %>%
  summarize(mean_cocoa_percent = mean(cocoa_percent)) %>%
  ungroup() %>%
  arrange(mean_cocoa_percent)

by_country$country <- factor(by_country$country, levels = order_levels$country)

by_country %>%
  ggplot(aes(x = country, y = cocoa_percent)) +
  geom_violin(fill = "chocolate4") +
  xlab("") +
  ylab("Cocoa Percent") +
  coord_flip() +
  ggtitle("Cocoa Percentage Distribution by Country")

by_country %>%
  ggplot(aes(x = cocoa_percent, y = country)) +
  geom_density_ridges(fill = "chocolate4") +
  ggtitle("Cocoa Percentage Distribution by Country") +
  ylab("") +
  xlab("Cocoa Percent")

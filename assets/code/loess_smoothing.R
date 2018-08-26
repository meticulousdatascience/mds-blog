library(tidyverse)

# the following CSV was downloaded from the "export" tab on this page:
# https://datamarket.com/data/set/22qn/annual-yield-of-grain-on-broadbalk-field-at-rothamsted-1852-1925-plot-6#!ds=22qn&display=line

df <- read_csv('annual-yield-of-grain.csv')

df2 <- df %>%
  rename(Yield = `Annual yield of grain on Broadbalk field at Rothamsted 1852-1925: plot 6`)

df2 %>%
  ggplot(aes(x = Year, y = Yield)) +
  geom_point() +
  geom_line() +
  xlab("") +
  ggtitle("Annual yield of grain on Broadbalk field at Rothamsted 1852-1925") +
  geom_smooth(method = "lm")

df2 %>%
  ggplot(aes(x = Year, y = Yield)) +
  geom_point() +
  geom_line() +
  xlab("") +
  ggtitle("Loess with default span = 0.75 and degree = 2") +
  geom_smooth()

df2 %>%
  ggplot(aes(x = Year, y = Yield)) +
  geom_point() +
  geom_line() +
  xlab("") +
  ggtitle("Loess with span = 0.25 and degree = 2") +
  geom_smooth(span = 0.25)

df2 %>%
  ggplot(aes(x = Year, y = Yield)) +
  geom_point() +
  geom_line() +
  xlab("") +
  ggtitle("Loess with span = 0.25 and degree = 1") +
  geom_smooth(method.args = list(degree = 1))
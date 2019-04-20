library(tidyverse)
set.seed(1020)

# parameters for distribution of X
mean_x = 1
var_x = 0.09

# linear effect x on y
alpha <- 2
var_epsilon <- 1

# n data points
n_data <- 10000

df <- data.frame(x = rnorm(n=n_data, mean=mean_x, sd=sqrt(var_x))) %>%
  mutate(noise = rnorm(n = n_data, sd = sqrt(var_epsilon))) %>%
  mutate(y = alpha*x + noise) %>%
  mutate(y2 = alpha*x - noise) %>%
  mutate(x2 = (y - noise)/alpha) %>%
  mutate(x3 = 1/2*y + noise)

df %>%
  lm(formula = y ~ x - 1) %>%
  summary()

df %>%
  lm(formula = y2 ~ x - 1) %>%
  summary()


mod_1 <- df %>%
  lm(formula = y ~ x)
summary(mod_1)

mod_1 <- df %>%
  lm(formula = x3 ~ y)
summary(mod_1)

mod_1 <- df %>%
  lm(formula = x2 ~ y)
summary(mod_1)


var(df$x2)

var(df$y)
4*var(df$x) + 1

df %>%
  ggplot(aes(x = x, y = y)) +
  geom_point(color = "blue") +
  expand_limits(x = 0, y = 0)

mod_1 <- df %>%
  lm(formula = y ~ x)
summary(mod_1)

mod_2 <- df %>%
  lm(formula = yprime ~ x)
summary(mod_2)

mod_3 <- df %>%
  lm(formula = y2 ~ x2 - 1)
summary(mod_3)

df2 <- data.frame(y = rnorm(n=n_data, mean=mean_x, sd=sqrt(var_x))) %>%
  mutate(x = 1/2*y - rnorm(n=n_data, sd=sqrt(var_epsilon/2)))

mod_3 <- df2 %>%
  lm(formula = x ~ y - 1)
summary(mod_3)

df3 <- data.frame(y = 2*rnorm(n = n_data, sd = 2) + rnorm(n = n_data, sd=sqrt(var_epsilon/2))) %>%
  mutate(x = 0.5*y + rnorm(n = n_data, sd = 4))

df3 %>%
  lm(formula = x ~ y - 1) %>%
  summary()

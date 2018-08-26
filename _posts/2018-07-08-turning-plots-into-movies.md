---
layout: post
title: "Turning Plots into Movies"
author: "Meti"
categories: journal
tags: [r, ggplot, magick, dataviz, bayesian]
image: popcorn.jpg
---

When learning about a new algorithm that updates in an iterative way (in other words, with new information the answer changes, one piece of information at a time), sometimes it's useful to be able to visualize how the updating process works. One way to do this is to make a single plot for each iteration and then combine them into an animation. In this post we'll walk through a simple iterative algorithm and then show how to make an animation using the [magick](https://cran.r-project.org/web/packages/magick/vignettes/intro.html) R package.

For example, suppose we have a binomial process, such as whether a visitor to a particular website will click on a particular button. We'll assume each of the visitors are independently likely to click on the button, and that the probability p that each visitor clicks on the button is exactly the same. We will use a very simple Bayesian model to update our estimate of this probability p, starting with the prior assumption that any value of p is equally likely (i.e. we are using a flat prior).

Here is our starting configuration

```
library(ggplot2)
library(magick)

# define the Magick image
img <- image_graph(600, 340, res = 96)

# generate some basic data
num_visitors <- 100
clicks <- sample(x = c(0,1), 
                 size = num_visitors, 
                 prob = c(0.70, 0.30), 
                 replace = TRUE)
```

For this simple example we'll use a grid approximation by updating the distribution at a subset of points on the unit interval.

```
# Flat prior
initial_prior <- rep(1, 1000)

# Grid of points on the unit interval we will update
p_grid <- seq(from = 0, to = 1, length.out = 1000)
```

Next, we will loop over each datapoint in `clicks`:

```
# Iterating over each datapoint, update the distribution + generate graph

for(i in seq(1:num_visitors)){

  likelihood <- dbinom(clicks[i], size = 1, prob = p_grid)

  if(i == 1){
    unstd_posterior <- likelihood*initial_prior
  } else {
    unstd_posterior <- likelihood*posterior
  }

  posterior <- unstd_posterior / sum(unstd_posterior)

  g <- data.frame(p_grid, posterior) %>%
    ggplot(aes(x = p_grid, y = posterior)) +
    geom_line() +
    ggtitle("Posterior Distribution") +
    xlab("Estimated Probability of Clicking") +
    theme(axis.text.y = element_blank(),
          axis.title.y = element_blank(),
          axis.ticks.y = element_blank())

  print(g)
}

dev.off()
```

Finally, we call `magick` functions to put these animations together into a movie:

```
animation <- image_animate(img, fps = 5)
print(animation)
```

Now it's popcorn time! Watching the animation, we can see the argmax of the distribution getting closer to 0.30, as expected based on our sample definition.

![Bayesian Updating Animation](https://meticulousdatascience.com/assets/img/bayesian_updating.gif)


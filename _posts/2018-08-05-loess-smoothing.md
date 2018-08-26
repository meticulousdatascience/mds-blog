---
layout: post
title: "Loess Smoothing"
author: "Meti"
categories: journal
tags: [r, ggplot, dataviz, time series, smoothing]
image: grain.jpg
---

I was in the uncomfortable situation recently where I used the ggplot function `geom_smooth()`, even though I was not entirely sure what it does mathematically, and then presented the resulting graph to business partners. As a meticulous data scientist, I never feel comfortable using techniques I don't fully understand. I used it to smooth a jagged time series into a nice looking curve. With no arguments, the function uses as default the LOESS regression method to calculate the smoothing.  So, in this post we'll discuss this method and dig deep into the details, so next time I feel comfortable using it!

To illustrate this concept, I took some data titled "Annual yield of grain on Broadbalk field at Rothamsted 1852-1925" from the [Time Series Data Library](https://datamarket.com/data/list/?q=provider:tsdl). A graph of the time series is shown below with a simple linear regression in blue.

![](https://meticulousdatascience.com/assets/img/annual_grain_yield_plot.png)

Protip: to plot the standard linear regression on top of the data, use `geom_smooth(method = "lm")`. It automatically plots the regression with the standard error. 

The standard linear regression captures the overall trend of decreasing yield over time, but it fails to find interesting local behavior. This is where LOESS comes in: it's a "locally weighted" regression. This means we will calculate a different value for each year, which depends on the points "nearby" that year , as opposed to a standard linear regression model which uses all points all the time. 

Note: the `geom_smooth` function is using the `loess` function in the `stats` package under the hood.

There are a number of choices we get to make:

- How many neighbors do we want to consider for any given year?
- What type of weighting function do we want to use?
- What type (degree) of regression do we want to use? 

First off, we'll start by determining how "local" the regression truly is by setting a "bandwidth" or "smoothing parameter" which says how many of the neighbors will be considered. In R, we do this by setting a `span` parameter, which is loosely described as controlling how "wiggly" the graph looks. The default is `span = 0.75`, which means that the regression considers the closest 3/4 of the total data points.

Second, we will set a weighting function. The default in R is the tricube weighting we discussed in a [previous post on Statistical Kernel functions](https://meticulousdatascience.com/journal/kernel-window-functions.html). (At this point it's unclear to me whether you can change this using the R functions described in this post. Will update if I find out.)

Finally, we set the degree of the polynomial we are using. Default is 2, so each local regression is a quadratic. If you want to change the degree in `geom_smooth` you have to supply arguments for the method, such as 
`geom_smooth(method.args = list(degree = 1))`. 

After calculating the values of $\hat{y}$, they are just connected by line segments. Following are some examples.

![](https://meticulousdatascience.com/assets/img/loess_smooth1.png)
![](https://meticulousdatascience.com/assets/img/loess_smooth2.png)
![](https://meticulousdatascience.com/assets/img/loess_smooth3.png)

[Reproducible Code Example](https://meticulousdatascience.com/assets/reproducible_code/loess_smoothing.txt)

References:

- [LOESS Regression on Wikipedia](https://en.wikipedia.org/wiki/Local_regression)
- [Documentation for LOESS Regression in R](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/loess.html)
- [`geom_smooth` code on Github](https://github.com/tidyverse/ggplot2/blob/master/R/stat-smooth.r)
- [R package for looking at R source code](https://github.com/jimhester/lookup#readme). I used this to understand the code for the `loess` method.
- [Original LOESS paper by Cleveland](https://pdfs.semanticscholar.org/414e/5d1f5a75e2327d99b5bbb93f2e4e241c5acc.pdf)


---
layout: post
title: "Ridgeline Plots"
author: "Meti"
categories: journal
tags: [r, ggplot, dataviz]
image: chocolate.jpg
---

One of my coworkers showed me a neat R package today called `ggridges` that implements ridgeline plots in `ggplot`. I was immediately excited by this because I've always wanted some code that plots something like a violin plot but with each "violin" cut in half.

I grabbed some data on the percentage of cocoa contained in samples of chocolate bars from various countries, selected the 10 countries with the most data points, and then created the violin plot as well as the ridgeline plot. I love the way the ridgeline plot looks!

![](https://meticulousdatascience.com/assets/img/chocolate_violin.png)
![](https://meticulousdatascience.com/assets/img/chocolate_ridgeline.png)

- [ggridges on CRAN](https://cran.r-project.org/web/packages/ggridges/index.html)
- [Flavors of Cacao dataset on Kaggle](https://www.kaggle.com/fangya/chocolate-bar-rating-analysis/data)
- [R code for these plots](https://github.com/meticulousdatascience/mds-blog/blob/master/assets/code/chocolate.R)



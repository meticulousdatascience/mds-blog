---
layout: post
title: "Donut Plots"
author: "Meti"
categories: journal
tags: [r, ggplot, donut, dataviz]
image: donuts.jpg
---

Every once in awhile I want to create a [donut plot](https://datavizcatalogue.com/methods/donut_chart.html). It's rare enough that I don't have the code memorized and so have a template saved. I would usually use a bar chart instead of a donut chart, because I find bar charts to be more intuitive and appealing, but I have to admit that a dashboard full of bar plots can be quite boring to read. I find myself using the donut plot here and there to break up the monotony when there are a lot of visualizations. The only other reason I'd use a donut plot is if I were analyzing donut sales! 

Here is the basic `R` code that forms my template:

```
library(tidyverse)

donut_dat <- data.frame(flavor = c("Chocolate", "Strawberry", "Pistachio"),
                        per_sold = c(.20, .30, .50))

donut_dat %>%
  ggplot(aes(x = 2, y = per_sold, fill = flavor)) +
  geom_bar(stat = "identity") +
  xlim(0.5, 2.5) +
  coord_polar(start = 0, theta = "y") +
  xlab("") +
  ylab("") +
  scale_fill_manual(values = c("#8b4513", "#698b22",  "#eea2ad")) +
  theme(axis.ticks=element_blank(),
        axis.text=element_blank(),
        axis.title=element_blank(),
        panel.grid=element_blank(),
        panel.border=element_blank(),
        legend.title = element_text(size = rel(2)),
        legend.text=element_text(size=rel(1.5)))

```

![Donut Plot](https://meticulousdatascience.com/assets/img/donut_plot.png)

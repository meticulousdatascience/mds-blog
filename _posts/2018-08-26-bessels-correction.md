---
layout: post
title: "Bessel's Correction"
author: "Meti"
categories: journal
tags: [estimators, bias, variance]
image: bananas.jpg
---

In this post we'll look at a feature that is plausibly sampled from a normal distribution: the measured widths of a bunch of bananas. The distribution along with a green dotted line pointing out the sample mean of 38.2 mm are plotted below.

![Banana Widths](https://meticulousdatascience.com/assets/img/banana_widths.png)

The sample mean is an unbiased estimator of the population mean, which means that the expected value of the sample mean is equal to the population mean. On the other hand, you may be familiar with the fact that the sample variance is a biased estimator for the population variance, so the expected value of the sample variance is not equal to the population variance. 

Bessel's correction says we can fix this by multiplying the sample variance by $\frac{n}{n-1}$, where $n$ is the number of data points. Because the correction entails multiplying the sample variance by a number greater than 1, this implies that the expected sample variance is too small. Why is this the case? 

First off, it's important to note that it's very unlikely that the sample mean is exactly equal to the actual population mean. We can write $\bar{x} = \mu + err$, where $\mu$ is the population mean, $\bar{x}$ is the sample mean, and $err$ is the difference between $\mu$ and $\bar{x}$, which can be negative or positive. Let's suppose for the sake of visualization that the sample mean is slightly larger than the population mean, so that $err > 0$. In the following graph, this is shown with a blue dotted line indicating the true population mean, which is assumed to be 37.5 mm. 

![Banana Widths 2](https://meticulousdatascience.com/assets/img/banana_widths2.png)

In this situation, our sample variance using the sample mean is 4.11 whereas when we use the assumed population mean of 37.5, we get 4.62. Echoing our earlier question: why is the sample variance too small?

When we're calculating variance, we are looking at the average squared distance from our data points to the mean. Let's think about how this quantity changes when we're using the sample mean instead of the population mean. 

In general, a mean is a "balancer" for the data, in the sense that the sum of distances from the mean to data points to the left of the mean, denoted by $X^-$ is equal to the sum of distances from the mean to data points on the right side of the mean, denoted by $X^+$. In equation form, 

$$\sum_{X^-} (x_i - \bar{x}) = \sum_{X^+} (x_i - \bar{x}).$$

If we replace the sample mean with the true mean, this balance no longer holds. In particular, because the sample mean in our example was too large, there is "more" data on the right side of the distribution. The distances from these data points to the true mean are all larger

$$ \sum (x_i - \mu) = \sum (x_i - (\bar{x} - err)) = \sum (x_i - \bar{x}) - n*err = - n*err$$ 


When we use the sample mean, we are "unbalancing" these distances, so that more of them on average are smaller distances than they should be in the calculation of the true variance. Intuitively this is because there is "more" data to the right of the true mean in our sample, which resulted in our sample mean being too large. In equation form, for our example


[Code for pictures](https://meticulousdatascience.com/assets/reproducible_code/bananas.txt)

References:

- [Bessel's Correction on Wikipedia](https://en.wikipedia.org/wiki/Bessel%27s_correction)
- [Banana Dataset](http://www.statistics4u.com/fundstat_eng/data_bananas.html)


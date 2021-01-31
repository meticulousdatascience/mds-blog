---
layout: post
title: "Bessel's Correction"
author: "Sonya B"
categories: journal
tags: [estimators, bias, variance]
image: bananas.jpg
---

In this post we'll look at a feature that is plausibly sampled from a normal distribution: the measured widths of a collection of bananas. To make this really concrete let's assume we have just 4 bananas, with widths given by the following vector.

```
banana_widths <- c(32, 36, 41, 43)
```

We can calculate the mean and variance of this small vector using the obvious R functions:

```
> mean(banana_widths)
[1] 38
> var(banana_widths)
[1] 24.66667
```

We can verify the mean calculated is the sample mean by just checking:

```
> sum(banana_widths)/length(banana_widths)
[1] 38
```

However, if we calculate the sample variance we get a different value than what `var` returned:

```
> sum((banana_widths - 38)**2)/length(banana_widths)
[1] 18.5
```

Why did R give us back $24.7$ instead of $18.5$ for the sample variance? The reason is because R applies a _correction_ to the sample variance. A bit of intuition for why the correction is needed is the topic of this post.

The fact that we need a correction means that the sample variance, unlike the sample mean, is a _biased_ estimator. This means that if we average the variance of all the samples we could have pulled from our population we won't get the population variance.

Bessel's correction says we can fix this by multiplying the sample variance by $\frac{n}{n-1}$, where $n$ is the number of data points. You can achieve the same goal by dividing the sum of squared distances by $n-1$ instead of by $n$, which gives back the same value for the variance that R did in `var`:

```
> sum((banana_widths - 38)**2)/(length(banana_widths)-1)
[1] 24.66667
```

Bessel's correction entails multiplying by $\frac{n}{n-1}$, which is always a number larger than 1. This implies that the sample variance is _too small_. In this post we'll focus on understanding why the sample variance is always going to be smaller using the sample mean than it would be if we used the population mean. 

Before we get to the answer, let's think about how a sample mean "balances" a set of data. The sample mean "centers" our data by making it so that the sum of the signed distances from our data points to their sample mean is zero:

![Mean Balancing](https://meticulousdatascience.com/assets/img/mean_balancing.png)

Our (biased) sample variance calculation is really just the average of the squares of these distances. Now, whatever our sample, it's very unlikely that the sample mean is exactly equal to the actual population mean. For the sake of argument, let's assume that the population mean is actually one unit smaller (37) than the sample mean, illustrated by the purple box below. In this scenario, what happened to our distances? 

![Mean Balancing](https://meticulousdatascience.com/assets/img/mean_balancing2.png)

The two distances on the left became smaller (in absolute value) and the two distances on the right became larger. If we calculate the sample variance again using the population mean we get

```
> sum((banana_widths - 37)**2)/length(banana_widths)
[1] 19.5
```

which is of course larger than our sample variance using the sample mean. Interestingly, it is the case that the sum of squared distances will always increase when you move away from the sample mean. This is because the sample mean actually minimizes the solution to the average sum of squares problem. 

Looking at the math, we are attempting to minimize the equation

$$(32 - a)^2 + (36 - a)^2 + (41 - a)^2 + (43 - a)^2.$$

Using simple calculus you can take a derivative and set to 0 to minimize, and find yourself solving the equation that precisely finds the sample mean:

$$a = \frac{32 + 36 + 41 + 43}{4}.$$

There are other proofs that the sample variance using the sample mean will always be smaller than the sample variance using the population mean which use no calculus and just simple algebra, but I rather like the idea of framing this as an optimization problem. 

Of course, it's worth noting that in this particular case the correction ended up giving us a worse estimate (24.7) than the original (18.5). It's nice to remember that all estimates and corrections are the best _on average_, and in random examples, they may not work very well!

References:

- [Bessel's Correction on Wikipedia](https://en.wikipedia.org/wiki/Bessel%27s_correction)
- An actual [banana dataset](http://www.statistics4u.com/fundstat_eng/data_bananas.html) and a [cleaned up version](https://github.com/meticulousdatascience/mds-blog/blob/master/assets/data/bananas_data.csv)
- [R var documentation](https://www.rdocumentation.org/packages/cmvnorm/versions/1.0-3/topics/var)


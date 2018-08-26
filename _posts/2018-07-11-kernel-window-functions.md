---
layout: post
title: "Kernel Window Functions"
author: "Meti"
categories: journal
tags: [time series, smoothing]
image: kernel.jpg
---

I've been reading about different smoothing techniques for jagged time series data, and I was interested to learn that the term "kernel" can refer to a "window" or "weighting" function. The goal of such a function is to assign larger values to inputs near a given fixed point, and taper off towards zero as you move away from the fixed point. The kernels are usually required to be positive, symmetric around the fixed point, integrable, and sometimes also bound an area of 1 (so that they define probability distributions of their own).

One interesting example is the tricube kernel. Given fixed point $x_i$ and distance $d_i$, the function is defined by 

$$W(x) = \left\{ \begin{array}{ll} (1 - (|x - x_i|/d_i)^3)^3 & \text{if $|x - x_i| \leq d_i$} \\ 0 & \text{otherwise} \end{array} \right.$$

(Technically, if we care about the weight function having total area 1, then we should scale it by $\frac{70}{81d_i}$.) 

For example, if $x_i$ = 5 and $d_i = 3$, we would get the following graph for $W$:

![](https://meticulousdatascience.com/assets/img/tricube.png)

You can see that as we move away from 5, the weights get smaller, until 3 units away from 5 when they've decayed to zero. Of course, if we are working in a higher dimensional space, we may want to change the distance metric we are using (the above equation doesn't worry about that since in one dimension, L1 = L2).

There are many other styles of kernel window functions, including Gaussians, logistic curves, and many others. In a later post we'll see how you can use kernels to smooth time series data.

Sidenote: In mathematics, specifically linear algebra, a "kernel" is a set of vectors which map to 0 under a given linear transformation. I am still trying to understand whether there is a connection between this use of the word and the window function version presented here.
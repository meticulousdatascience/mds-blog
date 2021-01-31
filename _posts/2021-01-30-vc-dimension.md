---
layout: post
title: "Example of Infinite VC Dimension"
author: "Sonya B"
categories: journal
tags: [machine learning]
usemathjax: true
image: 
---

A family of functions $$\{f_\alpha: X \rightarrow \mathbb{R}\}$$ shatters a set of points $$P \subseteq X $$ if for any assignment of binary labels to the elements of $$P$$ there exists an $$\alpha$$ so that $$f_\alpha(p) > 0$$ if and only if the binary label associated to $p$ is 0. (Note there are more abstract definitions but this will work for us for now.)

In other words, for a specific labeling of the points in $$P$$ there exists an $$\alpha$$ so that when we plot the points $$P$$ and plot the graph of $$f_\alpha$$, we see that the function completely separates the points in $$P$$ labeled as 0 from the points of $$P$$ labeled as 1. This means that $$f_\alpha$$ can be used as a binary classifier for the set $$P$$.

The VC dimension of $$\{f_\alpha\}$$ is defined to be the cardinality of the largest set of points $$P$$ that the family $$\{f_\alpha\}$$ shatters. Note that the family of functions doesn't have to shatter all sets of this size, only one. 

The plot belows shows that the set of quadratic functions $$\{f_{\alpha} = -(x-\alpha_0)(x-\alpha_1)\}$$ shatters a set of three points (the white points are labeled by 0s and the black points are labeled by 1s), so its VC dimension must be at least 3. (This example also illustrates that $$\alpha$$ can be a vector, it doesn't have to be just a number.)

![](https://meticulousdatascience.com/assets/img/vc1.png)

To prove that a family of functions has infinite VC dimension, we need to show there exists a set of any size that the family of functions can shatter. In this post, we'll prove that the family of functions $$\{f_\alpha(x) = \sin(\alpha x)\}$$ has infinite VC dimension. This problem comes from the book <i>The Elements of Statistical Learning</i>, problem 7.7.

To prove this, we'll show that the family of sine functions defined above shatters the points $$P = \left\{p_k = \frac{1}{10^k}: k = 1, \dots, n\right\}$$. 

So, to start with, suppose we have a binary labeling of all the points in $$P$$. We want to find a number $$\alpha$$ so that $$\sin(\alpha p_k) > 0$$ if and only if the label of $$p_k$$ is 0. 

Since $$p_k = \frac{1}{10^k}$$ we know that multiplying $$\alpha$$ by $$p_k$$ just moves the decimal in $$\alpha$$ to the left $$k$$ spots. For example, if $$\alpha = 32333$$ then $$\alpha p_3 = 32.333$$.

Now, the next thing we want to think about is that the location of the roots of the function $$\sin(\alpha x)$$ occur when $$\alpha x$$ is any multiple of $$\pi$$. If we assume $$\alpha > 0$$, then $$\sin(\alpha x) > 0$$ when $$\alpha x$$ is between an even and odd multiple of $$\pi$$ (such as $$0$$ and $$\pi$$) and $$\sin(\alpha x) < 0$$ when $$\alpha x$$ is between an odd and even multiple of $$\pi$$ (such as $$\pi$$ and $$2\pi$$). 

Putting these two things together, what we want to happen is that when we multiply $$\alpha$$ by $$p_k$$, i.e. move the decimals in $$\alpha$$ to the left $$k$$ spots, we end up with a number that is between an even and odd muliple of $$\pi$$ when the label of $$p_k$$ is 0 and between an odd and even multiple of $$\pi$$ when the label of $$p_k$$ is 1. 

This is easy enough to do! Let's let $$\alpha$$ be $$\pi$$ times the number defined by having a 3 in the $$k$$th digit (reading from the right) when $$p_k$$ is labeled by 0 and a 2 in the $$k$$th digit when $$p_k$$ is labeled by 1.

For example, if we have $$p_1$$, $$p_2$$, and $$p_3$$ labeled 0, 1, and 0, respectively, then we'll use $$\alpha = 323\pi$$.

Then, if we look at $$\sin(323\pi p_1) = \sin(32.3\pi)$$, we see that it's between an even and odd multiple of $$\pi$$ (specifically $$32\pi$$ and $$33\pi$$) and thus its value is positive, which is what we wanted since $$p_1$$ is labeled by a 0. Similarly, $$\sin(323\pi p_2) = \sin(3.23\pi)$$ is negative and $$\sin(323\pi p_3) = \sin(0.323\pi)$$ is positive. Below you can see the plot for $$\sin(323\pi x)$$ along with the three points $$p_1$$, $$p_2$$, and $$p_3$$.

![](https://meticulousdatascience.com/assets/img/vc2.png)

You probably observed that there are many different solutions, since the choice of $$2$$ and $$3$$ as the even and odd numbers in the construction of $$\alpha$$ are relatively arbitrary. You can find many rigorous proofs online using $$0$$s and $$1$$s instead of $$2$$s and $$3$$s, where a compact formula is created for $$\alpha$$. The point of this post was to demonstrate the thinking behind the choice of $$\alpha$$ from the ground up without jumping into a formula.


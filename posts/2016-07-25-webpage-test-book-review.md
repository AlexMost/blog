---
title: 'Using Webpagetets' book review
date: 2016-07-26
tags: books, frontend, book review
---

# Webpagetest book review
## book link - [here](http://shop.oreilly.com/product/0636920033592.do)

Recently I have finished this book and have some words for feedback. First of all
[Webpagetest](http://www.webpagetest.org/) is quite a powerful tool for monitoring website performance and for getting
some insights about performance bottlenecks and the ways in which they can be removed. This information can be inferred from projects page, but this tool is more powerful than I even thought and thanks to this book I have some insights about how I can use it on a real project more efficiently. So I definitely suggest you to read this book if
you care about measuring and testing website performance.

## What you can do with Webpagetest
The full list of features can be found in their spec or in the book. But here are some features that I found the most interesting for me:

* Measuring [speed index](https://sites.google.com/a/webpagetest.org/docs/using-webpagetest/metrics/speed-index).
* You can test webpage with or without cached resources (compare the results).
* You can check SPOF. (points of failure, check how your page behaves when some of the resources are not available).
* Configure to launch test on a real mobile devices.
* You can choose different locations all over the world for running your tests.
* You can use their API for launching some tests programmatically setting up CI.
* You can compare test of you webpage with competitors to get more insights about
which parts should be optimized (reports can be represented as a timeline screenshots or video).
* You can make your own custom setup of webpagetest instance on AWS or locally.
* You can setup a performance budget and add appropriate tasks to your CI.

## Synthetic or RUM tests?
Actually, there are two approaches on how you can measure your website performance.
One is RUM (real user monitoring). RUM can include such metrics as page load time, document ready time e.t.c. A good example for RUM is webpage statistics from google analytics. On the other side, a synthetic test is the test where you are actually model real user interaction and observing how the page renders (can include video recording, slides). Synthetic tests are useful when you want to control your webpage
performance across different environments and browsers. Webpagetest gives you a lot of 
options for setting up the most relevant tests for your case. And to be able to 
determine what settings are relevant for you can use data from RUM. So the answer for
"synthetic or RUM" is you should use both. In case of a webpagetest tool it is a tool for running synthetic tests.
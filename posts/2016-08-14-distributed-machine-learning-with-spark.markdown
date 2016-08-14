---
title: Distributed Machine Learning with Apache Spark (Edx course review)
date: 2016-08-14
tags: spark, courses
---

# Distributed Machine Learning with Apache Spark 
## Edx course - [link](https://www.edx.org/course/distributed-machine-learning-apache-uc-berkeleyx-cs120x)

So, I decided to continue my apache spark exploration and passed the second course on edx which is related to exploring this technology. Here is a brief summary of things that I found interesting in this course.

## You will become more familiar with machine learning basics and will create and train models for making predictions (linear regression, logistic regression)
This course will explain in detail the most basic concepts behind the linear and logistic regression models. Step by step you will create and train models for making predictions. I must admit that course materials are prepared well and if you have no prior experience in machine learning you will be able to learn those basics from scratch and apply all learned material for the real case scenarios. (click through rate predictions, predictions of the song year by some  features e.t.c). During the course, you will be working with datasets and tasks from [kaggle](https://www.kaggle.com/competitions). This is the most popular resource where data scientists all over the world are competing in solving the machine learning problems.

## You will become more familiar with Spark internals.
In the previous [course (Introduction to Apache Spark)](/posts/2016-07-13-apache-spark-intro.html) all tasks were based on work with DataFrame object. And in this one, you will be working with a little bit lower layer of abstraction - RDD (resilient distributed dataset). This experience brings some deeper understanding about how Spark works.

## You will recover some math skills
There are some math related tasks during this course. Basic matrix and vectors operations (multiplication, dot product e.t.c), derivatives their real case application (finding extremums for minimizing deviations). So if you have heard about those things in university but haven't seen where that knowledge can be applied - this course is a nice place to see how all those things work in a real world helping to solve real problems.

## A few words about functional programming
All spark API is based on functional code like maps, filters, reducers, zippers e.t.c. These operations are scaled on a bunch of workers and executed in parallel. But all that is happening behind the scenes (without ugly low-level locks, mutexes, and semaphores inside your code). Code that you are writing for data processing can be scaled almost infinitely. This is a strong argument for all those people who are saying that functional programming brings overhead in your code (because function calls can be expensive e.t.c). A few simple concepts: pure functions, referential transparency, immutable data structures made it possible to create the technology that can sort 100 TB array in 20 minutes and you don't need to setup supercomputers (mainframes) for that task you just need to write code that can be scaled.

## Conclusion
In general, I found this course interesting, challenging. Definitely, I don't regret that I have passed it and going to take the next one in this series. Big thanks to all those people who created this course and [databricks.com](https://databricks.com/) project.


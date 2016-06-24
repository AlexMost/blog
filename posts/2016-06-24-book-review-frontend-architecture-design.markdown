---
title: Book review "Frontend architecture design"
date: 2016-06-24
tags: frontend, frontend architecture, book review
---

Link on the Goodreads - [Frontend Architecture for Design Systems](https://www.goodreads.com/book/show/25977680-frontend-architecture-for-design-systems)

In general, it's a good book and gives you some insights about how you can improve 
your frontend architecture. Maybe I expected to get some more details about the ecosystem around javascript but 
instead, the author provides more examples for CSS methodologies. Anyway
, it was worth spending time on reading that book.

So below are the key points that I have taken from this book:

## The status of the frontend architecture
The way we build websites changed significantly in the
last couple of years. Pages were quite small in the past and all business logic was mostly concentrated on the backend. Now
we see that web page size continues growing. Requirements and expectations from the frontend are quite high nowadays.
Code size of js + CSS code is comparable with the backend code. And so it is reasonable to
research, think, design and continuously upgrade architecture for the frontend.

## Pillars of software architecture
The author defines four main pillars for modern software architecture. 
They are code, process, testing, and documentation. 
There are a couple of interesting examples of modular CSS approach in the book, that author used for Red hat site. 
OOCSS, SMACSS, and BEM so if you ever were interested in some kind of modular approach for writing CSS you should take a look.

## You should care about measuring website performance
Quite a good overview of modern web page performance test tools. 
Here are a couple of interesting resources that can help you with that:

* [http://httparchive.org/](http://httparchive.org/)
* [https://whatdoesmysitecost.com/](https://whatdoesmysitecost.com/)
* [http://www.webpagetest.org/](http://www.webpagetest.org/)

## Atomic design principle
You should care about components and their composition. Here is an awesome project
that gives you some insights on what is atomic design - [http://patternlab.io](http://patternlab.io/about.html)
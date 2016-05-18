---
title: Do we need npm -g?
date: 2016-05-18
---

## The problem
Nowadays our projects are obtaining more and more build dependencies.
In this article I will be speaking from the frontend development perspective.
But I think the same problem applies to other fields of development.

So very often, you are required to install some build deps globally via npm (grunt, gulp webpack, lint e.t.c). 
To my opinion that '-g' option in npm is a pure evil and here are the main reasons:

 * It's one more additional step for setting up the new environment for building your assets.
 * Global dependencies are not included into the package.json file, so nobody is aware of 
 what exact version of webpack(grunt, e.t.c) worked on your local machine, and your build can be broken 
 with some new version.
 * Very often, to use -g option you need to add sudo and that is a real security vulnerability problem.
 It's a great chance to add some evil script to npm install hook and stole all your nude photos.
 

## Why not to use make?
Makefiles originated in Unix like systems and is still the primary software build mechanism there.
They allow you to configure different rules for building your project.
If you are not familiar, you can read more about all power of make here - [GNU make](http://www.gnu.org/software/make/manual/make.html).
Don't be afraid, for the frontend part you need only small subset of make abilities. Such as modify environment variable,
passing arguments, or setting up rules dependencies to control the execution order.
Here is the example of basic project build setup, assume you have decided to build 
your assets with webpack and test with karma:

```bash
SHELL := /bin/bash
export PATH := $(PWD)/node_modules/.bin:$(PATH)

build:
        webpack
```

## Npm commands
Also, you can use npm commands like ```npm run```. This approach is little bit less
powerful than make but also works.

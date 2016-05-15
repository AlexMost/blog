---
title: Browser rendering optimisation (Udacity course)
date: 2016-05-15
---
<img src="/images/render-optimisations/udacity-logo.png"/>

## Browser rendering optimisation
course - [link](https://www.udacity.com/course/browser-rendering-optimization--ud860)

So here is, actually, the first post in this blog. And I decided to make it 
quite small, just a few impressions about the course from Google,
 that I have completed recently.

The course itself is quite small, but is full of interesting live examples
and gives you a nice overview of how browser rendering works. This course
gives you a good insight on how you can use Chrome dev tools to find bottlenecks
in your frontend apps. And gives you a lot of info on how to make your app running
at 60 fps. Shortly speaking, it will be useful for everyone who writes any frontend CSS/javascript code.

## Some course insights
Here are some main thoughts that I have after finishing the last course exercise:

* Use [composite layers](http://www.chrisdanford.com/blog/2011/07/24/understanding-hardware-compositing-css-transforms/) for creating smooth and almost zero cost animations. 
* Move CPU bound tasks to [Web workers](https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API/Using_web_workers). Seriously, why not to use them?
* There is no reason to use setInterval during animations, except you, are supporting
 old(as dirt) browsers. Use [requestAnimationFrame](https://developer.mozilla.org/en-US/docs/Web/API/window/requestAnimationFrame) instead.
* Avoid [forced synchronous layout](https://developers.google.com/web/tools/chrome-devtools/profile/rendering-tools/forced-synchronous-layouts?hl=en) calculation.
* Performance matters.
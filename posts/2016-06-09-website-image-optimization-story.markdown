---
title: Website image optimization story
date: 2016-06-09
tags: css, javascript, images
---

## So, I decided to write a blog post ...
The idea of this blog post was born during the time of creation of my previous post about
[Istanbul](/posts/2016-06-02-istambul.html). As it is already clear that blogpost was about travelling to Istanbul.
It was quite a nice travel with a lot of impressions and photos. So as a result I created a brief overview of the whole
travel and attached a lot of photos to my article. To be precise there are 36 photos now. 

## One does not simply can write and publish the blogpost
So far so good, when I finished my post I thought about image compression.
Because 36 photos without any size reduction were taking near 40 MB of space and that is
quite huge amount of data to load. As I have read somewhere on the internet the average page load size is
2 MB. So it is clear that I am far behind this limit.

## Step 1. Resize and compress all images
I looked over existing solutions and approaches and decided to use [imagemagick](http://www.imagemagick.org/script/index.php). 
After a few minutes looking over available commands and options i
decided to search for some reasonable config that will be
able to reduce image sizes without any significant visible changes and quality loose.
After some period of searching I ended up with this config
(thanks to [this](https://habrahabr.ru/post/261625/) awesome article):

```bash
mogrify -filter Triangle \
   -define filter:support=2 \
   -thumbnail OUTPUT_WIDTH \
   -unsharp 0.25x0.08+8.3+0.045 \
   -dither None \
   -posterize 136 \
   -quality 86 \
   -define jpeg:fancy-upsampling=off \
   -define png:compression-filter=5 \
   -define png:compression-level=9 \
   -define png:compression-strategy=1 \
   -define png:exclude-chunk=all \
   -interlace none \
   -colorspace sRGB INPUT_PATH
```

So I wrapped that in a small shell script - *smartresize.sh*:

*smartresize.sh*
```bash
smartresize() {
   echo "smart resize >>> $1 to $2"
   mogrify -filter Triangle \
   -define filter:support=2 \
   -thumbnail $2 \
   -unsharp 0.25x0.08+8.3+0.045 \
   -dither None \
   -posterize 136 \
   -quality 86 \
   -define jpeg:fancy-upsampling=off \
   -define png:compression-filter=5 \
   -define png:compression-level=9 \
   -define png:compression-strategy=1 \
   -define png:exclude-chunk=all \
   -interlace none \
   -colorspace sRGB $1
}

smartresize $1 $2
```

Just to be able to run that for all files (jpg) in some image dir I wrote a little rule in a Makefile:

```bash
compress:
    find tmp_img/ -name "*.jpg" -print0 | xargs -0 -n1 -I {} sh smartresize.sh {} 900
```

And after that I can place raw images inside *tmp_img/* folder and run *make compress*. That will resize all my
big images to smaller versions with max width or height in 900px and will reduce quality a little bit. This optimization works
much better than photoshop's "safe for web" function (near 35% better). And this script reduced
almost 90% of image sizes (not bad for a bash oneliner). At this point I could stop and publish my post, but
I decided to go further and make some more optimizations (:

## Image load statistics after basic compression
Here is page load statistics after images resize reduction 
(I have added throttling to make things look like more real with networking penalty from good 3G connection):

<img class="lazyload" src="/images/imgopt/1all_stats.jpg"/>

Really huge numbers for page load. Let's look what part of page load are taken by images (remember there are 36 photos on the page):

<img class="lazyload" src="/images/imgopt/1img_load_stats.jpg"/>

So we see that 5.5 MB of overall 6 MB content was just images load. If we will look at page load timeline
things will be not so terrifying, because at time 1.64 s we can actually start reading and see some part
of images (thanks to progressive jpeg) and at 3.55 s we can see also image.

<img class="lazyload" src="/images/imgopt/1screenshots.jpg"/>

Here is timeline for amount of work that is executed during that 32 seconds of page load:

<img class="lazyload" src="/images/imgopt/1timeline.jpg"/>

It is clear that even though we can see some readable content at time 3.4s there are still a lot of things going on on 
a background that are consuming our computation resources and make us far away from 60 fps.
We can do much better!

## Step2. Lazy load
There is no point in loading all images on the page load. The best approach that is commonly used all over the internet is to use
lazy image loading. This is how images were loaded previously (without lazy load):

<img class="lazyload" src="/images/imgopt/1img_load.jpg"/>

The were loaded all at once right after dom content was loaded. I used [lazysizes](https://github.com/aFarkas/lazysizes) for that task.
Here is how I need to change my image tags to load them on demand. Instead of:

```html
<img src="some-image.jpg"/>
```

I need to use:

```html
<img data-src="some-image.jpg" class="lazyload"/>
```

Let's refresh page and look at the stats:

<img class="lazyload" src="/images/imgopt/2all_stats.jpg"/>

Much better! We reduced number of initial requests. Now it takes 1.8MB to load our page, 
and we have Load event at 9.96s instead of 32.76s. But despite this optimization we can observe some problem while 
looking at the page load screenshots:

<img class="lazyload" src="/images/imgopt/2screenshots.jpg"/>

The page load looks very junky. As it expected afte dom content loaded at 1.79s we can see text without images but when images
are become available it starts jumping and creates poor user experience.



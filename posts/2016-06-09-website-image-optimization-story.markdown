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

## First step was just resize and compress all images
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

So I wrapped that in a small shell script - *smartresize.sh* and ended up with something like this in my Makefile:

```bash
compress:
    find tmp_img/ -name "*.jpg" -print0 | xargs -0 -n1 -I {} sh smartresize.sh {} 900
```

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
And after that I can place raw images inside *tmp_img/* folder and run *make compress*. That will resize all my
big images to smaller versions with max width or height in 900px and will reduce quality a little bit. This optimization works
much better than photoshop's "safe for web" function (near 35% better). And this script reduced
almost 90% of image sizes (not bad for a bash oneliner). At this point I could stop and publish my post, but
I decided to go further and make some more optimizations (:

Here is page load statistics after images resize (I have added throttling to make things look like more real with networking penalty):




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
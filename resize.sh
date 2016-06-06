resize() {
    for image in _site/images/**/*.jpg; do
        if [[ $image == *rszd* ]] ; then
            break
        fi
        convert $image -resize $1x$1 "$(dirname $image)/rszd$1_$(basename $image)";
    done
}

resize $1
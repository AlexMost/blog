.PHONY : install build watch deploy resize

install :
	npm install .
	stack setup
	stack build

build : clean
	stack exec site build

watch :
	stack exec site watch


clean:
	stack exec site clean


preview:
	find _site/images/ -name "*.jpg" | \
	grep -v "lqip" | \
	grep -v "rszd" | \
	sed 'p;s/\.jpg/\-lqip.jpg/' | \
	xargs -n2 convert -resize 100 -strip -interlace Plane -quality 10


lazify:
	find "$(shell pwd)/_site/posts" -name "*.html" -print | \
	tr '\n' '\0' | \
	xargs -0 -n1 node img-lazify.js


insertcss:
	find "$(shell pwd)/_site/" -name "*.html" -print | \
	tr '\n' '\0' | \
	xargs -0 -n1 node insert-css.js


compress:
	find tmp_img/ -name "*.jpg" -print0 | xargs -0 -n1 -I {} sh smartresize.sh {} 900


sizes:
	sh resize.sh 600
	sh resize.sh 300


optimize: sizes preview lazify insertcss


deploy: build optimize

.PHONY : install build watch deploy

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
	sed 'p;s/\.jpg/\-lqip.jpg/' | \
	xargs -n2 convert -resize 100x100^ -strip -interlace Plane -quality 10


lazify:
	find "$(shell pwd)/_site/posts" -name "*.html" -print | \
	tr '\n' '\0' | \
	xargs -0 -n1 node img-lazify.js


compress:
	find _site/images/ -name "*.jpg" -print0 | xargs -0 -n1 -I {} sh smartresize.sh {} 900


optimize: compress preview lazify

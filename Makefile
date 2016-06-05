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

image:
	find _site/images/ -name "*.jpg" | \
	grep -v "lqip" | \
	sed 'p;s/\.jpg/\-lqip.jpg/' | \
	xargs -n2 convert -strip -interlace Plane -blur 0x10 -quality 10


lazify: build
	find "$(shell pwd)/_site/posts" -name "*.html" -print | \
	tr '\n' '\0' | \
	xargs -0 -n1 node img-lazify.js


deploy: image lazify

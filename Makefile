.PHONY : install build watch deploy

install :
	stack setup
	stack build

build :
	stack exec site build

watch :
	stack exec site watch

deploy : build
    git commit -m "gh update"
	git subtree push --prefix _site/ origin gh-pages
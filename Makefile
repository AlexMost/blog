install:
	stack setup

build:
	stack exec site build

watch:
	stack exec site watch

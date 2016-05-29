.PHONY : install build watch deploy

install :
	stack setup
	stack build

build :
	stack exec site build

watch :
	stack exec site watch


clean:
	stack exec site clean

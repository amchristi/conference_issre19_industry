pdf=paper

all: | build ; make build/$(pdf).pdf

mysrc=$(wildcard src/*.tex src/*.png src/*.data src/*.txt)
srcthings=$(wildcard src/*.bib) $(etcthings) $(wildcard etc/*.sty etc/*.cfg src/*.pdf)
data=$(wildcard data/*)
#latexmk=../bin/latexmk -quiet -pdf
latexmk=../bin/latexmk -pdf


build/$(pdf).pdf: $(srcthings) $(mysrc)
	cp $(srcthings) $(mysrc) build
	cd build; $(latexmk) $(pdf).tex

build: ;  mkdir -p build

clobber:
	rm -rf build

clean:
	rm -rf build/*
	@touch src/paper.tex


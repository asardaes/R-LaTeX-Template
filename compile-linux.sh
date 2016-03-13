#!/bin/bash

filename="Thesis";

echo "Compiling..."

rm -rf $filename.pdf

if [ -e $filename.R -a $# -ne 0 ]; then
	Rscript --vanilla $filename.R $filename $1
fi

if ! [ -e $filename.tex ]; then
	echo "Error during knitting..."
	exit
fi

pdflatex -interaction=nonstopmode $filename.tex
bibtex $filename.aux
pdflatex -interaction=nonstopmode $filename.tex
 
rm -rf *.aux
rm -rf *.bbl
rm -rf *.blg
rm -rf *.d
rm -rf *.fls
rm -rf *.ilg
rm -rf *.ind
rm -rf *.toc*
rm -rf *.lot*
rm -rf *.lof*
rm -rf *.log
rm -rf *.idx
rm -rf *.out*
rm -rf *.nlo
rm -rf *.nls
rm -rf *.tdo

echo "Success!"
exit

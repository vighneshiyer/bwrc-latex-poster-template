SHELL=/bin/bash
MAIN = poster
PDF = $(MAIN).pdf
FIG_SVGS := $(shell find figs -type f -name "*.svg")
FIG_PDFS := $(subst .svg,.pdf,$(FIG_SVGS))

all: ${PDF}

%.pdf: %.tex $(FIG_PDFS) references.bib
	texfot pdflatex --shell-escape $<
	bibtex $(basename $<)
	texfot pdflatex --shell-escape $<
	texfot pdflatex --shell-escape $<

figs/%.pdf: figs/%.svg
	rsvg-convert -f pdf -o $@ $^

clean:
	$(RM) *.log *.aux \
	*.cfg *.glo *.idx *.toc \
	*.ilg *.ind *.out *.lof \
	*.lot *.bbl *.blg *.gls *.cut *.hd \
	*.dvi *.ps *.thm *.tgz *.zip *.rpi $(PDF) \
	*.nav *.run.xml *.vrb *.bcf *.snm *-blx.bib
	rm -rf _minted-$(MAIN)

.PHONY: all
.PRECIOUS: $(FIG_PDFS)

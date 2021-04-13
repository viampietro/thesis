PDFLATEX=pdflatex
BIBTEX=bibtex
TEX=main.tex
PDF=$(TEX:.tex=.pdf)

all: $(PDF)

$(PDF): $(TEX) $(wildcard *.tex) $(wildcard *.bib)
	$(PDFLATEX) $<; $(BIBTEX) $(<:.tex=); \
        for i in `seq 2`; do $(PDFLATEX) $<; done

check:
	@make -s clean; make -s all >/dev/null 2>&1; \
        echo "Checking with $(PDFLATEX) [$(TEX)]:"; $(PDFLATEX) $(TEX) | \
        grep "Overfull \\\hbox\|undefined on"; \
        echo "Checking with $(BIBTEX) [$(TEX)]:"; \
        $(BIBTEX) $(TEX:.tex=) | grep "Error\|Warning"; exit 0

clean:
	rm -f *~ .*~ *.aux *.bbl *.blg *.log *.out *.bcf *-blx.bib \
	*.fdb_latexmk *.fls *.lof *.lot *.run.xml *.toc $(PDF)

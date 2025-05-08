.PHONY: all analysis report clean

# Main analysis script
SCRIPT := citonga_tone_analysis.R

# RMarkdown report (if you choose to use it)
RMD    := citonga_tone_analysis.Rmd

# LaTeX report
TEX    := citonga_tone_report.tex
PDF    := citonga_tone_report.pdf

all: analysis report

analysis:
	Rscript $(SCRIPT)

report: analysis $(PDF)

$(PDF): $(TEX)
	pdflatex $(TEX) >/dev/null
	pdflatex $(TEX) >/dev/null

clean:
	rm -f *.aux *.log *.out *.pdf

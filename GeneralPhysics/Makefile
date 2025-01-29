LATEXMKFLAGS=
LATEXMK=latexmk

.PHONY: all clean

main: gp1_boot1_deriv.pdf gp1_boot1_deriv_true.pdf gp1_boot1_deriv_true_extra.pdf gp1_boot2_vector.pdf gp1_boot3_integ.pdf

%.pdf: %.tex
	${LATEXMK} $<

gp1_boot1_deriv_true.pdf: gp1_boot1_deriv.tex
	${LATEXMK} -jobname=gp1_boot1_deriv_true $<

clean:
	@${RM} -vf *.dvi *.aux *.fls *.ps *.log *.fdb_latexmk *~ *.out *.toc *.blg *.bbl *.synctex.gz *.bak *.xmpi *.xmpdata
	@${RM} -vrf _minted-* flycheck_*
	@${RM} blank.* texput.*

#@ls *.pdf | grep -v gp2.pdf | grep -v supplemental | xargs rm


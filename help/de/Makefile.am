figdir = figures
docname = gnucash-help
lang = de_DE
omffile = $(docname)-de_DE.omf
entities = \
	Help_ch_Intro.xml \
	Help_ch_GettingStarted.xml \
	Help_fdl-appendix.xml \
	Help_legal.xml \
	Help_chartofaccts.xml \
	Help_chtacctseg.xml \
	Help_txf-categories.xml \
	Help_tips-appendix.xml
DISTCLEANFILES =  $(docname)-de_DE.omf.out
CLEANFILES =  $(DISTCLEANFILES)
include $(top_srcdir)/xmldocs.make
include $(top_srcdir)/pdf.make
include $(top_srcdir)/epub.make
if WITH_MOBI
include $(top_srcdir)/mobi.make
endif

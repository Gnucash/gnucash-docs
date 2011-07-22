figdir = figures
docname = gnucash-help
lang = de_DE
omffile = $(docname)-de_DE.omf
entities = \
	fdl-appendix.xml \
	legal.xml \
	chartofaccts.xml \
	chtacctseg.xml \
	txf-categories.xml
DISTCLEANFILES =  $(docname)-de_DE.omf.out
CLEANFILES =  $(DISTCLEANFILES)
include $(top_srcdir)/xmldocs.make
include $(top_srcdir)/pdf.make
include $(top_srcdir)/epub.make
dist-hook: app-dist-hook

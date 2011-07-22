figdir = figures
docname = gnucash-guide
lang = de_DE
omffile = $(docname)-de_DE.omf
entities = \
 ch_basics.xml \
 ch_oview.xml \
 ch_accts.xml \
 ch_txns.xml \
 appendixe.xml \
 glossary.xml \
 index.xml
DISTCLEANFILES =  $(docname)-de_DE.omf.out
CLEANFILES =  $(DISTCLEANFILES)
include $(top_srcdir)/xmldocs.make
include $(top_srcdir)/pdf.make
include $(top_srcdir)/epub.make
dist-hook: app-dist-hook

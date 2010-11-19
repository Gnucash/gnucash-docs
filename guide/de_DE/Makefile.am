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
include $(top_srcdir)/xmldocs.make
include $(top_srcdir)/pdf.make
dist-hook: app-dist-hook
DISTCLEANFILES =  $(docname)-de_DE.omf.out

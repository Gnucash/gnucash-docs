figdir = figures
docname = gnucash-guide
lang = it
omffile = $(docname)-it.omf
DISTCLEANFILES =  $(docname)-it.omf.out
CLEANFILES =  $(DISTCLEANFILES)
include $(top_srcdir)/xmldocs.make
include $(top_srcdir)/pdf.make
include $(top_srcdir)/epub.make
if WITH_MOBI
include $(top_srcdir)/mobi.make
endif

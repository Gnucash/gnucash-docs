figdir = figures
docname = gnucash-help
lang = it_IT
omffile = $(docname)-it_IT.omf
DISTCLEANFILES =  $(docname)-it_IT.omf.out
CLEANFILES =  $(DISTCLEANFILES)
include $(top_srcdir)/xmldocs.make
include $(top_srcdir)/pdf.make
include $(top_srcdir)/epub.make
if WITH_MOBI
include $(top_srcdir)/mobi.make
endif
dist-hook: app-dist-hook

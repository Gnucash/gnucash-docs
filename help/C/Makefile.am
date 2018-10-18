if LANG_US
XSLTFLAGS_FO = --stringparam paper.type letter
else
XSLTFLAGS_FO = --stringparam paper.type A4
endif

figdir = figures
docname = gnucash-help
lang = C
omffile = $(docname)-C.omf
entities = \
	Help_ch_GettingStarted.xml
DISTCLEANFILES =  $(docname)-C.omf.out
CLEANFILES =  $(DISTCLEANFILES)
if GNC_WINDOWS
include $(top_srcdir)/chm.make
else
include $(top_srcdir)/xmldocs.make
include $(top_srcdir)/pdf.make
include $(top_srcdir)/epub.make
if WITH_MOBI
include $(top_srcdir)/mobi.make
endif
endif

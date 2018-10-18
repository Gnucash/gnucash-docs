if LANG_US
XSLTFLAGS_FO = --stringparam paper.type letter
else
XSLTFLAGS_FO = --stringparam paper.type A4
endif

figdir = figures
docname = gnucash-guide
lang = C
omffile = $(docname)-C.omf
entities = \
	ch_oview.xml \
	ch_basics.xml \
	ch_accts.xml \
	ch_txns.xml
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

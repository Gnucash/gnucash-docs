figdir = figures
docname = gnucash-guide
lang = de
omffile = $(docname)-de.omf
entities = \
 ch_accts.xml \
 ch_basics.xml \
 ch_oview.xml \
 ch_txns.xml
DISTCLEANFILES =  $(docname)-de.omf.out
CLEANFILES =  $(DISTCLEANFILES)
XSLTFLAGS_FO= --stringparam paper.type A4
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

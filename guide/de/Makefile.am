figdir = figures
docname = gnucash-guide
lang = de
omffile = $(docname)-de.omf
entities = \
 ch_accts.xml \
 ch_basics.xml \
 ch_bus_ap.xml \
 ch_bus_ar.xml \
 ch_capgain.xml \
 ch_cc.xml \
 ch_loans.xml \
 ch_invest.xml \
 ch_oth_assets.xml \
 ch_oview.xml \
 ch_txns.xml \
 appendixe.xml \
 glossary.xml \
 index.xml
DISTCLEANFILES =  $(docname)-de.omf.out
CLEANFILES =  $(DISTCLEANFILES)
include $(top_srcdir)/xmldocs.make
include $(top_srcdir)/pdf.make
include $(top_srcdir)/epub.make
if WITH_MOBI
include $(top_srcdir)/mobi.make
endif

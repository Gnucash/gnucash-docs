figdir = figures
docname = gnucash-guide
lang = de
omffile = $(docname)-de.omf
entities = \
 ch_accts.xml \
 ch_basics.xml \
 ch_budgets.xml \
 ch_bus_ap.xml \
 ch_bus_ar.xml \
 ch_bus_intro.xml \
 ch_bus_pay.xml \
 ch_bus_setup.xml \
 ch_capgain.xml \
 ch_cbook.xml \
 ch_cc.xml \
 ch_currency.xml \
 ch_loans.xml \
 ch_invest.xml \
 ch_oth_assets.xml \
 ch_oview.xml \
 ch_txns.xml \
 appendixe.xml \
 glossary.xml
DISTCLEANFILES =  $(docname)-de.omf.out
CLEANFILES =  $(DISTCLEANFILES)
XSLTFLAGS_FO= --stringparam paper.type A4
include $(top_srcdir)/xmldocs.make
include $(top_srcdir)/pdf.make
include $(top_srcdir)/epub.make
if WITH_MOBI
include $(top_srcdir)/mobi.make
endif

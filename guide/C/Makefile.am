figdir = figures
docname = gnucash-guide
lang = C
omffile = $(docname)-C.omf
entities = \
	fdl-appendix.xml \
	legal.xml \
	ch_oview.xml \
	ch_basics.xml \
	ch_accts.xml \
	ch_txns.xml \
	ch_cbook.xml \
	ch_cc.xml \
	ch_loans.xml \
	ch_invest.xml \
	ch_capgain.xml \
	ch_currency.xml \
	ch_dep.xml \
	ch_bus_ar.xml \
	ch_bus_ap.xml \
	ch_bus_pay.xml \
	ch_budgets.xml \
	ch_oth_assets.xml \
	ch_python_bindings.xml \
	ch_import_busisness_data.xml
	appendixa.xml \
	appendixb.xml \
	appendixc.xml \
	appendixd.xml
DISTCLEANFILES =  $(docname)-C.omf.out
CLEANFILES =  $(DISTCLEANFILES)
include $(top_srcdir)/xmldocs.make
include $(top_srcdir)/pdf.make
include $(top_srcdir)/epub.make
if WITH_MOBI
include $(top_srcdir)/mobi.make
endif
dist-hook: app-dist-hook

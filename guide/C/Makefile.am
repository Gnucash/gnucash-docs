figdir = figures
docname = gnucash-guide
lang = C
omffile = gnucash-guide-C.omf
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
	appendixa.xml \
	appendixb.xml \
	appendixc.xml \
	appendixd.xml
include $(top_srcdir)/xmldocs.make
dist-hook: app-dist-hook
DISTCLEANFILES =  gnucash-guide-C.omf.out

# 2008-10-02, Tom Browder: PDF creation.
#
# See README and HACKING.
#
# For now, the environment variable, 'DOCBOOK_XSL', must be set manually.
#
# To do: Fix configure to find the right tools and pieces and make the target
# if all parts are found.

CLEANFILES = gnucash-guide.pdf gnucash-guide.fo
pdf:
	fop -xml gnucash-guide.xml -xsl $(DOCBOOK_XSL) -pdf gnucash-guide.pdf

# for debugging intermediate output
pdf-debug:
	fop -d -xml gnucash-guide.xml -xsl $(DOCBOOK_XSL) -foout gnucash-guide.fo

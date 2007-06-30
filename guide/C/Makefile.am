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

# 2007-06-30, jsled: PDF creation "support".  This sucks.
#
# http://www.linuxfocus.org/English/May2000/article152.shtml
# http://www.ecos.sourceware.org/ml/docbook-apps/2001-q4/msg00168.html
#
# "|| true" because both commands "fail" for me. :p
#
# Note the stderr and stdout redirections. :/
#
# It seems it might be wiser to use XSL-FO instead, c.f.
# <http://sagehill.net/docbookxsl/PrintOutput.html>
pdf:
	docbook2tex -d /usr/share/sgml/docbook/dsssl-stylesheets-1.79/print/docbook.dsl gnucash-guide.xml 2> /dev/null || true 
	pdfjadetex gnucash-guide.tex > /dev/null || true

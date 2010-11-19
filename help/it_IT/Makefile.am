figdir = figures
docname = gnucash-help
lang = it_IT
omffile = $(docname)-it_IT.omf
entities = \
	Help_ch_Intro.xml \
	Help_ch_GettingStarted.xml \
	Help_ch_GUIMenus.xml \
	Help_ch_Account-Actions.xml \
	Help_ch_Transactions.xml \
	Help_ch_Tools_Druids.xml \
	Help_ch_Reports.xml \
	Help_ch_Customize.xml \
	Help_chtacctseg.xml \
	Help_chartofaccts.xml \
	Help_legal.xml \
	Help_txf-categories.xml \
	Help_fdl-appendix.xml \
        Help_tips-appendix.xml
DISTCLEANFILES =  $(docname)-it_IT.omf.out
CLEANFILES =  $(DISTCLEANFILES)
include $(top_srcdir)/xmldocs.make
include $(top_srcdir)/pdf.make
dist-hook: app-dist-hook

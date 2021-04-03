figdir = figures
docname = gnucash-help
lang = de
omffile = $(docname)-de.omf
entities = \
	Help_ch_Intro.xml \
	Help_ch_GettingHelp.xml \
	Help_ch_GettingStarted.xml \
	Help_ch_GUIMenus.xml \
	Help_ch_Account-Actions.xml \
	Help_ch_Transactions.xml \
	Help_ch_Business.xml\
	Help_ch_Tools_Assistants.xml \
	Help_ch_Reports.xml \
	Help_ch_Customize.xml \
	Help_fdl-appendix.xml \
	Help_legal.xml \
	Help_chartofaccts.xml \
	Help_chtacctseg.xml \
	Help_txf-categories.xml \
	Help_tips-appendix.xml
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

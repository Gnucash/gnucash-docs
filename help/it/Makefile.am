figdir = figures
docname = gnucash-help
lang = it
omffile = $(docname)-it.omf
DISTCLEANFILES =  $(docname)-it.omf.out
CLEANFILES =  $(DISTCLEANFILES)
XSLTFLAGS_FO= --stringparam paper.type A4
include $(top_srcdir)/xmldocs.make
include $(top_srcdir)/pdf.make
include $(top_srcdir)/epub.make
if WITH_MOBI
include $(top_srcdir)/mobi.make
endif

COMPONENTS = \
	${top_srcdir}/help/C/gnucash-help.xml \
	${top_srcdir}/help/C/Help_ch_Intro.xml \
        ${top_srcdir}/help/C/Help_ch_GettingHelp.xml \
	${top_srcdir}/help/C/Help_ch_GettingStarted.xml \
	${top_srcdir}/help/C/Help_ch_GUIMenus.xml \
	${top_srcdir}/help/C/Help_ch_Account-Actions.xml \
	${top_srcdir}/help/C/Help_ch_Transactions.xml \
	${top_srcdir}/help/C/Help_ch_Business.xml\
	${top_srcdir}/help/C/Help_ch_Tools_Assistants.xml \
	${top_srcdir}/help/C/Help_ch_Reports.xml \
	${top_srcdir}/help/C/Help_ch_Customize.xml \
	${top_srcdir}/help/C/Help_chtacctseg.xml \
	${top_srcdir}/help/C/Help_chartofaccts.xml \
	${top_srcdir}/help/C/Help_legal.xml \
	${top_srcdir}/help/C/Help_txf-categories.xml \
	${top_srcdir}/help/C/Help_fdl-appendix.xml \
        ${top_srcdir}/help/C/Help_tips-appendix.xml

gnucash-help.xml: ${COMPONENTS} ${srcdir}/it.po
	xml2po -e -p ${srcdir}/it.po -o $@ ${top_srcdir}/help/C/gnucash-help.xml
	if test "${srcdir}" != "${builddir}"; then mv $@ ${srcdir}; fi

EXTRA_DIST += it.po

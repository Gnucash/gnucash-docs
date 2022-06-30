set (COMPONENTS
        ${top_srcdir}/help/C/gnucash-help.xml
        ${top_srcdir}/help/C/ch_Intro.xml
        ${top_srcdir}/help/C/ch_GettingHelp.xml
        ${top_srcdir}/help/C/ch_GettingStarted.xml
        ${top_srcdir}/help/C/ch_GUIMenus.xml
        ${top_srcdir}/help/C/ch_Account-Actions.xml
        ${top_srcdir}/help/C/ch_Transactions.xml
        ${top_srcdir}/help/C/ch_Business.xml
        ${top_srcdir}/help/C/ch_Tools_Assistants.xml
        ${top_srcdir}/help/C/ch_Reports.xml
        ${top_srcdir}/help/C/ch_Customize.xml
        ${top_srcdir}/help/C/chtacctseg.xml
        ${top_srcdir}/help/C/chartofaccts.xml
        ${top_srcdir}/help/C/legal.xml
        ${top_srcdir}/help/C/txf-categories.xml
        ${top_srcdir}/help/C/fdl-appendix.xml
        ${top_srcdir}/help/C/tips-appendix.xml)

#gnucash-help.xml: ${COMPONENTS} ${srcdir}/it.po
#	xml2po -e -p ${srcdir}/it.po -o $@ ${top_srcdir}/help/C/gnucash-help.xml
#	if test "${srcdir}" != "${builddir}"; then mv $@ ${srcdir}; fi

#EXTRA_DIST += it.po

add_gnc_doc_targets(${docname} "")

set(extra_dist
    COME-TRADURRE
    it.po)
add_to_dist(${extra_dist})

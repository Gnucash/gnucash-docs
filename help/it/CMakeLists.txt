set (COMPONENTS
        ${top_srcdir}/help/C/gnucash-help.xml
        ${top_srcdir}/help/C/Help_ch_Intro.xml
        ${top_srcdir}/help/C/Help_ch_GettingHelp.xml
        ${top_srcdir}/help/C/Help_ch_GettingStarted.xml
        ${top_srcdir}/help/C/Help_ch_GUIMenus.xml
        ${top_srcdir}/help/C/Help_ch_Account-Actions.xml
        ${top_srcdir}/help/C/Help_ch_Transactions.xml
        ${top_srcdir}/help/C/Help_ch_Business.xml
        ${top_srcdir}/help/C/Help_ch_Tools_Assistants.xml
        ${top_srcdir}/help/C/Help_ch_Reports.xml
        ${top_srcdir}/help/C/Help_ch_Customize.xml
        ${top_srcdir}/help/C/Help_chtacctseg.xml
        ${top_srcdir}/help/C/Help_chartofaccts.xml
        ${top_srcdir}/help/C/Help_legal.xml
        ${top_srcdir}/help/C/Help_txf-categories.xml
        ${top_srcdir}/help/C/Help_fdl-appendix.xml
        ${top_srcdir}/help/C/Help_tips-appendix.xml
        legal.xml
        legal-disclaimer.xml
        fdl-appendix.xml
        )

#gnucash-help.xml: ${COMPONENTS} ${srcdir}/it.po
#	xml2po -e -p ${srcdir}/it.po -o $@ ${top_srcdir}/help/C/gnucash-help.xml
#	if test "${srcdir}" != "${builddir}"; then mv $@ ${srcdir}; fi

#EXTRA_DIST += it.po

add_gnc_doc_targets(${docname} "")

set(extra_dist
    COME-TRADURRE
    it.po
    legal.xml
    legal-disclaimer.xml
    fdl-appendix.xml)
add_to_dist(${extra_dist})

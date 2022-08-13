set (entities
    ${CMAKE_SOURCE_DIR}/manual/C/ch_Intro.xml
    ${CMAKE_SOURCE_DIR}/manual/C/ch_GettingHelp.xml
    ${CMAKE_SOURCE_DIR}/manual/C/ch_GettingStarted.xml
    ${CMAKE_SOURCE_DIR}/manual/C/ch_GUIMenus.xml
    ${CMAKE_SOURCE_DIR}/manual/C/ch_Account-Actions.xml
    ${CMAKE_SOURCE_DIR}/manual/C/ch_Transactions.xml
    ${CMAKE_SOURCE_DIR}/manual/C/ch_Business.xml
    ${CMAKE_SOURCE_DIR}/manual/C/ch_Tools_Assistants.xml
    ${CMAKE_SOURCE_DIR}/manual/C/ch_Reports.xml
    ${CMAKE_SOURCE_DIR}/manual/C/ch_Customize.xml
    ${CMAKE_SOURCE_DIR}/manual/C/chtacctseg.xml
    ${CMAKE_SOURCE_DIR}/manual/C/chartofaccts.xml
    ${CMAKE_SOURCE_DIR}/manual/C/legal.xml
    ${CMAKE_SOURCE_DIR}/manual/C/txf-categories.xml
    ${CMAKE_SOURCE_DIR}/manual/C/fdl-appendix.xml
    ${CMAKE_SOURCE_DIR}/manual/C/tips-appendix.xml
)

#gnucash-help.xml: ${CMAKE_SOURCE_DIR}/manual/C/gnucash-help.xml ${entities} ${srcdir}/it.po
#	xml2po -e -p ${srcdir}/it.po -o $@ ${CMAKE_SOURCE_DIR}/manual/C/gnucash-help.xml
#	if test "${srcdir}" != "${builddir}"; then mv $@ ${srcdir}; fi

add_gnc_doc_targets(${docname} "")

set(extra_dist
    COME-TRADURRE
    it.po)
add_to_dist(${extra_dist})

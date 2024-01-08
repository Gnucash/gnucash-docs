set (entities
    ${CMAKE_SOURCE_DIR}/manual/C/ch_Intro.docbook
    ${CMAKE_SOURCE_DIR}/manual/C/ch_GettingHelp.docbook
    ${CMAKE_SOURCE_DIR}/manual/C/ch_GettingStarted.docbook
    ${CMAKE_SOURCE_DIR}/manual/C/ch_GUIMenus.docbook
    ${CMAKE_SOURCE_DIR}/manual/C/ch_Account-Actions.docbook
    ${CMAKE_SOURCE_DIR}/manual/C/ch_Transactions.docbook
    ${CMAKE_SOURCE_DIR}/manual/C/ch_Business.docbook
    ${CMAKE_SOURCE_DIR}/manual/C/ch_Tools_Assistants.docbook
    ${CMAKE_SOURCE_DIR}/manual/C/ch_Reports.docbook
    ${CMAKE_SOURCE_DIR}/manual/C/ch_Customize.docbook
    ${CMAKE_SOURCE_DIR}/manual/C/ch_Finance-Quote.docbook
    ${CMAKE_SOURCE_DIR}/manual/C/chtacctseg.docbook
    ${CMAKE_SOURCE_DIR}/manual/C/chartofaccts.docbook
    ${CMAKE_SOURCE_DIR}/manual/C/legal.docbook
    ${CMAKE_SOURCE_DIR}/manual/C/txf-categories.docbook
    ${CMAKE_SOURCE_DIR}/manual/C/fdl-appendix.docbook
    ${CMAKE_SOURCE_DIR}/manual/C/tips-appendix.docbook
)

set (figures
    figures/AccountReg_Screen.png
    figures/AccountTree_Screen.png
    figures/Main-window-callouts.png
    figures/Pref_AccntPeriod.png
    figures/Pref_Accnts.png
    figures/Pref_Business.png
    figures/Pref_DateTime.png
    figures/Pref_General.png
    figures/Pref_OnlineBanking.png
    figures/Pref_Printing.png
    figures/Pref_Register.png
    figures/Pref_RegisterDefaults.png
    figures/Pref_Reports.png
    figures/Pref_Sched.png
    figures/Pref_Windows.png
    figures/Report_Screen.png
)

#index.docbook: ${CMAKE_SOURCE_DIR}/manual/C/index.docbook ${entities} ${srcdir}/it.po
#	xml2po -e -p ${srcdir}/it.po -o $@ ${CMAKE_SOURCE_DIR}/manual/C/index.docbook
#	if test "${srcdir}" != "${builddir}"; then mv $@ ${srcdir}; fi

set (xslt_files "")

add_gnc_doc_targets(${lang} "" "${figures}" "${xslt_files}")

set(extra_dist
    COME-TRADURRE
    it.po)
add_to_dist(${extra_dist})

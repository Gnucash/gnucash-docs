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

add_gnc_doc_targets(${lang} "" "${figures}")

set(extra_dist
    COME-TRADURRE
    it.po)
add_to_dist(${extra_dist})

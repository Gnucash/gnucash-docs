set (figdir "figures")
set (lang "ja")
set (entities
        fdl-appendix.xml
        legal.xml
        ch_oview.xml
        ch_basics.xml
        ch_accts.xml
        ch_txns.xml
        ch_cbook.xml
        ch_cc.xml
        ch_loans.xml
        ch_invest.xml
        ch_capgain.xml
        ch_currency.xml
        ch_dep.xml
        ch_bus_ar.xml
        ch_bus_ap.xml
        ch_bus_pay.xml
        ch_budgets.xml
        ch_oth_assets.xml
        ch_python_bindings.xml
        appendixa.xml
        appendixb.xml
        appendixc.xml
        appendixd.xml)

set (FOP_XCONF "${CMAKE_CURRENT_SOURCE_DIR}/fop.xconf.in")
# Compatibility hack for autotools
# When autotools gets dropped this line can be removed
# and CMAKE_CURRENT_SOURCE_DIR can be used directly in
# fop.xconf.in
set(BASEDIR_JA "${CMAKE_CURRENT_SOURCE_DIR}")

add_xml_target(${docname} ${lang} "${entities}" ${figdir})
add_html_target(${docname} ${lang} "${entities}" ${figdir})
if (PDF)
    add_pdf_target(${docname} ${lang} "${entities}" ${figdir})
endif()

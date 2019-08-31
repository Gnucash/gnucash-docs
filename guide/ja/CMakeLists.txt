set (figdir "figures")
set (lang "ja")
set (fopconfig "fop.xconf")
set (omffile "$(docname)-ja.omf")
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

add_xml_target(${docname} ${lang} "${entities}" ${figdir})
add_html_target(${docname} ${lang} "${entities}" ${figdir})

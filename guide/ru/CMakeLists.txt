set (entities
        ch_oview.xml
        ch_basics.xml
        ch_accts.xml
        ch_txns.xml
        ch_cbook.xml
        ch_cc.xml
        ch_expenses.xml
        ch_loans.xml
        ch_invest.xml
        ch_reports.xml
        ch_capgain.xml
        ch_currency.xml
        ch_dep.xml
        ch_bus_features.xml
        ch_budgets.xml
        ch_oth_assets.xml
        ch_python_bindings.xml
        ch_import_business_data.xml
        gnc-glossary.xml
        fdl-appendix.xml
        legal.xml
        appendixa.xml
        appendixd.xml)

set (FOP_XCONF "${CMAKE_CURRENT_SOURCE_DIR}/fop.xconf.in")

add_gnc_doc_targets(${docname} "${entities}")

set(extra_dist
    fop.xconf.in)
add_to_dist(${extra_dist})

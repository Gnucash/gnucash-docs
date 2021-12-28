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
        ch_bus_intro.xml
        ch_bus_setup.xml
        ch_bus_ar.xml
        ch_bus_ap.xml
        ch_bus_pay.xml
        ch_budgets.xml
        ch_oth_assets.xml
        ch_python_bindings.xml
#        ch_import_business_data.xml
        appendixa.xml
        appendixd.xml)

add_gnc_doc_targets(${docname} "${entities}")

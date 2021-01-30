set (entities
        ch_accts.xml
        ch_basics.xml
        ch_budgets.xml
        ch_bus_ap.xml
        ch_bus_ar.xml
        ch_bus_intro.xml
        ch_bus_pay.xml
        ch_bus_setup.xml
        ch_capgain.xml
        ch_cbook.xml
        ch_cc.xml
        ch_currency.xml
        ch_dep.xml
        ch_expenses.xml
        ch_import_business_data.xml
        ch_loans.xml
        ch_invest.xml
        ch_oth_assets.xml
        ch_oview.xml
        ch_python_bindings.xml
        ch_reports.xml
        ch_txns.xml
        appendixa.xml
        appendixb.xml
        appendixc.xml
        appendixd.xml
        appendixe.xml
        fdl-appendix.xml
        glossary.xml)

add_gnc_doc_targets(${docname} "${entities}")

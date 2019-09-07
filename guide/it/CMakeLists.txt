set (COMPONENTS
        ${top_srcdir}/guide/C/index.docbook
        ${top_srcdir}/guide/C/fdl-appendix.xml
        ${top_srcdir}/guide/C/legal.xml
        ${top_srcdir}/guide/C/ch_oview.xml
        ${top_srcdir}/guide/C/ch_basics.xml
        ${top_srcdir}/guide/C/ch_accts.xml
        ${top_srcdir}/guide/C/ch_txns.xml
        ${top_srcdir}/guide/C/ch_cbook.xml
        ${top_srcdir}/guide/C/ch_cc.xml
        ${top_srcdir}/guide/C/ch_expenses.xml
        ${top_srcdir}/guide/C/ch_loans.xml
        ${top_srcdir}/guide/C/ch_invest.xml
        ${top_srcdir}/guide/C/ch_reports.xml
        ${top_srcdir}/guide/C/ch_capgain.xml
        ${top_srcdir}/guide/C/ch_currency.xml
        ${top_srcdir}/guide/C/ch_dep.xml
        ${top_srcdir}/guide/C/ch_bus_features.xml
        ${top_srcdir}/guide/C/ch_budgets.xml
        ${top_srcdir}/guide/C/ch_oth_assets.xml
        ${top_srcdir}/guide/C/ch_python_bindings.xml
        ${top_srcdir}/guide/C/ch_import_business_data.xml
        ${top_srcdir}/guide/C/gnc-glossary.xml
        ${top_srcdir}/guide/C/appendixa.xml
        ${top_srcdir}/guide/C/appendixd.xml)

#index.docbook: ${COMPONENTS} ${srcdir}/it.po
#        xml2po -e -p ${srcdir}/it.po -o $@ ${top_srcdir}/guide/C/index.docbook
#        if test "${srcdir}" != "${builddir}"; then mv $@ ${srcdir}; fi

add_gnc_doc_targets(${docname} "" "${figures}")

set(extra_dist
    COME-TRADURRE
    it.po)
add_to_dist(${extra_dist})

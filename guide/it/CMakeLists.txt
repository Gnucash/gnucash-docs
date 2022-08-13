set (entities
    ${CMAKE_SOURCE_DIR}/guide/C/fdl-appendix.xml
    ${CMAKE_SOURCE_DIR}/guide/C/legal.xml
    ${CMAKE_SOURCE_DIR}/guide/C/ch_oview.xml
    ${CMAKE_SOURCE_DIR}/guide/C/ch_basics.xml
    ${CMAKE_SOURCE_DIR}/guide/C/ch_accts.xml
    ${CMAKE_SOURCE_DIR}/guide/C/ch_txns.xml
    ${CMAKE_SOURCE_DIR}/guide/C/ch_cbook.xml
    ${CMAKE_SOURCE_DIR}/guide/C/ch_cc.xml
    ${CMAKE_SOURCE_DIR}/guide/C/ch_expenses.xml
    ${CMAKE_SOURCE_DIR}/guide/C/ch_loans.xml
    ${CMAKE_SOURCE_DIR}/guide/C/ch_invest.xml
    ${CMAKE_SOURCE_DIR}/guide/C/ch_reports.xml
    ${CMAKE_SOURCE_DIR}/guide/C/ch_capgain.xml
    ${CMAKE_SOURCE_DIR}/guide/C/ch_currency.xml
    ${CMAKE_SOURCE_DIR}/guide/C/ch_dep.xml
    ${CMAKE_SOURCE_DIR}/guide/C/ch_bus_features.xml
    ${CMAKE_SOURCE_DIR}/guide/C/ch_budgets.xml
    ${CMAKE_SOURCE_DIR}/guide/C/ch_oth_assets.xml
    ${CMAKE_SOURCE_DIR}/guide/C/ch_python_bindings.xml
    ${CMAKE_SOURCE_DIR}/guide/C/ch_import_business_data.xml
    ${CMAKE_SOURCE_DIR}/guide/C/gnc-glossary.xml
    ${CMAKE_SOURCE_DIR}/guide/C/appendixa.xml
    ${CMAKE_SOURCE_DIR}/guide/C/appendixd.xml
)

#gnucash-guide.xml: ${CMAKE_SOURCE_DIR}/guide/C/gnucash-guide.xml ${entities} ${srcdir}/it.po
#        xml2po -e -p ${srcdir}/it.po -o $@ ${CMAKE_SOURCE_DIR}/guide/C/gnucash-guide.xml
#        if test "${srcdir}" != "${builddir}"; then mv $@ ${srcdir}; fi

add_gnc_doc_targets(${docname} "")

set(extra_dist
    COME-TRADURRE
    it.po)
add_to_dist(${extra_dist})

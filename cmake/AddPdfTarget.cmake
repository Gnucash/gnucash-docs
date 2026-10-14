function (add_pdf_target targetbase lang entities figures xslt_file)

    set(docname "gnucash-${targetbase}")
    set(fofile "${docname}.fo")
    set(pdffile "${docname}.pdf")

    set(BUILD_DIR "${DOCDIR_BUILD}/${lang}")

    if (NOT IS_ABSOLUTE ${xslt_file})
        set(xslt_file "${CMAKE_CURRENT_SOURCE_DIR}/${xslt_file}")
    endif()

    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${fofile}"
        COMMAND ${CMAKE_COMMAND} -E make_directory "${BUILD_DIR}"
        COMMAND ${XSLTPROC} ${XSLTPROCFLAGS} ${XSLTPROCFLAGS_FO}
                            -o "${CMAKE_CURRENT_BINARY_DIR}/${fofile}"
                            --stringparam gnc.lang ${lang}
                            "${xslt_file}"
                            "${CMAKE_CURRENT_SOURCE_DIR}/index.docbook"
        DEPENDS ${entities} "index.docbook" "${CMAKE_SOURCE_DIR}/docbook/gnc-docbookx.dtd")

    configure_file("${FOP_XCONF}" "${CMAKE_CURRENT_BINARY_DIR}/fop.xconf")

    add_custom_command(
        OUTPUT "${BUILD_DIR}/${pdffile}"
        COMMAND ${FOP} ${FOPFLAGS}
                        -l ${lang}
                        -c "${CMAKE_CURRENT_BINARY_DIR}/fop.xconf"
                        -fo "${CMAKE_CURRENT_BINARY_DIR}/${fofile}"
                        -pdf "${BUILD_DIR}/${pdffile}"
        DEPENDS "${CMAKE_CURRENT_BINARY_DIR}/${fofile}" ${figures})

    add_custom_target("${lang}-${targetbase}-pdf"
        DEPENDS "${BUILD_DIR}/${pdffile}")

    add_dependencies(${lang}-pdf "${lang}-${targetbase}-pdf")

endfunction()

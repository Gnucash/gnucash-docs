function (add_pdf_target docname lang entities figures)

    set(fofile "${docname}.fo")
    set(pdffile "${docname}.pdf")

    set(BUILD_DIR "${DOCDIR_BUILD}/${lang}")
    file(MAKE_DIRECTORY "${BUILD_DIR}")


    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${fofile}"
        COMMAND ${XSLTPROC} ${XSLTPROCFLAGS} ${XSLTPROCFLAGS_FO}
							--stringparam gnc.lang ${lang}
                            -o "${CMAKE_CURRENT_BINARY_DIR}/${fofile}"
                            "${CMAKE_SOURCE_DIR}/xsl/gnc-custom-fo.xsl"
                            "${CMAKE_CURRENT_SOURCE_DIR}/${docname}.xml"
        DEPENDS ${entities} "${docname}.xml" "${CMAKE_SOURCE_DIR}/docbook/gnc-docbookx.dtd")

    configure_file("${FOP_XCONF}" "${CMAKE_CURRENT_BINARY_DIR}/fop.xconf")

    add_custom_command(
        OUTPUT "${BUILD_DIR}/${pdffile}"
        COMMAND ${CMAKE_COMMAND} -E copy_directory "${CMAKE_SOURCE_DIR}/stylesheet" "${CMAKE_CURRENT_SOURCE_DIR}/stylesheet"
        COMMAND ${FOP} ${FOPFLAGS}
                        -l ${lang}
                        -c "${CMAKE_CURRENT_BINARY_DIR}/fop.xconf"
                        -fo "${CMAKE_CURRENT_BINARY_DIR}/${fofile}"
                        -pdf "${BUILD_DIR}/${pdffile}"
        DEPENDS "${CMAKE_CURRENT_BINARY_DIR}/${fofile}" ${figures})

    add_custom_target("${lang}-${docname}-pdf"
        DEPENDS "${BUILD_DIR}/${pdffile}")

    add_dependencies(${docname}-pdf "${lang}-${docname}-pdf")

endfunction()

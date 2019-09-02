function (add_pdf_target docname lang entities figdir)

    set(fofile "${docname}.fo")
    set(pdffile "${docname}.pdf")
    file(GLOB figures "${CMAKE_CURRENT_SOURCE_DIR}/${figdir}/*.png")

    # Determine paper format depending on language
    # It's a pretty simple hack: only US or C will be set to letter. All others use A4.
    if (lang MATCHES ".*_us.*|C")
        set (XSLTFLAGS_FO "--stringparam paper.type letter")
    else()
        set (XSLTFLAGS_FO "--stringparam paper.type A4")
    endif()

    add_custom_target("${lang}-${docname}-fo"
        COMMAND ${XSLTPROC} ${XSLTPROCFLAGS} ${XSLTPROCFLAGS_FO}
                            -o "${CMAKE_CURRENT_BINARY_DIR}/${fofile}"
                            --stringparam fop1.extensions 1
                            "${CMAKE_SOURCE_DIR}/xsl/1.79.2/fo/docbook.xsl"
                            "${CMAKE_CURRENT_SOURCE_DIR}/${docname}.xml"
        DEPENDS ${entities} "${docname}.xml" "${CMAKE_SOURCE_DIR}/docbook/gnc-docbookx.dtd")

    configure_file("${FOP_XCONF}" "${CMAKE_CURRENT_BINARY_DIR}/fop.xconf")
    add_custom_target("${lang}-${docname}-pdf"
        COMMAND ${FOP} ${FOPFLAGS}
                        -l ${lang}
                        -c "${CMAKE_CURRENT_BINARY_DIR}/fop.xconf"
                        -fo "${CMAKE_CURRENT_BINARY_DIR}/${fofile}"
                        -pdf "${CMAKE_CURRENT_BINARY_DIR}/${pdffile}"
        DEPENDS ${lang}-${docname}-fo ${figures})

    add_dependencies(${docname}-pdf "${lang}-${docname}-pdf")

endfunction()

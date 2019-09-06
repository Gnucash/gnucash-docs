function (add_pdf_target docname lang entities figdir)

    set(fofile "${docname}.fo")
    set(pdffile "${docname}.pdf")
    file(GLOB figures "${CMAKE_CURRENT_SOURCE_DIR}/${figdir}/*.png")

    set(BUILD_DIR "${DOCDIR_BUILD}/${lang}")
    file(MAKE_DIRECTORY "${BUILD_DIR}")

    # Determine paper format depending on language (which maps to the document's directory name)
    # * for language "C" (fallback language) determine paper format based on current locale
    # * for other languages, the will be set to letter. All others use A4.
    set (XSLTFLAGS_FO "--stringparam paper.type A4")
    if (lang STREQUAL "C")
        # For the fallback language determine paper format depending on locale
        # Only US or C will be set to letter. All others use A4.
        set (ENV_LANG $ENV{LANG})
        if (ENV_LANG AND ENV_LANG MATCHES ".*_us.*|C") # Replacing ENV_LANG here with if ($ENV{LANG}) won't work.
            set (XSLTFLAGS_FO "--stringparam paper.type letter")
        endif()
    endif()

    add_custom_target("${lang}-${docname}-fo"
        COMMAND ${XSLTPROC} ${XSLTPROCFLAGS} ${XSLTPROCFLAGS_FO}
                            -o "${CMAKE_CURRENT_BINARY_DIR}/${fofile}"
                            --stringparam fop1.extensions 1
                            "${CMAKE_SOURCE_DIR}/xsl/1.79.2/fo/docbook.xsl"
                            "${CMAKE_CURRENT_SOURCE_DIR}/${docname}.xml"
        BYPRODUCTS "${CMAKE_CURRENT_BINARY_DIR}/${fofile}"
        DEPENDS ${entities} "${docname}.xml" "${CMAKE_SOURCE_DIR}/docbook/gnc-docbookx.dtd")

    configure_file("${FOP_XCONF}" "${CMAKE_CURRENT_BINARY_DIR}/fop.xconf")
    add_custom_target("${lang}-${docname}-pdf"
        COMMAND ${FOP} ${FOPFLAGS}
                        -l ${lang}
                        -c "${CMAKE_CURRENT_BINARY_DIR}/fop.xconf"
                        -fo "${CMAKE_CURRENT_BINARY_DIR}/${fofile}"
                        -pdf "${BUILD_DIR}/${pdffile}"
        BYPRODUCTS "${BUILD_DIR}/${pdffile}"
        DEPENDS ${lang}-${docname}-fo ${figures})

    add_dependencies(${docname}-pdf "${lang}-${docname}-pdf")

endfunction()

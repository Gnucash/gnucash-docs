function (add_pdf_target targetbase lang entities figures xslfiles)

    set(docname "gnucash-${targetbase}")
    set(fofile "${docname}.fo")
    set(pdffile "${docname}.pdf")

    set(BUILD_DIR "${DOCDIR_BUILD}/${lang}")

    # Determine paper format depending on language (which maps to the document's directory name)
    # * for language "C" (fallback language) determine paper format based on current locale
    # * all others use A4.
    set (XSLTFLAGS_FO "--stringparam paper.type A4")
    if (lang STREQUAL "C")
        # For the fallback language determine paper format depending on locale
        # Only US or C will be set to letter. All others use A4.
        set (ENV_LANG $ENV{LANG})
        if (ENV_LANG AND ENV_LANG MATCHES ".*_us.*|C") # Replacing ENV_LANG here with if ($ENV{LANG}) won't work.
            set (XSLTFLAGS_FO "--stringparam paper.type letter")
        endif()
    endif()

    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${fofile}"
        COMMAND ${CMAKE_COMMAND} -E make_directory "${BUILD_DIR}"
        COMMAND ${XSLTPROC} ${XSLTPROCFLAGS} ${XSLTPROCFLAGS_FO}
                            -o "${CMAKE_CURRENT_BINARY_DIR}/${fofile}"
                            --stringparam fop1.extensions 1
                            --stringparam variablelist.as.blocks 1
                            --stringparam glosslist.as.blocks 1
                            "${xslfiles}"
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

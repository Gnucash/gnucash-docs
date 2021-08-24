#
# A function to generate PDF documentation
#
# FUNCTION:
#   add_pdf_target
# ARGUMENTS:
# - docname: The basename of the main xml file. Will be used to locate
#            this primary xml file and for various output files/directories.
#            Either "gnucash-guide" or "gnucash-help" now.
# - lang: The language of the current document, such as "C", "de" and so on.
# - entities: A list of all xml files this document is composed of. ONLY filename, WITHOUT path.
#             It does NOT contain "${docname}.xml".
# - figures: A list of FULL PATH image files.
# - dtd_files: A list of FULL PATH DTD files.
function (add_pdf_target docname lang entities figures dtd_files)

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
        DEPENDS ${entities} "${docname}.xml" ${dtd_files})

    configure_file("${FOP_XCONF}" "${CMAKE_CURRENT_BINARY_DIR}/fop.xconf")

    add_custom_command(
        OUTPUT "${BUILD_DIR}/${pdffile}"
        COMMAND ${CMAKE_COMMAND} -E copy_directory "${CMAKE_SOURCE_DIR}/xsl/images" "${CMAKE_CURRENT_BINARY_DIR}/images"
        COMMAND ${CMAKE_COMMAND} -E copy_directory "${CMAKE_CURRENT_SOURCE_DIR}/figures" "${CMAKE_CURRENT_BINARY_DIR}/figures"
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

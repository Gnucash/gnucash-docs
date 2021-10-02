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
#
function (add_pdf_target docname lang entities figures dtd_files)

    # Prepare variables and directories for build
    set(fmt "pdf")
    set(fofile "${docname}.fo")
    set(outfile "${docname}.${fmt}")

    set(BUILD_DIR "${CMAKE_CURRENT_BINARY_DIR}/${fmt}")
    set(OUTPUT_DIR "${CMAKE_BINARY_DIR}/share/doc/${lang}")

    configure_file("${FOP_XCONF}" "${BUILD_DIR}/fop.xconf")

    # GnuCash-specific xsl files
    file(GLOB xsl_files "${CMAKE_SOURCE_DIR}/xsl/*.xsl")
    file(GLOB gnucash_icon_files "${CMAKE_SOURCE_DIR}/xsl/icons/*")


    # Prepare ${BUILD_DIR}
    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-preparedir-trigger"
        COMMAND ${CMAKE_COMMAND} -E make_directory "${BUILD_DIR}/figures"
        COMMAND ${CMAKE_COMMAND} -E make_directory "${BUILD_DIR}/images/callouts"
        COMMAND ${CMAKE_COMMAND} -E make_directory "${OUTPUT_DIR}"
        COMMAND touch "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-preparedir-trigger")

    # Create FO file.
    add_custom_command(
        OUTPUT "${BUILD_DIR}/${fofile}"
        COMMAND ${XSLTPROC} ${XSLTPROCFLAGS} ${XSLTPROCFLAGS_FO}
                            -o "${BUILD_DIR}/${fofile}"
                            --stringparam gnc.lang ${lang}
                            "${CMAKE_SOURCE_DIR}/xsl/gnc-custom-${fmt}.xsl"
                            "${CMAKE_CURRENT_SOURCE_DIR}/${docname}.xml"
        DEPENDS ${entities} "${docname}.xml" ${dtd_files} ${xsl_files}
                "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-preparedir-trigger")

    # Create PDF file.
    add_custom_command(
        OUTPUT "${OUTPUT_DIR}/${outfile}"
        COMMAND ${FOP} ${FOPFLAGS}
                        -l ${lang}
                        -c "${BUILD_DIR}/fop.xconf"
                        -fo "${BUILD_DIR}/${fofile}"
                        -pdf "${OUTPUT_DIR}/${outfile}"
        DEPENDS "${BUILD_DIR}/${fofile}" ${figures}
                "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-fig-trigger"
                "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-gnucashicon-trigger")

    # Copy figures for this document
    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-fig-trigger"
        COMMAND ${CMAKE_COMMAND} -E copy ${figures} "${BUILD_DIR}/figures"
        COMMAND touch "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-fig-trigger"
        DEPENDS ${figures}
                "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-preparedir-trigger")

    # Copy XSL Stylesheet icons
    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-xslticon-trigger"
        # SVG admonition icons are used in PDF.
        COMMAND cp -f "${CMAKE_SOURCE_DIR}/xsl/images/*.svg" "${BUILD_DIR}/images"
        # SVG callout icons are used in PDF.
        COMMAND cp -f "${CMAKE_SOURCE_DIR}/xsl/images/callouts/*.svg"  "${BUILD_DIR}/images/callouts"
        COMMAND touch "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-xslticon-trigger"
        DEPENDS "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-preparedir-trigger")

    # Copy GnuCash-Specific icons
    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-gnucashicon-trigger"
        COMMAND cp -f "${CMAKE_SOURCE_DIR}/xsl/icons/*" "${BUILD_DIR}/images"
        COMMAND touch "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-gnucashicon-trigger"
        DEPENDS "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-xslticon-trigger"
                "${gnucash_icon_files}")

    add_custom_target("${lang}-${docname}-${fmt}"
        DEPENDS "${OUTPUT_DIR}/${outfile}")

    add_dependencies(${docname}-${fmt} "${lang}-${docname}-${fmt}")

    install(FILES "${OUTPUT_DIR}/${outfile}"
        DESTINATION "share/doc/${lang}"
        OPTIONAL
        COMPONENT "${fmt}")

    # Cleaning
    # Don't remove "fop.xconf".
    add_custom_target("${lang}-${docname}-${fmt}-clean"
        COMMAND ${CMAKE_COMMAND} -E rm -rf "${BUILD_DIR}/figures"
        COMMAND ${CMAKE_COMMAND} -E rm -rf "${BUILD_DIR}/images")

    add_dependencies(clean-extra "${lang}-${docname}-${fmt}-clean")

endfunction()

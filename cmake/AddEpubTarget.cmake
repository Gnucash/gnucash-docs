#
# A function to generate epub and mobi documentation
# A mobi is converted from epub.
#
# FUNCTION:
#   add_epub_target
# ARGUMENTS:
# - docname: The basename of the main xml file. Will be used to locate
#            this primary xml file and for various output files/directories.
#            Either "gnucash-guide" or "gnucash-help" now.
# - lang: The language of the current document, such as "C", "de" and so on.
# - entities: A list of all xml files this document is composed of. ONLY filename, WITHOUT path.
#             It does NOT contain "${docname}.xml".
# - figures: A list of FULL PATH image files.
# - dtd_files: A list of FULL PATH DTD files.
##########################
# FUNCTION:
#   add_mobi_target
# ARGUMENTS:
# - docname: The basename of the main xml file. Will be used to locate
#            this primary xml file and for various output files/directories.
#            Either "gnucash-guide" or "gnucash-help" now.
# - lang: The language of the current document, such as "C", "de" and so on.
#
function (add_epub_target docname lang entities figures dtd_files)

    # Setup base directory
    set(fmt "epub")
    set(outfile "${docname}.${fmt}")

    set(BUILD_DIR "${CMAKE_CURRENT_BINARY_DIR}/${fmt}")
    set(OUTPUT_DIR "${CMAKE_BINARY_DIR}/share/doc/${lang}")


    # GnuCash-specific xsl files
    file(GLOB xsl_files "${CMAKE_SOURCE_DIR}/xsl/*.xsl")
    file(GLOB gnucash_icon_files "${CMAKE_SOURCE_DIR}/xsl/icons/*")


    # Prepare ${BUILD_DIR}
    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-preparedir-trigger"
        COMMAND ${CMAKE_COMMAND} -E make_directory "${BUILD_DIR}/OEBPS/figures"
        COMMAND ${CMAKE_COMMAND} -E make_directory "${BUILD_DIR}/OEBPS/images/callouts"
        COMMAND ${CMAKE_COMMAND} -E make_directory "${OUTPUT_DIR}"
        COMMAND touch "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-preparedir-trigger")

    # Copy figures for this document
    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-fig-trigger"
        COMMAND ${CMAKE_COMMAND} -E copy ${figures} "${BUILD_DIR}/OEBPS/figures"
        COMMAND touch "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-fig-trigger"
        DEPENDS ${figures}
                "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-preparedir-trigger")

    # Copy XSL Stylesheet icons
    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-xslticon-trigger"
        # PNG admonition icons are used in EPUB.
        COMMAND cp -f "${CMAKE_SOURCE_DIR}/xsl/images/*.png" "${BUILD_DIR}/OEBPS/images"
        # SVG callout icons are used in EPUB.
        COMMAND cp -f "${CMAKE_SOURCE_DIR}/xsl/images/callouts/*.svg" "${BUILD_DIR}/OEBPS/images/callouts"
        COMMAND touch "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-xslticon-trigger"
        DEPENDS "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-preparedir-trigger")

    # Copy GnuCash-Specific icons
    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-gnucashicon-trigger"
        COMMAND cp -f "${CMAKE_SOURCE_DIR}/xsl/icons/*" "${BUILD_DIR}/OEBPS/images"
        COMMAND touch "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-gnucashicon-trigger"
        DEPENDS "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-xslticon-trigger"
                "${gnucash_icon_files}")

    # Create EPUB file.
    add_custom_command(
        OUTPUT "${OUTPUT_DIR}/${outfile}"
        COMMAND echo "application/epub+zip" > "${BUILD_DIR}/mimetype"
        COMMAND ${XSLTPROC} ${XSLTPROCFLAGS}
                            -o "${BUILD_DIR}/"
                            --stringparam base.dir OEBPS/
                            --stringparam epub.metainf.dir META-INF/
                            --stringparam epub.oebps.dir OEBPS/
                            "${CMAKE_SOURCE_DIR}/xsl/gnc-custom-${fmt}.xsl"
                            "${CMAKE_CURRENT_SOURCE_DIR}/${docname}.xml"
        COMMAND cd "${BUILD_DIR}" && zip -X -r "${OUTPUT_DIR}/${outfile}" mimetype META-INF OEBPS
        DEPENDS ${entities} "${docname}.xml" ${dtd_files} ${xsl_files} ${figures}
                "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-preparedir-trigger"
                "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-fig-trigger"
                "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-gnucashicon-trigger")

    add_custom_target("${lang}-${docname}-${fmt}"
        DEPENDS "${OUTPUT_DIR}/${outfile}")

    add_dependencies(${docname}-${fmt} "${lang}-${docname}-${fmt}")

    install(FILES "${OUTPUT_DIR}/${outfile}"
        DESTINATION "share/doc/${lang}"
        OPTIONAL
        COMPONENT "${fmt}")

endfunction()

function (add_mobi_target docname lang)

    set(fmt "mobi")
    set(BUILD_DIR "${CMAKE_BINARY_DIR}/share/doc/${lang}")
    set(OUTPUT_DIR "${BUILD_DIR}")

    set(outfile "${docname}.${fmt}")
    set(epubfile "${docname}.epub")

    add_custom_command(
        OUTPUT "${OUTPUT_DIR}/${outfile}"
        COMMAND ${EBOOK_CONVERT} "${OUTPUT_DIR}/${epubfile}" "${OUTPUT_DIR}/${outfile}"
        DEPENDS "${OUTPUT_DIR}/${epubfile}"
                "${lang}-${docname}-${fmt}")

    add_custom_target("${lang}-${docname}-${fmt}"
        DEPENDS "${OUTPUT_DIR}/${outfile}")

    add_dependencies(${lang}-${docname}-${fmt} "${lang}-${docname}-epub")
    add_dependencies(${docname}-${fmt} "${lang}-${docname}-${fmt}")

    install(FILES "${OUTPUT_DIR}/${outfile}"
        DESTINATION "share/doc/${lang}"
        OPTIONAL
        COMPONENT "${fmt}")

endfunction()

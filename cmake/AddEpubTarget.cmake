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

    file(MAKE_DIRECTORY "${BUILD_DIR}/OEBPS/figures")
    file(MAKE_DIRECTORY "${BUILD_DIR}/OEBPS/images/callouts")
    file(MAKE_DIRECTORY "${OUTPUT_DIR}")


    # GnuCash-specific xsl files
    file(GLOB xsl_files "${CMAKE_SOURCE_DIR}/xsl/*.xsl")
    file(GLOB gnucash_icon_files "${CMAKE_SOURCE_DIR}/xsl/icons/*")


    # Create EPUB file form xhtml (output of xsltproc)
    add_custom_command(
        OUTPUT "${OUTPUT_DIR}/${outfile}"
        COMMAND echo "application/epub+zip" > "${BUILD_DIR}/mimetype"
        COMMAND ${XSLTPROC} ${XSLTPROCFLAGS}
                            -o "${BUILD_DIR}/"
                            --stringparam base.dir OEBPS/
                            --stringparam epub.metainf.dir META-INF/
                            --stringparam epub.oebps.dir OEBPS/
                            "${CMAKE_SOURCE_DIR}/xsl/gnc-custom-epub.xsl"
                            "${CMAKE_CURRENT_SOURCE_DIR}/${docname}.xml"
        COMMAND ${CMAKE_COMMAND} -E copy_directory "${CMAKE_CURRENT_SOURCE_DIR}/figures" "${BUILD_DIR}/OEBPS/figures"
        COMMAND mkdir -p "${BUILD_DIR}/OEBPS/images/callouts"
        # PNG admonition and GnuCash icons are used in EPUB.
        COMMAND cp -f "${CMAKE_SOURCE_DIR}/xsl/images/*.png"  "${BUILD_DIR}/OEBPS/images"
        # SVG callout icons are used in html.
        COMMAND cp -f "${CMAKE_SOURCE_DIR}/xsl/images/callouts/*.svg"  "${BUILD_DIR}/OEBPS/images/callouts"
        # GnuCash-specific icons
        COMMAND cp -f "${CMAKE_SOURCE_DIR}/xsl/icons/*"  "${BUILD_DIR}/OEBPS/images"
        COMMAND zip -X -r "${OUTPUT_DIR}/${outfile}" mimetype META-INF OEBPS
        DEPENDS ${entities} "${docname}.xml" "${figures}" "${dtd_files}"
                "${xsl_files}" "${gnucash_icon_files}"
        WORKING_DIRECTORY "${BUILD_DIR}")

    add_custom_target("${lang}-${docname}-${fmt}"
        DEPENDS "${OUTPUT_DIR}/${outfile}")

    add_dependencies(${docname}-${fmt} "${lang}-${docname}-${fmt}")


    install(FILES
            "${OUTPUT_DIR}/${outfile}"
        DESTINATION "share/doc/${lang}"
        OPTIONAL)

endfunction()

#
# The target MOBI will be obsoleted in GnuCash 5.0.
#
function (add_mobi_target docname lang)

    set(BUILD_DIR "${CMAKE_BINARY_DIR}/share/doc/${lang}")
    file(MAKE_DIRECTORY "${BUILD_DIR}")

    set(epubfile "${BUILD_DIR}/${docname}.epub")
    set(mobifile "${BUILD_DIR}/${docname}.mobi")

    add_custom_command(
        OUTPUT "${mobifile}"
        COMMAND ${EBOOK_CONVERT} "${epubfile}" "${mobifile}"
        DEPENDS "${epubfile}")

    add_custom_target("${lang}-${docname}-mobi"
        DEPENDS "${mobifile}")

    add_dependencies(${docname}-mobi "${lang}-${docname}-mobi")

endfunction()

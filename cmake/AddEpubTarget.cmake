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
#   add_epub_target
# ARGUMENTS:
# - docname: The basename of the main xml file. Will be used to locate
#            this primary xml file and for various output files/directories.
#            Either "gnucash-guide" or "gnucash-help" now.
# - lang: The language of the current document, such as "C", "de" and so on.
# 



function (add_epub_target docname lang entities figures dtd_files)

    set(epubfile "${docname}.epub")
    set(EPUB_TMPDIR "${CMAKE_CURRENT_BINARY_DIR}/epub")

    set(BUILD_DIR "${DOCDIR_BUILD}/${lang}")
    file(MAKE_DIRECTORY "${BUILD_DIR}")

    add_custom_command(
        OUTPUT "${BUILD_DIR}/${epubfile}"
        COMMAND rm -fr "${EPUB_TMPDIR}"
        COMMAND mkdir "${EPUB_TMPDIR}"
        COMMAND echo "application/epub+zip" > "${EPUB_TMPDIR}/mimetype"
        COMMAND ${XSLTPROC} ${XSLTPROCFLAGS}
                            -o "${EPUB_TMPDIR}/"
                            --stringparam base.dir OEBPS/
                            --stringparam epub.metainf.dir META-INF/
                            --stringparam epub.oebps.dir OEBPS/
                            "${CMAKE_SOURCE_DIR}/xsl/gnc-custom-epub.xsl"
                            "${CMAKE_CURRENT_SOURCE_DIR}/${docname}.xml"
        COMMAND ${CMAKE_COMMAND} -E copy_directory "${CMAKE_CURRENT_SOURCE_DIR}/figures" "${EPUB_TMPDIR}/OEBPS/figures"
        COMMAND mkdir -p "${EPUB_TMPDIR}/OEBPS/images/callouts"
        # PNG admonition and GnuCash icons are used in EPUB.
        COMMAND cp -f "${CMAKE_SOURCE_DIR}/xsl/images/*.png"  "${EPUB_TMPDIR}/OEBPS/images"
        # SVG callout icons are used in html.
        COMMAND cp -f "${CMAKE_SOURCE_DIR}/xsl/images/callouts/*.svg"  "${EPUB_TMPDIR}/OEBPS/images/callouts"
        COMMAND cd "${EPUB_TMPDIR}" && zip -X -r "${BUILD_DIR}/${epubfile}" mimetype META-INF OEBPS
        DEPENDS ${entities} "${docname}.xml" "${figures}" "${dtd_files}")

    add_custom_target("${lang}-${docname}-epub"
        DEPENDS "${BUILD_DIR}/${epubfile}")

    add_dependencies(${docname}-epub "${lang}-${docname}-epub")

endfunction()

function (add_mobi_target docname lang)

    set(BUILD_DIR "${DOCDIR_BUILD}/${lang}")
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

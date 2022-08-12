function (add_epub_target docname lang entities figures)

    set(epubfile "${docname}.epub")
    set(EPUB_TMPDIR "${CMAKE_CURRENT_BINARY_DIR}/epub")

    set(BUILD_DIR "${DOCDIR_BUILD}/${lang}")

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
                            --stringparam fop1.extensions 1
                            "${CMAKE_SOURCE_DIR}/xsl/1.79.2/epub/docbook.xsl"
                            "${CMAKE_CURRENT_SOURCE_DIR}/${docname}.xml"
        COMMAND cmake -E copy_directory "${CMAKE_CURRENT_SOURCE_DIR}/figures" "${EPUB_TMPDIR}/OEBPS/figures"
        COMMAND ${CMAKE_COMMAND} -E make_directory "${BUILD_DIR}"
        COMMAND cd "${EPUB_TMPDIR}" && zip -X -r "${BUILD_DIR}/${epubfile}" mimetype META-INF OEBPS
        DEPENDS ${entities} "${docname}.xml" "${CMAKE_SOURCE_DIR}/docbook/gnc-docbookx.dtd" ${figures})

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

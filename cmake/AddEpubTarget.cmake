function (add_epub_target targetbase lang entities figures xslfiles)

    set(docname "gnucash-${targetbase}")
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
                            "${xslfiles}"
                            "${CMAKE_CURRENT_SOURCE_DIR}/index.docbook"
        COMMAND cmake -E copy_directory "${CMAKE_CURRENT_SOURCE_DIR}/figures" "${EPUB_TMPDIR}/OEBPS/figures"
        COMMAND ${CMAKE_COMMAND} -E make_directory "${BUILD_DIR}"
        COMMAND cd "${EPUB_TMPDIR}" && zip -X -r "${BUILD_DIR}/${epubfile}" mimetype META-INF OEBPS
        DEPENDS ${entities} "index.docbook" "${CMAKE_SOURCE_DIR}/docbook/gnc-docbookx.dtd" ${figures})

    add_custom_target("${lang}-${targetbase}-epub"
        DEPENDS "${BUILD_DIR}/${epubfile}")

    add_dependencies(${lang}-epub "${lang}-${targetbase}-epub")

endfunction()

function (add_mobi_target targetbase lang)

    set(docname "gnucash-${targetbase}")
    set(BUILD_DIR "${DOCDIR_BUILD}/${lang}")
    file(MAKE_DIRECTORY "${BUILD_DIR}")

    set(epubfile "${BUILD_DIR}/${docname}.epub")
    set(mobifile "${BUILD_DIR}/${docname}.mobi")

    add_custom_command(
        OUTPUT "${mobifile}"
        COMMAND ${EBOOK_CONVERT} "${epubfile}" "${mobifile}"
        DEPENDS "${epubfile}")

    add_custom_target("${lang}-${targetbase}-mobi"
        DEPENDS "${mobifile}")

    add_dependencies(${lang}-mobi "${lang}-${targetbase}-mobi")

endfunction()

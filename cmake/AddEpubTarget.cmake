function (add_epub_target docname lang entities figdir)

    set(epubfile "${docname}.epub")
    set(EPUB_TMPDIR "${CMAKE_CURRENT_BINARY_DIR}/epub")
    file(GLOB figures "${CMAKE_CURRENT_SOURCE_DIR}/${figdir}/*.png")

    set(BUILD_DIR "${DOCDIR_BUILD}/${lang}")
    file(MAKE_DIRECTORY "${BUILD_DIR}")

    add_custom_target("${lang}-${docname}-epub"
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
        COMMAND cd "${EPUB_TMPDIR}" && zip -X -r "${BUILD_DIR}/${epubfile}" mimetype META-INF OEBPS
        BYPRODUCTS "${BUILD_DIR}/${epubfile}"
        DEPENDS ${entities} "${docname}.xml" "${CMAKE_SOURCE_DIR}/docbook/gnc-docbookx.dtd" ${figures})

    add_dependencies(${docname}-epub "${lang}-${docname}-epub")

endfunction()

function (add_mobi_target docname lang)

    set(BUILD_DIR "${DOCDIR_BUILD}/${lang}")
    file(MAKE_DIRECTORY "${BUILD_DIR}")

    set(epubfile "${BUILD_DIR}/${docname}.epub")
    set(mobifile "${BUILD_DIR}/${docname}.mobi")

    add_custom_target("${lang}-${docname}-mobi"
        COMMAND ${EBOOK_CONVERT} ${epubfile} ${mobifile}
        BYPRODUCTS "${mobifile}"
        DEPENDS "${epubfile}")

    add_dependencies(${docname}-mobi "${lang}-${docname}-mobi")

endfunction()

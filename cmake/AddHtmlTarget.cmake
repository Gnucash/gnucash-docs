#
# A function to generate html documentation
#
# FUNCTION:
#   add_html_target
# ARGUMENTS:
# - docname: The basename of the main xml file. Will be used to locate
#            this primary xml file and for various output files/directories.
#            Either "gnucash-guide" or "gnucash-help" now.
# - lang: The language of the current document, such as "C", "de" and so on.
# - entities: A list of all xml files this document is composed of. ONLY filename, WITHOUT path.
#             It does NOT contain "${docname}.xml".
# - figures: A list of FULL PATH image files.
# - dtd_files: A list of FULL PATH DTD files.


function (add_html_target docname lang entities figures dtd_files)

    # Setup base directory
    # We don't need to make work directory, we can output HTML files directly.
    set(BUILD_DIR "${DOCDIR_BUILD}/${lang}/${docname}")
    file(MAKE_DIRECTORY "${BUILD_DIR}")

    # Convert xml to html with xsltproc
    # xsltproc --xinclude -o outputdir/ stylesheet.xsl "${docname}.xml"
    add_custom_command(
        OUTPUT "${BUILD_DIR}/index.html"
        COMMAND  ${XSLTPROC} ${XSLTPROCFLAGS} ${XSLTPROCFLAGS_HTML}
                             -o "${BUILD_DIR}/"
                             "${CMAKE_SOURCE_DIR}/xsl/gnc-custom-html.xsl"
                             "${CMAKE_CURRENT_SOURCE_DIR}/${docname}.xml"
        DEPENDS ${entities} "${docname}.xml" "${dtd_files}")


    # Copy figures for this document
    file(MAKE_DIRECTORY "${BUILD_DIR}/figures")
    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/htmlfigtrigger"
        COMMAND ${CMAKE_COMMAND} -E copy ${figures} "${BUILD_DIR}/figures"
        COMMAND touch "${CMAKE_CURRENT_BINARY_DIR}/htmlfigtrigger"
        DEPENDS ${figures})

    # Copy icon files for this documents
    # Removed dependency because icon files are rarely changed. 
    file(MAKE_DIRECTORY "${BUILD_DIR}/images/callouts")
    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/htmlicontrigger"
        # PNG admonition and GnuCash icons are used in html.
        COMMAND cp -f "${CMAKE_SOURCE_DIR}/xsl/images/*.png"  "${BUILD_DIR}/images"
        # SVG callout icons are used in html.
        COMMAND cp -f "${CMAKE_SOURCE_DIR}/xsl/images/callouts/*.svg"  "${BUILD_DIR}/images/callouts"
        COMMAND touch "${CMAKE_CURRENT_BINARY_DIR}/htmlicontrigger")

    add_custom_target("${lang}-${docname}-html"
        DEPENDS "${BUILD_DIR}/index.html"
                "${CMAKE_CURRENT_BINARY_DIR}/htmlfigtrigger"
                "${CMAKE_CURRENT_BINARY_DIR}/htmlicontrigger")

    add_dependencies(${docname}-html "${lang}-${docname}-html")

    install(DIRECTORY ${BUILD_DIR}
      DESTINATION "${CMAKE_INSTALL_DOCDIR}/${lang}"
      )
endfunction()

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

    # Prepare variables and directories for build
    set(fmt "html")

    # We don't need to make work directory, we can output HTML files directly.
    set(OUTPUT_DIR "${DOCDIR_BUILD}/${lang}/${docname}")

    file(MAKE_DIRECTORY "${OUTPUT_DIR}/figures")
    file(MAKE_DIRECTORY "${OUTPUT_DIR}/images/callouts")

    # GnuCash-specific xsl files
    file(GLOB xsl_files "${CMAKE_SOURCE_DIR}/xsl/*.xsl")
    file(GLOB gnucash_icon_files "${CMAKE_SOURCE_DIR}/xsl/icons/*")


    # Convert xml to html with xsltproc
    # xsltproc --xinclude -o outputdir/ stylesheet.xsl "${docname}.xml"
    add_custom_command(
        OUTPUT "${OUTPUT_DIR}/index.html"
        COMMAND  ${XSLTPROC} ${XSLTPROCFLAGS} ${XSLTPROCFLAGS_HTML}
                             -o "${OUTPUT_DIR}/"
                             "${CMAKE_SOURCE_DIR}/xsl/gnc-custom-html.xsl"
                             "${CMAKE_CURRENT_SOURCE_DIR}/${docname}.xml"
        DEPENDS ${entities} "${docname}.xml" "${dtd_files}" "${xsl_files}")


    # Copy figures for this document
    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-fig-trigger"
        COMMAND ${CMAKE_COMMAND} -E copy ${figures} "${OUTPUT_DIR}/figures"
        COMMAND touch "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-fig-trigger"
        DEPENDS ${figures})

    # Copy XSL Stylesheet icons
    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-xslticon-trigger"
        # PNG admonition icons are used in html.
        COMMAND cp -f "${CMAKE_SOURCE_DIR}/xsl/images/*.png" "${OUTPUT_DIR}/images"
        # SVG callout icons are used in html.
        COMMAND cp -f "${CMAKE_SOURCE_DIR}/xsl/images/callouts/*.svg"  "${OUTPUT_DIR}/images/callouts"
        COMMAND touch "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-xslticon-trigger")

    # Copy GnuCash-Specific icons
    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-gnucashicon-trigger"
        COMMAND cp -f "${CMAKE_SOURCE_DIR}/xsl/icons/*" "${OUTPUT_DIR}/images"
        COMMAND touch "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-gnucashicon-trigger"
        DEPENDS "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-xslticon-trigger"
                "${gnucash_icon_files}")

    # TARGET dependencies
    add_custom_target("${lang}-${docname}-${fmt}"
        DEPENDS "${OUTPUT_DIR}/index.html"
                "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-fig-trigger"
                "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-gnucashicon-trigger")

    add_dependencies(${docname}-${fmt} "${lang}-${docname}-${fmt}")

    install(DIRECTORY ${OUTPUT_DIR}
      DESTINATION "share/doc/${lang}"
      OPTIONAL)

endfunction()

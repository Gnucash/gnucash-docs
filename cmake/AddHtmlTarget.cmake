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
#
function (add_html_target docname lang entities figures dtd_files)

    # Prepare variables and directories for build
    set(fmt "html")

    # We don't need to make work directory, we can output HTML files directly.
    set(BUILD_DIR "${CMAKE_BINARY_DIR}/share/doc/${lang}/${docname}")
    set(OUTPUT_DIR "${BUILD_DIR}")

    # GnuCash-specific xsl files
    file(GLOB xsl_files "${CMAKE_SOURCE_DIR}/xsl/*.xsl")
    file(GLOB gnucash_icon_files "${CMAKE_SOURCE_DIR}/xsl/icons/*")

    set(styledir "${CMAKE_SOURCE_DIR}/stylesheet")
    file(GLOB styleicons "${CMAKE_SOURCE_DIR}/stylesheet/*.png")

    # Prepare ${BUILD_DIR}
    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-preparedir-trigger"
        COMMAND ${CMAKE_COMMAND} -E make_directory "${BUILD_DIR}/figures"
        COMMAND ${CMAKE_COMMAND} -E make_directory "${BUILD_DIR}/images/callouts"
        COMMAND touch "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-preparedir-trigger")

    # Convert xml to html with xsltproc
    # xsltproc --xinclude -o outputdir/ /usr/share/sgml/docbook/xsl-stylesheets/html/chunk.xsl filename.xml
    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/htmltrigger"
        COMMAND  ${XSLTPROC} ${XSLTPROCFLAGS} ${XSLTPROCFLAGS_HTML}
                             -o "${BUILD_DIR}/"
                             --param use.id.as.filename "1"
                             --stringparam chunker.output.encoding UTF-8
                             "${CMAKE_SOURCE_DIR}/xsl/general-customization.xsl"
                             "${CMAKE_CURRENT_SOURCE_DIR}/${docname}.xml"
        COMMAND touch "${CMAKE_CURRENT_BINARY_DIR}/htmltrigger"
        DEPENDS ${entities} "${docname}.xml" ${dtd_files} ${xsl_files}
                "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-preparedir-trigger")

    # Copy figures for this document
    file(MAKE_DIRECTORY "${BUILD_DIR}/figures")
    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/html_figtrigger"
        COMMAND ${CMAKE_COMMAND} -E copy ${figures} "${BUILD_DIR}/figures"
        COMMAND touch "${CMAKE_CURRENT_BINARY_DIR}/html_figtrigger"
        DEPENDS ${figures})

    # Copy style icons for this document (warning, info,...)
    file(MAKE_DIRECTORY "${BUILD_DIR}/stylesheet")
    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/styletrigger"
        COMMAND  ${CMAKE_COMMAND} -E copy ${styleicons} "${BUILD_DIR}/stylesheet/"
        COMMAND touch "${CMAKE_CURRENT_BINARY_DIR}/styletrigger"
        DEPENDS ${styleicons})

    add_custom_target("${lang}-${docname}-html"
        DEPENDS "${CMAKE_CURRENT_BINARY_DIR}/htmltrigger"
                "${CMAKE_CURRENT_BINARY_DIR}/html_figtrigger"
                "${CMAKE_CURRENT_BINARY_DIR}/styletrigger")

    add_dependencies(${docname}-html "${lang}-${docname}-html")

    install(DIRECTORY ${BUILD_DIR}
      DESTINATION "${CMAKE_INSTALL_DOCDIR}/${lang}"
      )
endfunction()

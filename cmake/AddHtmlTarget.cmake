#
# Functions to generate html documentation
#
# Paremeters:
# - docname: basename of the main xml file. Will be used to locate
#            this primary xml file and for various output files/directories
# - lang: language of the current document
# - entities: list of all xml files this document is composed of
# - figdir: name of the directory holding the images

function (add_html_target docname lang entities figures)

    set(styledir "${CMAKE_SOURCE_DIR}/stylesheet")

    set(BUILD_DIR "${DOCDIR_BUILD}/${lang}/${docname}")
    file(MAKE_DIRECTORY "${BUILD_DIR}")
    file(MAKE_DIRECTORY "${BUILD_DIR}/figures")
    file(MAKE_DIRECTORY "${BUILD_DIR}/stylesheet")

    # Convert xml to html with xsltproc
    # xsltproc --xinclude -o outputdir/ /usr/share/sgml/docbook/xsl-stylesheets/html/chunk.xsl filename.xml
    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/htmltrigger"
        COMMAND  ${XSLTPROC} ${XSLTPROCFLAGS} ${XSLTPROCFLAGS_HTML}
                             -o "${BUILD_DIR}/"
                             "${CMAKE_SOURCE_DIR}/xsl/gnucash/gnc-custom-html.xsl"
                             "${CMAKE_CURRENT_SOURCE_DIR}/${docname}.xml"
        COMMAND touch "${CMAKE_CURRENT_BINARY_DIR}/htmltrigger"
        DEPENDS ${entities} "${docname}.xml" "${CMAKE_SOURCE_DIR}/docbook/gnc-docbookx.dtd")

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
        COMMAND  ${CMAKE_COMMAND} -E copy_directory "${CMAKE_SOURCE_DIR}/stylesheet" "${BUILD_DIR}/stylesheet"
        COMMAND touch "${CMAKE_CURRENT_BINARY_DIR}/styletrigger"
        DEPENDS "${CMAKE_SOURCE_DIR}/stylesheet")

    add_custom_target("${lang}-${docname}-html"
        DEPENDS "${CMAKE_CURRENT_BINARY_DIR}/htmltrigger"
                "${CMAKE_CURRENT_BINARY_DIR}/html_figtrigger"
                "${CMAKE_CURRENT_BINARY_DIR}/styletrigger")

    add_dependencies(${docname}-html "${lang}-${docname}-html")

    install(DIRECTORY ${BUILD_DIR}
      DESTINATION "${CMAKE_INSTALL_DOCDIR}/${lang}"
      )
endfunction()

#
# Functions to generate html documentation
#
# Paremeters:
# - docname: basename of the main xml file. Will be used to locate
#            this primary xml file and for various output files/directories
# - lang: language of the current document
# - entities: list of all xml files this document is composed of
# - figdir: name of the directory holding the images

function (add_html_target docname lang entities figdir)

    file(GLOB figures "${CMAKE_CURRENT_SOURCE_DIR}/${figdir}/*.png")
    set(styledir "${CMAKE_SOURCE_DIR}/stylesheet")
    file(GLOB styleicons "${CMAKE_SOURCE_DIR}/stylesheet/*.png")

    set(BUILD_DIR "${DOCDIR_BUILD}/${lang}/${docname}")
    file(MAKE_DIRECTORY "${BUILD_DIR}")

    # Convert xml to html with xsltproc
    # xsltproc --xinclude -o outputdir/ /usr/share/sgml/docbook/xsl-stylesheets/html/chunk.xsl filename.xml
    add_custom_target("${lang}-${docname}-html-files"
        COMMAND  ${XSLTPROC} ${XSLTPROCFLAGS} ${XSLTPROCFLAGS_HTML}
                             -o "${BUILD_DIR}/"
                             --param use.id.as.filename "1"
                             --stringparam chunker.output.encoding UTF-8
                             "${CMAKE_SOURCE_DIR}/xsl/general-customization.xsl"
                             "${CMAKE_CURRENT_SOURCE_DIR}/${docname}.xml"
        DEPENDS ${entities} "${docname}.xml" "${CMAKE_SOURCE_DIR}/docbook/gnc-docbookx.dtd")

    # Copy figures for this document
    file(MAKE_DIRECTORY "${BUILD_DIR}/${figdir}")
    add_custom_target("${lang}-${docname}-html-figures"
        COMMAND  ${CMAKE_COMMAND} -E copy ${figures} "${BUILD_DIR}/${figdir}"
        DEPENDS ${figures})

    # Copy style icons for this document (warning, info,...)
    file(MAKE_DIRECTORY "${BUILD_DIR}/stylesheet")
    add_custom_target("${lang}-${docname}-html-style"
        COMMAND  ${CMAKE_COMMAND} -E copy ${styleicons} "${BUILD_DIR}/stylesheet"
        DEPENDS ${styleicons})

    add_custom_target("${lang}-${docname}-html"
        DEPENDS "${lang}-${docname}-html-files" "${lang}-${docname}-html-figures" "${lang}-${docname}-html-style")

    add_dependencies(${docname}-html "${lang}-${docname}-html")

endfunction()

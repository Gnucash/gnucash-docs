#
# Functions to generate html documentation
#
# Paremeters:
# - targetbase: basename of the target to build. Will also be used
#               as part of various output files/directories
# - lang: language of the current document
# - entities: list of all xml files this document is composed of
# - figdir: name of the directory holding the images

function (add_html_target targetbase lang entities figures xslt_file)

    set(docname "gnucash-${targetbase}")
    set(BUILD_DIR "${DOCDIR_BUILD}/${lang}/${docname}")

    if (NOT IS_ABSOLUTE ${xslt_file})
        set(xslt_file "${CMAKE_CURRENT_SOURCE_DIR}/${xslt_file}")
    endif()

    file(MAKE_DIRECTORY "${BUILD_DIR}" "${BUILD_DIR}/figures" "${BUILD_DIR}/stylesheet")

    # Copy figures for this document
    foreach(figure ${figures})
        configure_file(${figure} ${BUILD_DIR}/figures COPYONLY)
    endforeach()
    file(GLOB dest_figures "${BUILD_DIR}/${figures}")

    # Copy style icons for this document (warning, info, ...)
    file(GLOB styleicons "${CMAKE_SOURCE_DIR}/stylesheet/*.png")
    foreach(styleicon ${styleicons})
        configure_file(${styleicon} ${BUILD_DIR}/stylesheet COPYONLY)
    endforeach()
    file(GLOB dest_styleicons "${BUILD_DIR}/stylesheet/*")

    # Convert xml to html with xsltproc
    # xsltproc --xinclude -o outputdir/ /usr/share/sgml/docbook/xsl-stylesheets/html/chunk.xsl filename.xml
    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/htmltrigger"
        COMMAND  ${XSLTPROC} ${XSLTPROCFLAGS} ${XSLTPROCFLAGS_HTML}
                             -o "${BUILD_DIR}/"
                             --param use.id.as.filename "1"
                             --stringparam chunker.output.encoding UTF-8
                             "${xslt_file}"
                             "${CMAKE_CURRENT_SOURCE_DIR}/index.docbook"
        COMMAND touch "${CMAKE_CURRENT_BINARY_DIR}/htmltrigger"
        DEPENDS ${entities} "index.docbook" "${CMAKE_SOURCE_DIR}/docbook/gnc-docbookx.dtd")

    add_custom_target("${lang}-${targetbase}-html"
        DEPENDS "${CMAKE_CURRENT_BINARY_DIR}/htmltrigger"
                 ${dest_figures} ${dest_styleicons})

    add_dependencies(${lang}-html "${lang}-${targetbase}-html")

    if(WITH_HTML_INSTALL)
        install(DIRECTORY ${BUILD_DIR}
            DESTINATION "${CMAKE_INSTALL_DOCDIR}/${lang}")
    endif()
endfunction()

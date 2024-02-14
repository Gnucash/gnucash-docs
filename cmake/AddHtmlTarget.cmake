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
    set(styledir "${CMAKE_SOURCE_DIR}/stylesheet")
    file(GLOB styleicons "${CMAKE_SOURCE_DIR}/stylesheet/*.png")
    set(BUILD_DIR "${DOCDIR_BUILD}/${lang}/${docname}")

    if (NOT IS_ABSOLUTE ${xslt_file})
        set(xslt_file "${CMAKE_CURRENT_SOURCE_DIR}/${xslt_file}")
    endif()

    # Convert xml to html with xsltproc
    # xsltproc --xinclude -o outputdir/ /usr/share/sgml/docbook/xsl-stylesheets/html/chunk.xsl filename.xml
    add_custom_command(
      OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/htmltrigger"
      COMMAND ${CMAKE_COMMAND} -E make_directory "${BUILD_DIR}"
      COMMAND ${CMAKE_COMMAND} -E make_directory "${BUILD_DIR}/figures"
      COMMAND ${CMAKE_COMMAND} -E make_directory "${BUILD_DIR}/stylesheet"
        COMMAND  ${XSLTPROC} ${XSLTPROCFLAGS} ${XSLTPROCFLAGS_HTML}
                             -o "${BUILD_DIR}/"
                             --stringparam chunker.output.encoding UTF-8
                             "${xslt_file}"
                             "${CMAKE_CURRENT_SOURCE_DIR}/index.docbook"
        COMMAND touch "${CMAKE_CURRENT_BINARY_DIR}/htmltrigger"
        DEPENDS ${entities} "index.docbook" "${CMAKE_SOURCE_DIR}/docbook/gnc-docbookx.dtd")

    # Copy figures for this document
    set(source_figures "")
    foreach(figure ${figures})
        list(APPEND source_figures "${CMAKE_CURRENT_SOURCE_DIR}/${figure}")
    endforeach()

    set(dest_figures "")
    foreach(figure ${figures})
        list(APPEND dest_figures "${BUILD_DIR}/${figure}")
    endforeach()

    if(dest_figures)
        add_custom_command(
            OUTPUT ${dest_figures}
            COMMAND ${CMAKE_COMMAND} -E copy ${source_figures} "${BUILD_DIR}/figures"
            COMMAND touch "${CMAKE_CURRENT_BINARY_DIR}/html_figtrigger"
            DEPENDS ${source_figures} "${CMAKE_CURRENT_BINARY_DIR}/htmltrigger")
    endif()

    # Copy style icons for this document (warning, info,...)
    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/styletrigger"
        COMMAND  ${CMAKE_COMMAND} -E copy ${styleicons} "${BUILD_DIR}/stylesheet"
        COMMAND touch "${CMAKE_CURRENT_BINARY_DIR}/styletrigger"
        DEPENDS ${styleicons} "${CMAKE_CURRENT_BINARY_DIR}/htmltrigger")

    add_custom_target("${lang}-${targetbase}-html"
        DEPENDS "${CMAKE_CURRENT_BINARY_DIR}/htmltrigger"
                ${dest_figures}
                "${CMAKE_CURRENT_BINARY_DIR}/styletrigger")

    add_dependencies(${lang}-html "${lang}-${targetbase}-html")

    if(WITH_HTML_INSTALL)
        install(DIRECTORY ${BUILD_DIR}
          DESTINATION "${CMAKE_INSTALL_DOCDIR}/${lang}")
    endif()
endfunction()

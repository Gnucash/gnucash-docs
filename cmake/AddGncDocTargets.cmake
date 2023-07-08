function (add_gnc_doc_targets lang entities figures)

    get_filename_component(targetbase ${CMAKE_CURRENT_SOURCE_DIR} NAME)
    set(docname "gnucash-${targetbase}")

    if(entities)
        # Add a target to run xml lint checks on this document's source xml files
        add_custom_target("${lang}-${targetbase}-check"
            COMMAND  ${XMLLINT} --postvalid
                                --xinclude
                                --noout
                                --path ${CMAKE_SOURCE_DIR}/docbook
                                ${CMAKE_CURRENT_SOURCE_DIR}/index.docbook
            COMMAND  ${CMAKE_COMMAND}
                -D XMLLINT=${XMLLINT}
                -D GNC_SOURCE_DIR=${CMAKE_SOURCE_DIR}
                -D GNC_CURRENT_SOURCE_DIR=${CMAKE_CURRENT_SOURCE_DIR}
                -D docname=${docname}
                -D cmake_fig_list="${figures}"
                -P ${CMAKE_SOURCE_DIR}/cmake/CheckFigures.cmake
            DEPENDS ${entities} "index.docbook" "${CMAKE_SOURCE_DIR}/docbook/gnc-docbookx.dtd")
        add_dependencies(${lang}-check "${lang}-${targetbase}-check")
    endif()

    set(xslargs "${ARGN}")
    set(xsl_html "${BASE_XSL_HTML}")
    set(xsl_pdf "${BASE_XSL_PDF}")
    set(xsl_epub "${BASE_XSL_EPUB}")
    set(xsl_chm "${BASE_XSL_CHM}")
    while(NOT "${xslargs}" STREQUAL "")
        list(POP_FRONT xslargs xsldocumentformat xslfilepath)
        if(xsldocumentformat STREQUAL "xsl:html")
            set(xsl_html ${xslfilepath})
        endif()
        if(xsldocumentformat STREQUAL "xsl:pdf")
            set(xsl_pdf ${xslfilepath})
        endif()
        if(xsldocumentformat STREQUAL "xsl:epub")
            set(xsl_epub ${xslfilepath})
        endif()
        if(xsldocumentformat STREQUAL "xsl:chm")
            set(xsl_chm ${xslfilepath})
        endif()
    endwhile()

    # Add targets for each document format that is enabled
    if (WITH_CHM)
      add_chm_target(${targetbase} ${lang} "${entities}" "${figures}" "${xsl_chm}")
    endif()
    if (WITH_XDGHELP)
      add_xdghelp_target(${targetbase} ${lang} "${entities}" "${figures}")
    endif()
    if (WITH_HTML)
      add_html_target(${targetbase} ${lang} "${entities}" "${figures}" "${xsl_html}")
    endif()
    if (WITH_PDF)
      add_pdf_target(${targetbase} ${lang} "${entities}" "${figures}" "${xsl_pdf}")
    endif()
    if (WITH_EPUB)
      add_epub_target(${targetbase} ${lang} "${entities}" "${figures}" "${xsl_epub}")
    endif()
    if (WITH_MOBI)
      add_mobi_target(${targetbase} ${lang})
    endif()

    add_to_dist(
        CMakeLists.txt
        index.docbook
        ${entities}
        ${figures})

endfunction()

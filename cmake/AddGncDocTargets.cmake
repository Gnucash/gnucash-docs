function (add_gnc_doc_targets lang entities figures xslt_files)

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

    set(xslt_html "${BASE_XSLT_HTML}")
    set(xslt_pdf "${BASE_XSLT_PDF}")
    set(xslt_epub "${BASE_XSLT_EPUB}")
    set(xslt_chm "${BASE_XSLT_CHM}")
    while(NOT "${xslt_files}" STREQUAL "")
        list(POP_FRONT xslt_files xslt_type xslt_filename)
        if(xslt_type STREQUAL "html")
            set(xslt_html ${xslt_filename})
        endif()
        if(xslt_type STREQUAL "pdf")
            set(xslt_pdf ${xslt_filename})
        endif()
        if(xslt_type STREQUAL "epub")
            set(xslt_epub ${xslt_filename})
        endif()
        if(xslt_type STREQUAL "chm")
            set(xslt_chm ${xslt_filename})
        endif()
    endwhile()

    # Add targets for each document format that is enabled
    if (WITH_CHM)
      add_chm_target(${targetbase} ${lang} "${entities}" "${figures}" "${xslt_chm}")
    endif()
    if (WITH_XDGHELP)
      add_xdghelp_target(${targetbase} ${lang} "${entities}" "${figures}")
    endif()
    if (WITH_HTML)
      add_html_target(${targetbase} ${lang} "${entities}" "${figures}" "${xslt_html}")
    endif()
    if (WITH_PDF)
      add_pdf_target(${targetbase} ${lang} "${entities}" "${figures}" "${xslt_pdf}")
    endif()
    if (WITH_EPUB)
      add_epub_target(${targetbase} ${lang} "${entities}" "${figures}" "${xslt_epub}")
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

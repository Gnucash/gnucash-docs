function (add_gnc_doc_targets docname entities figures)

    get_filename_component(lang ${CMAKE_CURRENT_SOURCE_DIR} NAME)

    # Add a target to run xml lint checks on this document's source xml files
    add_custom_target("${lang}-${docname}-check"
        COMMAND  ${XMLLINT} --postvalid
                            --xinclude
                            --noout
                            --path ${CMAKE_SOURCE_DIR}/docbook
                            ${CMAKE_CURRENT_SOURCE_DIR}/${docname}.xml
        COMMAND  ${CMAKE_COMMAND}
            -D XMLLINT=${XMLLINT}
            -D GNC_SOURCE_DIR=${CMAKE_SOURCE_DIR}
            -D GNC_CURRENT_SOURCE_DIR=${CMAKE_CURRENT_SOURCE_DIR}
            -D docname=${docname}
            -D cmake_fig_list="${figures}"
            -P ${CMAKE_SOURCE_DIR}/cmake/CheckFigures.cmake
        DEPENDS ${entities} "${docname}.xml" "${CMAKE_SOURCE_DIR}/docbook/gnc-docbookx.dtd")
    add_dependencies(${docname}-check "${lang}-${docname}-check")

    # Add targets for each document format that is enabled
    if (WITH_CHM)
      add_chm_target(${docname} ${lang} "${entities}" "${figures}")
    endif()
    if (WITH_GHELP)
      add_ghelp_target(${docname} ${lang} "${entities}" "${figures}")
    endif()
    if (WITH_HTML)
      add_html_target(${docname} ${lang} "${entities}" "${figures}")
    endif()
    if (WITH_PDF)
      add_pdf_target(${docname} ${lang} "${entities}" "${figures}")
    endif()
    if (WITH_EPUB)
      add_epub_target(${docname} ${lang} "${entities}" "${figures}")
    endif()
    if (WITH_MOBI)
      add_mobi_target(${docname} ${lang})
    endif()

    add_to_dist(
        CMakeLists.txt
        ${docname}.xml
        ${entities}
        ${figures})

endfunction()

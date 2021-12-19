function (add_gnc_doc_targets docname entities)

    get_filename_component(lang ${CMAKE_CURRENT_SOURCE_DIR} NAME)

    file(GLOB_RECURSE figures
        "${CMAKE_CURRENT_SOURCE_DIR}/figures/*.png"
        "${CMAKE_CURRENT_SOURCE_DIR}/figures/figures/*.svg")

    if(entities)
        # Add a target to run xml lint checks on this document's source xml files
        add_custom_target("${lang}-${docname}-check"
            COMMAND  ${XMLLINT} --postvalid
                                --xinclude
                                --noout
                                --path ${CMAKE_SOURCE_DIR}/docbook
                                ${CMAKE_CURRENT_SOURCE_DIR}/${docname}.xml
            DEPENDS ${entities} "${docname}.xml" "${CMAKE_SOURCE_DIR}/docbook/gnc-docbookx.dtd")
        add_dependencies(${docname}-check "${lang}-${docname}-check")
    endif()

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

    file(GLOB_RECURSE figures_dist
        RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
        figures/*.png figures/*.svg)

    add_to_dist(
        CMakeLists.txt
        ${docname}.xml
        ${entities}
        ${figures_dist})

endfunction()

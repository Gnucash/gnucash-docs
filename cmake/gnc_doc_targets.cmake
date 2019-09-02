function (add_gnc_doc_targets docname entities)

    get_filename_component(lang ${CMAKE_CURRENT_SOURCE_DIR} NAME)

    add_xml_target(${docname} ${lang} "${entities}" figures)
    add_html_target(${docname} ${lang} "${entities}" figures)
    if (PDF)
        add_pdf_target(${docname} ${lang} "${entities}" figures)
    endif()
    add_epub_target(${docname} ${lang} "${entities}" figures)
    if (MOBI)
        add_mobi_target(${docname} ${lang})
    endif()

endfunction()

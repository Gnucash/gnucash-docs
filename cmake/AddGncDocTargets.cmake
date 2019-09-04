function (add_gnc_doc_targets docname entities)

    get_filename_component(lang ${CMAKE_CURRENT_SOURCE_DIR} NAME)

    if(entities)
        add_xml_target(${docname} ${lang} "${entities}" figures)
        add_html_target(${docname} ${lang} "${entities}" figures)
        if (PDF)
            add_pdf_target(${docname} ${lang} "${entities}" figures)
        endif()
        add_epub_target(${docname} ${lang} "${entities}" figures)
        if (MOBI)
            add_mobi_target(${docname} ${lang})
        endif()
    endif()

    set(autotoolsfiles
        Makefile.am
        Makefile.in
        ${docname}-${lang}.omf)

    file(GLOB_RECURSE figures
        RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
        figures/*.png)

    add_to_dist(
        CMakeLists.txt
        ${docname}.xml
        ${entities}
        ${autotoolsfiles}
        ${figures})

endfunction()

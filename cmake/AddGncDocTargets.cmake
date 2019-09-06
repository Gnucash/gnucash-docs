function (add_gnc_doc_targets docname entities)

    get_filename_component(lang ${CMAKE_CURRENT_SOURCE_DIR} NAME)

    if(entities)
        add_check_target(${docname} ${lang} "${entities}" figures)
        if (WITH_CHM)
            add_chm_target(${docname} ${lang} "${entities}" figures)
        endif()
        if (WITH_XML)
            add_xml_target(${docname} ${lang} "${entities}" figures)
        endif()
        if (WITH_HTML)
            add_html_target(${docname} ${lang} "${entities}" figures)
        endif()
        if (WITH_PDF)
            add_pdf_target(${docname} ${lang} "${entities}" figures)
        endif()
        if (WITH_EPUB)
            add_epub_target(${docname} ${lang} "${entities}" figures)
        endif()
        if (WITH_MOBI)
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

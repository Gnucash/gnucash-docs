set (figdir "figures")
set (lang "de")
set (entities
        Help_ch_Intro.xml
        Help_ch_GettingStarted.xml
        Help_fdl-appendix.xml
        Help_legal.xml
        Help_chartofaccts.xml
        Help_chtacctseg.xml
        Help_txf-categories.xml
        Help_tips-appendix.xml)

add_xml_target(${docname} ${lang} "${entities}" ${figdir})
add_html_target(${docname} ${lang} "${entities}" ${figdir})
if (PDF)
    add_pdf_target(${docname} ${lang} "${entities}" ${figdir})
endif()
add_epub_target(${docname} ${lang} "${entities}" ${figdir})
if (MOBI)
    add_mobi_target(${docname} ${lang})
endif()

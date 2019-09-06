set (docname "gnucash-help")

add_custom_target(${docname}-check)
add_dependencies(check ${docname}-check)

if (WITH_HTML)
    add_custom_target(${docname}-html)
    add_dependencies(html ${docname}-html)
endif()

if (WITH_XML)
    add_custom_target(${docname}-xml
        DEPENDS ${docname}-check)
    add_dependencies(xml ${docname}-xml)
endif()

if (WITH_PDF)
    add_custom_target(${docname}-pdf)
    add_dependencies(pdf ${docname}-pdf)
endif()

if (WITH_EPUB)
    add_custom_target(${docname}-epub)
    add_dependencies(epub ${docname}-epub)
endif()

if (WITH_MOBI)
    add_custom_target(${docname}-mobi)
    add_dependencies(mobi ${docname}-mobi)
endif()

if (WITH_CHM)
    add_custom_target(${docname}-chm)
    add_dependencies(chm ${docname}-chm)
endif()

add_subdirectory(C)
add_subdirectory(de)
add_subdirectory(it)
add_subdirectory(pt)

set(autotoolsfiles
    Makefile.am
    Makefile.in)
add_to_dist(CMakeLists.txt ${autotoolsfiles})

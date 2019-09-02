set (docname "gnucash-guide")

add_custom_target(${docname}-html)
add_dependencies(html ${docname}-html)

add_custom_target(${docname}-check)
add_dependencies(check ${docname}-check)

add_custom_target(${docname}-xml
    DEPENDS ${docname}-check
)
add_dependencies(xml ${docname}-xml)

if (PDF)
    add_custom_target(${docname}-pdf)
    add_dependencies(pdf ${docname}-pdf)
endif()

add_subdirectory(C)
add_subdirectory(de)
add_subdirectory(it)
add_subdirectory(ja)
add_subdirectory(pt)
add_subdirectory(ru)

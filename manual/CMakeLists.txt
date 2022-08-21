set (targetbase "manual")

add_custom_target(${targetbase}-check)
add_dependencies(check ${targetbase}-check)

if (WITH_HTML)
    add_custom_target(${targetbase}-html)
    add_dependencies(html ${targetbase}-html)
endif()

if (WITH_XDGHELP)
    add_custom_target(${targetbase}-xdghelp)
    add_dependencies(xdghelp ${targetbase}-xdghelp)
endif()

if (WITH_PDF)
    add_custom_target(${targetbase}-pdf)
    add_dependencies(pdf ${targetbase}-pdf)
endif()

if (WITH_EPUB)
    add_custom_target(${targetbase}-epub)
    add_dependencies(epub ${targetbase}-epub)
endif()

if (WITH_MOBI)
    add_custom_target(${targetbase}-mobi)
    add_dependencies(mobi ${targetbase}-mobi)
endif()

if (WITH_CHM)
    add_custom_target(${targetbase}-chm)
    add_dependencies(chm ${targetbase}-chm)
endif()

add_subdirectory(C)
add_subdirectory(de)
add_subdirectory(it)
add_subdirectory(pt)

add_to_dist(CMakeLists.txt)

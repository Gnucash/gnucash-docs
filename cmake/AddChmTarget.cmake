function (add_chm_target docname lang entities figdir)

    set(chmfile "${docname}.chm")
    set(mapfile "${docname}.hhmap")

    set(BUILD_DIR "${DOCDIR_BUILD}/${lang}")
    file(MAKE_DIRECTORY "${BUILD_DIR}")

    file(GLOB figures "${CMAKE_CURRENT_SOURCE_DIR}/${figdir}/*.png")

    file(MAKE_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/htmlhelp")
    add_custom_command(
        OUTPUT "${BUILD_DIR}/${chmfile}" "${BUILD_DIR}/${mapfile}"
        COMMAND ${CMAKE_COMMAND} -v
           -D docname=${docname}
           -D SRC_DIR=${CMAKE_SOURCE_DIR}
           -D CURRENT_SRC_DIR=${CMAKE_CURRENT_SOURCE_DIR}
           -D CURRENT_BIN_DIR=${CMAKE_CURRENT_BINARY_DIR}
           -D BUILD_DIR=${BUILD_DIR}
           -D XSLTPROC=${XSLTPROC}
           "-DXSLTPROCFLAGS=\"${XSLTPROCFLAGS}\""
           "-Dentities=\"${entities}\""
           -D HHC=${HHC}
           -P ${CMAKE_SOURCE_DIR}/cmake/MakeChm.cmake
        DEPENDS ${entities} "${docname}.xml" "${CMAKE_SOURCE_DIR}/docbook/gnc-docbookx.dtd" ${figures}
        WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/htmlhelp")

    add_custom_target("${lang}-${docname}-chm"
        DEPENDS "${BUILD_DIR}/${chmfile}" "${BUILD_DIR}/${mapfile}")

    add_dependencies(${docname}-chm "${lang}-${docname}-chm")

    install(FILES
            "${BUILD_DIR}/${chmfile}"
            "${BUILD_DIR}/${mapfile}"
        DESTINATION "${CMAKE_INSTALL_DOCDIR}/${lang}"
        COMPONENT "${docname}-chm")

endfunction()

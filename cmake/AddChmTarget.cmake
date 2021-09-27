#
# A function to generate chm documentation
#
# FUNCTION:
#   add_chm_target
# ARGUMENTS:
# - docname: The basename of the main xml file. Will be used to locate
#            this primary xml file and for various output files/directories.
#            Either "gnucash-guide" or "gnucash-help" now.
# - lang: The language of the current document, such as "C", "de" and so on.
# - entities: A list of all xml files this document is composed of. ONLY filename, WITHOUT path.
#             It does NOT contain "${docname}.xml".
# - figures: A list of FULL PATH image files.
# - dtd_files: A list of FULL PATH DTD files.
#
function (add_chm_target docname lang entities figures dtd_files)

    # Setup base directory
    set(fmt "chm")
    set(outfile "${docname}.${fmt}")

    set(BUILD_DIR "${CMAKE_CURRENT_BINARY_DIR}/${fmt}")
    set(OUTPUT_DIR "${CMAKE_BINARY_DIR}/share/doc/${lang}")

    # GnuCash-specific xsl files
    file(GLOB xsl_files "${CMAKE_SOURCE_DIR}/xsl/*.xsl")
    file(GLOB gnucash_icon_files "${CMAKE_SOURCE_DIR}/xsl/icons/*")

    set(chmfile "${docname}.chm")
    set(mapfile "${docname}.hhmap")

    set(BUILD_DIR "${DOCDIR_BUILD}/${lang}")

    # Prepare ${BUILD_DIR}
    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-preparedir-trigger"
        COMMAND ${CMAKE_COMMAND} -E make_directory "${BUILD_DIR}/figures"
        COMMAND ${CMAKE_COMMAND} -E make_directory "${BUILD_DIR}/images/callouts"
        COMMAND touch "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-preparedir-trigger")


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
        DEPENDS ${entities} "${docname}.xml" ${dtd_files} ${xsl_files} ${figures}
                "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-preparedir-trigger"
        WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/htmlhelp")

    add_custom_target("${lang}-${docname}-chm"
        DEPENDS "${BUILD_DIR}/${chmfile}" "${BUILD_DIR}/${mapfile}")

    add_dependencies(${docname}-chm "${lang}-${docname}-chm")

    install(FILES
            "${BUILD_DIR}/${chmfile}"
            "${BUILD_DIR}/${mapfile}"
        DESTINATION "${CMAKE_INSTALL_DOCDIR}/${lang}"
        COMPONENT "chm")

endfunction()

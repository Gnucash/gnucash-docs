#
# Functions to install the docbook xml sources for use with gnome help
#
# FUNCTION:
#   add_ghelp_target
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
function (add_ghelp_target docname lang entities figures dtd_files)

    # Setup base directory
    set(fmt "ghelp")
    set(outfile "index.docbook")

    set(BUILD_DIR "${CMAKE_BINARY_DIR}/share/help/${lang}/${docname}")
    set(OUTPUT_DIR "${BUILD_DIR}")

    # GnuCash-specific xsl files
    file(GLOB gnucash_icon_files "${CMAKE_SOURCE_DIR}/xsl/icons/*")

    set(source_files "")
    foreach(xml_file ${entities} ${docname}.xml)
        list(APPEND source_files "${CMAKE_CURRENT_SOURCE_DIR}/${xml_file}")
    endforeach()

    set(dest_files "")
    foreach(xml_file ${entities} ${docname}.xml)
        list(APPEND dest_files "${BUILD_DIR}/${xml_file}")
    endforeach()

    # Prepare ${BUILD_DIR}
    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-preparedir-trigger"
        COMMAND ${CMAKE_COMMAND} -E make_directory "${BUILD_DIR}/figures"
        COMMAND ${CMAKE_COMMAND} -E make_directory "${BUILD_DIR}/images"
        COMMAND touch "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-preparedir-trigger")

    # Copy DTD files for this document
    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-dtd-trigger"
        COMMAND ${CMAKE_COMMAND} -E copy ${dtd_files} "${BUILD_DIR}"
        COMMAND touch "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-dtd-trigger"
        DEPENDS "${dtd_files}"
                "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-preparedir-trigger")

    # Copy figures for this document
    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-fig-trigger"
        COMMAND ${CMAKE_COMMAND} -E copy ${figures} "${BUILD_DIR}/figures"
        COMMAND touch "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-fig-trigger"
        DEPENDS ${figures}
                "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-preparedir-trigger")


    # Copy GnuCash-Specific icons
    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-gnucashicon-trigger"
        COMMAND cp -f "${CMAKE_SOURCE_DIR}/xsl/icons/*" "${BUILD_DIR}/images"
        COMMAND touch "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-gnucashicon-trigger"
        DEPENDS "${gnucash_icon_files}"
                "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-preparedir-trigger")


    add_custom_command(
        OUTPUT ${dest_files}
        COMMAND ${CMAKE_COMMAND} -E copy ${source_files} "${BUILD_DIR}"
        DEPENDS ${entities} "${docname}.xml" ${dtd_files}
                "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-preparedir-trigger"
        WORKING_DIRECTORY "${BUILD_DIR}")

    add_custom_target("${lang}-${docname}-ghelp"
        DEPENDS ${dest_files}
                "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-dtd-trigger"
                "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-gnucashicon-trigger"
                "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-fig-trigger")

    add_dependencies(${docname}-ghelp "${lang}-${docname}-ghelp")

    install(FILES ${source_files}
        DESTINATION "${CMAKE_INSTALL_DATADIR}/gnome/help/${docname}/${lang}"
        COMPONENT "ghelp")
    install(FILES ${figures}
        DESTINATION "${CMAKE_INSTALL_DATADIR}/gnome/help/${docname}/${lang}/figures"
        COMPONENT "ghelp")
endfunction()

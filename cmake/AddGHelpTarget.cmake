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

    # Setup variables.
    set(fmt "ghelp")
    set(outfile "${docname}.xml")

    set(BUILD_DIR "${CMAKE_BINARY_DIR}/share/gnome/help/${docname}/${lang}")

    # Prepare Directory
    file(MAKE_DIRECTORY "${BUILD_DIR}")
    file(MAKE_DIRECTORY "${BUILD_DIR}/images")

    # GnuCash-specific xsl files
    file(GLOB gnucash_icon_files "${CMAKE_SOURCE_DIR}/xsl/icons/*")

    set(source_files "")
    foreach(xml_file ${entities} ${docname}.xml)
        list(APPEND source_files "${CMAKE_CURRENT_SOURCE_DIR}/${xml_file}")
    endforeach()
    list(APPEND source_files ${dtd_files})

    # Copy source XML files and DTD files for this document
    add_custom_command(
        OUTPUT ${outfile}
        COMMAND ${CMAKE_COMMAND} -E copy ${source_files} "${BUILD_DIR}"
        DEPENDS ${entities} "${docname}.xml" ${dtd_files}
        WORKING_DIRECTORY "${BUILD_DIR}")

    # Copy figures for this document
    file(MAKE_DIRECTORY "${BUILD_DIR}/figures")
    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/ghelp_figtrigger"
        COMMAND ${CMAKE_COMMAND} -E copy ${figures} "${BUILD_DIR}/figures"
        COMMAND touch "${CMAKE_CURRENT_BINARY_DIR}/ghelp_figtrigger"
        DEPENDS ${figures})

    # Copy GnuCash-Specific icons
    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-gnucashicon-trigger"
        COMMAND cp -f "${CMAKE_SOURCE_DIR}/xsl/icons/*" "${BUILD_DIR}/images"
        COMMAND touch "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-gnucashicon-trigger"
        DEPENDS "${gnucash_icon_files}")


    add_custom_target("${lang}-${docname}-ghelp"
        DEPENDS ${outfile}
                "${CMAKE_CURRENT_BINARY_DIR}/ghelp_figtrigger"
                "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-gnucashicon-trigger")

    add_dependencies(${docname}-ghelp "${lang}-${docname}-ghelp")

    install(FILES ${source_files}
        DESTINATION "share/gnome/help/${docname}/${lang}")
    install(FILES ${figures}
        DESTINATION "share/gnome/help/${docname}/${lang}/figures")
    install(FILES ${gnucash_icon_files}
        DESTINATION "share/gnome/help/${docname}/${lang}/images")
endfunction()

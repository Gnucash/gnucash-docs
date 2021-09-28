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

    # Prepare ${BUILD_DIR}
    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-preparedir-trigger"
        COMMAND ${CMAKE_COMMAND} -E make_directory "${BUILD_DIR}/figures"
        COMMAND ${CMAKE_COMMAND} -E make_directory "${BUILD_DIR}/images"
        COMMAND ${CMAKE_COMMAND} -E make_directory "${OUTPUT_DIR}"
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
                "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-fig-trigger")

    # Copy XML files
    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-xml-trigger"
        COMMAND ${CMAKE_COMMAND} -E copy ${entities} ${docname}.xml "${BUILD_DIR}"
        COMMAND touch "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-xml-trigger"
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        DEPENDS ${entities} "${docname}.xml" ${dtd_files}
                "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-preparedir-trigger")

    add_custom_target("${lang}-${docname}-${fmt}"
        DEPENDS "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-xml-trigger"
                "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-dtd-trigger"
                "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-gnucashicon-trigger"
                "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-fig-trigger")

    add_dependencies(${docname}-${fmt} "${lang}-${docname}-${fmt}")

    install(DIRECTORY ${OUTPUT_DIR}
        DESTINATION "share/doc/${lang}"
        COMPONENT "${fmt}")

endfunction()

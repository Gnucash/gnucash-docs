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

function (add_ghelp_target docname lang entities figures dtd_files)

    # Setup base directory
    set(fmt "ghelp")
    set(outfile "index.docbook")

    set(BUILD_DIR "${CMAKE_BINARY_DIR}/share/help/${lang}/${docname}")

    # GnuCash-specific xsl files
    file(GLOB gnucash_icon_files "${CMAKE_SOURCE_DIR}/xsl/icons/*")

    # The cmake version of Ubuntu 18.04LTS is 3.10.
    # Can be replace with list(TRANSFORM <list> <ACTION> [<SELECTOR>] [OUTPUT_VARIABLE <output variable>])
    # once we can adopt cmake 3.12.
    #
    # Creating *full path* XML filenames for sources.
    set(source_files "")
    foreach(xml_file ${entities} ${docname}.xml)
        list(APPEND source_files "${CMAKE_CURRENT_SOURCE_DIR}/${xml_file}")
    endforeach()

    # Make symlink from index.docbook to ${outfile}
    add_custom_command(
        OUTPUT "${BUILD_DIR}/${outfile}"
        COMMAND ${CMAKE_COMMAND} -E create_symlink "${docname}.xml" "${outfile}"
        WORKING_DIRECTORY "${BUILD_DIR}"
        DEPENDS "${BUILD_DIR}/${docname}.xml")

    # Copy source XML files for this document
    add_custom_command(
        OUTPUT "${BUILD_DIR}/${docname}.xml"
        COMMAND ${CMAKE_COMMAND} -E copy ${entities} "${docname}.xml" "${BUILD_DIR}"
        WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
        DEPENDS ${entities} "${docname}.xml"
                "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-preparedir-trigger")

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


    # Prepare ${BUILD_DIR}
    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-preparedir-trigger"
        COMMAND ${CMAKE_COMMAND} -E make_directory "${BUILD_DIR}/figures"
        COMMAND ${CMAKE_COMMAND} -E make_directory "${BUILD_DIR}/images/callouts"
        COMMAND touch "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-preparedir-trigger")

    add_custom_target("${lang}-${docname}-${fmt}"
        DEPENDS "${BUILD_DIR}/${outfile}"
                "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-dtd-trigger"
                "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-fig-trigger"
                "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-gnucashicon-trigger")

    add_dependencies(${docname}-${fmt} "${lang}-${docname}-${fmt}")


    install(DIRECTORY "${BUILD_DIR}"
        DESTINATION "share/help/${lang}")

    # Cleaning
    add_custom_target("${lang}-${docname}-${fmt}-clean"
        COMMAND ${CMAKE_COMMAND} -E rm -rf "${BUILD_DIR}")

    add_dependencies(clean-extra "${lang}-${docname}-${fmt}-clean")

endfunction()

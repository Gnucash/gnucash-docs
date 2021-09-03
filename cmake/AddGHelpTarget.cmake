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

    set(BUILD_DIR "${CMAKE_BINARY_DIR}/share/gnome/help/${docname}/${lang}")

    file(MAKE_DIRECTORY "${BUILD_DIR}/figures")
    file(MAKE_DIRECTORY "${BUILD_DIR}/images")


    # GnuCash-specific xsl files
    file(GLOB gnucash_icon_files "${CMAKE_SOURCE_DIR}/xsl/icons/*")

    # The cmake version of Ubuntu 18.04LTS is 3.10.
    # We can't use list(TRANSFORM <list> <ACTION> [<SELECTOR>] [OUTPUT_VARIABLE <output variable>])

    # Creating *full path* XML filenames for sources.
    set(source_files "")
    foreach(xml_file ${entities} ${docname}.xml)
        list(APPEND source_files "${CMAKE_CURRENT_SOURCE_DIR}/${xml_file}")
    endforeach()

    # Copy source XML files for this document
    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-xml-trigger"
        COMMAND ${CMAKE_COMMAND} -E copy ${entities} "${docname}.xml" "${BUILD_DIR}"
        COMMAND touch "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-xml-trigger"
        DEPENDS ${entities} "${docname}.xml"
        WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}")

    # Copy DTD files for this document
    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-dtd-trigger"
        COMMAND ${CMAKE_COMMAND} -E copy ${dtd_files} "${BUILD_DIR}"
        COMMAND touch "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-dtd-trigger"
        DEPENDS "${dtd_files}")


    # Copy figures for this document
    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-fig-trigger"
        COMMAND ${CMAKE_COMMAND} -E copy ${figures} "${BUILD_DIR}/figures"
        COMMAND touch "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-fig-trigger"
        DEPENDS ${figures})


    # Copy GnuCash-Specific icons
    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-gnucashicon-trigger"
        COMMAND cp -f "${CMAKE_SOURCE_DIR}/xsl/icons/*" "${BUILD_DIR}/images"
        COMMAND touch "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-gnucashicon-trigger"
        DEPENDS "${gnucash_icon_files}")

    add_custom_target("${lang}-${docname}-${fmt}"
        DEPENDS "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-xml-trigger"
                "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-dtd-trigger"
                "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-fig-trigger"
                "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-gnucashicon-trigger")

    add_dependencies(${docname}-${fmt} "${lang}-${docname}-${fmt}")


    install(DIRECTORY "${BUILD_DIR}"
        DESTINATION "share/gnome/help/${docname}")

endfunction()

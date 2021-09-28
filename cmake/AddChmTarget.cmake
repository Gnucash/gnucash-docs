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

    # Prepare ${BUILD_DIR}
    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-preparedir-trigger"
        COMMAND ${CMAKE_COMMAND} -E make_directory "${BUILD_DIR}/figures"
        COMMAND ${CMAKE_COMMAND} -E make_directory "${BUILD_DIR}/images/callouts"
        COMMAND ${CMAKE_COMMAND} -E make_directory "${OUTPUT_DIR}"
        COMMAND touch "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-preparedir-trigger")

    # Create CHM file from hhp (the output of xsltproc)
    add_custom_command(
        OUTPUT "${OUTPUT_DIR}/${outfile}"
        # A workaround because ${HHC} always returns FALSE.
        COMMAND COMMAND ${HHC} htmlhelp.hhp || cd .
        COMMAND cp "${outfile}" "${OUTPUT_DIR}/${outfile}"
        WORKING_DIRECTORY "${BUILD_DIR}"
        DEPENDS "${BUILD_DIR}/htmlhelp.hhp"
                "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-fig-trigger"
                "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-gnucashicon-trigger")


    # Create HTML files for CHM with xsltproc
    #  "${BUILD_DIR}/htmlhelp.hhp" and "${BUILD_DIR}/toc.hhc" are also cleated.
    add_custom_command(
        OUTPUT "${BUILD_DIR}/htmlhelp.hhp"
        COMMAND ${XSLTPROC} ${XSLTPROCFLAGS} ${XSLTPROCFLAGS_CHM}
                -o "${BUILD_DIR}/"
                --stringparam htmlhelp.chm ${outfile}
                --stringparam gnc.lang ${lang}
                "${CMAKE_SOURCE_DIR}/xsl/gnc-custom-${fmt}.xsl"
                "${CMAKE_CURRENT_SOURCE_DIR}/${docname}.xml"
        DEPENDS ${entities} "${docname}.xml" ${dtd_files} ${xsl_files})

    # Copy figures for this document
    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-fig-trigger"
        COMMAND ${CMAKE_COMMAND} -E copy ${figures} "${BUILD_DIR}/figures"
        COMMAND touch "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-fig-trigger"
        DEPENDS ${figures}
                "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-preparedir-trigger")

    # Copy XSL Stylesheet icons
    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-xslticon-trigger"
        # PNG admonition icons are used in chm.
        COMMAND cp -f "${CMAKE_SOURCE_DIR}/xsl/images/*.png" "${BUILD_DIR}/images"
        # PNG callout icons are used in chm.
        COMMAND cp -f "${CMAKE_SOURCE_DIR}/xsl/images/callouts/*.png"  "${BUILD_DIR}/images/callouts"
        COMMAND touch "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-xslticon-trigger"
        DEPENDS "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-preparedir-trigger")

    # Copy GnuCash-Specific icons
    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-gnucashicon-trigger"
        # PNG icons are used in chm. SVG is not supported.
        COMMAND cp -f "${CMAKE_SOURCE_DIR}/xsl/icons/*.png" "${BUILD_DIR}/images"
        COMMAND touch "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-gnucashicon-trigger"
        DEPENDS "${CMAKE_CURRENT_BINARY_DIR}/${fmt}-xslticon-trigger"
                "${gnucash_icon_files}")



    add_custom_target("${lang}-${docname}-${fmt}"
        DEPENDS "${OUTPUT_DIR}/${outfile}")

    add_dependencies(${docname}-${fmt} "${lang}-${docname}-${fmt}")

    install(FILES "${OUTPUT_DIR}/${outfile}"
        DESTINATION "share/doc/${lang}"
        OPTIONAL
        COMPONENT "${fmt}")

endfunction()

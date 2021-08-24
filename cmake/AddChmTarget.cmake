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

function (add_chm_target docname lang entities figures dtd_files)


    set(BUILD_DIR "${CMAKE_CURRENT_BINARY_DIR}/htmlhelp")

    # Copy figures for this document
    file(MAKE_DIRECTORY "${BUILD_DIR}/figures")
    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/chmfigtrigger"
        COMMAND ${CMAKE_COMMAND} -E copy ${figures} "${BUILD_DIR}/figures"
        COMMAND touch "${CMAKE_CURRENT_BINARY_DIR}/figtrigger"
        DEPENDS ${figures})

    # Copy icon files for this documents
    # Removed dependency because icon files are rarely changed. 
    file(MAKE_DIRECTORY "${BUILD_DIR}/images/callouts")
    add_custom_command(
        OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/chmicontrigger"
        # PNG admonition and GnuCash icons are used in CHM.
        COMMAND cp -f "${CMAKE_SOURCE_DIR}/xsl/images/*.png"  "${BUILD_DIR}/images"
        # PNG callout icons are used in CHM.
        COMMAND cp -f "${CMAKE_SOURCE_DIR}/xsl/images/callouts/*.png"  "${BUILD_DIR}/images/callouts"
        COMMAND touch "${CMAKE_CURRENT_BINARY_DIR}/icontrigger")

    # Crreate HTML files for CHM with xsltproc
    #  "${BUILD_DIR}/htmlhelp.hhp" and "${BUILD_DIR}/toc.hhc" are also cleated.
    add_custom_command(
        OUTPUT "${BUILD_DIR}/htmlhelp.hhp"
        COMMAND ${XSLTPROC} ${XSLTPROCFLAGS} ${XSLTPROCFLAGS_CHM}
                -o "${BUILD_DIR}/"
                --path "${CMAKE_SOURCE_DIR}/docbook"
                --stringparam htmlhelp.chm ${docname}.chm
                --stringparam gnc.lang ${lang} 
                "${CMAKE_SOURCE_DIR}/xsl/gnc-custom-chm.xsl"
                "${CMAKE_CURRENT_SOURCE_DIR}/${docname}.xml"
        DEPENDS ${entities} "${docname}.xml" "${dtd_files}"
            "${CMAKE_CURRENT_BINARY_DIR}/chmicontrigger" 
            "${CMAKE_CURRENT_BINARY_DIR}/chmfigtrigger")

    file(MAKE_DIRECTORY "${DOCDIR_BUILD}/${lang}")
    # Create CHM file from hhp
    add_custom_command(
        OUTPUT "${DOCDIR_BUILD}/${lang}/${docname}.chm"
        # A workaround because ${HHC} always returns fales
        COMMAND COMMAND ${HHC} htmlhelp.hhp || cd .
        COMMAND cp "${docname}.chm" "${DOCDIR_BUILD}/${lang}/${docname}.chm"
        WORKING_DIRECTORY "${BUILD_DIR}"
        DEPENDS "${BUILD_DIR}/htmlhelp.hhp")


    add_custom_target("${lang}-${docname}-chm"
        DEPENDS "${DOCDIR_BUILD}/${lang}/${docname}.chm")

    add_dependencies(${docname}-chm "${lang}-${docname}-chm")

    install(FILES
            "${DOCDIR_BUILD}/${lang}/${docname}.chm"
        DESTINATION "${CMAKE_INSTALL_DOCDIR}/${lang}"
        COMPONENT "chm")

endfunction()

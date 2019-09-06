#
# Functions to generate xml (docbook) documentation
#
# Paremeters:
# - docname: basename of the main xml file. Will be used to locate
#            this primary xml file and for various output files/directories
# - lang: language of the current document
# - entities: list of all xml files this document is composed of
# - figdir: name of the directory holding the images

# ************** Rules to install xml files for gnome-help ***********************
function (add_xml_target docname lang entities figdir)

    set(xml_files "${entities}")
    list(APPEND xml_files "${docname}.xml" "${CMAKE_SOURCE_DIR}/docbook/gnc-docbookx.dtd")
    file(GLOB figures "${CMAKE_CURRENT_SOURCE_DIR}/${figdir}/*.png")

    install(FILES ${xml_files}
        DESTINATION "${CMAKE_INSTALL_DATADIR}/gnome/help/${docname}/${lang}"
        COMPONENT "${docname}-xml")
    install(FILES ${figures}
        DESTINATION "${CMAKE_INSTALL_DATADIR}/gnome/help/${docname}/${lang}/${figdir}"
        COMPONENT "${docname}-xml")

    add_custom_target("${lang}-${docname}-check"
        COMMAND  ${XMLLINT} --postvalid
                            --xinclude
                            --noout
                            --path ${CMAKE_SOURCE_DIR}/docbook
                            ${CMAKE_CURRENT_SOURCE_DIR}/${docname}.xml
        DEPENDS ${entities} "${docname}.xml" "${CMAKE_SOURCE_DIR}/docbook/gnc-docbookx.dtd")

    add_dependencies(${docname}-check "${lang}-${docname}-check")

# TODO Uninstall target
# uninstall-hook:
# 	rmdir --ignore-fail-on-non-empty "$(DESTDIR)$(gnomehelpfiguresdir)"
# 	rmdir --ignore-fail-on-non-empty "$(DESTDIR)$(gnomehelpdir)"
endfunction()

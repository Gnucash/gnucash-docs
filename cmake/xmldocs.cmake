#
# Functions to generate xml (docbook) or html documentation
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
        COMPONENT "${lang}-${docname}-xml")
    install(FILES ${figures}
        DESTINATION "${CMAKE_INSTALL_DATADIR}/gnome/help/${docname}/${lang}/${figdir}"
        COMPONENT "${lang}-${docname}-xml")

    add_custom_target("${lang}-${docname}-check"
        COMMAND  ${XMLLINT} --postvalid
                            --xinclude
                            --noout
                            --path ${CMAKE_SOURCE_DIR}/docbook
                            ${CMAKE_CURRENT_SOURCE_DIR}/${docname}.xml
        DEPENDS ${entities} "${docname}.xml" "${CMAKE_SOURCE_DIR}/docbook/gnc-docbookx.dtd")

    add_dependencies(check "${lang}-${docname}-check")

# TODO Uninstall and dist targets
# uninstall-hook:
# 	rmdir --ignore-fail-on-non-empty "$(DESTDIR)$(gnomehelpfiguresdir)"
# 	rmdir --ignore-fail-on-non-empty "$(DESTDIR)$(gnomehelpdir)"
#
# EXTRA_DIST = ${xml_files} ${omffile} ${figures}
endfunction()

# TODO Omf ?
# ************** Rules to make and install omf file ******************************
# If the following file is in a subdir (like help/) you need to add that to the path
# include $(top_srcdir)/omf.make
# if ENABLE_SK
# OMF = omf
# OMF_DATA_HOOK = install-data-hook-omf
# UNINSTALL_OMF = uninstall-local-omf
# else
# OMF=
# OMF_DATA_HOOK=
# UNINSTALL_OMF=
# endif
#
# CLEANFILES += omf_timestamp
#
# install-data-hook: ${OMF_DATA_HOOK}
# uninstall-local: ${UNINSTALL_OMF}
#
# all: ${OMF}

# ************** Rules to make and install html documentation ********************
function (add_html_target docname lang entities figdir)

    file(GLOB figures "${CMAKE_CURRENT_SOURCE_DIR}/${figdir}/*.png")
    set(styledir "${CMAKE_SOURCE_DIR}/stylesheet")
    file(GLOB styleicons "${CMAKE_SOURCE_DIR}/stylesheet/*.png")

    # TODO clean target
    #CLEANFILES += $(docname)/*.html

    # Convert xml to html with xsltproc
    # xsltproc --xinclude -o outputdir/ /usr/share/sgml/docbook/xsl-stylesheets/html/chunk.xsl filename.xml
    file(MAKE_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/${docname}")
    add_custom_target("${lang}-${docname}-html-files"
        COMMAND  ${XSLTPROC} ${XSLTPROCFLAGS} ${XSLTPROCFLAGS_HTML}
                             -o "${CMAKE_CURRENT_BINARY_DIR}/${docname}/"
                             --param use.id.as.filename "1"
                             --stringparam chunker.output.encoding UTF-8
                             "${CMAKE_SOURCE_DIR}/xsl/general-customization.xsl"
                             "${CMAKE_CURRENT_SOURCE_DIR}/${docname}.xml"
        DEPENDS ${entities} "${docname}.xml" "${CMAKE_SOURCE_DIR}/docbook/gnc-docbookx.dtd")

    # Copy figures for this document
    file(MAKE_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/${docname}/${figdir}")
    add_custom_target("${lang}-${docname}-html-figures"
        COMMAND  ${CMAKE_COMMAND} -E copy ${figures} "${CMAKE_CURRENT_BINARY_DIR}/${docname}/${figdir}"
        DEPENDS ${figures})

    # Copy style icons for this document (warning, info,...)
    file(MAKE_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/${docname}/stylesheet")
    add_custom_target("${lang}-${docname}-html-style"
        COMMAND  ${CMAKE_COMMAND} -E copy ${styleicons} "${CMAKE_CURRENT_BINARY_DIR}/${docname}/stylesheet"
        DEPENDS ${styleicons})

    add_custom_target("${lang}-${docname}-html"
        DEPENDS "${lang}-${docname}-html-files" "${lang}-${docname}-html-figures" "${lang}-${docname}-html-style")

    add_dependencies(html "${lang}-${docname}-html")

    install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/${docname}
        DESTINATION "${CMAKE_INSTALL_DOCDIR}/${PACKAGE_NAME}/${lang}"
        COMPONENT "${lang}-${docname}-html")

    # TODO uninstall target
#     uninstall-html:
#             -if test "$(docname)"; then \
#                 if test "$(figdir)"; then \
#                     for file in $(docname)/$(figdir)/*.png; do \
#                         basefile=`basename $$file`; \
#                         rm -f "$(DESTDIR)$(otherdocdir)/$(docname)/$(figdir)/$$basefile"; \
#                     done; \
#                     rmdir --ignore-fail-on-non-empty "$(DESTDIR)$(otherdocdir)/$(docname)/$(figdir)"; \
#                 fi; \
#                 for file in $(styledir)/*.png; do \
#                     basefile=`basename $$file`; \
#                     rm -f "$(DESTDIR)$(otherdocdir)/$(docname)/stylesheet/$$basefile"; \
#                 done; \
#                 rmdir --ignore-fail-on-non-empty "$(DESTDIR)$(otherdocdir)/$(docname)/stylesheet"; \
#                 for file in $(docname)/*.html; do \
#                     basefile=`basename $$file`; \
#                     rm -f "$(DESTDIR)$(otherdocdir)/$(docname)/$$basefile"; \
#                 done; \
#                 rmdir --ignore-fail-on-non-empty "$(DESTDIR)$(otherdocdir)/$(docname)"; \
#                 rmdir --ignore-fail-on-non-empty "$(DESTDIR)$(otherdocdir)"; \
#             fi
endfunction()

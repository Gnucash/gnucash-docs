#
# Functions to install the docbook xml sources for use with gnome help
#
# Paremeters:
# - docname: basename of the main xml file. Will be used to locate
#            this primary xml file and for various output files/directories
# - lang: language of the current document
# - entities: list of all xml files this document is composed of
# - figdir: name of the directory holding the images

function (add_xdghelp_target docname lang entities figures)

    set(BUILD_DIR_BASE "${DATADIR_BUILD}/help/${lang}")
    set(BUILD_DIR "${BUILD_DIR_BASE}/${docname}")

    # Define location where KDE's help system looks for <doc>
    # when invoked with help:<doc>
    set(kde_lang ${lang})
    if (lang STREQUAL "C")
        set(kde_lang "en")
    endif()
    set(BUILD_DIR_KDE_BASE "${DATADIR_BUILD}/doc/HTML")

    set(source_files "")
    foreach(xml_file ${entities} index.docbook)
        list(APPEND source_files "${CMAKE_CURRENT_SOURCE_DIR}/${xml_file}")
    endforeach()

    set(dtd_files "${CMAKE_SOURCE_DIR}/docbook/gnc-docbookx.dtd"
                  "${CMAKE_SOURCE_DIR}/docbook/gnc-gui-struct.dtd"
                  "${CMAKE_SOURCE_DIR}/docbook/gnc-gui-C.dtd"
                  "${CMAKE_SOURCE_DIR}/docbook/gnc-gui-${lang}.dtd")
    list(REMOVE_DUPLICATES dtd_files)
    list(APPEND source_files ${dtd_files})

    set(dest_files "")
    foreach(xml_file ${entities} index.docbook gnc-docbookx.dtd)
        list(APPEND dest_files "${BUILD_DIR}/${xml_file}")
    endforeach()

    add_custom_command(
      OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/xdghelptrigger"
      COMMAND ${CMAKE_COMMAND} -E make_directory "${BUILD_DIR}"
      COMMAND ${CMAKE_COMMAND} -E make_directory "${BUILD_DIR}/figures"

      # Add links to make our documentation visible for KDE's help system
      COMMAND ${CMAKE_COMMAND} -E make_directory "${BUILD_DIR_KDE_BASE}"
      COMMAND ${CMAKE_COMMAND} -E create_symlink "${BUILD_DIR_BASE}" "${BUILD_DIR_KDE_BASE}/${kde_lang}"
      COMMAND touch "${CMAKE_CURRENT_BINARY_DIR}/xdghelptrigger")


    add_custom_command(
        OUTPUT ${dest_files}
        COMMAND ${CMAKE_COMMAND} -E copy ${source_files} "${BUILD_DIR}"
        DEPENDS ${entities} "index.docbook" ${dtd_files} "${CMAKE_CURRENT_BINARY_DIR}/xdghelptrigger"
        WORKING_DIRECTORY "${BUILD_DIR}")

    # Copy figures for this document
    set(source_figures "")
    foreach(figure ${figures})
        list(APPEND source_figures "${CMAKE_CURRENT_SOURCE_DIR}/${figure}")
    endforeach()

    set(dest_figures "")
    foreach(figure ${figures})
        list(APPEND dest_figures "${BUILD_DIR}/${figure}")
    endforeach()

    if(dest_figures)
        add_custom_command(
            OUTPUT ${dest_figures}
            COMMAND ${CMAKE_COMMAND} -E copy ${source_figures} "${BUILD_DIR}/figures"
            DEPENDS ${source_figures} "${CMAKE_CURRENT_BINARY_DIR}/xdghelptrigger")
    endif()

    add_custom_target("${lang}-${docname}-xdghelp"
        DEPENDS "${CMAKE_CURRENT_BINARY_DIR}/xdghelptrigger"
                 ${dest_files} ${dest_figures})

    add_dependencies(${docname}-xdghelp "${lang}-${docname}-xdghelp")

    set(doc_install_dir_base "${CMAKE_INSTALL_DATADIR}/help/${lang}")
    set(doc_install_dir "${doc_install_dir_base}/${docname}")
    install(FILES ${source_files}
        DESTINATION "${doc_install_dir}"
        COMPONENT "xdghelp")
    install(FILES ${figures}
        DESTINATION "${doc_install_dir}/figures"
        COMPONENT "xdghelp")

    # Add links to make our documentation visible for KDE's help system
    set(doc_install_dir_kde_base "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_DATADIR}/doc/HTML")
    install(CODE "execute_process (COMMAND ${CMAKE_COMMAND} -E make_directory \"${doc_install_dir_kde_base}\")"
        COMPONENT "xdghelp")
    install(CODE "execute_process (COMMAND ${CMAKE_COMMAND} -E create_symlink \"../../../${doc_install_dir_base}\" \"${doc_install_dir_kde_base}/${kde_lang}\")"
        COMPONENT "xdghelp")
endfunction()

function (add_lang_targets _lang)

    set (lang ${_lang} PARENT_SCOPE)

    add_custom_target(${_lang}-check)
    add_dependencies(check ${_lang}-check)

    if (WITH_HTML)
        add_custom_target(${_lang}-html)
        add_dependencies(html ${_lang}-html)
    endif()

    if (WITH_XDGHELP)
        add_custom_target(${_lang}-xdghelp)
        add_dependencies(xdghelp ${_lang}-xdghelp)
    endif()

    if (WITH_PDF)
        add_custom_target(${_lang}-pdf)
        add_dependencies(pdf ${_lang}-pdf)
    endif()

    if (WITH_EPUB)
        add_custom_target(${_lang}-epub)
        add_dependencies(epub ${_lang}-epub)
    endif()

    if (WITH_MOBI)
        add_custom_target(${_lang}-mobi)
        add_dependencies(mobi ${_lang}-mobi)
    endif()

    if (WITH_CHM)
        add_custom_target(${_lang}-chm)
        add_dependencies(chm ${_lang}-chm)
    endif()

endfunction()

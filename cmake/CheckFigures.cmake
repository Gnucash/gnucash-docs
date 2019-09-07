execute_process(
    COMMAND ${XMLLINT} --postvalid
                       --xinclude
                       --path ${GNC_SOURCE_DIR}/docbook
                       --xpath "//imagedata/@fileref"
                       ${GNC_CURRENT_SOURCE_DIR}/index.docbook
    RESULT_VARIABLE LINT_RESULT
    OUTPUT_VARIABLE xml_figures
)
if (NOT ${LINT_RESULT} STREQUAL "0")
    message(FATAL_ERROR "Error while scanning document for referenced images: ${LINT_RESULT}")
endif()

set(fullpath_xml_figures "")
set(missing_img_files "")

get_filename_component(doc_lang ${GNC_CURRENT_SOURCE_DIR} NAME)

string(REPLACE "\n" ";" xml_figures ${xml_figures})
foreach(xml_figure ${xml_figures})
    string (REGEX REPLACE "^.*=\"(.*)\"" "\\1" xml_figure ${xml_figure})
    find_file(image ${xml_figure} ${GNC_CURRENT_SOURCE_DIR} NO_DEFAULT_PATH)
    if(NOT image)
        list(APPEND missing_img_files "  - ${xml_figure}")
    else()
        list(APPEND fullpath_xml_figures ${GNC_CURRENT_SOURCE_DIR}/${xml_figure})
    endif()
endforeach()

if(missing_img_files)
    string(REPLACE ";" "\n" missing_img_files "${missing_img_files}")
    string(PREPEND missing_img_files "  Following non-existing images are referenced in document ${docname}(${doc_lang}):\n")
    message(WARNING ${missing_img_files})
endif()

set(unused_img_files "")
file(GLOB_RECURSE images
    "${GNC_CURRENT_SOURCE_DIR}/figures/*.png"
    "${GNC_CURRENT_SOURCE_DIR}/figures/*.svg")

foreach(image ${images})
    list(FIND fullpath_xml_figures "${image}" result)
    if (${result} EQUAL -1)
        list(APPEND unused_img_files "    - ${image}")
    endif()
endforeach()

if(unused_img_files)
    string(REPLACE ";" "\n" unused_img_files "${unused_img_files}")
    string(PREPEND unused_img_files " Note: following images exist but are not referenced in document ${docname}(${doc_lang}):\n")
    message(STATUS ${unused_img_files})
endif()

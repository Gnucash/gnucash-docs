cmake_minimum_required (VERSION 3.10)

execute_process(
    COMMAND ${XMLLINT} --postvalid
                       --xinclude
                       --path ${GNC_SOURCE_DIR}/docbook
                       --xpath "//imagedata/@fileref"
                       ${GNC_CURRENT_SOURCE_DIR}/${docname}.xml
    RESULT_VARIABLE LINT_RESULT
    OUTPUT_VARIABLE raw_xml_figures
)
if (NOT ${LINT_RESULT} STREQUAL "0")
    message(FATAL_ERROR "Error while scanning document for referenced images: ${LINT_RESULT}")
endif()

get_filename_component(doc_lang ${GNC_CURRENT_SOURCE_DIR} NAME)

# Clean up search result
string(REPLACE "\n" ";" raw_xml_figures ${raw_xml_figures})
set(xml_figures "")
foreach(raw_xml_figure ${raw_xml_figures})
    string(REGEX REPLACE "^.*=\"(.*)\"" "\\1" xml_figure ${raw_xml_figure})
    if(NOT ${xml_figure} IN_LIST xml_figures)
        list(APPEND xml_figures ${xml_figure})
    endif()
endforeach()
list(SORT xml_figures)

# Transform passed in parameter back into a list
string(REPLACE " " ";" cmake_fig_list ${cmake_fig_list})
list(SORT cmake_fig_list)

set(fullpath_xml_figures "")
set(missing_img_files "")
set(not_found_in_cmake "")
foreach(xml_figure ${xml_figures})
    # Check if referenced image exists on the file system
    unset(image CACHE)
    find_file(image ${xml_figure} ${GNC_CURRENT_SOURCE_DIR} NO_DEFAULT_PATH)
    if(NOT image)
        list(APPEND missing_img_files "  - ${xml_figure}")
    else()
        list(APPEND fullpath_xml_figures ${GNC_CURRENT_SOURCE_DIR}/${xml_figure})
    endif()

    # Check if referenced image is listed in the relevant figures list in CMakeLists.txt
    if ("${xml_figure}" IN_LIST cmake_fig_list)
    else()
        list(APPEND not_found_in_cmake "  - ${xml_figure}")
    endif()
endforeach()

# Output result for missing image files - currently still a warning, maybe should be flagged as error ?
if(missing_img_files)
    list(SORT missing_img_files)
    string(REPLACE ";" "\n" missing_img_files "${missing_img_files}")
    string(PREPEND missing_img_files "  Following non-existing images are referenced in document ${docname}(${doc_lang}):\n")
    message(WARNING ${missing_img_files})
endif()

# Output result for missing CMakeLists.txt entries - currently still a warning, maybe should be flagged as error ?
if(not_found_in_cmake)
    list(SORT not_found_in_cmake)
    string(REPLACE ";" "\n" not_found_in_cmake "${not_found_in_cmake}")
    string(PREPEND not_found_in_cmake "  Following referenced images are not listed in ${docname}/${doc_lang}/CMakeLists.txt:\n")
    message(WARNING ${not_found_in_cmake})
endif()

# Check for file present in the figures directory that aren't referenced in document
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
    list(SORT unused_img_files)
    string(REPLACE ";" "\n" unused_img_files "${unused_img_files}")
    string(PREPEND unused_img_files " Note: following images exist but are not referenced in document ${docname}(${doc_lang}):\n")
    message(STATUS ${unused_img_files})
endif()

# Check if figures mentioned in CMakeLists.txt are effectively referenced in document
set(cmake_unused "")
foreach(cmake_figure ${cmake_fig_list})
    if ("${cmake_figure}" IN_LIST xml_figures)
    else()
        list(APPEND cmake_unused "    - ${cmake_figure}")
    endif()
endforeach()

if(cmake_unused)
    list(SORT cmake_unused)
    string(REPLACE ";" "\n" cmake_unused "${cmake_unused}")
    string(PREPEND cmake_unused " Note: following images are listed in CMakeLists.txt but are not referenced in document ${docname}(${doc_lang}):\n")
    message(STATUS ${cmake_unused})
endif()

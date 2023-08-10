function(add_to_dist)
    set(local_dist_files ${dist_files})
    foreach(file ${ARGN})
        if (IS_ABSOLUTE ${file})
            set(fullpath ${file})
        else()
            set(fullpath ${CMAKE_CURRENT_SOURCE_DIR}/${file})
        endif()
        file(RELATIVE_PATH relative ${CMAKE_SOURCE_DIR} ${fullpath})
        list(APPEND local_dist_files ${relative})
    endforeach()
    set (dist_files ${local_dist_files}
        CACHE INTERNAL "Files that will be included in the distribution tarball")
endfunction()

function(execute_process_and_check_result)
    cmake_parse_arguments(VARS "" "WORKING_DIRECTORY;ERROR_MSG" "COMMAND" ${ARGN})
    execute_process(
            COMMAND ${VARS_COMMAND}
            WORKING_DIRECTORY ${VARS_WORKING_DIRECTORY}
            RESULT_VARIABLE RESULT
    )
    if (NOT "${RESULT}" STREQUAL "0")
        message(FATAL_ERROR ${VARS_ERROR_MSG})
    endif()
endfunction()

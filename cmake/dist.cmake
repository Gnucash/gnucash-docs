function(add_to_dist)
    set(local_dist_files ${dist_files})
    foreach(file ${ARGN})
        file(RELATIVE_PATH relative ${CMAKE_SOURCE_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/${file})
        list(APPEND local_dist_files ${relative})
    endforeach()
    set (dist_files ${local_dist_files}
        CACHE INTERNAL "Files that will be included in the distribution tarball")
endfunction()

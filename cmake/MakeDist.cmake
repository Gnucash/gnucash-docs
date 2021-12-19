# This file implements the process of making source distribution tarballs. It expects to find a file list in
# the cmake cache variable dist_files.
#
# Given all of these files, the procedure is to:
# 1. Remove any existing dist directory and make a new one.
# 2. Copy of all the files in dist_manifest.text and ${dist_generated}
#    into the dist directory.
# 3. Create the tarball and compress it with gzip and bzip2.
# 4. Then remove the dist directory.

include(${CMAKE_MODULE_PATH}/DistCommon.cmake)


function(make_dist PACKAGE_PREFIX GNUCASH_SOURCE_DIR BUILD_SOURCE_DIR)

    # -- Remove any existing packaging directory.
    file(REMOVE_RECURSE ${PACKAGE_PREFIX})

    if (EXISTS ${PACKAGE_PREFIX})
        message(FATAL_ERROR "Unable to remove existing dist directory \"${PACKAGE_PREFIX}\". Cannot continue.")
    endif()

    # -- Copy in distributed files
    foreach(file ${dist_files})
        if(NOT EXISTS ${GNUCASH_SOURCE_DIR}/${file})
            message(FATAL_ERROR "Can't find dist file ${GNUCASH_SOURCE_DIR}/${file}")
        endif()
        get_filename_component(dir ${file} DIRECTORY)
        file(MAKE_DIRECTORY ${PACKAGE_PREFIX}/${dir})
        file(COPY ${GNUCASH_SOURCE_DIR}/${file} DESTINATION ${PACKAGE_PREFIX}/${dir})
    endforeach()

    # -- Create the tarballs.

    execute_process_and_check_result(
            COMMAND ${CMAKE_COMMAND} -E tar zcf ${PACKAGE_PREFIX}.tar.gz ${PACKAGE_PREFIX}
            WORKING_DIRECTORY .
            ERROR_MSG "tar command to create ${PACKAGE_PREFIX}.tar.gz failed."
    )

    execute_process_and_check_result(
            COMMAND ${CMAKE_COMMAND} -E tar jcf ${PACKAGE_PREFIX}.tar.bz2 ${PACKAGE_PREFIX}
            WORKING_DIRECTORY .
            ERROR_MSG "tar command to create ${PACKAGE_PREFIX}.tar.gz failed."
    )

    # -- Clean up packaging directory.

    file(REMOVE_RECURSE ${PACKAGE_PREFIX})

    if(EXISTS ${PACKAGE_PREFIX})
        message(WARNING "Could not remove packaging directory '${PACKAGE_PREFIX}'")
    endif()

    # -- All done.

    message("\n\nDistributions ${PACKAGE_PREFIX}.tar.gz and ${PACKAGE_PREFIX}.tar.bz2 created.\n\n")
endfunction()

 make_dist(${PACKAGE_PREFIX} ${GNUCASH_SOURCE_DIR} ${BUILD_SOURCE_DIR})

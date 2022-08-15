# CMakeLists.txt for GnuCash Documenation

cmake_minimum_required (VERSION 3.10)

# This sets a number of environment variables we can use later on
# The names of these variables start with PROJECT_ and gnucash-docs_VERSION
# We don't actually use C, but GNUInstallDirs doesn't work if we don't
# specify a language.
project (gnucash-docs
    VERSION 4.11
    LANGUAGES C)

set (PACKAGE_NAME GnuCash Docs)
set (PACKAGE_BUGREPORT "https://bugs.gnucash.org/describecomponents.cgi?product=Documentation")
set (PACKAGE_STRING "${PACKAGE_NAME} ${gnucash-docs_VERSION}")
set (PACKAGE_URL "https://www.gnucash.org/")
set (PACKAGE_PREFIX "${PROJECT_NAME}-${gnucash-docs_VERSION}")

# Extra cmake macros
set (CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake;${CMAKE_MODULE_PATH}")
include (AddChmTarget)
include (AddEpubTarget)
include (AddXdgHelpTarget)
include (AddHtmlTarget)
include (AddPdfTarget)
include (AddGncDocTargets)
include (DistCommon)
include (GNUInstallDirs)

# Clear cache variables that will be filled later during the cmake run
unset(dist_files CACHE)

# ############################################################
# These options are settable from the CMake command line. For example,
# to enable mobi, put -D WITH_MOBI=ON on the command line.
# The targets enabled by default are different for Windows vs.
# the other supported platforms.
# On windows only chm is enabled by default
# On any other platform chm and mobi are disabled by default

if(NOT WIN32)
    option (WITH_XDGHELP "Enable build rules for gnome help document format" ON)
    option (WITH_HTML "Enable build rules for html document format" ON)
    option (WITH_PDF "Enable build rules for pdf document format" ON)
    option (WITH_EPUB "Enable build rules for epub document format" ON)
    option (WITH_CHM "Enable build rules for chm document format" OFF)
else()
    option (WITH_XDGHELP "Enable build rules for gnome help document format" OFF)
    option (WITH_HTML "Enable build rules for html document format" OFF)
    option (WITH_PDF "Enable build rules for pdf document format" OFF)
    option (WITH_EPUB "Enable build rules for epub document format" OFF)
    option (WITH_CHM "Enable build rules for chm document format" ON)
endif()
option (WITH_MOBI "Enable build rules for Mobipocket document format" OFF)

if(APPLE)
    option (WITH_HTML_INSTALL "Enable install rules for html document format" ON)
else()
    option (WITH_HTML_INSTALL "Enable install rules for html document format" OFF)
endif()


# ############################################################
# Following parameters can equally be set using -D switches on the CMake command line.
# Set font dirs and font for Russian pdf documents
set(EXTENDED_SANS "opentype/freefont/FreeSans" CACHE STRING "Extended sans font used for Russian pdf")
set(EXTENDED_SERIF "opentype/freefont/FreeSerif" CACHE STRING "Extended serif font used for Russian pdf")
set(EXTENDED_MONO "opentype/freefont/FreeMono" CACHE STRING "Extended mono font used for Russian pdf")
set(extended_fontdir "${CMAKE_SOURCE_DIR}/fonts" CACHE STRING "Directory to search for extended fonts")
set(extended_extension "otf" CACHE STRING "Extended fonts extension")

# Set font dirs and font for Japanese pdf documents
set(JAPANESE_MINCHO_TTF "ume-tmo3.ttf" CACHE STRING "Mincho TrueType font used for Japanese pdf")
set(JAPANESE_GOTHIC_TTF "ume-tmo3.ttf" CACHE STRING "Gothic TrueType font used for Japanese pdf")
set(japanese_fontdir "${CMAKE_SOURCE_DIR}/fonts/truetype" CACHE STRING "Directory to search for Japanese fonts")

# Buildtime destination directories for our generated documentation
set(DATADIR_BUILD "${CMAKE_BINARY_DIR}/share")
set(DOCDIR_BUILD  "${DATADIR_BUILD}/doc/${PACKAGE}")

# ############################################################
# Find the documentation dependencies

# Check for xsltproc
# Some distributions package it separately of libxslt
find_program(XSLTPROC xsltproc)
if(NOT XSLTPROC)
    message(SEND_ERROR "Can't find xsltproc, perhaps you should install the xsltproc or libxslt package ?")
endif(NOT XSLTPROC)
SET (XSLTPROCFLAGS --path "${CMAKE_SOURCE_DIR}/docbook" --xinclude "$ENV{XSLTPROCFLAGS}")

# Same for xmllint
find_program(XMLLINT xmllint)
if(NOT XMLLINT)
    message(SEND_ERROR "Can't find xmllint, perhaps you should install the xsltproc or libxslt package ?")
endif(NOT XMLLINT)

# Check for optional fop
if(WITH_PDF)
    find_program(FOP fop)
    if(NOT FOP)
        message(WARNING "Can't find fop. You will not be able to generate PDF files.")
        set (WITH_PDF OFF)
    endif(NOT FOP)
endif()

if(WITH_MOBI)
    find_program(EBOOK_CONVERT ebook-convert)
    if (NOT EBOOK_CONVERT)
        set(WITH_MOBI OFF)
        message(WARNING "Can't find ebook-convert. To enable the generation of mobi files install the Calibre package: https://www.calibre-ebook.com/")
    else()
        # Mobi is based on epub so enable epub if mobi is requested
        set(WITH_EPUB ON)
    endif()
else()
    message(STATUS "Mobi file format support is disabled.  Specify -DWITH_MOBI=ON if you want to enable it.")
endif()

# To find our figures in the source directory each run of fop
# will be passed a fop.xconf file to set a base-dir.
# The default fop.xconf file below does just that.
# Every document/language can define its own FOP_XCONF
# to point at a document/language specific fop.xconf
# instead for additional fop configuration as needed.
# For example the Japanese document will use it to embed Japanese fonts
set (FOP_XCONF_DFLT "${CMAKE_SOURCE_DIR}/fop.xconf.in")
set (FOP_XCONF "${FOP_XCONF_DFLT}")

# Find the htmlhelp compiler for chm output
if(WITH_CHM)
    if(WIN32)
        find_program(HHC hhc.exe
            PATHS "c:/Program Files (x86)/Html Help Workshop" "c:/Program Files/Html Help Workshop")
        if(NOT HHC)
            message(SEND_ERROR "Html Help Workshop not found")
        endif()
    else(WIN32)
        find_program(HHC chmcmd)
        if(NOT HHC)
            set(WITH_CHM OFF)
            message(WARNING "Free Pascal's chmcmd not found. Chm related targets will be disabled.")
        endif()
    endif(WIN32)
endif(WITH_CHM)

# The global targets. Their dependencies will be filled in by subsequent commands in
# the respective subdirectories.
add_custom_target(check)
if (WITH_HTML)
    add_custom_target(html)
endif()
if (WITH_XDGHELP)
  if (UNIX AND NOT APPLE)
    add_custom_target(xdghelp ALL)
  else(UNIX AND NOT APPLE)
    add_custom_target(xdghelp)
  endif()
endif()
if (WITH_PDF)
    add_custom_target(pdf)
endif()
if (WITH_EPUB)
    add_custom_target(epub)
endif()
if (WITH_MOBI)
    add_custom_target(mobi)
endif()
if (WITH_CHM)
    if(WIN32)
        add_custom_target(chm ALL)
    else()
        add_custom_target(chm)
    endif()
endif()


add_subdirectory (guide)
add_subdirectory (manual)

file(GLOB_RECURSE extrafiles
    RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
    cmake/* fonts/* stylesheet/* xsl/* docbook/*)
add_to_dist(${extrafiles})

configure_file(COPYING ${DATADIR_BUILD}/${PROJECT_NAME}/COPYING COPYONLY)
configure_file(COPYING-DOCS ${DATADIR_BUILD}/${PROJECT_NAME}/COPYING-DOCS COPYONLY)
install(FILES COPYING COPYING-DOCS DESTINATION ${CMAKE_INSTALL_DATADIR}/${PROJECT_NAME})

add_to_dist(
    AUTHORS
    CMakeLists.txt
    COPYING
    COPYING-DOCS
    ChangeLog
    NEWS
    README
    fop.xconf.in)

############################ BEGIN MAKE DIST #################

set(DIST_FILE "${PACKAGE_PREFIX}.tar")

add_custom_command(OUTPUT ${DIST_FILE}.gz ${DIST_FILE}.bz2
        COMMAND ${CMAKE_COMMAND}
           -D CMAKE_MODULE_PATH=${CMAKE_SOURCE_DIR}/cmake
           -D PACKAGE_PREFIX=${PACKAGE_PREFIX}
           -D GNUCASH_SOURCE_DIR=${CMAKE_SOURCE_DIR}
           -D BUILD_SOURCE_DIR=${CMAKE_BINARY_DIR}
           "-Ddist_files=\"${dist_files}\""
           -D SHELL=${SHELL}
           -P ${CMAKE_SOURCE_DIR}/cmake/MakeDist.cmake

        DEPENDS
          ${dist_files}
        )

add_custom_target(dist DEPENDS ${DIST_FILE}.gz ${DIST_FILE}.bz2)

add_custom_target(distcheck DEPENDS dist
        COMMAND ${CMAKE_COMMAND}
            -D CMAKE_MODULE_PATH=${CMAKE_SOURCE_DIR}/cmake
            -D PACKAGE_PREFIX=${PACKAGE_PREFIX}
            -D GNUCASH_SOURCE_DIR=${CMAKE_SOURCE_DIR}
            -D SHELL=${SHELL}
            -P ${CMAKE_SOURCE_DIR}/cmake/MakeDistCheck.cmake
        )

############################# END MAKE DIST #################

# uninstall target
configure_file(
        "${CMAKE_SOURCE_DIR}/cmake/cmake_uninstall.cmake.in"
        "${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake"
        @ONLY)

add_custom_target(uninstall
        COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake)

# CMakeLists.txt for GnuCash Documenation

cmake_minimum_required (VERSION 3.5)

project (gnucash-docs)

# Version number of gnucash
set (GNUCASH_MAJOR_VERSION 3)
set (GNUCASH_MINOR_VERSION 6)
set (VERSION "${GNUCASH_MAJOR_VERSION}.${GNUCASH_MINOR_VERSION}")
set (GNUCASH_LATEST_STABLE_SERIES 3.x)

set (PACKAGE gnucash-docs)
set (PACKAGE_NAME GnuCash Docs)
set (PACKAGE_VERSION 3.6)
set (PACKAGE_BUGREPORT "https://bugs.gnucash.org/describecomponents.cgi?product=Documentation")
set (PACKAGE_TARNAME ${PACKAGE})
set (PACKAGE_STRING "${PACKAGE_NAME} ${PACKAGE_VERSION}")
set (PACKAGE_URL "https://www.gnucash.org/")

# Extra cmake macros
set (CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake;${CMAKE_MODULE_PATH}")
include (AddChmTarget)
include (AddEpubTarget)
include (AddHtmlTarget)
include (AddPdfTarget)
include (AddXmlTarget)
include (AddGncDocTargets)
include (DistCommon)
include (GNUInstallDirs)

# Clear cache variables that will be filled later during the cmake run
unset(dist_files CACHE)

# ############################################################
# These options are settable from the CMake command line. For example,
# to enable mobi, put -D WITH_MOBI=ON on the command line.

option (WITH_MOBI "Enable build rules for Mobipocket document format" OFF)

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
set (PDF YES)
find_program(FOP fop)
if(NOT FOP)
    message(WARNING "Can't find fop. You will not be able to generate PDF files.")
    set (PDF NO)
endif(NOT FOP)

set(MOBI NO)
if(WITH_MOBI)
    find_program(EBOOK_CONVERT ebook-convert)
    if (EBOOK_CONVERT)
        set(MOBI YES)
    else()
        message(SEND_ERROR "Couldn't find ebook-convert required for mobi file format support. Please install the Calibre package: https://www.calibre-ebook.com/")
    endif()
else()
    message(STATUS "Mobi file format support is disabled.  Specify -DWITH_MOBY=ON if you want to enable it.")
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
if(WIN32)
    find_program(HHC hhc.exe
        PATHS "c:/Program Files (x86)/Html Help Workshop" "c:/Program Files/Html Help Workshop")
    if(NOT HHC)
        message(ERROR "Html Help Workshop not found")
    endif()
else(WIN32)
    find_program(HHC chmcmd)
    if(NOT HHC)
        message(STATUS "Free Pascal's chmcmd not found. The chm build rules will not be able to generate the final chm file, but are still enabled for debugging purposes.")
    endif()
endif(WIN32)

# The global targets. Their dependencies will be filled in by subsequent commands in
# the respective subdirectories.
add_custom_target(html)
add_custom_target(check)
add_custom_target(xml)
if (PDF)
    add_custom_target(pdf)
endif()
add_custom_target(epub)
if (MOBI)
    add_custom_target(mobi)
endif()
add_custom_target(chm)


add_subdirectory (guide)
add_subdirectory (help)

set(autotoolsfiles
    configure.ac
    configure
    config.guess
    config.sub
    COPYING
    INSTALL
    Makefile.am
    Makefile.in
    aclocal.m4
    gnucash-docs.spec.in
    install-sh
    ltmain.sh
    missing
    chm.make
    epub.make
    mobi.make
    omf.make
    pdf.make
    xmldocs.make)
add_to_dist(${autotoolsfiles})

file(GLOB_RECURSE extrafiles
    RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
    cmake/* fonts/* stylesheet/* xsl/*)
add_to_dist(${extrafiles})

add_to_dist(
    AUTHORS
    CMakeLists.txt
    COPYING-DOCS
    ChangeLog
    HACKING
    NEWS
    README
    docbook/gnc-docbookx.dtd
    fop.xconf.in)

############################ BEGIN MAKE DIST #################

set(PACKAGE_PREFIX "${PACKAGE}-${PACKAGE_VERSION}")
set(DIST_FILE "${PACKAGE_PREFIX}.tar")

add_custom_command(OUTPUT ${DIST_FILE}.gz ${DIST_FILE}.bz2
        COMMAND ${CMAKE_COMMAND}
           -D CMAKE_MODULE_PATH=${CMAKE_SOURCE_DIR}/cmake
           -D PACKAGE_PREFIX=${PACKAGE_PREFIX}
           -D GNUCASH_SOURCE_DIR=${CMAKE_SOURCE_DIR}
           -D BUILD_SOURCE_DIR=${CMAKE_BINARY_DIR}
           "-Ddist_files=\"${dist_files}\""
           -P ${CMAKE_SOURCE_DIR}/cmake/MakeDist.cmake

        DEPENDS
          ${dist_files}
        )

add_custom_target(dist DEPENDS ${DIST_FILE}.gz ${DIST_FILE}.bz2)

add_custom_target(distcheck DEPENDS dist
        COMMAND ${CMAKE_COMMAND}
            -D CMAKE_MODULE_PATH=${CMAKE_SOURCE_DIR}/cmake
            -D PACKAGE_PREFIX=${PACKAGE_PREFIX}
            -P ${CMAKE_SOURCE_DIR}/cmake/MakeDistCheck.cmake
        )

############################# END MAKE DIST #################

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
include (xmldocs)
include (pdf)
include (GNUInstallDirs)


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

#
# dnl
# dnl Check for mobi target and optional ebook-convert
# dnl
# AC_ARG_WITH([mobi],
# 	[AC_HELP_STRING([--with-mobi],
# 			[do make Mobipocket target])],,
# 	with_mobi=no)
# AM_CONDITIONAL([WITH_MOBI], [test "x$with_mobi" = "xyes"])
# if test "x$with_mobi" = "xyes"; then
#   AC_PATH_PROG(EBOOK_CONVERT, ebook-convert, no)
#   if test "x$EBOOK_CONVERT" = "xno"; then
#     AC_MSG_ERROR([Couldn't find ebook-convert. Please install the Calibre package: https://www.calibre-ebook.com/])
#   fi
# else
#   AC_MSG_NOTICE([Didn't make mobi target.  If you need, specify --with-mobi])
# fi

# Determine paper format depending on locale
# It's a pretty simple hack: only US or C will be set to letter. All others use A4.
set (ENV_LANG $ENV{LANG})
if (ENV_LANG AND ENV_LANG MATCHES ".*_us.*|C") # Replacing ENV_LANG here with if ($ENV{LANG}) won't work.
    set (XSLTFLAGS_FO "--stringparam paper.type letter")
else()
    set (XSLTFLAGS_FO "--stringparam paper.type A4")
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

#
# ac_cv_gnc_windows="no"
# case $host_os in
#   mingw*)
#   ac_cv_gnc_windows="yes"
#   AC_PATH_PROG([HHC], hhc.exe, [hhc_not_found], [/c/Program Files (x86)/Html Help Workshop:/c/Program Files/Html Help Workshop])
#   if test ! -x "${HHC}"; then
#      AC_MSG_ERROR([Html Help Workshop Not Found])
#   fi
#   AM_EXTRA_RECURSIVE_TARGETS([chm install-chm])
#   ;;
#   *)
#   ;;
# esac
# AM_CONDITIONAL([GNC_WINDOWS], [test x${ac_cv_gnc_windows} = "xyes"])
# AM_CONDITIONAL([LANG_US], [test x${lang_us} = "xtrue"])
# AC_CONFIG_FILES([
# gnucash-docs.spec
# help/Makefile
# help/C/Makefile
# help/de/Makefile
# help/it/Makefile
# help/pt/Makefile
# guide/Makefile
# guide/C/Makefile
# guide/de/Makefile
# guide/it/Makefile
# guide/ja/Makefile
# guide/pt/Makefile
# guide/ru/Makefile
# Makefile])
#
# AC_CONFIG_FILES([guide/ja/fop.xconf])
# AC_CONFIG_FILES([guide/ru/fop.xconf])
#
# AC_OUTPUT

# The global targets. Their dependencies will be filled in by subsequent commands in
# the respective subdirectories.
add_custom_target(html)
add_custom_target(check)
add_custom_target(xml)
if (PDF)
    add_custom_target(pdf)
endif()


add_subdirectory (guide)
add_subdirectory (help)

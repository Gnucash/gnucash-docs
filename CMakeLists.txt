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
include (GNUInstallDirs)


# ############################################################
# These options are settable from the CMake command line. For example, to disable
# enable mobi, put -D WITH_MOBI=ON on the command line.

option (WITH_MOBI "Enable build rules for Mobipocket document format" OFF)

set(JP_FONTDIR "" CACHE STRING "Directory to search for Japanese fonts")
set(JP_MINCHO "ume-tmo3.ttf" CACHE STRING "Japanese Mincho TrueType font to use")
set(JP_GOTHIC "ume-tmo3.ttf" CACHE STRING "Japanese Gothic TrueType font to use")

# AM_INIT_AUTOMAKE()
#

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

#
# dnl
# dnl Check for optional fop
# dnl
# AC_PATH_PROG(FOP, fop)
# fop_version=0
# if test -z "$FOP"; then
#   AC_MSG_WARN([fop not found. You will not be able to generate PDF files.])
# else
#   fop_version=`$FOP -version | cut -f 3 -d ' ' | cut -c 1`
# fi
#
# dnl
# dnl Get the absolute path to $srcdir
# dnl
# ac_abs_top_srcdir=$(cd -- "$srcdir" && pwd)
#
# dnl
# dnl Set font dirs and font
# dnl
# EXTENDED_SANS=opentype/freefont/FreeSans
# EXTENDED_SERIF=opentype/freefont/FreeSerif
# EXTENDED_MONO=opentype/freefont/FreeMono
# extended_fontdir=$ac_abs_top_srcdir/fonts
# extended_extension=otf
# AC_SUBST(EXTENDED_SANS)
# AC_SUBST(EXTENDED_SERIF)
# AC_SUBST(EXTENDED_MONO)
# AC_SUBST(extended_fontdir)
# AC_SUBST(extended_extension)
#
# dnl
# dnl Check Japanese TrueType fonts for PDF
# dnl
# AC_ARG_WITH([japanese-fontdir],
# 	[AS_HELP_STRING([--with-japanese-fontdir=DIR],
# 			[use DIR for Japanese TrueType font directory])],,
# 			[with_japanese_fontdir=check])
# AC_ARG_WITH([japanese-mincho-ttf],
# 	[AS_HELP_STRING([--with-japanese-mincho-ttf],
# 			[specify Japanese Mincho TrueType font (default is ume-tmo3.ttf)])],,)
# AC_ARG_WITH([japanese-gothic-ttf],
# 	[AS_HELP_STRING([--with-japanese-gothic-ttf],
# 			[specify Japanese Gothic TrueType font (default is ume-tmo3.ttf)])],,)
# JAPANESE_MINCHO_TTF=ume-tmo3.ttf
# JAPANESE_GOTHIC_TTF=ume-tmo3.ttf
# japanese_fontdir=$ac_abs_top_srcdir/fonts/truetype
# JAPANESE_MINCHO_TTF_ABS=$japanese_fontdir/$JAPANESE_MINCHO_TTF
# JAPANESE_GOTHIC_TTF_ABS=$japanese_fontdir/$JAPANESE_GOTHIC_TTF
#
# dnl Japanese fonts search path (Ubuntu, RedHat, openSUSE:local, Fedora)
# japanese_fontdirs="/usr/share/fonts /usr/local/share/fonts /usr/local/share/fonts"
#
# if test "x$with_japanese_fontdir" != "xcheck" && test "x$with_japanese_fontdir" != "xyes" ; then
# japanese_fontdirs="$with_japanese_fontdir $japanese_fontdir"
# fi
#
# if test "x$with_japanese_mincho_ttf" != "x" ; then
# AC_CHECK_FILE($with_japanese_mincho_ttf,
# [JAPANESE_MINCHO_TTF=$with_japanase_mincho_ttf
# JAPANESE_MINCHO_TTF_ABS=$font
# font = $with_japanese_mincho_ttf],
# [for fontdir in $japanese_fontdirs ""; do
# font=$fontdir/$with_japanese_mincho_ttf
# AC_CHECK_FILE($font,
# [JAPANESE_MINCHO_TTF=$font
# JAPANESE_MINCHO_TTF_ABS=$font
# japanese_fontdir=$fontdir
# break],)
# done])
# if test -z $font; then
# AC_MSG_WARN([$with_japanese_mincho_ttf not found, using default mincho font])
# fi
# unset font
# fi
# if test "x$with_japanese_gothic_ttf" != "x" ; then
# AC_CHECK_FILE($with_japanese_gothic_ttf,
# [JAPANESE_GOTHIC_TTF=$with_japanase_gothic_ttf
# JAPANESE_GOTHIC_TTF_ABS=$font
# font = $with_japanese_gothic_ttf],
# [for fontdir in $japanese_fontdirs ""; do
# font=$fontdir/$with_japanese_gothic_ttf
# AC_CHECK_FILE($font,
# [JAPANESE_GOTHIC_TTF=$font
# JAPANESE_GOTHIC_TTF_ABS=$font
# japanese_fontdir=$fontdir
# break],)
# done])
# if test -z $font; then
# AC_MSG_WARN([$with_japanese_gothic_ttf not found, using default gothic font])
# fi
# unset font
# fi
# AC_SUBST(japanese_fontdir)
# AC_SUBST(JAPANESE_MINCHO_TTF)
# AC_SUBST(JAPANESE_MINCHO_TTF_ABS)
# AC_SUBST(JAPANESE_GOTHIC_TTF)
# AC_SUBST(JAPANESE_GOTHIC_TTF_ABS)
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

# Add global targets. Their dependencies will be filled in by subsequent command in
# the respective subdirectories.
add_custom_target(html)
add_custom_target(check)
add_custom_target(xml
    DEPENDS check
)


add_subdirectory (guide)
add_subdirectory (help)

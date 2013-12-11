# copyright (c) 2000-2002 Chris Lyttle
# copyright (c) 2003-2013 GnuCash Development Team

dnl Process this file with autoconf to produce a configure script.
AC_INIT(gnucash-docs, 2.6.0)

dnl ==========================================================================
dnl
dnl If you add a version number here, you *must* add an AC_SUBST line for
dnl it too, or it will never make it into the spec file!
dnl
dnl ==========================================================================

SCROLLKEEPER_BUILD_REQUIRED=0.3.4
AC_SUBST(SCROLLKEEPER_BUILD_REQUIRED)

dnl ====================================
dnl = Begin tests for scrollkeeper
dnl ====================================
AC_ARG_ENABLE([scrollkeeper],
	[AC_HELP_STRING([--disable-scrollkeeper],
			[do not make updates to the scrollkeeper database])],,
	enable_scrollkeeper=yes)
AM_CONDITIONAL(ENABLE_SK, test "x$enable_scrollkeeper" = "xyes")
AC_PATH_PROG(SCROLLKEEPER_CONFIG, scrollkeeper-config,no)
if (test "x$enable_scrollkeeper" = "xyes") && (test x$SCROLLKEEPER_CONFIG = xno); then
  AC_MSG_ERROR(Couldn't find scrollkeeper-config. Please install the scrollkeeper package: http://scrollkeeper.sourceforge.net)
fi
dnl ====================================
dnl = End tests for scrollkeeper
dnl ====================================

AM_INIT_AUTOMAKE()

dnl
dnl Check for xsltproc
dnl Some distributions package it separately of libxslt
dnl
AC_PATH_PROG(XSLTPROC, xsltproc)
if test -z "$XSLTPROC"; then
  AC_MSG_ERROR([xsltproc not found, perhaps you should install the xsltproc or libxslt package ?])
fi
dnl Same for xmllint
AC_PATH_PROG(XMLLINT, xmllint, [""])
if test -z "$XMLLINT"; then
  AC_MSG_ERROR([xmllint not found, perhaps you should install the xmllint or libxslt package ?])
fi

dnl
dnl Check for optional fop
dnl
AC_PATH_PROG(FOP, fop)
if test -z "$FOP"; then
  AC_MSG_WARN([fop not found. You will not be able to generate PDF files.])
else
  AC_PATH_PROG(FOP_TTFREADER, fop-ttfreader)
  if test -z "$FOP_TTFREADER"; then
    AC_MSG_WARN([fop-ttfreader not found. You won't be able to generate non-latin PDF files.])
  fi
fi

dnl
dnl Check Japanese TrueType fonts for PDF
dnl
AC_ARG_WITH([japanese-fontdir],
	[AS_HELP_STRING([--with-japanese-fontdir=DIR],
			[use DIR for Japanese TrueType font directory])],,
			[with_japanese_fontdir=check])
AC_ARG_WITH([japanese-mincho-ttf],
	[AS_HELP_STRING([--with-japanese-mincho-ttf],
			[specify Japanese Mincho TrueType font (default is ipaexm.ttf)])],,[with_japanese_mincho_ttf=ipaexm.ttf])
AC_ARG_WITH([japanese-gothic-ttf],
	[AS_HELP_STRING([--with-japanese-gothic-ttf],
			[specify Japanese Gothic TrueType font (default is ipaexg.ttf)])],,[with_japanese_gothic_ttf=ipaexg.ttf])

JAPANESE_MINCHO_TTF=
JAPANESE_GOTHIC_TTF=
dnl Japanese fonts search path (Ubuntu, RedHat, openSUSE:local)
japanese_fontdir="/usr/share/fonts/truetype/ipaexfont /usr/share/fonts/opentype/ipaexfont /usr/share/fonts/ipa-gothic /usr/share/fonts/ipa-mincho /usr/local/share/fonts/i ."

if test "x$with_japanese_fontdir" != "xcheck" && test "x$with_japanese_fontdir" != "xyes" ; then
   japanese_fontdir="$with_japanese_fontdir $japanese_fontdir"
fi

for fontdir in $japanese_fontdir ""; do
    if test "x$JAPANESE_MINCHO_TTF" != "x" ; then 
        case $JAPANESE_MINCHO_TTF in
            /*)
               ;;
            *)
                JAPANESE_MINCHO_TTF=`pwd`/$JAPANESE_MINCHO_TTF
               ;;
        esac	
        break
    fi
    font=$fontdir/$with_japanese_mincho_ttf
    AC_CHECK_FILE($font,[JAPANESE_MINCHO_TTF=$font],)
done


for fontdir in $japanese_fontdir ""; do
    if test "x$JAPANESE_GOTHIC_TTF" != "x" ; then 
        case $JAPANESE_GOTHIC_TTF in
            /*)
               ;;
            *)
                JAPANESE_GOTHIC_TTF=`pwd`/$JAPANESE_GOTHIC_TTF
               ;;
        esac	
        break 
    fi
    font=$fontdir/$with_japanese_gothic_ttf
    AC_CHECK_FILE($font,[JAPANESE_GOTHIC_TTF=$font],)
done
unset font

if test -z "$JAPANESE_MINCHO_TTF" || test -z "$JAPANESE_GOTHIC_TTF" ; then
   AC_MSG_WARN([

Japanese TrueType fonts not found. You can't create Japanese PDF files.
If you'd like to create Japanese PDF files, please download IPAex Fonts from
  http://ossipedia.ipa.go.jp/ipafont/index.html
and specify --with-japanese-fontdir=DIR option.
])
  AM_CONDITIONAL([WITH_JAPANESE_PDF],[false])
elif test -z "$FOP_TTFREADER"; then
   AC_MSG_WARN([

fop-ttfreader not found. You can't create Japanese PDF files.
If you'd like to create Japanese PDF files, please setup FOP properly.
])
  AM_CONDITIONAL([WITH_JAPANESE_PDF],[false])
else
  AM_CONDITIONAL([WITH_JAPANESE_PDF],[true])
fi
AC_SUBST(JAPANESE_MINCHO_TTF)
AC_SUBST(JAPANESE_GOTHIC_TTF)

dnl
dnl Check for mobi target and optional ebook-convert
dnl
AC_ARG_WITH([mobi],
	[AC_HELP_STRING([--with-mobi],
			[do make Mobipocket target])],,
	with_mobi=no)
AM_CONDITIONAL([WITH_MOBI], [test "x$with_mobi" = "xyes"])
if test "x$with_mobi" = "xyes"; then
  AC_PATH_PROG(EBOOK_CONVERT, ebook-convert, no)
  if test "x$EBOOK_CONVERT" = "xno"; then
    AC_MSG_ERROR([Couldn't find ebook-convert. Please install the Calibre package: http://www.calibre-ebook.com/])
  fi
else
  AC_MSG_NOTICE([Didn't make mobi target.  If you need, specify --with-mobi])
fi

AC_OUTPUT(
gnucash-docs.spec
help/Makefile
help/C/Makefile
help/de/Makefile
help/it/Makefile
guide/Makefile
guide/C/Makefile
guide/de/Makefile
guide/it/Makefile
guide/ja/Makefile
guide/ja/fop.xconf
Makefile)

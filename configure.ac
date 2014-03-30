# copyright (c) 2000-2002 Chris Lyttle
# copyright (c) 2003-2013 GnuCash Development Team

dnl Process this file with autoconf to produce a configure script.
AC_INIT(gnucash-docs, 2.6.3)

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
    if test -e /usr/share/java/fop.jar; then
      FOP_TTFREADER="java -cp /usr/share/java/fop.jar:/usr/share/java/avalon-framework.jar:/usr/share/java/commons-logging.jar:/usr/share/java/commons-io.jar:/usr/share/java/xmlgraphics-commons.jar org.apache.fop.fonts.apps.TTFReader"
    fi
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
			[specify Japanese Mincho TrueType font (default is ipaexm.ttf)])],,)
AC_ARG_WITH([japanese-gothic-ttf],
	[AS_HELP_STRING([--with-japanese-gothic-ttf],
			[specify Japanese Gothic TrueType font (default is ipaexg.ttf)])],,)

JAPANESE_MINCHO_TTF=`pwd`/fonts/ume-tmo3.ttf
JAPANESE_GOTHIC_TTF=`pwd`/fonts/ume-tmo3.ttf
japanese_mincho_metric=fonts/mincho.xml
japanese_gothic_metric=fonts/gothic.xml

if test -z "$FOP_TTFREADER"; then
   AC_MSG_WARN([
        fop-ttfreader not found, using the default Japanese fonts.
])

else
dnl Japanese fonts search path (Ubuntu, RedHat, openSUSE:local, Fedora)
  japanese_fontdir="/usr/share/fonts/truetype /usr/share/fonts /usr/local/share/fonts /usr/local/share/fonts"

  if test "x$with_japanese_fontdir" != "xcheck" && test "x$with_japanese_fontdir" != "xyes" ; then
     japanese_fontdir="$with_japanese_fontdir $japanese_fontdir"
  fi
  
  if test "x$with_japanese_mincho_ttf" != "x" ; then
      for fontdir in $japanese_fontdir ""; do
          font=$fontdir/$with_japanese_mincho_ttf
          AC_CHECK_FILE($font,[
			       JAPANESE_MINCHO_TTF=$font
      	    		       unset japanese_mincho_metric
			       break
      			       ],)
      done
      if test -z $font; then
          AC_MSG_WARN([$with_japanese_mincho_ttf not found, using default mincho font])
      fi
      unset font
  fi
  if test "x$with_japanese_gothic_ttf" != "x" ; then 
      for fontdir in $japanese_fontdir ""; do
          font=$fontdir/$with_japanese_gothic_ttf
          AC_CHECK_FILE($font,[
	         	       JAPANESE_GOTHIC_TTF=$font
			       unset japanese_gothic_metric
			       break
			      ],)
      done
      if test -z $font; then
          AC_MSG_WARN([$with_japanese_gothic_ttf not found, using default gothic font])
      fi
      unset font
   fi
fi
echo Mincho Metric: $japanese_mincho_metric
if test "x$japanese_mincho_metric" != "x"; then
   cp $japanese_mincho_metric guide/ja
fi
echo Gothic Metric: $japanese_gothic_metric
if test "x$japanese_gothic_metric" != "x"; then
   cp $japanese_gothic_metric guide/ja
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

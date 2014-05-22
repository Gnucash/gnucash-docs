# copyright (c) 2000-2002 Chris Lyttle
# copyright (c) 2003-2013 GnuCash Development Team

dnl Process this file with autoconf to produce a configure script.
AC_INIT(gnucash-docs, 2.6.99)

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
SCROLLKEEPER_CONFIG=no
AC_ARG_WITH([scrollkeeper],
	[AC_HELP_STRING([--with-scrollkeeper],
			[do not make updates to the scrollkeeper database (default=check)])],
	[], [with_scrollkeeper=check])
if test x$with_scrollkeeper != "xno"; then
   AC_PATH_PROG(SCROLLKEEPER_CONFIG, scrollkeeper-config, no)
   if (test "x$with_scrollkeeper" = "xyes") && (test x$SCROLLKEEPER_CONFIG = xno); then
      AC_MSG_ERROR(Couldn't find scrollkeeper-config. Please install the scrollkeeper package: http://scrollkeeper.sourceforge.net or rarian: http://rarian.freedesktop.org and link the rarian executables to their scrollkeeper equivalents.)
   fi
fi
AM_CONDITIONAL(ENABLE_SK, test "x$SCROLLKEEPER_CONFIG" = "xyes")

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
			[specify Japanese Mincho TrueType font (default is ume-tmo3.ttf)])],,)
AC_ARG_WITH([japanese-gothic-ttf],
	[AS_HELP_STRING([--with-japanese-gothic-ttf],
			[specify Japanese Gothic TrueType font (default is ume-tmo3.ttf)])],,)

JAPANESE_MINCHO_TTF=fonts/ume-tmo3.ttf
JAPANESE_GOTHIC_TTF=fonts/ume-tmo3.ttf
JAPANESE_MINCHO_TTF_ABS='${top_srcdir}/${JAPANESE_MINCHO_TTF}'
JAPANESE_GOTHIC_TTF_ABS='${top_srcdir}/${JAPANESE_GOTHIC_TTF}'
japanese_mincho_metric=/fonts/mincho.xml
japanese_gothic_metric=/fonts/gothic.xml

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
       AC_CHECK_FILE($with_japanese_mincho_ttf,
		     [JAPANESE_MINCHO_TTF=$with_japanase_mincho_ttf
		      JAPANESE_MINCHO_TTF_ABS=$font
		      unset japanese_mincho_metric
		      font = $with_japanese_mincho_ttf],
		     [for fontdir in $japanese_fontdir ""; do
          	     	  font=$fontdir/$with_japanese_mincho_ttf
          		  AC_CHECK_FILE($font,
					[JAPANESE_MINCHO_TTF=$font
					 JAPANESE_MINCHO_TTF_ABS=$font
      	    		       		 unset japanese_mincho_metric
			       		 break],)
      			  done])
      if test -z $font; then
          AC_MSG_WARN([$with_japanese_mincho_ttf not found, using default mincho font])
      fi
      unset font
  fi
  if test "x$with_japanese_gothic_ttf" != "x" ; then
        AC_CHECK_FILE($with_japanese_gothic_ttf,
		     [JAPANESE_GOTHIC_TTF=$with_japanase_gothic_ttf
		      JAPANESE_GOTHIC_TTF_ABS=$font
		      unset japanese_gothic_metric
		      font = $with_japanese_gothic_ttf],
		     [for fontdir in $japanese_fontdir ""; do
          	     	  font=$fontdir/$with_japanese_gothic_ttf
          		  AC_CHECK_FILE($font,
					[JAPANESE_GOTHIC_TTF=$font
					 JAPANESE_GOTHIC_TTF_ABS=$font
      	    		       		 unset japanese_gothic_metric
			       		 break],)
      			  done])
       if test -z $font; then
          AC_MSG_WARN([$with_japanese_gothic_ttf not found, using default gothic font])
      fi
      unset font
   fi
fi
echo Mincho Metric: $japanese_mincho_metric
if test "x$japanese_mincho_metric" != "x"; then
   AC_CONFIG_COMMANDS([mincho_metric],
		      [cp $ac_top_srcdir$mincho_metric guide/ja],
		      [mincho_metric=$japanese_mincho_metric])
fi
echo Gothic Metric: $japanese_gothic_metric
if test "x$japanese_gothic_metric" != "x"; then
   AC_CONFIG_COMMANDS([gothic_metric],
		      [cp $ac_top_srcdir$gothic_metric guide/ja],
		      [gothic_metric=$japanese_gothic_metric])
fi
AC_SUBST(JAPANESE_MINCHO_TTF)
AC_SUBST(JAPANESE_MINCHO_TTF_ABS)
AC_SUBST(JAPANESE_GOTHIC_TTF)
AC_SUBST(JAPANESE_GOTHIC_TTF_ABS)

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

AC_CONFIG_FILES([
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
Makefile])

AC_CONFIG_FILES([guide/ja/fop.xconf])

AC_OUTPUT

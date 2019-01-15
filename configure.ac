# copyright (c) 2000-2002 Chris Lyttle
# copyright (c) 2003-2016 GnuCash Development Team

dnl Process this file with autoconf to produce a configure script.
AC_INIT([gnucash-docs], [3.900], [https://bugzilla.gnome.org/page.cgi?id=browse.html&product=GnuCash], , [http://www.gnucash.org/])
AC_CANONICAL_HOST

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
      AC_MSG_ERROR(Couldn't find scrollkeeper-config. Please install the scrollkeeper package: http://scrollkeeper.sourceforge.net or rarian: https://rarian.freedesktop.org and link the rarian executables to their scrollkeeper equivalents.)
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
XSLTPROCFLAGS="--path \${top_srcdir}/docbook --xinclude $XSLTPROCFLAGS"
AC_SUBST([XSLTPROCFLAGS])

dnl Same for xmllint
AC_PATH_PROG(XMLLINT, xmllint, [""])
if test -z "$XMLLINT"; then
  AC_MSG_ERROR([xmllint not found, perhaps you should install the xmllint or libxslt package ?])
fi

dnl
dnl Check for optional fop
dnl
AC_PATH_PROG(FOP, fop)
fop_version=0
if test -z "$FOP"; then
  AC_MSG_WARN([fop not found. You will not be able to generate PDF files.])
else
  fop_version=`$FOP -version | cut -f 3 -d ' ' | cut -c 1`
fi

EXTENDED_SANS=opentype/freefont/FreeSans
EXTENDED_SERIF=opentype/freefont/FreeSerif
EXTENDED_MONO=opentype/freefont/FreeMono
extended_fontdir=$ac_pwd/$srcdir/fonts
extended_extension=otf
AC_SUBST(EXTENDED_SANS)
AC_SUBST(EXTENDED_SERIF)
AC_SUBST(EXTENDED_MONO)
AC_SUBST(extended_fontdir)
AC_SUBST(extended_extension)

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
JAPANESE_MINCHO_TTF=ume-tmo3.ttf
JAPANESE_GOTHIC_TTF=ume-tmo3.ttf
japanese_fontdir=$ac_pwd/$srcdir/fonts/truetype
JAPANESE_MINCHO_TTF_ABS=$japanese_fontdir/$JAPANESE_MINCHO_TTF
JAPANESE_GOTHIC_TTF_ABS=$japanese_fontdir/$JAPANESE_GOTHIC_TTF

dnl Japanese fonts search path (Ubuntu, RedHat, openSUSE:local, Fedora)
japanese_fontdirs="/usr/share/fonts /usr/local/share/fonts /usr/local/share/fonts"

if test "x$with_japanese_fontdir" != "xcheck" && test "x$with_japanese_fontdir" != "xyes" ; then
japanese_fontdirs="$with_japanese_fontdir $japanese_fontdir"
fi

if test "x$with_japanese_mincho_ttf" != "x" ; then
AC_CHECK_FILE($with_japanese_mincho_ttf,
[JAPANESE_MINCHO_TTF=$with_japanase_mincho_ttf
JAPANESE_MINCHO_TTF_ABS=$font
font = $with_japanese_mincho_ttf],
[for fontdir in $japanese_fontdirs ""; do
font=$fontdir/$with_japanese_mincho_ttf
AC_CHECK_FILE($font,
[JAPANESE_MINCHO_TTF=$font
JAPANESE_MINCHO_TTF_ABS=$font
japanese_fontdir=$fontdir
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
font = $with_japanese_gothic_ttf],
[for fontdir in $japanese_fontdirs ""; do
font=$fontdir/$with_japanese_gothic_ttf
AC_CHECK_FILE($font,
[JAPANESE_GOTHIC_TTF=$font
JAPANESE_GOTHIC_TTF_ABS=$font
japanese_fontdir=$fontdir
break],)
done])
if test -z $font; then
AC_MSG_WARN([$with_japanese_gothic_ttf not found, using default gothic font])
fi
unset font
fi
AC_SUBST(japanese_fontdir)
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
    AC_MSG_ERROR([Couldn't find ebook-convert. Please install the Calibre package: https://www.calibre-ebook.com/])
  fi
else
  AC_MSG_NOTICE([Didn't make mobi target.  If you need, specify --with-mobi])
fi
if test -z $LANG; then LANG="C"; fi
case $LANG in
     *_US*|C)
        lang_us=true ;;
     *)
        lang_us=false ;;
esac

ac_cv_gnc_windows="no"
case $host_os in
  mingw*)
  ac_cv_gnc_windows="yes"
  AC_PATH_PROG([HHC], hhc.exe, [hhc_not_found], [/c/Program Files (x86)/Html Help Workshop:/c/Program Files/Html Help Workshop])
  if test ! -x "${HHC}"; then
     AC_MSG_ERROR([Html Help Workshop Not Found])
  fi
  AM_EXTRA_RECURSIVE_TARGETS([chm install-chm])
  ;;
  *)
  ;;
esac
AM_CONDITIONAL([GNC_WINDOWS], [test x${ac_cv_gnc_windows} = "xyes"])
AM_CONDITIONAL([LANG_US], [test x${lang_us} = "xtrue"])
AC_CONFIG_FILES([
gnucash-docs.spec
help/Makefile
help/C/Makefile
help/de/Makefile
help/it/Makefile
help/pt/Makefile
guide/Makefile
guide/C/Makefile
guide/de/Makefile
guide/it/Makefile
guide/ja/Makefile
guide/pt/Makefile
guide/ru/Makefile
Makefile])

AC_CONFIG_FILES([guide/ja/fop.xconf])
AC_CONFIG_FILES([guide/ru/fop.xconf])

AC_OUTPUT

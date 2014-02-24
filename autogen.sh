#!/bin/sh -x
# Run this to generate all the initial makefiles, etc.

# Exit this script if any command fails with non-zero exit status.
set -e

if test -z "$srcdir" ; then srcdir=`dirname $0` ; fi
if test -z "$srcdir" ; then srcdir=.            ; fi
cd $srcdir

PROJECT=gnucash-docs
DIE=0

# First cache the command names in variables. If you want to
# override the names, simply set the variables before calling this
# script.

#: ${INTLTOOLIZE=intltoolize}
#: ${GETTEXTIZE=gettextize}
: ${LIBTOOLIZE=libtoolize}
: ${ACLOCAL=aclocal}
: ${AUTOHEADER=autoheader}
: ${AUTOMAKE=automake}
: ${AUTOCONF=autoconf}
ACLOCAL_FLAGS="$ACLOCAL_FLAGS -I ."

(${AUTOCONF} --version) < /dev/null > /dev/null 2>&1 || {
	echo
	echo "You must have autoconf installed to compile $PROJECT."
	echo "Download the appropriate package for your distribution,"
	echo "or get the source tarball at ftp://ftp.gnu.org/pub/gnu/"
	DIE=1
}

(${LIBTOOLIZE} --version) < /dev/null > /dev/null 2>&1 || {
	echo
	echo "You must have libtoolize installed to compile $PROJECT."
	echo "Get ftp://alpha.gnu.org/gnu/libtool-1.0h.tar.gz"
	echo "(or a newer version if it is available)"
	DIE=1
}

(${AUTOMAKE} --version) < /dev/null > /dev/null 2>&1 || {
	echo
	echo "You must have automake installed to compile $PROJECT."
	echo "Get ftp://ftp.cygnus.com/pub/home/tromey/automake-1.2d.tar.gz"
	echo "(or a newer version if it is available)"
	DIE=1
}

if test "$DIE" -eq 1; then
	exit 1
fi

#${INTLTOOLIZE}
#${GETTEXTIZE}
${LIBTOOLIZE} -f --automake
${ACLOCAL} ${ACLOCAL_FLAGS}
#${AUTOHEADER}
${AUTOMAKE} --add-missing
${AUTOCONF}

echo You must now run ./configure "$@"

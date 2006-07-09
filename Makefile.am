SUBDIRS = help \
	  guide

EXTRA_DIST = gnucash-docs.spec \
	     COPYING-DOCS \
	     xmldocs.make \
	     omf.make \
	     stylesheet \
	     xsl \
	     HACKING

DISTCHECK_CONFIGURE_FLAGS = --disable-scrollkeeper

distuninstallcheck_listfiles =  \
find -regex '.*/var/scrollkeeper/.*' -prune -or -type f -print

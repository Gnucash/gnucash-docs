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

dist-hook:
	rm -rf `find $(distdir)/stylesheet -name \.svn`
	rm -rf `find $(distdir)/xsl -name \.svn`

distuninstallcheck_listfiles =  \
find -regex '.*/var/scrollkeeper/.*' -prune -or -type f -print

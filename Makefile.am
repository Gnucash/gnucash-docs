SUBDIRS = help \
	  guide \
	  doc-tools

EXTRA_DIST = gnucash-docs.spec.in \
	     COPYING-DOCS \
	     xmldocs.make \
	     omf.make \
	     stylesheet \
	     xsl \
	     HACKING

dist-hook: gnucash-docs.spec
	cp gnucash-docs.spec $(distdir)


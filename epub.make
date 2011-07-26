# 2011-07-10, SASAKI Suguru: EPUB creation.

epubfile = $(docname).epub

$(epubfile): $(entities)

epub: $(epubfile)

epub-am:

.xml.epub:
	EPUB_TMPDIR=`mktemp -d .epubtmpXXXXXXXX`; \
	posthook='exit 1'; \
	(cd "$$EPUB_TMPDIR" && \
	echo "application/epub+zip" > mimetype && \
	xsltproc --stringparam base.dir OEBPS/ \
	         --stringparam epub.metainf.dir META-INF/ \
	         --stringparam epub.oebps.dir OEBPS/ \
	         ../../../xsl/1.75.2/epub/docbook.xsl \
	         ../$(docname).xml && \
	cp -L -R ../figures OEBPS/ && \
	zip -X -r ../$(epubfile) mimetype META-INF OEBPS && \
	cd ..) && posthook=''; \
	if test -d "$$EPUB_TMPDIR"; then \
	  rm -v -fr "$$EPUB_TMPDIR"; \
	fi; \
	eval "$$posthook";

CLEANFILES += $(epubfile)


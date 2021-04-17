# Todo: After testing replace the redirect '> xmlformat/$$basefile' by '--in-place --backup "~"'
# Note: Clean required?

if test -n "$XMLFORMAT"; then
.PHONY: format
format:
	$(mkdir_p) "xmlformat";
	for file in ${srcdir}/*.xml; do \
	    basefile=`basename $$file`; \
	   ${XMLFORMAT} --config-file $(top_srcdir)/xmlformat.conf ${srcdir}/$$basefile > xmlformat/$$basefile; \
	done
fi


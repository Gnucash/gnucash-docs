# Create CHM help files for Win32
# Copyright 2017 John Ralls <jralls@ceridwen.us>
# Procedure lifted from make_chm() in gnucash-on-windows.git:install-impl.sh,
# originally written by Andreas Köhler.

chmfile=$(docname).chm
mapfile=$(docname).hhmap

htmlhelp_xsl="http://docbook.sourceforge.net/release/xsl/current/htmlhelp/htmlhelp.xsl"

$(chmfile): $(entities) $(figfiles)
$(mapfile): $(chmfile)

chm-local: $(chmfile) $(mapfile)

install-chm-local: $(chmfile) $(mapfile)
	$(mkinstalldirs) $(DESTDIR)$(docdir)/$(lang)
	$(INSTALL_DATA) $(chmfile) $(DESTDIR)$(docdir)/$(lang)
	$(INSTALL_DATA) $(mapfile) $(DESTDIR)$(docdir)/$(lang)

.xml.chm:
	${XSLTPROC} $(XSLTPROCFLAGS) --stringparam htmlhelp.chm $(chmfile) ${htmlhelp_xsl} ${srcdir}/$(docname).xml
	if test ! -d ${builddir}/figures ; then \
		ln -s ${srcdir}/figures ${builddir} ; \
	fi
	count=0
	echo >> htmlhelp.hhp
	echo "[ALIAS]" >> htmlhelp.hhp
	echo "IDH_0=index.html" >> htmlhelp.hhp
	echo "#define IDH_0 0" > mymaps
	echo "[Map]" > htmlhelp.hhmap
	echo "Searching for anchors ..."
	for id in `cat ${srcdir}/*.xml | sed '/sect.*id=/!d;s,.*id=["'\'']\([^"'\'']*\)["'\''].*,\1,'` ; do \
		files=`grep -l "[\"']$${id}[\"']" *.html` || continue; \
		echo "IDH_$$((++count))=$${files}#$${id}" >> htmlhelp.hhp; \
		echo "#define IDH_$${count} $${count}" >> mymaps; \
		echo "$${id}=$${count}" >> htmlhelp.hhmap; \
	done
	echo >> htmlhelp.hhp
	echo "[MAP]" >> htmlhelp.hhp
	cat mymaps >> htmlhelp.hhp
	rm mymaps
	"${HHC}" htmlhelp.hhp  >/dev/null  || true
	mv htmlhelp.hhmap $(mapfile)

CLEANFILES += $(chmfile) $(mapfile) htmlhelp.hhp *.html toc.hhc
# Don't try to make dist from windows, this is here only to silence an
# error from the Italian translations.
EXTRA_DIST = $(entities) $(docname).xml

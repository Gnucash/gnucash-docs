#
# No modifications of this Makefile should be necessary.
#
# To use this template:
#     1) Define: figdir, docname, lang, omffile, and entities in
#        your Makefile.am file for each document directory,
#        although figdir, omffile, and entities may be empty
#     2) Make sure the Makefile in (1) also includes 
#	 "include $(top_srcdir)/xmldocs.make"
#     3) Optionally define 'entities' to hold xml entities which
#        you would also like installed
#     4) Figures must go under $(figdir)/ and be in PNG format
#     5) You should only have one document per directory 
#     6) Note that the figure directory, $(figdir)/, should not have its
#        own Makefile since this Makefile installs those figures.
#
# example Makefile.am:
#   figdir = figures
#   docname = scrollkeeper-manual
#   lang = C
#   omffile=scrollkeeper-manual-C.omf
#   entities = fdl.xml
#   include $(top_srcdir)/xmldocs.make
#
# About this file:
#	This file was taken from scrollkeeper_example2, a package illustrating
#	how to install documentation and OMF files for use with ScrollKeeper 
#	0.3.x and 0.4.x.  For more information, see:
#		http://scrollkeeper.sourceforge.net/
#	Version: 0.1.2 (last updated: March 20, 2002)
#
# This file is changed from the original to generate html files for GnuCash,
# install them in a subdir with the docname and copy the stylesheet png's in.
# Dec 2002 Chris Lyttle
# Oct 2012 Geert Janssens - Simplified xml doc installation and distribution


# ************* Begin of section some packagers may need to modify  **************
# These variables (gnomehelpdir and otherdocdir) specify where the documents
# should be installed. The default values should work for most packages.
# Gnome Help expects all documents here (this is where the xml files should go):
gnomehelpdir = $(datadir)/gnome/help/$(docname)/$(lang)
# Our other document versions go here:
otherdocdir = $(docdir)/$(lang)


# **************  You should not have to edit below this line  *******************

# ************** Rules to install xml files for gnome-help ***********************

xml_files = $(entities) $(docname).xml
gnomehelp_DATA =  $(xml_files)
gnomehelpfiguresdir = $(gnomehelpdir)/$(figdir)
gnomehelpfigures_DATA = $(shell ls ${srcdir}/${figdir}/*.png)

# At install time copy our dtd next to the xml files
install-data-hook:
	$(mkinstalldirs) "$(DESTDIR)$(gnomehelpdir)"
	$(INSTALL_DATA) "${top_srcdir}/docbook/gnc-docbookx.dtd" "$(DESTDIR)$(gnomehelpdir)/gnc-docbookx.dtd"

uninstall-hook:
	rmdir --ignore-fail-on-non-empty "$(DESTDIR)$(gnomehelpfiguresdir)"
	rmdir --ignore-fail-on-non-empty "$(DESTDIR)$(gnomehelpdir)"

EXTRA_DIST = $(xml_files) $(omffile) $(gnomehelpfigures_DATA)

# ************** Rules to make and install omf file ******************************
# If the following file is in a subdir (like help/) you need to add that to the path
include $(top_srcdir)/omf.make
if ENABLE_SK
OMF = omf
OMF_DATA_HOOK = install-data-hook-omf
UNINSTALL_OMF = uninstall-local-omf
else
OMF=
OMF_DATA_HOOK=
UNINSTALL_OMF=
endif

CLEANFILES += omf_timestamp

install-data-hook: ${OMF_DATA_HOOK}
uninstall-local: ${UNINSTALL_OMF}

all: ${OMF}

# ************** Rules to make and install html documentation ********************
styledir = $(top_srcdir)/stylesheet
CLEANFILES += $(docname)/*.html
figfiles = $(shell ls ${srcdir}/${figdir}/*.png)
html: all convert-html copy-pics copy-style

# Convert xml to html with xsltproc
# xsltproc --xinclude -o outputdir/ /usr/share/sgml/docbook/xsl-stylesheets/html/chunk.xsl filename.xml
convert-html: 
	$(mkinstalldirs) "$(docname)"; \
	for file in $(docname).xml; do \
	    $(XSLTPROC) $(XSLTPROCFLAGS) $(XSLTPROCFLAGS_HTML) \
	              -o "$(docname)/" \
	              --param use.id.as.filename "1" \
	              --stringparam chunker.output.encoding UTF-8  \
	              "$(top_srcdir)/xsl/general-customization.xsl" "$(srcdir)/$$file"; \
	done

copy-pics:
	$(mkinstalldirs) "$(docname)/$(figdir)"; \
	for file in $(srcdir)/$(figdir)/*.png; do \
	    basefile=`basename $$file`; \
	    $(INSTALL_DATA) "$$file" "$(docname)/$(figdir)/$$basefile"; \
	done

copy-style:
	$(mkinstalldirs) "$(docname)/stylesheet"; \
	for file in $(styledir)/*.png; do \
	    basefile=`basename $$file`; \
	    $(INSTALL_DATA) "$$file" "$(docname)/stylesheet/$$basefile"; \
	done

install-html: html
	$(mkinstalldirs) $(DESTDIR)$(otherdocdir)/$(docname);\
	for file in $(docname)/*.html; do\
	    basefile=`basename $$file`; \
	    $(INSTALL_DATA) $$file $(DESTDIR)$(otherdocdir)/$(docname)/$$basefile;\
	done
	$(mkinstalldirs) "$(DESTDIR)$(otherdocdir)/$(docname)/$(figdir)"; \
	for file in $(docname)/$(figdir)/*.png; do \
	    basefile=`basename $$file`; \
	    $(INSTALL_DATA) "$$file" "$(DESTDIR)$(otherdocdir)/$(docname)/$(figdir)/$$basefile"; \
	done
	$(mkinstalldirs) "$(DESTDIR)$(otherdocdir)/$(docname)/stylesheet"; \
	for file in $(styledir)/*.png; do \
	    basefile=`basename $$file`; \
	    $(INSTALL_DATA) "$$file" "$(DESTDIR)$(otherdocdir)/$(docname)/stylesheet/$$basefile"; \
	done

uninstall-html:
	-if test "$(docname)"; then \
	    if test "$(figdir)"; then \
	        for file in $(docname)/$(figdir)/*.png; do \
	            basefile=`basename $$file`; \
	            rm -f "$(DESTDIR)$(otherdocdir)/$(docname)/$(figdir)/$$basefile"; \
	        done; \
	        rmdir --ignore-fail-on-non-empty "$(DESTDIR)$(otherdocdir)/$(docname)/$(figdir)"; \
	    fi; \
	    for file in $(styledir)/*.png; do \
	        basefile=`basename $$file`; \
	        rm -f "$(DESTDIR)$(otherdocdir)/$(docname)/stylesheet/$$basefile"; \
	    done; \
	    rmdir --ignore-fail-on-non-empty "$(DESTDIR)$(otherdocdir)/$(docname)/stylesheet"; \
	    for file in $(docname)/*.html; do \
	        basefile=`basename $$file`; \
	        rm -f "$(DESTDIR)$(otherdocdir)/$(docname)/$$basefile"; \
	    done; \
	    rmdir --ignore-fail-on-non-empty "$(DESTDIR)$(otherdocdir)/$(docname)"; \
	    rmdir --ignore-fail-on-non-empty "$(DESTDIR)$(otherdocdir)"; \
	fi

check:
	xmllint --postvalid --xinclude --noout ${srcdir}/${docname}.xml


# A set of temporary rules to assist in the conversion of our current, separate documents per language
# into a single common document with translations managed via po files.
fpot_files = $(docname).fpot $(entities:.xml=.fpot)
fpots: $(fpot_files)

%.fpot: %.xml
	itstool -dk -o $@ $<; \
	grep -E '[(]itstool[)]|^#:' $@ | sed -E -e 's!/de/!/<lang>/!' -e 's/xml:[0-9]*/xml:<line>/' > $*.struct

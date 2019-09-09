SUBDIRS = help \
	  guide

EXTRA_DIST = COPYING-DOCS \
	     CMakeLists.txt \
	     xmldocs.make \
	     omf.make \
	     pdf.make \
         chm.make \
	     docbook \
	     stylesheet \
	     xsl \
	     HACKING \
	     README \
	     cmake/AddChmTarget.cmake \
	     cmake/AddEpubTarget.cmake \
	     cmake/AddGHelpTarget.cmake \
	     cmake/AddGncDocTargets.cmake \
	     cmake/AddHtmlTarget.cmake \
	     cmake/AddPdfTarget.cmake \
	     cmake/cmake_uninstall.cmake.in \
	     cmake/DistCommon.cmake \
	     cmake/MakeChm.cmake \
	     cmake/MakeDistCheck.cmake \
	     cmake/MakeDist.cmake \
	     fonts/gothic.xml \
	     fonts/mincho.xml \
	     fonts/truetype/ume-tgo4.ttf \
	     fonts/truetype/ume-tmo3.ttf \
	     fonts/opentype/freefont/FreeMonoBoldOblique.otf \
	     fonts/opentype/freefont/FreeMonoBold.otf \
	     fonts/opentype/freefont/FreeMonoOblique.otf \
	     fonts/opentype/freefont/FreeMono.otf \
	     fonts/opentype/freefont/FreeSansBoldOblique.otf \
	     fonts/opentype/freefont/FreeSansBold.otf \
	     fonts/opentype/freefont/FreeSansOblique.otf \
	     fonts/opentype/freefont/FreeSans.otf \
	     fonts/opentype/freefont/FreeSerifBoldItalic.otf \
	     fonts/opentype/freefont/FreeSerifBold.otf \
	     fonts/opentype/freefont/FreeSerifItalic.otf \
	     fonts/opentype/freefont/FreeSerif.otf \
	     fonts/README.Fonts \
	     fop.xconf.in

DISTCHECK_CONFIGURE_FLAGS = --disable-scrollkeeper

dist-hook:
	rm -rf `find $(distdir)/stylesheet -name \.svn`
	rm -rf `find $(distdir)/stylesheet -name \.git`
	rm -rf `find $(distdir)/xsl -name \.svn`
	rm -rf `find $(distdir)/xsl -name \.git`

distuninstallcheck_listfiles =  \
find -regex '.*/var/scrollkeeper/.*' -prune -or -type f -print

if WITH_MOBI
  MOBI_RECURSIVE = mobi-recursive
mobi: mobi-recursive
endif

epub: epub-recursive

epub-recursive $(MOBI_RECURSIVE):
	@fail= failcom='exit 1'; \
	for f in x $$MAKEFLAGS; do \
	  case $$f in \
	    *=* | --[!k]*);; \
	    *k*) failcom='fail=yes';; \
	  esac; \
	done; \
	dot_seen=no; \
	target=`echo $@ | sed s/-recursive//`; \
	list="$(SUBDIRS)"; for subdir in $$list; do \
	  echo "Making $$target in $$subdir"; \
	  if test "$$subdir" = "."; then \
	    dot_seen=yes; \
	    local_target="$$target-am"; \
	  else \
	    local_target="$$target"; \
	  fi; \
	  ($(am__cd) $$subdir && $(MAKE) $(AM_MAKEFLAGS) $$local_target) \
	  || eval $$failcom; \
	done; test -z "$$fail"

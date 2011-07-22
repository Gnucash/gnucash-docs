SUBDIRS = help \
	  guide

EXTRA_DIST = gnucash-docs.spec \
	     COPYING-DOCS \
	     xmldocs.make \
	     omf.make \
	     pdf.make \
	     stylesheet \
	     xsl \
	     HACKING

DISTCHECK_CONFIGURE_FLAGS = --disable-scrollkeeper

dist-hook:
	rm -rf `find $(distdir)/stylesheet -name \.svn`
	rm -rf `find $(distdir)/xsl -name \.svn`

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


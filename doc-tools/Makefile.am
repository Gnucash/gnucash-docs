docdir = $(datadir)/gnome/help/gnucash/C

noinst_PROGRAMS = dbadd

LDADD = \
  ${DB_LIBS}

dbadd_SOURCES = \
  dbadd.c

EXTRA_DIST = \
  .cvsignore \
  build-help-index.in

noinst_DATA = build-help-index

install-data-local: help-search-index-rm help-search-index.db
	$(INSTALL_DATA) help-search-index.db \
		$(DESTDIR)$(docdir)/help-search-index.db

help-search-index-rm:
	if test -e help-search-index.db; then \
	rm -f help-search-index.db; \
	fi

# Add html content to help-search-index.db
help-search-index.db:
	./build-help-index \
	./dbadd \
	./help-search-index.db \
	$(top_builddir)/help/C/gnucash-help/*.html \
	$(top_builddir)/guide/C/gnucash-guide/*.html;


## We borrow guile's convention and use @-...-@ as the substitution
## brackets here, instead of the usual @...@.  This prevents autoconf
## from substituting the values directly into the left-hand sides of
## the sed substitutions.
build-help-index: build-help-index.in
	rm -f $@.tmp
	sed < $< > $@.tmp \
            -e 's:@-PERL-@:${PERL}:g'
	chmod +x $@.tmp
	mv $@.tmp $@

CLEANFILES = build-help-index help-search-index.db

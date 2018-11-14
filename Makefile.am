SUBDIRS = help \
	  guide

EXTRA_DIST = gnucash-docs.spec \
	     COPYING-DOCS \
	     xmldocs.make \
	     omf.make \
	     pdf.make \
             chm.make \
	     docbook \
	     stylesheet \
	     xsl \
	     HACKING \
	     README \
	     fonts/gothic.xml \
	     fonts/mincho.xml \
	     fonts/ume-tgo4.ttf \
	     fonts/ume-tmo3.ttf \
	     fonts/README.Fonts

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

pot: $(abs_top_srcdir)/po/gnucash-docs.pot

$(abs_top_srcdir)/po/gnucash-docs.pot: $(abs_top_srcdir)/guide/C/*.xml $(abs_top_srcdir)/help/C/*.xml
	mkdir -p $(abs_top_srcdir)/po
	cd $(abs_top_srcdir)/po; \
	itstool -dk -o gnucash-docs.pot $(subst $(abs_top_srcdir),..,$(sort $^))

$(abs_top_srcdir)/po/%.po: $(abs_top_srcdir)/po/gnucash-docs.pot
	msgmerge $(abs_top_srcdir)/po/$*.po $(abs_top_srcdir)/po/gnucash-docs.pot > $(abs_top_srcdir)/po/$*.po-new
	mv $(abs_top_srcdir)/po/$*.po-new $(abs_top_srcdir)/po/$*.po

# A set of temporary rules to help in the conversion from separate documents per
# language to a single base document with translations in po format.
LANGUAGES = de it ja pt ru
fpots := $(foreach L,$(LANGUAGES),fpot-$(L))
.PHONY: $(fpots)

$(foreach L,$(LANGUAGES),$(eval fpot-$(L): po/gnucash-docs-$(L)-english.fpot po/gnucash-docs-$(L)-english.struct po/gnucash-docs-$(L)-native.fpot po/gnucash-docs-$(L)-native.struct))

po/gnucash-docs-de-english.fpot po/gnucash-docs-it-english.fpot po/gnucash-docs-pt-english.fpot : $(abs_top_srcdir)/guide/C/*.xml $(abs_top_srcdir)/help/C/*.xml
po/gnucash-docs-ja-english.fpot po/gnucash-docs-ru-english.fpot : $(abs_top_srcdir)/guide/C/*.xml
po/gnucash-docs-de-native.fpot : $(abs_top_srcdir)/guide/de/*.xml $(abs_top_srcdir)/help/de/*.xml
po/gnucash-docs-it-native.fpot : $(abs_top_srcdir)/guide/it/*.xml $(abs_top_srcdir)/help/it/*.xml
po/gnucash-docs-ja-native.fpot : $(abs_top_srcdir)/guide/ja/*.xml
po/gnucash-docs-pt-native.fpot : $(abs_top_srcdir)/guide/pt/*.xml $(abs_top_srcdir)/help/pt/*.xml
po/gnucash-docs-ru-native.fpot : $(abs_top_srcdir)/guide/ru/*.xml

po/gnucash-docs-%.fpot :
	mkdir -p po
	cd $(abs_top_srcdir)/po; \
	itstool -dk -o $(abs_builddir)/$@ $(subst $(abs_top_srcdir),..,$(sort $^))

po/gnucash-docs-%.struct: po/gnucash-docs-%.fpot
	POTLANG=$(subst -native,,$(patsubst %-english,C,$*)); \
	grep -E '[(]itstool[)]|^#:' $< | sed -E -e "s!/$${POTLANG}/!/<lang>/!" -e 's/xml:[0-9]*/xml:<line>/' > $@

po/%.po: po/gnucash-docs-%-english.fpot po/gnucash-docs-%-native.fpot po/gnucash-docs-%-english.struct po/gnucash-docs-%-native.struct
	@cd po; \
	if diff -q gnucash-docs-$*-english.struct gnucash-docs-$*-native.struct >/dev/null; \
	then \
		$(abs_top_srcdir)/util/gen-pot.pl gnucash-docs-$*-english.fpot gnucash-docs-$*-native.fpot > $*.po; \
		echo "Generation of $@ complete."; \
	else \
		echo "Error: Can't automatically generate $*.po."; \
		echo "       Msgid order  differs differs between gnucash-docs-$*-english.fpot and gnucash-docs-$*-native.fpot."; \
		echo "       Please adjust the original xml files such that the fpot msgid order aligns perfectly."; \
		echo "       You can use gnucash-docs-$*-english.fpot, gnucash-docs-$*-native.fpot"; \
		echo "       gnucash-docs-$*-english.struct and gnucash-docs-$*-native.struct in $(abs_top_builddir)/po"; \
		echo "       to help determine where the adjustments need to be made."; \
	fi

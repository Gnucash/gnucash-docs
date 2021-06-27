
dnl Same for xmlformat
dnl currently only for perl version, improve for ruby version
AC_PATH_PROGS(XMLFORMAT, [xmlformat.pl xmlformat.rb], [""])
if test -z "$XMLFORMAT"; then
  AC_MSG_WARN([xmlformat (.pl or .rb) - required for 'make format' - not found, perhaps you should install the xmlformat package or download it from http://www.kitebird.com/software/xmlformat?])
fi

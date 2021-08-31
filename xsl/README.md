# GnuCash Document XSLT Stylesheets

## XSLT Stylesheets
The gnucash-docs now use xslt stylesheets on the system. And there are some customization files
in this directory. But only images/ contents are left to make admonition and callout graphics
for convenience. See README, AUTHORS, COPYING in the images/ directory for their information.
Be careful about COPYING when changing files in in images/ directory.

DocBook XSLT 1.0 Stylesheets repository was moved from sourceforge.net to
https://github.com/docbook/xslt10-stylesheets.

## Gnucash-Specific Customization of XSLT Stylesheets
The new main structure is as follows:
```
gnc-custom-html.xsl --- gnc-custom-common.xsl ---------- OASIS html xsl --> HTML
                     |          ^                  |
gnc-custom-fo.xsl ---           |                   ---- OASIS FO xsl --> FO -> PDF
       ^                        |
       |                       common
       |                        guimenu.xsl
   format specific              emphasis.xsl
     gnc-titlepage-fo.xsl
     gnc-titlepage-html.xsl
```

The other formats and file names are in the same name scheme.

## GnuCash-Specific Icons
GnuCash-specific icon files should be put into icons/ directory. It is recommended to put both
SVG and PNG formats if exist.

GnuCash-specific icons are installed into the same directory of XSLT admonition icons. And if
their names conflict, GnuCash-specific icons take precedence.

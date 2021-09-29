<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>


<!--######################## Common Parameters ######################-->
<xsl:param name="admon.graphics">1</xsl:param>

<xsl:param name="callout.graphics.extension">.svg</xsl:param>

<xsl:param name="section.autolabel">1</xsl:param>
<xsl:param name="section.label.includes.component.label">1</xsl:param>

<xsl:param name="chunk.tocs.and.lots.has.title">0</xsl:param>


<!--######################## Files to Include ######################-->
<!-- This makes part title to be shown as "Part I. Basics", rather than "Basics" -->
<xsl:include href="parttitle.xsl"/>

<!-- Navigation Header and Footer customization. -->
<xsl:include href="navigation.xsl"/>

<!-- Bold fixed the application tag. -->
<xsl:include href="application.xsl"/>

<!-- Bold the emphasis tag. -->
<xsl:include href="emphasis.xsl"/>

<!-- Bold the guimenu|guisubmenu|guimenuitem|guilabel tag. -->
<xsl:include href="guimenu.xsl"/>

</xsl:stylesheet>

<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>

<!-- Importing the Norman Walsh's stylesheet as the basis. -->
<xsl:import href="1.79.2/fo/docbook.xsl"/>
<!-- see NOTE ABOUT PATHS in README file for details -->

<!--####################### PDF Parameters    ####################-->

<xsl:param name="fop1.extensions">1</xsl:param>
<xsl:param name="header.column.widths">1 4 1</xsl:param>

<!-- Underline the hyperlinks -->
<xsl:attribute-set name="xref.properties">
  <xsl:attribute name="text-decoration">underline</xsl:attribute>
</xsl:attribute-set>

<!-- Adjust verbatim elements -->
<xsl:attribute-set name="monospace.verbatim.properties" use-attribute-sets="verbatim.properties monospace.properties">
  <xsl:attribute name="font-size">9</xsl:attribute>
</xsl:attribute-set>
<xsl:param name="monospace.verbatim.font.width">0.30em</xsl:param>

<xsl:param name="generate.toc">
book      toc,title,figure,table,example,equation
</xsl:param>

<!-- Use A4 paper except lang equals C -->
<xsl:param name="paper.type">
  <xsl:choose>
    <xsl:when test="$gnc.lang = 'C'">USletter</xsl:when>
    <xsl:otherwise>A4</xsl:otherwise>
  </xsl:choose>
</xsl:param>

<!-- Admonition graphics and aligning title -->
<!-- Should graphics be included in admonitions? 0 or 1 -->
<xsl:param name="admon.graphics" select="1"/>

<!-- Specifies the default path and extension for admonition graphics -->
<xsl:param name="admon.graphics.path">../../stylesheet/</xsl:param>
<!-- <xsl:param name="admon.graphics.extension">.svg</xsl:param> -->

<!-- Adjust the admonition graphics, title and textblock -->
<xsl:template match="*" mode="admon.graphic.width">
  <xsl:text>24pt</xsl:text>
</xsl:template>
<xsl:attribute-set name="admonition.title.properties">
  <xsl:attribute name="font-size">
    <xsl:value-of select="$body.font.master * 1.2"/>
    <xsl:text>pt</xsl:text>
  </xsl:attribute>
  <xsl:attribute name="space-after.optimum">0.2em</xsl:attribute>
  <xsl:attribute name="space-after.minimum">0.0em</xsl:attribute>
  <xsl:attribute name="space-after.maximum">0.2em</xsl:attribute>
</xsl:attribute-set>
<xsl:attribute-set name="admonition.properties">
  <xsl:attribute name="space-before.optimum">0.0em</xsl:attribute>
  <xsl:attribute name="space-before.minimum">0.0em</xsl:attribute>
  <xsl:attribute name="space-before.maximum">0.0em</xsl:attribute>
  <xsl:attribute name="space-after.optimum">0.4em</xsl:attribute>
  <xsl:attribute name="space-after.minimum">0.2em</xsl:attribute>
  <xsl:attribute name="space-after.maximum">0.4em</xsl:attribute>
</xsl:attribute-set>
<xsl:attribute-set name="graphical.admonition.properties">
  <xsl:attribute name="space-before.optimum">0.6em</xsl:attribute>
  <xsl:attribute name="space-before.minimum">0.4em</xsl:attribute>
  <xsl:attribute name="space-before.maximum">0.8em</xsl:attribute>
  <xsl:attribute name="space-after.optimum">0.6em</xsl:attribute>
  <xsl:attribute name="space-after.minimum">0.4em</xsl:attribute>
  <xsl:attribute name="space-after.maximum">0.8em</xsl:attribute>
</xsl:attribute-set>

<!--####################### Files to Include  ####################-->

<!-- Change titlepage -->
<xsl:include href="fo-titlepage.xsl" />

<!-- Customize every lists -->
<xsl:include href="fo-lists.xsl"/>

<!--  GnuCash common customization for HTML, PDF and so on. -->
<!--  This must be the last entry   -->
<xsl:include href="gnc-custom-common.xsl" />

</xsl:stylesheet>

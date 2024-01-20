<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>

<!-- Importing the Norman Walsh's stylesheet as the basis. -->
<xsl:import href="1.79.2/fo/docbook.xsl"/>
<!-- see NOTE ABOUT PATHS in README file for details -->

<!--####################### PDF Parameters    ####################-->

<xsl:param name="fop1.extensions">1</xsl:param>
<xsl:param name="header.column.widths">1 4 1</xsl:param>

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

<!--####################### Files to Include  ####################-->

<!-- Change titlepage -->
<xsl:include href="fo-titlepage.xsl" />

<!-- Customize every lists -->
<xsl:include href="fo-lists.xsl"/>

<!--  GnuCash common customization for HTML, PDF and so on. -->
<!--  This must be the last entry   -->
<xsl:include href="gnc-custom-common.xsl" />

</xsl:stylesheet>

<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>

<!-- import stylesheet
    <xsl:import href="https://cdn.docbook.org/release/xsl/current/fo/docbook.xsl" />
    http://docbook.sourceforge.net/release/xsl/ is deprecated, but we have to
    use it for compatibility.
-->
<xsl:import href="http://docbook.sourceforge.net/release/xsl/current/fo/docbook.xsl" />

<!-- FO parameters for GnuCash docs. -->
<xsl:param name="fop1.extensions">1</xsl:param>
<xsl:param name="variablelist.as.blocks">1</xsl:param>
<xsl:param name="header.column.widths">1 4 1</xsl:param>
<xsl:param name="admon.graphics.extension">.svg</xsl:param>


<xsl:param name="generate.toc">
book      toc,title,figure,table,example,equation
</xsl:param>

<!-- Use A4 paper except lang equals C
  TODO: Move paper size settings to CMake option for GB and other countries.
 -->
<xsl:param name="paper.type">
  <xsl:choose>
    <xsl:when test="$gnc.lang = 'C'">USletter</xsl:when>
    <xsl:otherwise>A4</xsl:otherwise>
  </xsl:choose>
</xsl:param>


<!-- Change titlepage -->
<xsl:include href="titlepage-pdf.xsl" />

<!-- Bold variablelist/varlistentry/term -->
<xsl:include href="variablelist-pdf.xsl"/>

<!-- Set list spacing compact -->
<xsl:attribute-set name="list.item.spacing">
  <xsl:attribute name="space-before.optimum">0em</xsl:attribute>
  <xsl:attribute name="space-before.minimum">0em</xsl:attribute>
  <xsl:attribute name="space-before.maximum">0.2em</xsl:attribute>
</xsl:attribute-set>

<!--  GnuCash common customization for HTML, PDF and so on. -->
<xsl:include href="gnc-custom-common.xsl" />
</xsl:stylesheet>

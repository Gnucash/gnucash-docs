<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>


<!-- import stylesheet -->
<xsl:import href="../fo/docbook.xsl" />


<!-- PDF parameters for GnuCash docs. -->
<xsl:param name="fop1.extensions">1</xsl:param>
<xsl:param name="variablelist.as.blocks">1</xsl:param>
<xsl:param name="header.column.widths">1 4 1</xsl:param>


<xsl:param name="generate.toc">
appendix  nop
article/appendix  nop
article   nop
book      toc,title,figure,table,example,equation
chapter   nop
part      nop
preface   nop
qandadiv  nop
qandaset  nop
reference nop
sect1     nop
sect2     nop
sect3     nop
sect4     nop
sect5     nop
section   nop
set       nop
</xsl:param>


<!-- Use A4 paper except lang equals C -->
<xsl:param name="paper.type">
  <xsl:choose>
    <xsl:when test="$gnc.lang = 'C'">USletter</xsl:when>
    <xsl:otherwise>A4</xsl:otherwise>
  </xsl:choose>
</xsl:param>


<xsl:include href="gnc-titlepage-fo.xsl" />

<!--  GnuCash common customization for HTML, PDF and so on. -->
<xsl:include href="gnc-custom-common.xsl" />


<!--  GnuCash PDF specific customization files. -->
<!-- Bold variablelist/varlistentry/term -->
<xsl:include href="variablelist-fo.xsl"/>

</xsl:stylesheet>

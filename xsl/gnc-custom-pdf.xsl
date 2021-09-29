<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>

<!-- import stylesheet
    <xsl:import href="https://cdn.docbook.org/release/xsl/current/fo/docbook.xsl" />
    http://docbook.sourceforge.net/release/xsl/ is deprecated, but we have to
    use it for compatibility.
-->
<xsl:import href="http://docbook.sourceforge.net/release/xsl/current/fo/docbook.xsl" />

<!-- PDF parameters for GnuCash docs. -->
<xsl:param name="fop1.extensions">1</xsl:param>
<xsl:param name="variablelist.as.blocks">1</xsl:param>
<xsl:param name="header.column.widths">1 4 1</xsl:param>
<xsl:param name="admon.graphics.extension">.svg</xsl:param>


<xsl:param name="generate.toc">
book      toc,title,figure,table,example,equation
</xsl:param>


<!-- Change titlepage -->
<xsl:include href="titlepage-pdf.xsl" />

<!-- Bold variablelist/varlistentry/term -->
<xsl:include href="variablelist-pdf.xsl"/>

<!--  GnuCash common customization for HTML, PDF and so on. -->
<xsl:include href="gnc-custom-common.xsl" />
</xsl:stylesheet>

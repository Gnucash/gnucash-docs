<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>


<!-- import stylesheet 
    <xsl:import href="https://cdn.docbook.org/release/xsl/current/htmlhelp/htmlhelp.xsl" />
    http://docbook.sourceforge.net/release/xsl/ is deprecated, but we have to 
    use it for compatibility.
-->
<xsl:import href="http://docbook.sourceforge.net/release/xsl/current/htmlhelp/htmlhelp.xsl" />


<!-- parameters for GnuCash docs. -->
<xsl:param name="admon.graphics.extension">.png</xsl:param>
<xsl:param name="callout.graphics.extension">.png</xsl:param>

<xsl:param name="htmlhelp.default.topic">ch01.html</xsl:param>

<xsl:param name="generate.toc">
book      nop
</xsl:param>

<!-- language specific character code for wchar
     ja: Shift_JIS
     ru: KOI8-R
-->

<xsl:param name="htmlhelp.encoding">
  <xsl:choose>
    <xsl:when test="$gnc.lang = 'ja'">Shift_JIS</xsl:when>
    <xsl:when test="$gnc.lang = 'ru'">KOI8-R</xsl:when>
    <xsl:otherwise>ISO-8859-1</xsl:otherwise>
  </xsl:choose>
</xsl:param>

<xsl:param name="chunker.output.encoding">
  <xsl:choose>
    <xsl:when test="$gnc.lang = 'ja'">Shift_JIS</xsl:when>
    <xsl:when test="$gnc.lang = 'ru'">KOI8-R</xsl:when>
    <xsl:otherwise>ISO-8859-1</xsl:otherwise>
  </xsl:choose>
</xsl:param>



 
<!--  GnuCash common customization for HTML, PDF and so on. -->
<xsl:include href="gnc-custom-common.xsl" />

<!-- GnuCash HTML titlepage 
mingw32 xslt is buggy and I give up to customize titilepage.
<xsl:include href="gnc-titlepage-chm.xsl" />
-->


<!-- Bold variablelist/varlistentry/term -->
<xsl:include href="variablelist-html.xsl"/>


<!--  GnuCash chm specific customization files. -->




</xsl:stylesheet>

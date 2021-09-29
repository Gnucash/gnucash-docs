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


<!--  GnuCash common customization for HTML, PDF and so on. -->
<xsl:include href="gnc-custom-common.xsl" />
</xsl:stylesheet>

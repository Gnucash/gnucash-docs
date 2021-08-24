<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>


<!-- import stylesheet 
    <xsl:import href="https://cdn.docbook.org/release/xsl/current/epub/docbook.xsl" />
    http://docbook.sourceforge.net/release/xsl/ is deprecated, but we have to 
    use it for compatibility.
-->
<xsl:import href="http://docbook.sourceforge.net/release/xsl/current/epub/docbook.xsl" />


<!-- ePub parameters for GnuCash docs. -->



 
<!--  GnuCash common customization for HTML, PDF and so on. -->
<xsl:include href="gnc-custom-common.xsl" />

<!-- Bold variablelist/varlistentry/term -->
<xsl:include href="variablelist-html.xsl"/>


<!--  GnuCash ePub specific customization files. -->
<xsl:include href="gnc-titlepage-html.xsl" />



</xsl:stylesheet>

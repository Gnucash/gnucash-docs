<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>


<!-- import stylesheet -->
<xsl:import href="../htmlhelp/htmlhelp.xsl" />


<!-- parameters for GnuCash docs. -->

<xsl:param name="admon.graphics.extension">.png</xsl:param>
 
<!--  GnuCash common customization for HTML, PDF and so on. -->
<xsl:include href="gnc-custom-common.xsl" />

<!-- Bold variablelist/varlistentry/term -->
<xsl:include href="variablelist-html.xsl"/>


<!--  GnuCash chm specific customization files. -->




</xsl:stylesheet>

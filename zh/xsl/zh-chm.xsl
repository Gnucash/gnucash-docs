<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'
                xmlns="http://www.w3.org/TR/xhtml1/transitional"
                exclude-result-prefixes="#default">

<!-- Importing the base stylesheet. -->
<xsl:import href="../../xsl/gnc-custom-chm.xsl"/>

<!-- charset -->
<xsl:param name="htmlhelp.encoding">gbk</xsl:param>
<xsl:param name="javahelp.encoding">gbk</xsl:param>

<!-- <xsl:param name="default.encoding" select="'gbk'" doc:type='string'/> -->
<xsl:param name="chunker.output.encoding" select="'gbk'"/>
<xsl:output encoding="gbk" indent="no"/>

</xsl:stylesheet>

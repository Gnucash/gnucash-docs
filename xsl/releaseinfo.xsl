<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'
                xmlns="http://www.w3.org/TR/xhtml1/transitional"
                exclude-result-prefixes="#default">

<!-- ***************************Releaseinfo*********************-->

<!-- Custom template to make the releaseinfo tag italicized. -->
<xsl:template match="releaseinfo" mode="titlepage.mode">
  <p class="{name(.)}"><i>
  <xsl:apply-templates mode="titlepage.mode"/>
  </i></p>
</xsl:template>

</xsl:stylesheet>
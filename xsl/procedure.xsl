<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'
                xmlns="http://www.w3.org/TR/xhtml1/transitional"
                exclude-result-prefixes="#default">

<!-- *******************************Procedure*******************-->

<xsl:param name="formal.procedures">
  <xsl:if test="procedure[@role='informal']">
    <xsl:text>0</xsl:text>
  </xsl:if>
</xsl:param>

</xsl:stylesheet>




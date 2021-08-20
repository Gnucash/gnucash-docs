<?xml version='1.0'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                		xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:xlink='http://www.w3.org/1999/xlink'
                exclude-result-prefixes="xlink"
                version='1.0'>

<!-- ***************************Variablelist********************-->

<!-- Custom template to make the term tag bold.-->
<xsl:template match="varlistentry/term">
  <fo:inline font-weight="bold">
    <xsl:call-template name="anchor"/>
    <xsl:call-template name="simple.xlink">
      <xsl:with-param name="content">
        <xsl:apply-templates/>
      </xsl:with-param>
    </xsl:call-template>
  </fo:inline>
  <xsl:choose>
    <xsl:when test="not(following-sibling::term)"/> <!-- do nothing -->
    <xsl:otherwise>
      <!-- * if we have multiple terms in the same varlistentry, generate -->
      <!-- * a separator (", " by default) and/or an additional line -->
      <!-- * break after each one except the last -->
      <fo:inline><xsl:value-of select="$variablelist.term.separator"/></fo:inline>
      <xsl:if test="not($variablelist.term.break.after = '0')">
        <fo:block/>
      </xsl:if>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>
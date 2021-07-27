<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>

<!-- ***************************Variablelist********************-->

<!-- Custom template to make the term tag bold.-->
<xsl:template match="varlistentry/term">
  <span><strong>
    <xsl:call-template name="common.html.attributes"/>
    <xsl:call-template name="id.attribute"/>
    <xsl:call-template name="anchor"/>
    <xsl:call-template name="simple.xlink">
      <xsl:with-param name="content">
        <xsl:apply-templates/>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:choose>
      <xsl:when test="position() = last()"/> <!-- do nothing -->
      <xsl:otherwise>
        <!-- * if we have multiple terms in the same varlistentry, generate -->
        <!-- * a separator (", " by default) and/or an additional line -->
        <!-- * break after each one except the last -->
        <xsl:value-of select="$variablelist.term.separator"/>
        <xsl:if test="not($variablelist.term.break.after = '0')">
          <br/>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </strong></span>
</xsl:template>

</xsl:stylesheet>
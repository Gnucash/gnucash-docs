<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
                version='1.0'
                xmlns="http://www.w3.org/TR/xhtml1/transitional"
                exclude-result-prefixes="#default">

<!--******************************Admonitions*******************-->

<!--********************************Variables*******************-->

<!-- Should graphics be included in admonitions? 0 or 1 -->
<xsl:param name="admon.graphics" select="1"/>

<!-- Specifies the default path for admonition graphics -->
<xsl:param name="admon.graphics.path">./stylesheet/</xsl:param>

<!-- Specifies the default graphic file if none is given. -->
<xsl:param name="graphic.default.extension" select="'png'" doc:type="string"/>

<!--*******************************Templates********************-->

<!-- Moves the title just to the right of the admonition graphic. -->
<xsl:template name="graphical.admonition">
  <div class="{name(.)}">
  <xsl:if test="$admon.style != ''">
    <xsl:attribute name="style">
      <xsl:value-of select="$admon.style"/>
    </xsl:attribute>
  </xsl:if>
  <table border="0">
    <tr>
      <td rowspan="2" align="center" valign="top">
        <xsl:attribute name="width">
          <xsl:apply-templates select="." mode="admon.graphic.width"/>
        </xsl:attribute>
        <img>
          <xsl:attribute name="src">
            <xsl:call-template name="admon.graphic"/>
          </xsl:attribute>
        </img>
      </td>
      <th align="left" valign="top">
        <xsl:call-template name="anchor"/>
        <xsl:apply-templates select="." mode="object.title.markup"/>
      </th>
    </tr>
    <tr>
      <td colspan="2" align="left" valign="top">
        <xsl:apply-templates/>
      </td>
    </tr>
  </table>
  </div>
</xsl:template>

</xsl:stylesheet>
<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exsl="http://exslt.org/common"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:ng="http://docbook.org/docbook-ng"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns:math="http://exslt.org/math"
                exclude-result-prefixes="db ng exsl"
                version='1.0'>

<!-- Importing the base stylesheet. -->
<xsl:import href="../../xsl/gnc-custom-html.xsl"/>

<xsl:template match="imagedata[@screenshot-physicalwidth]">
  <xsl:variable name="maxwidth">
    <xsl:value-of select="10" />
  </xsl:variable>
  <xsl:variable name="scalefactor">
    <xsl:value-of select="0.82" />
  </xsl:variable>
  <xsl:variable name="physicalwidth">
    <xsl:value-of select="number(substring-before(@screenshot-physicalwidth, 'in'))" />
  </xsl:variable>
  <xsl:variable name="preferredwidth">
    <xsl:choose>
      <xsl:when test="$physicalwidth * $scalefactor > $maxwidth">
        <xsl:value-of select="$maxwidth" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$physicalwidth * $scalefactor" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="fragnode">
    <fragment>
      <imagedata>
        <xsl:copy-of select="@*[not(name(.) = 'screenshot-physicalwidth')]"/>
        <xsl:attribute name="contentwidth">
          <xsl:value-of select="concat(string($preferredwidth), 'in')" />
        </xsl:attribute>
      </imagedata>
    </fragment>
  </xsl:variable>
  <xsl:apply-templates select="exsl:node-set($fragnode)/*[1]"/>
</xsl:template>

<xsl:template match="fragment">
  <xsl:apply-templates />
</xsl:template>

</xsl:stylesheet>

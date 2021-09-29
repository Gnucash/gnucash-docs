<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- This makes part title to be shown as "Part I. Basics", rather
      than "Basics" -->


<xsl:template match="part/title" mode="titlepage.mode" priority="2">
  <xsl:call-template name="component.title">
    <xsl:with-param name="node" select="ancestor::part[1]"/>
  </xsl:call-template>
</xsl:template>

</xsl:stylesheet>

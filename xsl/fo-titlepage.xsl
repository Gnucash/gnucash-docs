<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exsl="http://exslt.org/common"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="exsl"
                version="1.0">

<!-- This stylesheet was created by template/titlepage.xsl-->

<xsl:template name="book.titlepage.recto">

  <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="bookinfo/title"/>

  <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="bookinfo/edition"/>

  <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="bookinfo//revision[1]/date"/>

  <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="bookinfo/authorgroup"/>
</xsl:template>


<xsl:attribute-set name="book.titlepage.recto.style">
  <xsl:attribute name="font-family">
    <xsl:value-of select="$title.fontset"/>
  </xsl:attribute>
  <xsl:attribute name="font-weight">bold</xsl:attribute>
  <xsl:attribute name="font-size">24pt</xsl:attribute>
  <xsl:attribute name="text-align">center</xsl:attribute>
</xsl:attribute-set>

<xsl:template match="title" mode="book.titlepage.recto.auto.mode">
    <fo:inline font-weight="bold" font-size="24pt" text-align="center">
    <fo:external-graphic width="auto" height="auto" content-width="24pt" src="url(../../stylesheet/gnucash-icon.png)"/>
    <xsl:call-template name="gentext.space"/>
    <xsl:apply-templates mode="book.titlepage.recto.style"/>
    </fo:inline>
</xsl:template>


<xsl:template match="edition" mode="book.titlepage.recto.auto.mode">
<fo:block xsl:use-attribute-sets="article.titlepage.recto.style" space-before="5em">
  <xsl:attribute name="font-size">20pt</xsl:attribute>
  <xsl:attribute name="text-align">center</xsl:attribute>
  <xsl:call-template name="gentext">
    <xsl:with-param name="key" select="'Revision'"/>
  </xsl:call-template>
  <xsl:call-template name="gentext.space"/>
  <xsl:text>:</xsl:text>
  <xsl:call-template name="gentext.space"/>
  <xsl:apply-templates mode="titlepage.mode"/>
</fo:block>
</xsl:template>

<xsl:template match="date" mode="book.titlepage.recto.auto.mode">
<fo:block xsl:use-attribute-sets="article.titlepage.recto.style" space-before="5em">
  <xsl:attribute name="font-size">20pt</xsl:attribute>
  <xsl:attribute name="text-align">center</xsl:attribute>
  <xsl:call-template name="gentext">
    <xsl:with-param name="key" select="'pubdate'"/>
  </xsl:call-template>
  <xsl:call-template name="gentext.space"/>
  <xsl:text>:</xsl:text>
  <xsl:call-template name="gentext.space"/>
  <xsl:apply-templates mode="titlepage.mode"/>
</fo:block>
</xsl:template>


</xsl:stylesheet>

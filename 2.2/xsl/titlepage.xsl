<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- This stylesheet was created by template/titlepage.xsl; do not edit it by hand. -->


  

<xsl:template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="book.titlepage.recto">
    
  <xsl:choose xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:when xmlns:xsl="http://www.w3.org/1999/XSL/Transform" test="bookinfo/title">
      <xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" mode="book.titlepage.recto.auto.mode" select="bookinfo/title"/>
    </xsl:when>
    <xsl:when xmlns:xsl="http://www.w3.org/1999/XSL/Transform" test="title">
      <xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" mode="book.titlepage.recto.auto.mode" select="title"/>
    </xsl:when>
  </xsl:choose>

    
  <xsl:choose xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:when xmlns:xsl="http://www.w3.org/1999/XSL/Transform" test="bookinfo/subtitle">
      <xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" mode="book.titlepage.recto.auto.mode" select="bookinfo/subtitle"/>
    </xsl:when>
    <xsl:when xmlns:xsl="http://www.w3.org/1999/XSL/Transform" test="subtitle">
      <xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" mode="book.titlepage.recto.auto.mode" select="subtitle"/>
    </xsl:when>
  </xsl:choose>

    
  <xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" mode="book.titlepage.recto.auto.mode" select="bookinfo/authorgroup"/>
    
  <xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" mode="book.titlepage.recto.auto.mode" select="bookinfo/author"/>
    
  <xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" mode="book.titlepage.recto.auto.mode" select="bookinfo/publisher"/>
	
  <xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" mode="book.titlepage.recto.auto.mode" select="bookinfo/copyright"/>
    
  <xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" mode="book.titlepage.recto.auto.mode" select="bookinfo/legalnotice"/>
    
  <xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" mode="book.titlepage.recto.auto.mode" select="bookinfo/revhistory"/>
    
  <xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" mode="book.titlepage.recto.auto.mode" select="bookinfo/revision"/>
    
  <xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" mode="book.titlepage.recto.auto.mode" select="bookinfo/releaseinfo"/>
  
</xsl:template>
    
    
    
    
    
	
    
    
    
    
  

  

<xsl:template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="book.titlepage.verso">
  
</xsl:template>
  

  

<xsl:template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="book.titlepage.separator">
  
</xsl:template>

  

<xsl:template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="book.titlepage.before.recto">
  
</xsl:template>

  

<xsl:template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="book.titlepage.before.verso">
    <img align="left" src="stylesheet/gnucash-icon.png" alt="GnuCash Logo"/>
  
</xsl:template>


<xsl:template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="book.titlepage">
  <div class="titlepage">
    <xsl:call-template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="book.titlepage.before.recto"/>
    <xsl:call-template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="book.titlepage.recto"/>
    <xsl:call-template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="book.titlepage.before.verso"/>
    <xsl:call-template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="book.titlepage.verso"/>
    <xsl:call-template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="book.titlepage.separator"/>
  </div>
</xsl:template>

<xsl:template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" match="*" mode="book.titlepage.recto.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" match="*" mode="book.titlepage.verso.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" match="title" mode="book.titlepage.recto.auto.mode">
<div use-attribute-sets="book.titlepage.recto.style">
<xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" select="." mode="book.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" match="subtitle" mode="book.titlepage.recto.auto.mode">
<div use-attribute-sets="book.titlepage.recto.style">
<xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" select="." mode="book.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" match="authorgroup" mode="book.titlepage.recto.auto.mode">
<div use-attribute-sets="book.titlepage.recto.style">
<xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" select="." mode="book.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" match="author" mode="book.titlepage.recto.auto.mode">
<div use-attribute-sets="book.titlepage.recto.style">
<xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" select="." mode="book.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" match="publisher" mode="book.titlepage.recto.auto.mode">
<div use-attribute-sets="book.titlepage.recto.style">
<xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" select="." mode="book.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" match="copyright" mode="book.titlepage.recto.auto.mode">
<div use-attribute-sets="book.titlepage.recto.style">
<xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" select="." mode="book.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" match="legalnotice" mode="book.titlepage.recto.auto.mode">
<div use-attribute-sets="book.titlepage.recto.style">
<xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" select="." mode="book.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" match="revhistory" mode="book.titlepage.recto.auto.mode">
<div use-attribute-sets="book.titlepage.recto.style">
<xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" select="." mode="book.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" match="revision" mode="book.titlepage.recto.auto.mode">
<div use-attribute-sets="book.titlepage.recto.style">
<xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" select="." mode="book.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" match="releaseinfo" mode="book.titlepage.recto.auto.mode">
<div use-attribute-sets="book.titlepage.recto.style">
<xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" select="." mode="book.titlepage.recto.mode"/>
</div>
</xsl:template>


  

<xsl:template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="article.titlepage.recto">
    
  <xsl:choose xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:when xmlns:xsl="http://www.w3.org/1999/XSL/Transform" test="articleinfo/title">
      <xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" mode="article.titlepage.recto.auto.mode" select="articleinfo/title"/>
    </xsl:when>
    <xsl:when xmlns:xsl="http://www.w3.org/1999/XSL/Transform" test="artheader/title">
      <xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" mode="article.titlepage.recto.auto.mode" select="artheader/title"/>
    </xsl:when>
    <xsl:when xmlns:xsl="http://www.w3.org/1999/XSL/Transform" test="title">
      <xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" mode="article.titlepage.recto.auto.mode" select="title"/>
    </xsl:when>
  </xsl:choose>

    
  <xsl:choose xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:when xmlns:xsl="http://www.w3.org/1999/XSL/Transform" test="articleinfo/subtitle">
      <xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" mode="article.titlepage.recto.auto.mode" select="articleinfo/subtitle"/>
    </xsl:when>
    <xsl:when xmlns:xsl="http://www.w3.org/1999/XSL/Transform" test="artheader/subtitle">
      <xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" mode="article.titlepage.recto.auto.mode" select="artheader/subtitle"/>
    </xsl:when>
    <xsl:when xmlns:xsl="http://www.w3.org/1999/XSL/Transform" test="subtitle">
      <xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" mode="article.titlepage.recto.auto.mode" select="subtitle"/>
    </xsl:when>
  </xsl:choose>

    
  <xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" mode="article.titlepage.recto.auto.mode" select="articleinfo/authorgroup"/>
  <xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" mode="article.titlepage.recto.auto.mode" select="artheader/authorgroup"/>
    
  <xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" mode="article.titlepage.recto.auto.mode" select="articleinfo/author"/>
  <xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" mode="article.titlepage.recto.auto.mode" select="artheader/author"/>
    
  <xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" mode="article.titlepage.recto.auto.mode" select="articleinfo/publisher"/>
  <xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" mode="article.titlepage.recto.auto.mode" select="artheader/publisher"/>
	
  <xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" mode="article.titlepage.recto.auto.mode" select="articleinfo/copyright"/>
  <xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" mode="article.titlepage.recto.auto.mode" select="artheader/copyright"/>
    
  <xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" mode="article.titlepage.recto.auto.mode" select="articleinfo/legalnotice"/>
  <xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" mode="article.titlepage.recto.auto.mode" select="artheader/legalnotice"/>
    
  <xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" mode="article.titlepage.recto.auto.mode" select="articleinfo/revhistory"/>
  <xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" mode="article.titlepage.recto.auto.mode" select="artheader/revhistory"/>
    
  <xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" mode="article.titlepage.recto.auto.mode" select="articleinfo/revision"/>
  <xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" mode="article.titlepage.recto.auto.mode" select="artheader/revision"/>
    
  <xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" mode="article.titlepage.recto.auto.mode" select="articleinfo/releaseinfo"/>
  <xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" mode="article.titlepage.recto.auto.mode" select="artheader/releaseinfo"/>
  
</xsl:template>
    
    
    
    
    
	
    
    
    
    
  

  

<xsl:template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="article.titlepage.verso">
  
</xsl:template>
  

  

<xsl:template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="article.titlepage.separator">
  
</xsl:template>

  

<xsl:template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="article.titlepage.before.recto">
  
</xsl:template>

  

<xsl:template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="article.titlepage.before.verso">
    <img align="left" src="stylesheet/gnucash-icon.png" alt="GnuCash Logo"/>
  
</xsl:template>


<xsl:template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="article.titlepage">
  <div class="titlepage">
    <xsl:call-template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="article.titlepage.before.recto"/>
    <xsl:call-template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="article.titlepage.recto"/>
    <xsl:call-template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="article.titlepage.before.verso"/>
    <xsl:call-template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="article.titlepage.verso"/>
    <xsl:call-template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="article.titlepage.separator"/>
  </div>
</xsl:template>

<xsl:template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" match="*" mode="article.titlepage.recto.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" match="*" mode="article.titlepage.verso.mode">
  <!-- if an element isn't found in this mode, -->
  <!-- try the generic titlepage.mode -->
  <xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" select="." mode="titlepage.mode"/>
</xsl:template>

<xsl:template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" match="title" mode="article.titlepage.recto.auto.mode">
<div use-attribute-sets="article.titlepage.recto.style">
<xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" select="." mode="article.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" match="subtitle" mode="article.titlepage.recto.auto.mode">
<div use-attribute-sets="article.titlepage.recto.style">
<xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" select="." mode="article.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" match="authorgroup" mode="article.titlepage.recto.auto.mode">
<div use-attribute-sets="article.titlepage.recto.style">
<xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" select="." mode="article.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" match="author" mode="article.titlepage.recto.auto.mode">
<div use-attribute-sets="article.titlepage.recto.style">
<xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" select="." mode="article.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" match="publisher" mode="article.titlepage.recto.auto.mode">
<div use-attribute-sets="article.titlepage.recto.style">
<xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" select="." mode="article.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" match="copyright" mode="article.titlepage.recto.auto.mode">
<div use-attribute-sets="article.titlepage.recto.style">
<xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" select="." mode="article.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" match="legalnotice" mode="article.titlepage.recto.auto.mode">
<div use-attribute-sets="article.titlepage.recto.style">
<xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" select="." mode="article.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" match="revhistory" mode="article.titlepage.recto.auto.mode">
<div use-attribute-sets="article.titlepage.recto.style">
<xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" select="." mode="article.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" match="revision" mode="article.titlepage.recto.auto.mode">
<div use-attribute-sets="article.titlepage.recto.style">
<xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" select="." mode="article.titlepage.recto.mode"/>
</div>
</xsl:template>

<xsl:template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" match="releaseinfo" mode="article.titlepage.recto.auto.mode">
<div use-attribute-sets="article.titlepage.recto.style">
<xsl:apply-templates xmlns:xsl="http://www.w3.org/1999/XSL/Transform" select="." mode="article.titlepage.recto.mode"/>
</div>
</xsl:template>


</xsl:stylesheet>

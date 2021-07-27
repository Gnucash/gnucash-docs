<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'
                xmlns="http://www.w3.org/TR/xhtml1/transitional"
                exclude-result-prefixes="#default">

<!-- *****************************Legalnotice*******************-->

<!-- Puts a link on the title page to each legalnotice. -->
<xsl:param name="generate.legalnotice.link" select="0"/>

<xsl:template match="legalnotice[1]" mode="titlepage.mode">
  <xsl:text>&#xA;</xsl:text>
  <h2>
  <xsl:call-template name="gentext">
    <xsl:with-param name="key" select="'legalnotice'"/>
  </xsl:call-template>
  </h2>
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<!-- Makes the address inside the legalnotice inline instead of separated 
  	 from the body of the text.-->
<xsl:template match="legalnotice//address">
  <xsl:param name="suppress-numbers" select="'0'"/>
  <xsl:variable name="vendor" select="system-property('xsl:vendor')"/>

  <xsl:variable name="rtf">
    <xsl:apply-templates mode="inline-address"/>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="$suppress-numbers = '0'
                    and @linenumbering = 'numbered'
                    and $use.extensions != '0'
                    and $linenumbering.extension != '0'">
          <xsl:call-template name="number.rtf.lines">
            <xsl:with-param name="rtf" select="$rtf"/>
          </xsl:call-template>
    </xsl:when>

    <xsl:otherwise>
          <xsl:apply-templates mode="inline-address"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- Added a comma after the street, city and postal code. -->
<xsl:template match="street|city|postcode" mode="inline-address">
  <xsl:apply-templates mode="inline-address"/>
  <xsl:text>, </xsl:text>
</xsl:template>

<xsl:template match="state|country" mode="inline-address">   
  <xsl:apply-templates mode="inline-address"/>
</xsl:template>


<xsl:template match="legalnotice/title" mode="titlepage.mode">
  <h2><xsl:apply-templates/></h2>
</xsl:template>


</xsl:stylesheet>

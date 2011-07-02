<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
                version='1.0'
                xmlns="http://www.w3.org/TR/xhtml1/transitional"
                exclude-result-prefixes="#default">

<!-- **************************Copyright*************************-->

<!-- Makes the copyright years appear as a range. -->
<xsl:param name="make.year.ranges" select="1" doc:type="boolean"/>

<xsl:template match="copyright[1]" mode="titlepage.mode">

  <div class="{name(.)}">
    <h2>
	  <xsl:call-template name="gentext">
	    <xsl:with-param name="key" select="'Copyright'"/>
	  </xsl:call-template>
	</h2>

    <p class="{name(.)}">
      <xsl:call-template name="gentext">
	    <xsl:with-param name="key" select="'Copyright'"/>
	  </xsl:call-template>
	  <xsl:call-template name="gentext.space"/>
	  <xsl:call-template name="dingbat">
	    <xsl:with-param name="dingbat">copyright</xsl:with-param>
	  </xsl:call-template>
	  <xsl:call-template name="gentext.space"/>
	  <xsl:call-template name="copyright.years">
	    <xsl:with-param name="years" select="year"/>
		<xsl:with-param name="print.ranges" select="$make.year.ranges"/>
		<xsl:with-param name="single.year.ranges"
						select="$make.single.year.ranges"/>
	  </xsl:call-template>
	  <xsl:call-template name="gentext.space"/>
	  <xsl:apply-templates select="holder" mode="titlepage.mode"/>
	</p>
  </div>

</xsl:template>

</xsl:stylesheet>
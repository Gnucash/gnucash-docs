<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>

<!-- ****************************Publisher********************-->

<xsl:template match="publisher[1]" mode="titlepage.mode">

  <div class="{name(.)}">
    <h2>
	  <xsl:call-template name="gentext">
	    <xsl:with-param name="key" select="'Publisher'"/>
	  </xsl:call-template>
	</h2>
	
	<xsl:apply-templates mode="titlepage.mode"/>
  </div>
  
</xsl:template>

</xsl:stylesheet>
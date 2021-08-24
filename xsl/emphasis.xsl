<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>

<!-- ****************************Emphasis************************-->

<!-- Custom template to make the emphasis tag bold the text instead of 
	 the text be italicized. -->
<xsl:template match="emphasis">
  <xsl:call-template name="inline.boldseq"/>
</xsl:template>

</xsl:stylesheet>
<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'
                xmlns="http://www.w3.org/TR/xhtml1/transitional"
                exclude-result-prefixes="#default">

<!-- ****************************Emphasis************************-->

<!-- Custom template to make the application tag bold fixed width -->
<xsl:template match="application">
  <xsl:call-template name="inline.boldmonoseq"/>
</xsl:template>

</xsl:stylesheet>
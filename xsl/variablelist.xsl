<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'
                xmlns="http://www.w3.org/TR/xhtml1/transitional"
                exclude-result-prefixes="#default">

<!-- ***************************Variablelist********************-->

<!-- Custom template to make the term tag bold.-->
<xsl:template match="variablelist//term">
  <xsl:call-template name="inline.boldseq"/>
</xsl:template>

</xsl:stylesheet>
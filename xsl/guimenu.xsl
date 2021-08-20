<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'
                xmlns="http://www.w3.org/TR/xhtml1/transitional"
                exclude-result-prefixes="#default">

<!-- ****************************Emphasis************************-->

<!-- Custom template to make the guimenu, guisubmenu, guimenuitem and guilabel
	 tags bold the text. -->

	 <xsl:template match="guimenu|guisubmenu|guimenuitem|guilabel">
	 <xsl:call-template name="inline.boldseq"/> </xsl:template>

</xsl:stylesheet>
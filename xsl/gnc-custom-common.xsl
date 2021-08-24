<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>


<!-- Common Parameters -->
<xsl:param name="admon.graphics">1</xsl:param>
<!-- If you prefer png, commint out below. -->
<xsl:param name="callout.graphics.extension">.svg</xsl:param>

<xsl:param name="section.autolabel">1</xsl:param>
<xsl:param name="section.label.includes.component.label">1</xsl:param>

<xsl:param name="chunk.tocs.and.lots.has.title">0</xsl:param>



<!--########################Files to Include######################-->



<!-- This makes part title to be shown as "Part I. Basics", rather
      than "Basics" --> 
<xsl:include href="parttitle.xsl"/>


<!-- Navigation Header and Footer customization. -->
<xsl:include href="navigation.xsl"/>

<!-- Outputs Author (s):. -->
<!-- 
<xsl:include href="author.xsl"/>
 -->
 
<!-- Change presentation of othercredit. -->
<!-- 
<xsl:include href="othercredit.xsl"/>
 -->
<!-- Adds inline addresses inside the legalnotice. -->
<!-- 
<xsl:include href="legalnotice.xsl"/>
 -->
<!-- Italicizes the <sgmltag>releaseinfo</sgmltag>. -->
<!-- 
<xsl:include href="releaseinfo.xsl"/>
 -->
 
<!-- Bold fixed the application tag. -->
<xsl:include href="application.xsl"/>
 
<!-- Bold the emphasis tag. -->
<xsl:include href="emphasis.xsl"/>
 
<!-- Bold the guimenu|guisubmenu|guimenuitem|guilabel tag. -->
<xsl:include href="guimenu.xsl"/>

 
<!-- Adds an informal procedure. -->
<!-- <xsl:include href="procedure.xsl"/>
 -->
 
<!-- Glossary customization. -->
<!-- 
<xsl:include href="glossary.xsl"/>
 -->

</xsl:stylesheet>

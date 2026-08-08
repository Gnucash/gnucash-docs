<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>

<!--####################### Common Parameters ####################-->


<!--####################### Files to Include  ####################-->

<!-- Bolds the <sgmltag>application</sgmltag>. -->
<xsl:include href="application.xsl"/>

<!-- Bolds the <sgmltag>emphasis</sgmltag>. -->
<xsl:include href="emphasis.xsl"/>

<!-- Bolds the <sgmltag>guimenu</sgmltag>. -->
<xsl:include href="guimenu.xsl"/>

<!-- Navigation Header and Footer customization. -->
<xsl:include href="navigation.xsl"/>

<!-- This makes part title to be shown as "Part I. Basics", rather than "Basics" --> 
<xsl:include href="parttitle.xsl"/>

</xsl:stylesheet>

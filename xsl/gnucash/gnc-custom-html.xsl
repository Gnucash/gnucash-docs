<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>


<!-- import stylesheet -->
<xsl:import href="../html/chunk.xsl" />


<!-- HTML parameters for GnuCash docs. -->
<xsl:param name="chunker.output.encoding">UTF-8</xsl:param>
<xsl:param name="use.id.as.filename">1</xsl:param>
 
<xsl:param name="default.image.width">510px</xsl:param>
<xsl:param name="link.to.self.for.mediaobject">1</xsl:param>



<xsl:param name="generate.toc">
appendix  nop
article/appendix  nop
article   nop
book      toc,title,figure,table,example,equation
chapter   nop
part      toc,title
preface   title
qandadiv  nop
qandaset  nop
reference nop
sect1     nop
sect2     nop
sect3     nop
sect4     nop
sect5     nop
section   nop
set       nop
</xsl:param>

<!-- Use CSS -->
<!-- <xsl:param name="make.clean.html">1</xsl:param> -->

<xsl:param name="chunk.first.sections">0</xsl:param>

<!-- Create HTML file per chapter. Set 0 makes translation easy. Default is 1.-->
<xsl:param name="chunk.section.depth">0</xsl:param>

<!-- Create large HTML file. -->
<xsl:param name="onechunk">0</xsl:param>

 
<!--  GnuCash common customization for HTML, PDF and so on. -->
<xsl:include href="gnc-custom-common.xsl" />

<!-- GnuCash HTML titlepage -->
<xsl:include href="gnc-titlepage-html.xsl" />

<!-- Bold variablelist/varlistentry/term -->
<xsl:include href="variablelist-html.xsl"/>


<!--  GnuCash HTML specific customization files. -->




</xsl:stylesheet>

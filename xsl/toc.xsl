<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
                version='1.0'
                xmlns="http://www.w3.org/TR/xhtml1/transitional"
                exclude-result-prefixes="#default">

<!--**************************TOC*********************************-->

<!-- Should books have a TOC? 0 or 1 -->
<xsl:param name="generate.book.toc" select="1" doc:type="boolean"/>

<!-- Should articles have a TOC? 0 or 1 -->
<xsl:param name="generate.article.toc" select="1" doc:type="boolean"/>

<!-- Should parts have a TOC? 0 or 1 -->
<xsl:param name="generate.part.toc" select="1" doc:type="boolean"/>

<!-- Should chapters be labeled? 0 or 1 -->
<xsl:param name="chapter.autolabel" select="1" doc:type="boolean"/>

<!-- Should sections be labeled? 0 or 1 -->
<xsl:param name="section.autolabel" select="1" doc:type ="boolean"/>

<!-- Related to section labels, should those labels include the chapter
     number in them (i.e., 1.1, 1.2, 1.3, 1.4 ) -->
<xsl:param name="section.label.includes.component.label" select="1" doc:type="boolean"/>

<!-- Makes the id as the filename for each chunk. -->
<xsl:param name="use.id.as.filename" select="1" doc:type='boolean'/>

<!-- Should the first section have its own chunk? 0 or 1 -->
<xsl:param name="chunk.first.sections" select ="1"/>

<!-- This template is called from book/part toc.
     We commented out "subtoc" stuff. As a result, book/part tocs only
     contain chapters /appendices/prefaces, but not sect*. -->

<xsl:template match="preface|chapter|appendix|article" mode="toc">

<!--  <xsl:variable name="subtoc">
    <xsl:element name="{$toc.list.type}">
      <xsl:apply-templates select="section|sect1|bridgehead" mode="toc"/>
    </xsl:element>
  </xsl:variable>

  <xsl:variable name="subtoc.list">
    <xsl:choose>
      <xsl:when test="$toc.dd.type = ''">
        <xsl:copy-of select="$subtoc"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:element name="{$toc.dd.type}">
          <xsl:copy-of select="$subtoc"/>
        </xsl:element>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable> -->

  <xsl:element name="{$toc.listitem.type}">
    <xsl:variable name="label">
      <xsl:apply-templates select="." mode="label.markup"/>
    </xsl:variable>
    <xsl:copy-of select="$label"/>
    <xsl:if test="$label != ''">
      <xsl:value-of select="$autotoc.label.separator"/>
    </xsl:if>
    <a>
      <xsl:attribute name="href">
        <xsl:call-template name="href.target"/>
      </xsl:attribute>
      <xsl:apply-templates select="." mode="title.markup"/>
    </a>
<!--    <xsl:if test="$toc.listitem.type = 'li'
                  and $toc.section.depth>0 and section|sect1">
      <xsl:copy-of select="$subtoc.list"/>
    </xsl:if> -->
  </xsl:element>
<!--  <xsl:if test="$toc.listitem.type != 'li'
                and $toc.section.depth>0 and section|sect1">
    <xsl:copy-of select="$subtoc.list"/>
  </xsl:if> -->
</xsl:template>




</xsl:stylesheet>


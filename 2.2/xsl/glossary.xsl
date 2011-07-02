<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'
                xmlns="http://www.w3.org/TR/xhtml1/transitional"
                exclude-result-prefixes="#default">

<!-- ************************Glossary***************************-->

<!-- Importing the Norman Walsh's stylesheet as the basis. -->
<!--
<xsl:import href="/usr/share/sgml/docbook/stylesheet/xsl/nwalsh-1.45/html/chunk.xsl"/>
-->
<xsl:template match="glossentry/glossterm">
  <dt>
    <b>
      <xsl:apply-templates/>
    </b>
  </dt>
</xsl:template>

<xsl:template match="glossentry/glossterm[1]" priority="2">
  <dt>
	<b>
      <xsl:call-template name="anchor">
        <xsl:with-param name="node" select=".."/>
      </xsl:call-template>
      <xsl:apply-templates/>
	</b>
  </dt>
</xsl:template>

<xsl:template match="glossentry/glossdef[@subject]">

	<xsl:if test="position()=2">
	<xsl:text disable-output-escaping="yes">&lt;dd&gt;</xsl:text>
	<xsl:text disable-output-escaping="yes">&lt;div class="informaltable"&gt;</xsl:text>
	<xsl:text disable-output-escaping="yes">&lt;table border="0"&gt;</xsl:text>
	<xsl:text disable-output-escaping="yes">&lt;tbody&gt;</xsl:text>
	</xsl:if>

	<tr>
	<td valign="top">
	<p>
	<xsl:value-of select="@subject"/>
	</p>
	</td>
	<td>
    <xsl:apply-templates select="*[local-name(.) != 'glossseealso']"/>
	</td>
	</tr>

    <xsl:if test="glossseealso">
      <p>
        <xsl:call-template name="gentext.template">
          <xsl:with-param name="context" select="'glossary'"/>
          <xsl:with-param name="name" select="'seealso'"/>
        </xsl:call-template>
        <xsl:apply-templates select="glossseealso"/>
      </p>
    </xsl:if>

	<xsl:if test="position()=last()">
	<xsl:text disable-output-escaping="yes">&lt;/tbody&gt;</xsl:text>
	<xsl:text disable-output-escaping="yes">&lt;/table&gt;</xsl:text>
	<xsl:text disable-output-escaping="yes">&lt;/div&gt;</xsl:text>
	<xsl:text disable-output-escaping="yes">&lt;/dd&gt;</xsl:text>
	</xsl:if>

</xsl:template>

</xsl:stylesheet>






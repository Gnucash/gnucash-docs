<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>

<!-- ****************************Revhistory********************-->

<xsl:template match="revhistory" mode="titlepage.mode">
  <xsl:variable name="numcols">
<!--
    <xsl:choose>
      <xsl:when test="//authorinitials">3</xsl:when>
      <xsl:otherwise>2</xsl:otherwise>
    </xsl:choose>
-->
    4
  </xsl:variable>

  <div class="{name(.)}">
    <h2><xsl:call-template name="gentext">
              <xsl:with-param name="key" select="'History'"/>
            </xsl:call-template>
    </h2>
    <table border="1" width="100%" summary="Revision history">
      <tr>
        <th align="left" valign="top" colspan="1">
          <b>
            <xsl:call-template name="gentext">
              <xsl:with-param name="key" select="'Title'"/>
            </xsl:call-template>
          </b>
        </th>
	<th align="left" valign="top" colspan="1">
          <b>
            <xsl:call-template name="gentext">
              <xsl:with-param name="key" select="'Date'"/>
            </xsl:call-template>
          </b>
        </th>
	<th align="left" valign="top" colspan="1">
          <b>
            <xsl:call-template name="gentext">
              <xsl:with-param name="key" select="'Author'"/>
            </xsl:call-template>
          </b>
        </th>
	<th align="left" valign="top" colspan="1">
          <b>
            <xsl:call-template name="gentext">
              <xsl:with-param name="key" select="'Publisher'"/>
            </xsl:call-template>
          </b>
        </th>
      </tr>
      <xsl:apply-templates mode="titlepage.mode">
        <xsl:with-param name="numcols" select="$numcols"/>
      </xsl:apply-templates>
    </table>
  </div>
</xsl:template>

<xsl:template match="revhistory/revision" mode="titlepage.mode">
  <xsl:param name="numcols" select="'4'"/>  
  <xsl:variable name="revnumber" select=".//revnumber"/>
  <xsl:variable name="revdate"   select=".//date"/>
  <xsl:variable name="revremark" select=".//revremark|.//revdescription"/>

  <xsl:variable name="revision.authors"
  select="$revremark/para[@role='author']|.//authorinitials"/> 



  <xsl:variable name="revision.publisher" select="$revremark/para[@role='publisher']"/>


  <xsl:variable name="revision.other" select="$revremark/para[@role='']"/>


  <tr>
    <td align="left">
         <p>  
         <xsl:value-of select="$revnumber"/>
	 </p>
	</td>

	<td align="left">
	  <p>
		<xsl:value-of select="$revdate"/>
	  </p>
	</td>

	<td align="left">

	    <xsl:apply-templates
	     select="$revision.authors"/>

	</td>

	<td align="left">
           <xsl:apply-templates
	  select="$revision.publisher"/>

	</td>
  </tr>
  <xsl:if test="$revision.other">
    <tr>
      <td align="left" colspan="4">
        <xsl:apply-templates select="$revision.other"/>
      </td>
    </tr>
  </xsl:if>
</xsl:template>

<xsl:template match="revision/revnumber" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="revision/date" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="revision/authorinitials" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="revision/revremark" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="revision/revdescription" mode="titlepage.mode">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>



<!-- ==================================================================== -->

</xsl:stylesheet>

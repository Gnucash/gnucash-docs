<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'
                xmlns="http://www.w3.org/TR/xhtml1/transitional"
                exclude-result-prefixes="#default">

<!-- ***************************Othercredit**********************-->

<!-- Puts Othercredit on title page.  -->

<xsl:template match="othercredit" mode="titlepage.mode">
<xsl:variable name="contrib" select="string(contrib)"/>

<!-- The following piece of code tries to find all <othercredit> witht
he same contrib field so that they can be listed under the same
heading. Borrowed from Walsh's modular stylesheets -->

  <xsl:if test="not(preceding-sibling::othercredit[string(contrib)=$contrib])">
       <xsl:if test="contrib">
         <h2><xsl:apply-templates mode="titlepage.mode"
          select="contrib"/></h2>
       </xsl:if> 
        <dl>
 	<xsl:apply-templates select= "." mode="titlepage.othercredits"/>
         <xsl:apply-templates
       select="following-sibling::othercredit[string(contrib)=$contrib]" 
       mode="titlepage.othercredits"/>
        </dl>
  </xsl:if>


</xsl:template>

<xsl:template match="othercredit" mode="titlepage.othercredits">
<xsl:variable name="author.org" select=".//orgname"/>
<xsl:variable name="author.email" select=".//email"/>

         <dt><xsl:call-template name="person.name"/></dt>
	 <xsl:if test="$author.org">
	      <dd><strong>
               <xsl:call-template name="gentext">
                <xsl:with-param name="key" select="'Affiliation'"/>
               </xsl:call-template><xsl:text>: </xsl:text>
               </strong> 
               <xsl:apply-templates select="$author.org"/>
	      </dd>
         </xsl:if> 
         <xsl:if test="$author.email">
           <dd><strong>        
            <xsl:call-template name="gentext">
             <xsl:with-param name="key" select="'Email'"/>
            </xsl:call-template><xsl:text>: </xsl:text>
           </strong> 
           <xsl:apply-templates select="$author.email"/>
	   </dd>
         </xsl:if> 
</xsl:template>

</xsl:stylesheet>


<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'
                xmlns="http://www.w3.org/TR/xhtml1/transitional"
                exclude-result-prefixes="#default">

<!-- ***************************Author**********************-->

<!-- Adds the string "Author/Authors" to the author tag in the 
	 title page. Also prints editors and othercredit   -->

<xsl:template match="artheader/author|articleinfo/author|bookinfo/author|authorgroup/author|editor" mode="titlepage.mode">
<xsl:variable name="author.org" select=".//orgname"/>
<xsl:variable name="author.email" select=".//email"/>
<dl>
 <dt><xsl:call-template name="person.name.last-first"/></dt>
 <xsl:if test="$author.org">
    <dd><strong>
        <xsl:call-template name="gentext">
           <xsl:with-param name="key" select="'Affiliation'"/>
         </xsl:call-template><xsl:text>: </xsl:text>
        </strong> 
        <xsl:apply-templates select="$author.org"/></dd>
 </xsl:if> 
 <xsl:if test="$author.email">
    <dd><strong>        
         <xsl:call-template name="gentext">
           <xsl:with-param name="key" select="'Email'"/>
         </xsl:call-template><xsl:text>: </xsl:text>

        </strong> 
        <xsl:apply-templates select="$author.email"/></dd>
 </xsl:if> 
</dl>
</xsl:template>

<xsl:template match="authorgroup" mode="titlepage.mode">

      <!-- count the number of authors -->
       <xsl:variable name="numaut" select="count(author)"/>
         <xsl:choose>	
          <xsl:when test="$numaut > 1">
           <h2>    
	    <xsl:call-template name="gentext" mode="titlepage.mode">
	     <xsl:with-param name="key" select="'Authors'"/>
	    </xsl:call-template>
	    </h2>
	   </xsl:when>
	   <xsl:when test="$numaut = 1">
            <h2>    
	     <xsl:call-template name="gentext" mode="titlepage.mode">
	      <xsl:with-param name="key" select="'Author'"/>
	     </xsl:call-template>
	    </h2>
	   </xsl:when>
	   <xsl:otherwise>
           </xsl:otherwise>
	   </xsl:choose>
	 <xsl:apply-templates select="author" mode="titlepage.mode"/>
        <!-- Now let us deal with editors -->
        <xsl:variable name="editors" select="editor"/>
	<xsl:if test="$editors">
	  <h2> 
             <xsl:call-template name="gentext" mode="titlepage.mode">
	      <xsl:with-param name="key" select="'Editedby'"/>
	     </xsl:call-template>
	  </h2>
          <xsl:apply-templates select="editor" mode="titlepage.mode"/>
        </xsl:if>
        <!-- finally, everyone else --> 
        <xsl:apply-templates select="othercredit" mode="titlepage.mode"/>
 </xsl:template>

</xsl:stylesheet>

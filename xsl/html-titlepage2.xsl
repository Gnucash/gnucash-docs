<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- This is a customization layer, to change some of the things in
   auto-generated titlepage.xsl -->

<xsl:template xmlns:xsl="http://www.w3.org/1999/XSL/Transform" name="book.titlepage">
<!-- Added to create a separate titlepage -->
  <xsl:param name="next" select="."/>
  <xsl:param name="prev" select="bookinfo[1]"/>
  <xsl:variable name="id">titlepage</xsl:variable>
  <xsl:choose>
    <xsl:when test="$generate.titlepage.link != 0">


   <!-- *****put logo etc. and title on the root page -->

       <xsl:call-template name="book.titlepage.before.recto"/>               
       <xsl:call-template  name="book.titlepage.before.verso"/>
       <xsl:choose> <!-- put title -->
         <xsl:when test="bookinfo/title">
            <xsl:apply-templates  mode="book.titlepage.recto.auto.mode"
              select="bookinfo/title"/> 
         </xsl:when>
         <xsl:when test="title">
          <xsl:apply-templates  mode="book.titlepage.recto.auto.mode" select="title"/>
         </xsl:when>
       </xsl:choose>

    
       <xsl:choose> <!-- put subtitle -->
         <xsl:when test="bookinfo/subtitle">
            <xsl:apply-templates mode="book.titlepage.recto.auto.mode"
              select="bookinfo/subtitle"/> 
         </xsl:when>
         <xsl:when test="subtitle">
         <xsl:apply-templates mode="book.titlepage.recto.auto.mode" 
	   select="subtitle"/> 
         </xsl:when>
       </xsl:choose>


       <!-- **** Now create link to titlepage.html **** -->
       <a> <xsl:attribute name="href">
            <xsl:call-template name="href.target">
             <xsl:with-param name="object" select="$prev"/>
            </xsl:call-template>
           </xsl:attribute>
           <xsl:apply-templates select="$prev" mode="object.title.markup"/>    
       </a>                
       <xsl:call-template name="book.titlepage.separator"/>



      <xsl:variable name="filename">
        <xsl:call-template name="make-relative-filename">
          <xsl:with-param name="base.dir" select="$base.dir"/>
          <xsl:with-param name="base.name" select="concat($id,$html.ext)"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:variable name="title">
        <xsl:apply-templates select="." mode="title.markup"/>
      </xsl:variable>

      <xsl:call-template name="write.chunk">
        <xsl:with-param name="filename" select="$filename"/>
        <xsl:with-param name="content">
          <html>
            <head>
              <title><xsl:value-of select="$title"/></title>
            </head>
            <body>
              <xsl:call-template name="body.attributes"/>
	    	  <xsl:call-template name="user.header.navigation"/>

	    	  <xsl:call-template name="header.navigation">
			<xsl:with-param name="next" select="$next"/>
		      </xsl:call-template>

		      <xsl:call-template name="user.header.content"/>
			  <div class="titlepage">
			    <xsl:call-template  name="book.titlepage.before.recto"/>
			    <xsl:call-template  name="book.titlepage.before.verso"/>
			    <xsl:call-template  name="book.titlepage.recto"/>
			    <xsl:call-template  name="book.titlepage.verso"/>
			    <xsl:call-template  name="book.titlepage.separator"/>
			  </div>	
		      <xsl:call-template name="user.footer.content"/>

		      <xsl:call-template name="footer.navigation">
			<xsl:with-param name="next" select="$next"/>
		      </xsl:call-template>

		      <xsl:call-template name="user.footer.navigation"/>
            </body>
          </html>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
	  <div class="titlepage">
	    <xsl:call-template  name="book.titlepage.before.recto"/>
	    <xsl:call-template  name="book.titlepage.before.verso"/>
	    <xsl:call-template  name="book.titlepage.recto"/>
	    <xsl:call-template  name="book.titlepage.verso"/>
	    <xsl:call-template  name="book.titlepage.separator"/>
	  </div>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


 <!-- *********** Article titlepage ****************--> 
<xsl:template name="article.titlepage">
  <xsl:param name="next" select="."/>  
  <xsl:param name="prev" select="articleinfo[1]"/>
  <xsl:variable name="id">titlepage</xsl:variable>
  <xsl:choose>
    <xsl:when test="$generate.titlepage.link != 0">
   
    <!-- *****put logo etc. and title on the root page -->

       <xsl:call-template name="article.titlepage.before.recto"/>               
       <xsl:call-template  name="article.titlepage.before.verso"/>
       <xsl:choose> <!-- put title -->
         <xsl:when test="articleinfo/title">
            <xsl:apply-templates  mode="article.titlepage.recto.auto.mode"
              select="articleinfo/title"/> 
         </xsl:when>
         <xsl:when  test="artheader/title">
            <xsl:apply-templates
		mode="article.titlepage.recto.auto.mode"
                select="artheader/title"/> 
         </xsl:when>
         <xsl:when test="title">
          <xsl:apply-templates  mode="article.titlepage.recto.auto.mode" select="title"/>
         </xsl:when>
       </xsl:choose>

    
       <xsl:choose> <!-- put subtitle -->
         <xsl:when test="articleinfo/subtitle">
            <xsl:apply-templates mode="article.titlepage.recto.auto.mode"
              select="articleinfo/subtitle"/> 
         </xsl:when>
         <xsl:when test="artheader/subtitle">
            <xsl:apply-templates mode="article.titlepage.recto.auto.mode" 
	      select="artheader/subtitle"/> 
         </xsl:when>
         <xsl:when test="subtitle">
         <xsl:apply-templates mode="article.titlepage.recto.auto.mode" 
	   select="subtitle"/> 
         </xsl:when>
       </xsl:choose>

       <!-- **** Now create link to titlepage.html **** -->
       <a> <xsl:attribute name="href">
            <xsl:call-template name="href.target">
             <xsl:with-param name="object" select="$prev"/>
            </xsl:call-template>
           </xsl:attribute>
           <xsl:apply-templates select="$prev" mode="object.title.markup"/>    
       </a>                
       <xsl:call-template name="article.titlepage.separator"/>

      <!-- ******** Now create the file titlepage.html **** -->
      <xsl:variable name="filename">
	    <xsl:call-template name="make-relative-filename">
		  <xsl:with-param name="base.dir" select="$base.dir"/>
		  <xsl:with-param name="base.name" select="concat($id,$html.ext)"/>
		</xsl:call-template>
      </xsl:variable>
	  
      <xsl:variable name="title">
	    <xsl:apply-templates select="." mode="title.markup"/>
      </xsl:variable>
	  
      <xsl:call-template name="write.chunk">
       <xsl:with-param name="filename" select="$filename"/>
       <xsl:with-param name="content">
            <html>
	    <head>
	      <title><xsl:value-of select="$title"/></title>
	     </head>
	     <body>
	        <xsl:call-template name="body.attributes"/>
		<xsl:call-template name="user.header.navigation"/>
		<xsl:call-template name="header.navigation">
		    <xsl:with-param name="next" select="$next"/>
		</xsl:call-template>
			  
	        <xsl:call-template name="user.header.content"/>
                  <div class="titlepage">
                   <xsl:call-template name="article.titlepage.before.recto"/>
                   <xsl:call-template name="article.titlepage.before.verso"/>
                   <xsl:call-template name="article.titlepage.recto"/>
                   <xsl:call-template name="article.titlepage.verso"/>
                  </div>
		<xsl:call-template name="user.footer.content"/>
		  <xsl:call-template name="footer.navigation">
		    <xsl:with-param name="next" select="$next"/>
		  </xsl:call-template>
		  <xsl:call-template name="user.footer.navigation"/>
	     </body>
	     </html>
	</xsl:with-param>
        </xsl:call-template>
    </xsl:when>
    <xsl:otherwise> <!-- Do not make a the titlepage a separate file --> 
        <div class="titlepage">
          <xsl:call-template name="article.titlepage.before.recto"/>
          <xsl:call-template name="article.titlepage.before.verso"/>
          <xsl:call-template name="article.titlepage.recto"/>
          <xsl:call-template name="article.titlepage.verso"/>
         </div>
    </xsl:otherwise>
   </xsl:choose>
</xsl:template>
</xsl:stylesheet>
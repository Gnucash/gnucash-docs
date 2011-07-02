<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'
                xmlns="http://www.w3.org/TR/xhtml1/transitional"
                exclude-result-prefixes="#default">


<!-- *********************Navigation header/footer************************-->

<!-- Custom template to add <<< and >>> to navigation header/footer -->

<!-- ==================================================================== -->

<xsl:template name="header.navigation">
  <xsl:param name="prev" select="/foo"/>
  <xsl:param name="next" select="/foo"/>
  <xsl:variable name="home" select="/*[1]"/>
  <xsl:variable name="up" select="parent::*"/>

  <xsl:if test="$suppress.navigation = '0'">
    <div class="navheader">
      <table width="100%" summary="Navigation header">
        <tr>
          <th colspan="3" align="center">
            <xsl:apply-templates select="." mode="object.title.markup"/>
          </th>
        </tr>
        <tr>
          <td width="20%" align="left">
            <xsl:if test="count($prev)>0">
              <a accesskey="p">
                <xsl:attribute name="href">
                  <xsl:call-template name="href.target">
                    <xsl:with-param name="object" select="$prev"/>
                  </xsl:call-template>
                </xsl:attribute>
		<xsl:text>&lt;&lt;&lt;&#160;</xsl:text>
                <xsl:call-template name="gentext">
                  <xsl:with-param name="key">nav-prev</xsl:with-param>
                </xsl:call-template>
              </a>
            </xsl:if>
            <xsl:text>&#160;</xsl:text>
          </td>
          <th width="60%" align="center">
            <xsl:choose>
              <xsl:when test="count($up) > 0 and $up != $home">
                <xsl:apply-templates select="$up" mode="object.title.markup"/>
              </xsl:when>
              <xsl:otherwise>&#160;</xsl:otherwise>
            </xsl:choose>
          </th>
          <td width="20%" align="right">
            <xsl:text>&#160;</xsl:text>
            <xsl:if test="count($next)>0">
              <a accesskey="n">
                <xsl:attribute name="href">
                  <xsl:call-template name="href.target">
                    <xsl:with-param name="object" select="$next"/>
                  </xsl:call-template>
                </xsl:attribute>
                <xsl:call-template name="gentext">
                  <xsl:with-param name="key">nav-next</xsl:with-param>
                </xsl:call-template>
		<xsl:text>&#160;&gt;&gt;&gt;</xsl:text>
              </a>
            </xsl:if>
          </td>
        </tr>
      </table>
      <hr/>
    </div>
  </xsl:if>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template name="footer.navigation">
  <xsl:param name="prev" select="/foo"/>
  <xsl:param name="next" select="/foo"/>
  <xsl:variable name="home" select="/*[1]"/>
  <xsl:variable name="up" select="parent::*"/>

  <xsl:if test="$suppress.navigation = '0'">
    <div class="navfooter">
      <hr/>
      <table width="100%" summary="Navigation footer">
        <tr>
          <td width="40%" align="left">
            <xsl:if test="count($prev)>0">
              <a accesskey="p">
                <xsl:attribute name="href">
                  <xsl:call-template name="href.target">
                    <xsl:with-param name="object" select="$prev"/>
                  </xsl:call-template>
                </xsl:attribute>
		<xsl:text>&lt;&lt;&lt;&#160;</xsl:text>
                <xsl:call-template name="gentext">
                  <xsl:with-param name="key">nav-prev</xsl:with-param>
                </xsl:call-template>
              </a>
            </xsl:if>
            <xsl:text>&#160;</xsl:text>
          </td>
          <td width="20%" align="center">
            <xsl:choose>
              <xsl:when test="$home != .">
                <a accesskey="h">
                  <xsl:attribute name="href">
                    <xsl:call-template name="href.target">
                      <xsl:with-param name="object" select="$home"/>
                    </xsl:call-template>
                  </xsl:attribute>
                  <xsl:call-template name="gentext">
                    <xsl:with-param name="key">nav-home</xsl:with-param>
                  </xsl:call-template>
                </a>
              </xsl:when>
              <xsl:otherwise>&#160;</xsl:otherwise>
            </xsl:choose>
          </td>
          <td width="40%" align="right">
            <xsl:text>&#160;</xsl:text>
            <xsl:if test="count($next)>0">
              <a accesskey="n">
                <xsl:attribute name="href">
                  <xsl:call-template name="href.target">
                    <xsl:with-param name="object" select="$next"/>
                  </xsl:call-template>
                </xsl:attribute>
                <xsl:call-template name="gentext">
                  <xsl:with-param name="key">nav-next</xsl:with-param>
                </xsl:call-template>
		<xsl:text>&#160;&gt;&gt;&gt;</xsl:text>
              </a>
            </xsl:if>
          </td>
        </tr>

        <tr>
          <td width="40%" align="left">
            <xsl:apply-templates select="$prev" mode="object.title.markup"/>
            <xsl:text>&#160;</xsl:text>
          </td>
          <td width="20%" align="center">
            <xsl:choose>
              <xsl:when test="count($up)>0">
                <a accesskey="u">
                  <xsl:attribute name="href">
                    <xsl:call-template name="href.target">
                      <xsl:with-param name="object" select="$up"/>
                    </xsl:call-template>
                  </xsl:attribute>
                  <xsl:call-template name="gentext">
                    <xsl:with-param name="key">nav-up</xsl:with-param>
                  </xsl:call-template>
                </a>
              </xsl:when>
              <xsl:otherwise>&#160;</xsl:otherwise>
            </xsl:choose>
          </td>
          <td width="40%" align="right">
            <xsl:text>&#160;</xsl:text>
            <xsl:apply-templates select="$next" mode="object.title.markup"/>
          </td>
        </tr>
      </table>
    </div>
  </xsl:if>
</xsl:template>


</xsl:stylesheet>

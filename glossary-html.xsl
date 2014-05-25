<?xml version="1.0" encoding="UTF-8"?>

<!-- faqxml: glossary-html.xsl
  Stylesheet for translation to html

  Version: 1.3 (2014-05-25)

  Sorting: see D. Tidwell, "XSLT (second edition)", 2008.

  Option to insert alphabetical headings and contents line is based on: 
     http://stackoverflow.com/questions/734946/building-list-with-xslt
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
     xmlns="http://www.w3.org/TR/xhtml1/strict" version="2.0">

<xsl:output
   method="html"
   encoding="UTF-8"
/>

<xsl:template match="glossary">

<html>
<head>

<title> <xsl:value-of select="@title"/> </title>

<style>
<!-- 
  Styles are not in use. This is appropriate for using the html output where a website CSS
  file is in use - or in a CMS website such as Drupal or WordPress where file-specific 
  style definitions are not possible.
  Uncomment if needed.
-->
<!--
div.glossentry {
	padding-top: 0.1em;
	padding-bottom: 0.5em;
}


div.glossterm {
}

div.glossdef {
}

p {
	text-align: justify;
}
-->
</style>

</head>
<body>

<h1> <xsl:value-of select="@title"/> </h1>

<p><i>
Version:
<xsl:if test="@version">
  <xsl:value-of select="@version"/>, 
</xsl:if>
<xsl:choose>
  <xsl:when test="@date">
    <xsl:value-of select="@date"/>
  </xsl:when>
  <xsl:otherwise>
    <!-- current-date() requires XSLT version 2 -->
    <xsl:value-of select="current-date()"/>
  </xsl:otherwise>
</xsl:choose>
</i></p>
<xsl:text> </xsl:text>

<xsl:choose>
  <!-- Output sorted and with alphabetical headings -->
  <xsl:when test="@sorted='true' and @alphahead='true'">
       <!-- First grouping pass creates the Contents line-->
       <p><a name="Top"/></p>
       <p><strong><i>Contents: &#x9;
       <xsl:for-each-group select="glossentry[status='published']"
           group-by="upper-case(substring(@sortkey,1,1))">
        <xsl:sort select="current-grouping-key()"/>
       
        <a><xsl:attribute name="href"><xsl:sequence select=
           "concat('#',current-grouping-key())"/></xsl:attribute>
        <xsl:sequence select=
           "current-grouping-key()"/>
        </a>&#160;
        </xsl:for-each-group>
       </i></strong></p>
       
       <!-- Second grouping pass creates the glossary content --> 
       <xsl:for-each-group select="glossentry[status='published']"
           group-by="upper-case(substring(@sortkey,1,1))">
        <xsl:sort select="current-grouping-key()"/>

        <h3><a><xsl:attribute name="name"><xsl:sequence select=
           "current-grouping-key()"/></xsl:attribute></a>
            <xsl:sequence select="current-grouping-key()"/></h3>

        <xsl:for-each select="current-group()">
          <xsl:sort select="upper-case(sortkey)"/>
          <xsl:call-template name="glossentry"/>
          <!--<xsl:apply-templates select="glossentry"/>-->
        </xsl:for-each>
        
        <xsl:if test="../@toplinks='true'">
        <p style="text-align:right; margin-top:0.3em"><a style="text-align:right;" href="#Top">Back to Top</a></p>
        </xsl:if>

      </xsl:for-each-group>
  </xsl:when>   
  <!-- If the sorted attribute is set, do sorting but not with alpha headings --> 
  <xsl:when test="@sorted='true'"> 
     <xsl:apply-templates>
       <xsl:sort select="@sortkey"/> <!--primary sort by value of sortkey-->
       <xsl:sort select="glossterm"/> <!-- secondary sort by glossterm if sortkey values are same-->
     </xsl:apply-templates>
</xsl:when>
  <!-- Otherwise no sorting, use order of glossary terms as in the xml source -->
  <xsl:otherwise>
     <xsl:apply-templates/>
  </xsl:otherwise>
</xsl:choose>


<hr/>
<para><i>
Created with <a href="https://github.com/phillipkent/faqxml" target="_blank">faqxml</a> stylesheet 'glossary-html'
</i></para>

</body>
</html>
</xsl:template>

<!-- only output glossentry elements with status 'published'-->
<xsl:template match="glossentry" name="glossentry">
<xsl:choose>
   <xsl:when test="status='published'">
      <div class="glossentry" style="padding-bottom:0.15em">
      <p><a name="{@glen-id}"/>
      <xsl:apply-templates select="glossterm"/><xsl:apply-templates select="glossdef"/>
      </p></div>
   </xsl:when>
   <xsl:otherwise>
      <!-- output nothing -->
   </xsl:otherwise>
   </xsl:choose>

</xsl:template>

<xsl:template match="glossterm">
<strong>
<xsl:call-template name="article"/>.</strong>
</xsl:template>

<xsl:template match="glossdef">
<xsl:call-template name="article"/>
</xsl:template>

<xsl:template match="glenref">
   <xsl:choose>
   <xsl:when test="@linktext">
      <a href="{concat('#',@refid)}"><xsl:value-of select="@linktext"/></a>
   </xsl:when>
   <xsl:otherwise>
     <a href="{concat('#',@refid)}"><xsl:value-of select="id(@refid)/glossterm"/></a> 
   </xsl:otherwise>
   </xsl:choose>
</xsl:template>

<xsl:template name="article"><xsl:apply-templates/></xsl:template>

<xsl:template match="link">
<a>
<xsl:attribute name="href"><xsl:value-of select="@url"/></xsl:attribute>
<xsl:attribute name="target">_blank</xsl:attribute>
<xsl:apply-templates/>
<!-- trying to insert arrow character for 'external link'- not working
&#8599;
-->
</a>
</xsl:template>

<xsl:template match="mailto">
<a href="mailto:{.}"><xsl:apply-templates/></a>
</xsl:template>

<xsl:template match="pre">
<pre><xsl:apply-templates/></pre>
</xsl:template>

<xsl:template match="p">
<p><xsl:apply-templates/></p>
</xsl:template>

<xsl:template match="ul">
<ul><xsl:apply-templates/></ul>
</xsl:template>

<xsl:template match="ol">
<ol><xsl:apply-templates/></ol>
</xsl:template>

<xsl:template match="li">
<li><xsl:apply-templates/></li>
</xsl:template>

<xsl:template match="b">
<b><xsl:apply-templates/></b>
</xsl:template>

<xsl:template match="br">
<br/>
</xsl:template>

<xsl:template match="emphasis">
<em><xsl:apply-templates/></em>
</xsl:template>

<xsl:template match="para">
<p><xsl:apply-templates/></p>
</xsl:template>

<xsl:template match="command">
<code><xsl:apply-templates/></code>
</xsl:template>

</xsl:stylesheet>

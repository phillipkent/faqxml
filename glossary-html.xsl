<?xml version="1.0" encoding="UTF-8"?>

<!-- faqxml: glossary-html.xsl
  Stylesheet for translation to html

  Version: 0.1 (2014-01-03)
-->

<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/TR/xhtml1/strict">

<xsl:output
   method="html"
   encoding="UTF-8"
/>

<xsl:template match="glossary">
<html>
<head>

<title> <xsl:value-of select="@title"/> </title>

<style>
div.glossentry {
	padding-top: 0.1em;
	padding-bottom: 0.5em;
}

div.glossterm {
        font-style: italic;
}

div.glossdef {
        font-style: 
}

p {
	text-align: justify;
}
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

<xsl:apply-templates/>

<hr/>
<para><i>
Created with <a href="https://github.com/phillipkent/faqxml" target="_blank">faqxml</a> stylesheet 'glossary-html'
</i></para>

</body>
</html>
</xsl:template>

<xsl:template match="glossentry">
<a name="{@glen-id}"/>
<div class="glossentry">

<div class="glossterm"> 
<xsl:call-template name="article"/>
</div>

<div class="glossdef">
...............
</div>

</div>
</xsl:template>

<xsl:template match="glenref">
 <a href="{concat('#',@refid)}">
   <xsl:value-of select="id(@refid)/glossterm"/></a>
</xsl:template>

<xsl:template name="article">
<xsl:apply-templates/>
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

</xsl:stylesheet>

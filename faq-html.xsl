<?xml version="1.0" encoding="UTF-8"?>

<!-- faqxml: faq-html.xsl
  Stylesheet for translation to html with folded answers
  using JavaScript

  Version: 0.5 (2014-02-10)

  This stylesheet is part of "faqxml" by Phillip Kent
  [https://github.com/phillipkent/faqxml]
  
  "faqxml" is licensed under the GNU GENERAL PUBLIC LICENSE Version 3

  Based on stylesheets by Mikhail Yakshin [http://faqxml.sourceforge.net],
  licensed under GPLv2 
-->

<!-- 
 To do:
   Cross-referencing - external to glossary, user guide?
-->

<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/TR/xhtml1/strict">

<xsl:output
   method="html"
   encoding="UTF-8"
/>

<xsl:template match="faq">
<html>
<head>

<title> <xsl:value-of select="@title"/> </title>

<script language="javascript">
<xsl:comment>
function toggle_answer(id)
{
	var el = document.getElementById(id);
	if (el.style.display == "block") {
		el.style.display = "none";
	} else {
		el.style.display = "block";
	}
}

function toggle_all(state)
{
  var elems = document.querySelectorAll("div[id^='ans']"); 
  for(var i=0; i &lt; elems.length; i++) {
    elems[i].style.display = state; 
  }
<!-- ALTERNATIVE VERSION 
  var elems = document.getElementsByTagName("div");
  for(var i=0; i &lt; elems.length; i++) {
    if(elems[i].id.indexOf("ans") != -1) {
       elems[i].style.display = state; 
    }
  }
-->
}
//</xsl:comment>
</script>
<style>
div.qa {
	padding-top: 0.1em;
	padding-bottom: 0.1em;
}

div.question {
	text-align: justify;
	padding: 0.1em;
}

div.answer {
	text-align: justify;
	padding: 0.1em;
	margin-top: 0.1em;
}

div.toolbox {
	float: right;
	background-color: #72713F;
	border: 1px solid white;
	padding: 1em;
}

div.toolbox a {
	display: block;
	text-align: center;
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
<p>
<a href="javascript:toggle_all('block');">[SHOW ALL ANSWERS]</a>
<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;</xsl:text>
<a href="javascript:toggle_all('none');">[HIDE ALL ANSWERS]</a>
</p>

<!-- CONTENTS NOT IN USE

<h2>Contents</h2>
<xsl:call-template name="contents"/>
-->

<!-- CREDITS NOT IN USE 
<h2>Credit list</h2>
<xsl:call-template name="credit-list"/>
-->

<xsl:apply-templates/>

<hr/>
<para><i>
Created with <a href="https://github.com/phillipkent/faqxml" target="_blank">faqxml</a> stylesheet faq-html
</i></para>
</body>
</html>
</xsl:template>

<xsl:template name="contents">
	<xsl:for-each select="section">
		<xsl:call-template name="section-contents"/>
	</xsl:for-each>
</xsl:template>

<xsl:template name="section-contents">
	<p>
	<a><xsl:attribute name="href">#<xsl:number count="section" level="multiple"/> </xsl:attribute>
         <xsl:if test="@shownumber='on'">
                <xsl:number count="section" level="multiple"/>.
         </xsl:if> 
         <xsl:value-of select="@title"/></a>
	</p>
	<xsl:if test="section">
		<blockquote>
		<xsl:for-each select="section">
			<xsl:call-template name="section-contents"/>
		</xsl:for-each>
		</blockquote>
	</xsl:if>
</xsl:template>

<xsl:template match="section">
	<a><xsl:attribute name="name"><xsl:number count="section" level="multiple"/></xsl:attribute></a>
	<h2>
         <xsl:if test="@shownumber='on'">
                <xsl:number count="section" level="multiple"/>.
         </xsl:if>
         <xsl:value-of select="@title"/></h2>
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="section/section">
	<a><xsl:attribute name="name"><xsl:number count="section" level="multiple"/></xsl:attribute></a>
	<h3> <xsl:if test="@shownumber='on'">
                <xsl:number count="section" level="multiple"/>.
         </xsl:if><xsl:value-of select="@title"/></h3>
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="section/section/section">
	<a><xsl:attribute name="name"><xsl:number count="section" level="multiple"/></xsl:attribute></a>
	<h4> <xsl:if test="@shownumber='on'">
                <xsl:number count="section" level="multiple"/>.
         </xsl:if><xsl:value-of select="@title"/></h4>
	<xsl:apply-templates/>
</xsl:template>

<!-- only output qa elements with status 'published'-->
<xsl:template match="qa[status='published']">
<a name="{@qa-id}"/>
<div class="qa">
<xsl:apply-templates select="question"/>
<div>
<xsl:attribute name="id">ans<xsl:number count="section|qa" format="1" level="multiple"/></xsl:attribute>
<xsl:attribute name="style">display: none</xsl:attribute>
<xsl:apply-templates select="answer"/>
</div>
</div>
</xsl:template>

<xsl:template match="qa[status='unpublished']">
<!-- do nothing -->
</xsl:template>

<xsl:template match="qaref">
 <a href="{concat('#',@refid)}">
   <xsl:value-of select="id(@refid)/question"/></a>
</xsl:template>

<xsl:template match="question">
<div class="question">
<table width="100%">
<tr>
<td width="5%" valign="top">
<p>
<b>Q</b>
<a title="Question"><xsl:attribute name="href">javascript:toggle_answer('ans<xsl:number count="section|qa" format="1" level="multiple"/>');</xsl:attribute>[+]</a>
<xsl:text> </xsl:text>
</p>
<xsl:call-template name="author"/>
</td>
<td width="95%" valign="top"><xsl:call-template name="article"/></td>
</tr>
</table>
</div>
</xsl:template>

<xsl:template match="answer">
<div class="answer">
<table width="100%">
<tr>
<td width="5%" valign="top"><p><b>A</b></p><xsl:call-template name="author"/></td>
<td width="95%" valign="top"><xsl:call-template name="article"/></td>
</tr>
</table>
</div>
</xsl:template>


<xsl:template name="author">
<xsl:if test="@author"><p>[ <xsl:value-of select="@author"/> ]</p></xsl:if>
</xsl:template>

<xsl:template name="article">
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="link">
<a>
<xsl:attribute name="href"><xsl:value-of select="@url"/></xsl:attribute>
<xsl:attribute name="target">_blank</xsl:attribute>
<xsl:apply-templates/>
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

</xsl:stylesheet>

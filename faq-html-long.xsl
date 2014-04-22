<?xml version="1.0" encoding="UTF-8"?>

<!-- faqxml: faq-html-long.xsl
  Stylesheet for translation to html in 'long' form

  Version: 1.0 (2014-03-27)
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

<style>
div.qa {
	padding-top: 0.1em;
	padding-bottom: 0.5em;
}

div.question {
	padding: 0.2em;
}

div.answer {
	padding: 0.2em;
	margin-top: 0.1em;
}

div.toolbox {
	float: right;
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
(Version:
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
)</i></p>
<xsl:text> </xsl:text>
<xsl:if test="@toplinks='true'">
<p><a name="Top"></a></p>
</xsl:if>

<xsl:call-template name="contents"/>

<!-- START: SPECIAL FOR INTEROUTE: BACK BUTTON TO VDC 2.0 DOCUMENTATION INDEX PAGE -->
<p style="text-align:right;">
    <a style="text-align:right;" href="/main/knowledge-centre/library/vdc-2-launch-documentation">
        <img style="width: 220px; height: 36px;" src="/main/sites/default/files/images/Back_to_VDC_docs.PNG" alt="Go back to VDC 2.0 documentation"></img>
    </a>
</p>
<!-- END: SPECIAL FOR INTEROUTE: BACK BUTTON TO VDC 2.0 DOCUMENTATION INDEX PAGE -->

<xsl:apply-templates />

<div>
<hr/>
<p><i>
Created with <a href="https://github.com/phillipkent/faqxml" target="_blank">faqxml</a> stylesheet 'faq-html-long'
</i></p>
</div>

</body>
</html>
</xsl:template>

<xsl:template name="contents">
	<xsl:for-each select="section">
		<xsl:call-template name="section-contents"/>
                <xsl:if test="qa">
                  <blockquote>
                  <xsl:for-each select="qa[status='published']"> <!--only if qa is 'published'-->
                     <xsl:call-template name="qa-contents"/>
                  </xsl:for-each>
                  </blockquote>
		</xsl:if>
	</xsl:for-each>
</xsl:template>

<xsl:template name="section-contents">
	<p><strong>
	<a><xsl:attribute name="href">#<xsl:number count="section" level="multiple"/> </xsl:attribute>
         <xsl:if test="@shownumber='on'">
                <xsl:number count="section" level="multiple"/>.
         </xsl:if> 
         <xsl:value-of select="@title"/></a>
	</strong></p>
	<xsl:if test="section">
		<blockquote>
		<xsl:for-each select="section">
			<xsl:call-template name="section-contents"/>
		</xsl:for-each>
		</blockquote>
	</xsl:if>
</xsl:template>

<xsl:template name="qa-contents">
   <p>Q. <a><xsl:attribute name="href">#<xsl:value-of select="@qa-id"/></xsl:attribute>
      <xsl:value-of select="question"/></a></p>
</xsl:template>


<xsl:template match="section">
	<a><xsl:attribute name="name"><xsl:number count="section" level="multiple"/></xsl:attribute></a>
        <h2>
         <xsl:if test="@shownumber='on'">
                <xsl:number count="section" level="multiple"/>.
         </xsl:if>
         <xsl:value-of select="@title"/></h2>
	<xsl:apply-templates/>
        <xsl:if test="../@toplinks='true'">
           <p style="text-align:right; margin-top:1em"><a style="text-align:right;" href="#Top">Back to Top</a></p>
        </xsl:if> 
</xsl:template>

<xsl:template match="section/section">
	<a><xsl:attribute name="name"><xsl:number count="section" level="multiple"/></xsl:attribute></a>
	<h3> <xsl:if test="@shownumber='on'">
                <xsl:number count="section" level="multiple"/>.
         </xsl:if> <xsl:value-of select="@title"/></h3>
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="section/section/section">
	<a><xsl:attribute name="name"><xsl:number count="section" level="multiple"/></xsl:attribute></a>
	<h4> <xsl:if test="@shownumber='on'">
                <xsl:number count="section" level="multiple"/>.
         </xsl:if> <xsl:value-of select="@title"/></h4>
	<xsl:apply-templates/>
</xsl:template>

<!-- only output qa elements with status 'published'-->
<xsl:template match="qa[status='published']">
<a name="{@qa-id}"/>
<div class="qa">
<xsl:apply-templates select="question"/>
<xsl:apply-templates select="answer"/>
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
<b>Q.</b> <xsl:call-template name="author"/>
<xsl:call-template name="article"/>
</div>
</xsl:template>

<xsl:template match="answer">
<div class="answer">
<xsl:call-template name="article"/>
</div>
</xsl:template>


<xsl:template match="link">
<a>
<xsl:attribute name="href"><xsl:value-of select="@url"/></xsl:attribute>
<xsl:attribute name="target">_blank</xsl:attribute>
<xsl:apply-templates/>
<!-- trying to insert arrow character - not working
&#8599;
-->
</a>
</xsl:template>

<xsl:template match="mailto">
<a href="mailto:{.}"><xsl:apply-templates/></a>
</xsl:template>

<xsl:template name="author">
<xsl:if test="@author"> [ <xsl:value-of select="@author"/> ] </xsl:if>
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

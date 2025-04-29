<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:laalto="https://www.mzk.cz/ns/libri-augmentati/alto/1.0"
 xmlns:alto2="http://www.loc.gov/standards/alto/ns-v2#"
 xmlns:alto3="http://www.loc.gov/standards/alto/ns-v3#"
 xmlns:alto4="http://www.loc.gov/standards/alto/ns-v4#"
 exclude-result-prefixes="xs math xd"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Apr 26, 2025</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:mode on-no-match="shallow-copy"/>
 <xsl:mode on-no-match="shallow-copy" name="page"/>
 <xsl:mode on-no-match="shallow-copy" name="first"/>
 <xsl:strip-space elements="*"/>
 <xsl:output method="xml" indent="yes" />
 
 <xsl:template match="laalto:pages">
  <xsl:apply-templates select="alto2:alto[1] | alto3:alto[1] | alto4:alto[1]" />
 </xsl:template>
 
 <xsl:template match="alto2:alto[1] | alto3:alto[1] | alto4:alto[1]">
  <xsl:variable name="folowing" select="following-sibling::*"/>
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:apply-templates select="*" mode="first">
    <xsl:with-param name="following" select="$folowing" />
   </xsl:apply-templates>
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="alto2:Description | alto3:Description | alto4:Description" mode="first" priority="2">
  <xsl:param name="following" as="element()*" />
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:apply-templates mode="#current">
    <xsl:with-param name="following" select="$following" />
   </xsl:apply-templates>
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="alto2:sourceImageInformation | alto3:sourceImageInformation | alto4:sourceImageInformation" mode="first" />
 
 
 <xsl:template match="alto2:Styles | alto3:Styles | alto4:Styles" mode="first" priority="2">
  <xsl:param name="following" as="element()*" />
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:copy-of select="*:TextStyle" />
   <xsl:copy-of select="$following//*:Styles/*:TextStyle" />
   <xsl:copy-of select="*:ParagraphStyle" />
   <xsl:copy-of select="$following//*:Styles/*:ParagraphStyle" />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="alto2:alto/*" mode="first">
  <xsl:param name="following" as="element()*" />
  <xsl:variable name="tag-name" select="local-name()"/>
  <xsl:variable name="namespace" select="namespace-uri()"/>
  <xsl:element name="{$tag-name}" namespace="{$namespace}">
   <xsl:copy-of select="@*" />
   <xsl:copy-of select="*" />
   <xsl:apply-templates select="$following//*[local-name() = $tag-name]" mode="next" />
  </xsl:element>
 </xsl:template>
 
 <!--<xsl:template match="alto2:Styles | alto3:Styles | alto4:Styles" mode="next">
  <xsl:copy-of select="*" />
 </xsl:template>-->
 
 <xsl:template match="alto2:Layout | alto3:Layout | alto4:Layout" mode="first">
  <xsl:param name="following" as="element()*" />
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:copy-of select="*" />
   <xsl:apply-templates select="$following//*:Layout" mode="next" />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="alto2:Layout | alto3:Layout | alto4:Layout" mode="next">
  <xsl:copy-of select="*" />
 </xsl:template>
 
</xsl:stylesheet>
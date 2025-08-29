<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 exclude-result-prefixes="xs math xd"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Jul 11, 2025</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:variable name="new-line" select="'&#xd;&#xa;'"/>
 
 <xsl:output method="text" indent="no" />
 <xsl:mode on-no-match="shallow-skip"/>
 
 <xsl:template match="page">
  <xsl:value-of select="concat('#', @ID, ' ')"/>
  <xsl:apply-templates />
 </xsl:template>
 
 <xsl:template match="block">
  <xsl:value-of select="$new-line"/>
  <xsl:value-of select="concat('#', @ID, ' ')"/>
  <xsl:apply-templates />
 </xsl:template>
 
 
 <xsl:template match="line">
  <xsl:variable name="prev-line" select="preceding::line[1]" />
  <xsl:variable name="next-line" select="following::line[1]" />
  <xsl:if test="@role=('start')">
   <xsl:value-of select="$new-line"/>
   <xsl:if test="not($prev-line/@role='end')">
    <xsl:value-of select="$new-line"/> 
   </xsl:if>
  </xsl:if>
  <xsl:value-of select="@text"/>
  <xsl:choose>
   <xsl:when test="@role=('end')">
    <xsl:value-of select="$new-line"/>
    <xsl:if test="not($next-line/@role='start')">
     <xsl:value-of select="$new-line"/> 
    </xsl:if>
   </xsl:when>
   <xsl:otherwise>
    <xsl:value-of select="' '"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>
 
</xsl:stylesheet>
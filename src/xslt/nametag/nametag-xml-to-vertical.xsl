<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 exclude-result-prefixes="xs math xd"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Jan 5, 2025</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>


 <xsl:variable name="new-line" select="'&#xa;'"/>
 <xsl:strip-space elements="*"/>
 <xsl:mode on-no-match="shallow-skip"/>
 <xsl:output method="text" />
 
 <xsl:template match="sentence"><xsl:apply-templates /><xsl:value-of select="$new-line"/></xsl:template>
 <xsl:template match="token"><xsl:value-of select="."/><xsl:value-of select="$new-line"/></xsl:template>
 
</xsl:stylesheet>
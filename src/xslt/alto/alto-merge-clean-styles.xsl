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
   <xd:p><xd:b>Created on:</xd:b> 2025-07-05</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:mode on-no-match="shallow-copy"/>
 <xsl:output indent="yes" />
 
 <xsl:template match="alto2:Styles | alto3:Styles | alto4:Styles">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:for-each-group select="alto2:TextStyle | alto3:TextStyle | alto4:TextStyle" group-by="@laalto:key">
    <xsl:sort select="@laalto:key" />
    <xsl:variable name="style" select="current-group()[1]"/>
    <xsl:element name="{local-name($style)}" namespace="{namespace-uri($style)}">
     <xsl:attribute name="ID" select="$style/@laalto:key" />
     <xsl:copy-of select="$style/@* except ($style/@ID, $style/@laalto:key)" />
    </xsl:element>
   </xsl:for-each-group>
   
   <xsl:for-each-group select="alto2:ParagraphStyle | alto3:ParagraphStyle | alto4:ParagraphStyle" group-by="@laalto:key">
    <xsl:sort select="@laalto:key" />
    <xsl:variable name="style" select="current-group()[1]"/>
    <xsl:element name="{local-name($style)}" namespace="{namespace-uri($style)}">
     <xsl:attribute name="ID" select="$style/@laalto:key" />
     <xsl:copy-of select="$style/@* except ($style/@ID, $style/@laalto:key)" />
    </xsl:element>
   </xsl:for-each-group>
   
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="@laalto:STYLEREFS" />
 <xsl:template match="@STYLEREFS">
  <xsl:attribute name="{local-name(.)}" select="parent::*/@laalto:STYLEREFS" namespace="{namespace-uri(@STYLEREFS)}" />
 </xsl:template>
 
 
</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
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
 
 <xsl:import href="_alto-common.xsl"/>
 
 <xsl:param name="page-order" as="xs:integer" select="2" />
 <xsl:mode on-no-match="shallow-copy"/>
 <xsl:variable name="page-id" select="'P' || format-integer($page-order, $page-id-picture)"/>
 
 <xsl:template match="alto2:Page | alto3:Page | alto4:Page">
  <xsl:copy>
   <xsl:attribute name="ID" select="$page-id" />
   <xsl:attribute name="PHYSICAL_IMG_NR" select="$page-order" />
   <xsl:copy-of select="@* except (@ID, @PHYSICAL_IMG_NR)" />
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="alto2:*[@ID] | alto3:*[@ID] | alto4:*[@ID]">
  <xsl:copy>
   <xsl:attribute name="ID" select="$page-id || '.' || @ID" />
   <xsl:copy-of select="@* except @ID" />
   <xsl:apply-templates select="@STYLEREFS" />
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="alto2:TextStyle | alto3:TextStyle | alto4:TextStyle
  | alto2:ParagraphStyle | alto3:ParagraphStyle | alto4:ParagraphStyle" priority="2">
  <xsl:copy>
   <xsl:attribute name="ID" select="$page-id || '.' || @ID" />
   <xsl:copy-of select="@* except @ID" />
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="@STYLEREFS">
  <xsl:variable name="refs" select="tokenize(.)"/>
  <xsl:attribute name="{name()}" select="string-join((for $ref in $refs return $page-id || '.' || $ref), ' ')" />
 </xsl:template>
 
 
</xsl:stylesheet>
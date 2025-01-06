<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:ns="http://www.namescape.nl/" 
 xmlns:alto="http://schema.ccs-gmbh.com/ALTO" 
 xmlns:alto-v2="http://www.loc.gov/standards/alto/ns-v2#"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns="http://www.tei-c.org/ns/1.0"  
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 exclude-result-prefixes="xs xd tei"
 version="2.0">
 <xsl:import href="alto2tei-functions.xsl"/>
 
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Aug 12, 2021</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:template match="alto-v2:Illustration">
  <figure>
   <xsl:call-template name="setId"/>
  </figure>
 </xsl:template>
 
 <xsl:template match="alto-v2:GraphicalElement">
  <graphic>
   <xsl:call-template name="setId"/>
  </graphic>
 </xsl:template>
 
 <xsl:template match="alto-v2:Illustration | alto-v2:GraphicalElement" mode="facsimile">
  <tei:zone>
   <xsl:attribute name="type">
    <xsl:value-of select="name(.)"/>
   </xsl:attribute>
   <xsl:call-template name="setId_facs"/>
   <xsl:if test="@HPOS and @WIDTH">
    <xsl:attribute name="ulx" select="ns:scaleCoordinates(xs:integer(@HPOS))"/>
    <xsl:attribute name="uly" select="ns:scaleCoordinates(xs:integer(@VPOS))"/>
    <xsl:attribute name="lrx" select="ns:scaleCoordinates(xs:integer(@HPOS)) + ns:scaleCoordinates(xs:integer(@WIDTH))"/>
    <xsl:attribute name="lry" select="ns:scaleCoordinates(xs:integer(@VPOS)) + ns:scaleCoordinates(xs:integer(@HEIGHT))"/>
   </xsl:if>
   <xsl:apply-templates mode="#current"/>
  </tei:zone>
 </xsl:template>
 
</xsl:stylesheet>
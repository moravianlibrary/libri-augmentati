<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:ns="http://www.namescape.nl/"
 xmlns:alto="http://schema.ccs-gmbh.com/ALTO" 
 xmlns:tei="http://www.tei-c.org/ns/1.0" 
 exclude-result-prefixes="xs xd"
 version="2.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Aug 12, 2021</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:param name="scale">1</xsl:param>
 <xsl:param name="generateIds">true</xsl:param>
 
 <xd:doc scope="component">
  <xd:desc>
   <xd:p></xd:p>
  </xd:desc>
  <xd:param name="value"/>
 </xd:doc>
 <xsl:function name="ns:scaleCoordinates">
  <xsl:param name="value" as="xs:integer"/>
  <xsl:value-of select="$value * $scale"/>
 </xsl:function>
 
 
 <xsl:template name="setId_facs">
  <xsl:if test="@ID or $generateIds = 'true'">
   <xsl:attribute name="xml:id">
    <xsl:choose>
     <xsl:when test="@ID">f<xsl:value-of select="@ID"/></xsl:when>
     <xsl:otherwise>f<xsl:number level="any" count="*"/></xsl:otherwise>
    </xsl:choose>
   </xsl:attribute>
  </xsl:if>
 </xsl:template>
 
 <xsl:template name="setId">
  <xsl:if test="@ID or $generateIds = 'true'">
   <xsl:attribute name="xml:id">
    <xsl:choose>
     <xsl:when test="@ID">
      <xsl:value-of select="@ID"/>
     </xsl:when>
     <xsl:otherwise>e<xsl:number level="any" count="*"/></xsl:otherwise>
    </xsl:choose>
   </xsl:attribute>
   <xsl:attribute name="facs">
    <xsl:choose>
     <xsl:when test="@ID">#f<xsl:value-of select="@ID"/></xsl:when>
     <xsl:otherwise>#f<xsl:number level="any" count="*"/></xsl:otherwise>
    </xsl:choose>
   </xsl:attribute>
  </xsl:if>
  <xsl:if test="@STYLEREFS">
   <xsl:attribute name="rendition">#<xsl:value-of select="@STYLEREFS"/></xsl:attribute>
  </xsl:if>
  <xsl:if test="@STYLE">
   <xsl:attribute name="rend">
    <xsl:value-of select="@STYLE"/>
   </xsl:attribute>
  </xsl:if>
 </xsl:template>
 
</xsl:stylesheet>
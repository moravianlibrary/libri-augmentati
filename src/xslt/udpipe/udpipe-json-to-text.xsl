<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:fn="http://www.w3.org/2005/xpath-functions" 
 xmlns:laud="https://www.mzk.cz/ns/libri-augmentati/udpipe/1.0" 
 exclude-result-prefixes="xs fn"
 version="3.0">
 
 <xsl:variable name="rn" select="'&#xd;&#xa;'"/> <!-- &#xa; -->
 <xsl:variable name="tab" select="'&#x9;'"/>
 <xsl:output method="text" />
 
 <xsl:template match="/">
   <xsl:apply-templates select="laud:result" />
 </xsl:template>
 
  <xsl:template  match="laud:result">
  <xsl:variable name="text" as="xs:string">
    <xsl:value-of select="."/>
   <!--<xsl:value-of select="replace(string(.), '\\t', $tab)"/> -->
    <!--<xsl:value-of select="replace(string(.), '\\', 'QQQ')"/>-->
  </xsl:variable>
  <!--<xsl:value-of select="$text => replace('\\t', $tab) => replace('\\n', $rn)"/>-->
  <xsl:value-of select="$text 
   => replace('\\t', $tab)
   => replace('\\n\\n', $rn)
   => replace('\\n', $rn) 
   => replace('SpacesAfter=\\\\s\\\\r\\', 'SpacesAfter=No')
   => replace('\\\\r', '')
   => replace('=\\', '=')
   "/>
 </xsl:template>
 <!-- => replace(., '\\n', $rn)  -->
 
</xsl:stylesheet>
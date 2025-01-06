<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 exclude-result-prefixes="xs math xd"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Dec 26, 2024</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 
 <xsl:output method="text" />
 
 <xsl:variable name="ns-lant" select="concat('xmlns:lant=', '&#x22;', 'https://www.mzk.cz/ns/libri-augmentati/nametag/1.0', '&#x22;')" />
 <xsl:variable name="root" select="'lant:result'"/>

 <xsl:template match="/">
   <xsl:variable name="text">
    <xsl:value-of select="string(/*/.) => replace('\\\\r\\\\n', '') => normalize-space()" />
   </xsl:variable>
   <xsl:value-of select="concat('&lt;', $root, ' source=', '&#x22;', 'NameTag', '&#x22;', ' ', $ns-lant ,'&gt;', $text, '&lt;/', $root, '&gt;')" />
 </xsl:template>
 
</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:laalto="https://www.mzk.cz/ns/libri-augmentati/alto/1.0"
 xmlns:alto2="http://www.loc.gov/standards/alto/ns-v2#"
 xmlns:alto3="http://www.loc.gov/standards/alto/ns-v3#"
 xmlns:alto4="http://www.loc.gov/standards/alto/ns-v4#"
 xmlns="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs math xd"
 version="3.0">

 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> 2025-07-05</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:key name="text-style" use="@ID" match="alto2:TextStyle | alto3:TextStyle | alto4:TextStyle" />
 <xsl:key name="paragraph-style" use="@ID" match="alto2:ParagraphStyle | alto3:ParagraphStyle | alto4:ParagraphStyle" />
 <xsl:key name="style" use="@ID" match="alto2:TextStyle | alto3:TextStyle | alto4:TextStyle | alto2:ParagraphStyle | alto3:ParagraphStyle | alto4:ParagraphStyle" />
 
 
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:template match="alto2:alto | alto3:alto | alto4:alto">
  <xsl:copy>
   <xsl:namespace name="laalto" select="'https://www.mzk.cz/ns/libri-augmentati/alto/1.0'" />
   <xsl:copy-of select="@*" />
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="*[@STYLEREFS]">
  <xsl:variable name="values" select="tokenize(@STYLEREFS)"/>
  <xsl:variable name="keys" select="for $value in $values return laalto:get-style-key(key('style', $value)) "/>
  
  <xsl:copy>
    <xsl:copy-of select="@*" />
   <xsl:attribute name="laalto:{local-name(@STYLEREFS)}" select="string-join($keys, ' ')" namespace="https://www.mzk.cz/ns/libri-augmentati/alto/1.0" />
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="alto2:TextStyle | alto3:TextStyle | alto4:TextStyle | alto4:TextStyle | alto2:ParagraphStyle | alto3:ParagraphStyle | alto4:ParagraphStyle">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:variable name="key" select="laalto:get-style-key(.)"/>
   <xsl:attribute name="key" namespace="https://www.mzk.cz/ns/libri-augmentati/alto/1.0" select="$key" />
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
 <xsl:function name="laalto:get-style-key" as="xs:string">
  <xsl:param name="style" as="element()" />
  <xsl:variable name="attributes" as="attribute()*">
   <xsl:for-each select="$style/@* except $style/@ID">
    <xsl:sort select="local-name(.)" />
    <xsl:attribute name="{local-name(.)}" select="." />
   </xsl:for-each>
  </xsl:variable>
  <xsl:variable name="items" select="for $attribute in $attributes return concat($attribute/local-name(), '_', replace($attribute/string(), '\s', '-'))"/>
  <xsl:variable name="key" select="if(count($items) eq 0) then $style/@ID else string-join($items, '__')"/>
  <xsl:value-of select="$key"/>
 </xsl:function>
 
</xsl:stylesheet>
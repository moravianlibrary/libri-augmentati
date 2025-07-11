<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:map="http://www.w3.org/2005/xpath-functions/map"
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
 <xsl:output indent="yes" />
 
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:variable name="page-id" select="'P' || format-integer($page-order, $page-id-picture)"/>
 <xsl:variable name="element-ids" select="map {
  'TopMargin' : map {'prefix' : 'TM', 'id-regex' : 'P\d{4}_TM\d{4}'},
  'LeftMargin' : map {'prefix' : 'LM', 'id-regex' : 'P\d{4}_LM\d{4}'},
  'RightMargin' : map {'prefix' : 'RM', 'id-regex' : 'P\d{4}_RM\d{4}'},
  'BottomMargin' : map {'prefix' : 'BM', 'id-regex' : 'P\d{4}_BM\d{4}'},
  'PrintSpace' : map {'prefix' : 'PS', 'id-regex' : 'P\d{4}_PS\d{4}'},
  'ComposedBlock' : map {'prefix' : 'CB', 'id-regex' : 'P\d{4}_CB\d{4}'},
  'GraphicalElement' : map {'prefix' : 'GE', 'id-regex' : 'P\d{4}_GE\d{4}_SUB'},
  'TextBlock' : map {'prefix' : 'TB', 'id-regex' : 'P\d{4}_TB\d{4}'},
  'TextLine'  : map {'prefix' : 'TL', 'id-regex' : 'P\d{4}_TL\d{4}'},
  'String'    : map {'prefix' : 'ST', 'id-regex' : 'P\d{4}_ST\d{4}'},
  'SP'    : map {'prefix' : 'SP', 'id-regex' : 'P\d{4}_SP\d{4}'}
  }"/>
 
 <xsl:variable name="element-names" select="map:keys($element-ids)" /> 
 
 <xsl:template match="alto2:Page | alto3:Page | alto4:Page" priority="5">
  <xsl:copy>
   <xsl:attribute name="ID" select="$page-id" />
   <xsl:attribute name="PHYSICAL_IMG_NR" select="$page-order" />
   <xsl:copy-of select="@* except (@ID, @PHYSICAL_IMG_NR)" />
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>

 <xsl:template match="alto2:TextStyle | alto3:TextStyle | alto4:TextStyle
  | alto2:ParagraphStyle | alto3:ParagraphStyle | alto4:ParagraphStyle" priority="3">
  <xsl:copy>
   <xsl:attribute name="ID" select="$page-id || '.' || @ID" />
   <xsl:copy-of select="@* except @ID" />
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 

 <xsl:template match="alto2:*[@ID] | alto3:*[@ID] | alto4:*[@ID]" priority="2">
  <xsl:variable name="name" select="name()"/>
  <xsl:variable name="position">
   <xsl:number level="any" />
  </xsl:variable>
  <xsl:variable name="id">
   <xsl:choose>
    <xsl:when test="map:contains($element-ids, $name)">
     <xsl:value-of select="$page-id || '_' || $element-ids?($name)?prefix || format-integer($position, $page-id-picture) "/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:value-of select="$page-id || '.' || @ID"/>
    </xsl:otherwise>
   </xsl:choose> 
  </xsl:variable>
  
  <xsl:copy>
   <xsl:attribute name="ID" select="$id" />
   <xsl:copy-of select="@* except @ID" />
   <xsl:apply-templates select="@STYLEREFS" />
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="alto2:*[name() = $element-names] | alto3:*[name() = $element-names] | alto4:*[name() = $element-names]">
  <xsl:variable name="name" select="name()"/>
  <xsl:variable name="position">
   <xsl:number level="any" />
  </xsl:variable>
  <xsl:variable name="id" select="$page-id || '_' || $element-ids?($name)?prefix || format-integer($position, $page-id-picture)" />
  <xsl:copy>
   <xsl:attribute name="ID" select="$id" />
   <xsl:copy-of select="@* except @ID" />
   <xsl:apply-templates select="@STYLEREFS" />
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
 
 <xsl:template match="@STYLEREFS">
  <xsl:variable name="refs" select="tokenize(.)"/>
  <xsl:attribute name="{name()}" select="string-join((for $ref in $refs return $page-id || '.' || $ref), ' ')" />
 </xsl:template>
 
 
</xsl:stylesheet>
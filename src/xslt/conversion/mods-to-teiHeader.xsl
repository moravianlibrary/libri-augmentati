<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:foxml="info:fedora/fedora-system:def/foxml#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:or="http://www.nsdl.org/ontologies/relationships#" xmlns:dl4dh="https://system-kramerius.cz/ns/xproc/dl4dh/1.0"
 xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/" 
 xmlns:dc="http://purl.org/dc/elements/1.1/"
 xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0" xmlns:mods="http://www.loc.gov/mods/v3" exclude-result-prefixes="xs math xd foxml rdf or tei mods dl4dh oai_dc dc" version="2.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Jul 11, 2021</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p/>
  </xd:desc>
 </xd:doc>

 <xsl:param name="availability" as="element(tei:availability)*" />
 <xsl:param name="textClass" as="element(tei:textClass)?" />
 <xsl:param name="appInfo" as="element(tei:appInfo)*" />
 
 <xsl:output method="xml" indent="yes"/>

 <xsl:template match="mods:modsCollection">
  <teiHeader>
   <xsl:apply-templates/>
  </teiHeader>
 </xsl:template>

 <xsl:template match="mods:mods">
  <fileDesc>
   <titleStmt>
    <xsl:choose>
     <xsl:when test="mods:titleInfo[mods:title]">
      <xsl:apply-templates select="mods:titleInfo" mode="titleStmt"/>
     </xsl:when>
     <xsl:otherwise>
      <xsl:apply-templates select="/foxml:digitalObject/foxml:datastream[@ID='DC']/foxml:datastreamVersion/foxml:xmlContent/oai_dc:dc/dc:title" mode="titleStmt" />
     </xsl:otherwise>
    </xsl:choose>
    
    <xsl:apply-templates select="mods:name" mode="titleStmt"/>
   </titleStmt>
   <xsl:apply-templates select="mods:physicalDescription" /> <!-- tj. extent -->
   <publicationStmt>
   <xsl:apply-templates select="mods:originInfo"/>
    <xsl:apply-templates select="mods:identifier" />
    <xsl:copy-of select="$availability"/>
   </publicationStmt>
   <sourceDesc>
    <bibl/>
   </sourceDesc>
  </fileDesc>
  <encodingDesc>
   <appInfo>
    <xsl:copy-of select="$appInfo/tei:application" />
   </appInfo>
  </encodingDesc>
  <profileDesc>
   <xsl:copy-of select="$textClass"/>
   <langUsage>
    <xsl:apply-templates select="mods:language"/>
   </langUsage>
  </profileDesc>
 </xsl:template>
 
 
  <xsl:template match="dc:title" mode="titleStmt">
   <title><xsl:apply-templates /></title>
  </xsl:template>
 
 <!--
  Ukázky:
  
  <mods:titleInfo> 
    <mods:nonSort>Das</mods:nonSort>  
    <mods:title>Erdbeben in Chili</mods:title> 
  </mods:titleInfo>

  <mods:titleInfo>
    <mods:partNumber>[1]</mods:partNumber>
  </mods:titleInfo>

  <mods:titleInfo> 
    <mods:title>[Neues Taschenwörterbuch der böhmischen und deutschen Sprache</mods:title> 
  </mods:titleInfo>  
  <mods:titleInfo type="alternative"> 
    <mods:title>Nový kapesní slovník česko-německý a německo-český</mods:title> 
  </mods:titleInfo>  
  <mods:titleInfo type="alternative"> 
    <mods:title>Kapesní slovník česko-německý a německo-český</mods:title> 
  </mods:titleInfo>  
  <mods:titleInfo type="alternative"> 
    <mods:title>Taschenwörterbuch der deutschen und böhmischen Sprache</mods:title> 
  </mods:titleInfo>  
 
 -->
 
 <xsl:template match="mods:titleInfo" mode="titleStmt">
  <title>
   <xsl:if test="@type='alternative'">
    <xsl:attribute name="type" select="'alt'" />
   </xsl:if>
   <xsl:apply-templates select="mods:nonSort | mods:title" mode="#current" />
  </title>
  <xsl:apply-templates select="mods:subTitle" mode="#current" />
 </xsl:template>
 
 <xsl:template match="mods:nonSort" mode="titleStmt">
  <xsl:apply-templates />
  <xsl:text> </xsl:text>
 </xsl:template>
 
 <xsl:template match="mods:title" mode="titleStmt">
   <xsl:apply-templates/>
 </xsl:template>
 
 <xsl:template match="mods:subTitle" mode="titleStmt">
  <title type='sub'>
   <xsl:apply-templates />
  </title>
 </xsl:template>

 <xsl:template match="mods:mods/mods:name[mods:role/mods:roleTerm[@authority = 'marcrelator' and @type = 'code'][. = ('aut', 'aui')]]" mode="titleStmt">
  <author>
   <persName><xsl:value-of select="mods:namePart[not(@type)]"/></persName>
   <idno type="mods:nameIdentifier"><xsl:value-of select="mods:nameIdentifier"/></idno>
  </author>
 </xsl:template>
 
 <xsl:template match="mods:mods/mods:name[mods:role/mods:roleTerm[@authority = 'marcrelator' and @type = 'code'][. = ('com')]]" mode="titleStmt">
  <editor>
   <persName><xsl:value-of select="mods:namePart[not(@type)]"/></persName>
   <idno type="mods:nameIdentifier"><xsl:value-of select="mods:nameIdentifier"/></idno>
  </editor>
 </xsl:template>

 <xsl:template match="mods:originInfo">
  
   <xsl:apply-templates select="mods:publisher"/>
   <xsl:apply-templates select="mods:place"/>
   <xsl:apply-templates select="mods:dateIssued" />
  
 </xsl:template>

 <xsl:template match="mods:publisher">
  <publisher>
   <xsl:apply-templates/>
  </publisher>
 </xsl:template>

 <xsl:template match="mods:place/mods:placeTerm[not(@authority)]">
  <pubPlace>
   <xsl:apply-templates/>
  </pubPlace>
 </xsl:template>

 <xsl:template match="mods:dateIssued">
  <date>
   <xsl:apply-templates/>
  </date>
 </xsl:template>

 <xsl:template match="mods:languageTerm">
  <language ident="{.}">
   <xsl:value-of select="."/>
  </language>
 </xsl:template>
 
 <xsl:template match="mods:physicalDescription">
  <xsl:apply-templates select="mods:extent" />
 </xsl:template>
 
 <xsl:template match="mods:extent">
  <extent><xsl:apply-templates /></extent>
 </xsl:template>
 
 <xsl:template match="mods:identifier">
  <idno type="{@type}" ><xsl:apply-templates /></idno>
 </xsl:template>

 <xsl:template match="/">
  <xsl:apply-templates select="foxml:digitalObject/foxml:datastream[@ID = 'BIBLIO_MODS']/foxml:datastreamVersion/foxml:xmlContent"/>
 </xsl:template>

 <xsl:template match="foxml:xmlContent[mods:modsCollection]" priority="2">
  <xsl:apply-templates/>
 </xsl:template>

 <xsl:template match="mods:typeOfResource | mods:genre"/>

 <xsl:template match="mods:placeTerm[@authority = 'marccountry' and @type = ('code', 'text')]"/>

 <xsl:template match="mods:issuance"/>

 <xsl:template match="mods:titleInfo"/>

 <xsl:template match="mods:name"/>

</xsl:stylesheet>

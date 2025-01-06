<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:foxml="info:fedora/fedora-system:def/foxml#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:or="http://www.nsdl.org/ontologies/relationships#" xmlns:dl4dh="https://system-kramerius.cz/ns/xproc/dl4dh/1.0"
  xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/" 
 xmlns:dc="http://purl.org/dc/elements/1.1/"
 xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0" xmlns:mods="http://www.loc.gov/mods/v3" exclude-result-prefixes="xs math xd foxml rdf or tei mods oai_dc dc dl4dh" version="3.0">
 <xsl:import href="mods-to-teiHeader.xsl"/>
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Jan 05, 2025</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p/>
  </xd:desc>
 </xd:doc>

 <xsl:param name="tei-page" as="element(tei:TEI)" />
 <!--<xsl:param name="file-name" />
 <xsl:param name="file-path" select="concat('file:/D:/Data/Dropbox/Zavazky/DL4DH/Znackovani/Xml/Tei/Merge/', $file-name, '.xml')"/>-->

 <!--
  https://stackoverflow.com/questions/8931697/xslt-stylesheet-parameters-in-imported-stylesheets/8956135
  An xsl:variable in an importing stylesheet can override an xsl:param in an imported stylesheet
 -->
 <xsl:variable name="availability" as="element(tei:availability)*" select="$tei-page//tei:availability"/>
 <xsl:variable name="textClass" as="element(tei:textClass)?" select="$tei-page//tei:textClass"/>
 <xsl:variable name="appInfo" as="element(tei:appInfo)*" select="$tei-page//tei:appInfo"/>


 <xsl:template match="/">
  <TEI xmlns="http://www.tei-c.org/ns/1.0">
   <xsl:apply-templates select="foxml:digitalObject//mods:modsCollection"/>
   <text>
    <body>
     <!--<xsl:apply-templates select="//rdf:RDF//or:hasPage"/>-->
    </body>
   </text>
  </TEI>
 </xsl:template>

 <xsl:template match="or:hasPage">
  <xsl:variable name="uuid" select="substring-after(@rdf:resource, 'uuid:')"/>
  <xsl:variable name="doc" select="doc(concat('file:/D:/Data/Dropbox/Zavazky/DL4DH/Znackovani/Xml/Tei/Merge/', $uuid, '.xml'))"/>
  <div>
   <pb n="{$uuid}"/>
   <xsl:copy-of select="$doc//tei:body/tei:div/*"/>
  </div>
 </xsl:template>
</xsl:stylesheet>

<p:library  xmlns:p="http://www.w3.org/ns/xproc" 
 xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:lad="https://www.mzk.cz/ns/libri-augmentati/documents/1.0"
 xmlns:lap="https://www.mzk.cz/ns/libri-augmentati/processing/1.0"
 xmlns:las="https://www.mzk.cz/ns/libri-augmentati/settings/1.0"
 xmlns:lar="https://www.mzk.cz/ns/libri-augmentati/report/1.0"
 xmlns:lax="https://www.mzk.cz/ns/libri-augmentati/xproc/1.0"
 xmlns:lae="https://www.mzk.cz/ns/libri-augmentati/enrichment/1.0"
 xmlns:lant="https://www.mzk.cz/ns/libri-augmentati/nametag/1.0"
 xmlns:xhtml="http://www.w3.org/1999/xhtml"
 version="3.0">
 
 <p:import href="nametag.xpl"/>
 <p:import href="udpipe.xpl"/>
 <p:import href="alto.xpl"/>
 <p:import href="tei.xpl"/>
 
 <p:documentation>
  <xhtml:section xml:lang="en">
   <xhtml:h1>Enrichment</xhtml:h1>
   <xhtml:p>The main programming library for enrichment data by external (web) services.</xhtml:p>
  </xhtml:section>
  <xhtml:section xml:lang="cs">
   <xhtml:h1>Obohacení</xhtml:h1>
   <xhtml:p>Hlavní programová knihovna pro obohacení dat pomocí externích (webových) služeb.</xhtml:p>
  </xhtml:section>
 </p:documentation>

 
 <p:declare-step type="lae:enrich-data" name="enriching-data">
  <!-- INPUT PORTS -->
  <p:input port="source" primary="true" sequence="true">
   <p:documentation>
    <xhtml:p xml:lang="en">Sequence of virtual documents.</xhtml:p>
    <xhtml:p xml:lang="cs">Sekvence virtuálních dokumentů.</xhtml:p>
   </p:documentation>
  </p:input>
  
  
  <p:input port="settings" primary="false">
   <p:documentation>
    <xhtml:p xml:lang="en">Settings for web services for enrichement.</xhtml:p>
    <xhtml:p xml:lang="cs">Nastavení webových služeb pro obohacení.</xhtml:p>
   </p:documentation>
  </p:input>
  
  <p:input port="report-in" sequence="true">
   <lar:report />
  </p:input>
  
  
  <!-- OUTPUT PORTS -->
  <p:output port="result" primary="true" sequence="true">
   <p:documentation>
    <xhtml:p xml:lang="en">Sequence of virtual documents.</xhtml:p>
    <xhtml:p xml:lang="cs">Sekvence virtuálních dokumentů.</xhtml:p>
   </p:documentation>
  </p:output>
  
  <p:output port="report" pipe="report-in@enriching-data" />
  
  
  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
  
  <p:option name="output-directory" required="true" as="xs:string" />
  <p:option name="pause-before-request" select="2" as="xs:integer"/>
  
  <p:option name="output-format" values="('TEXT', 'TEI')" as="xs:string*" />
  <p:option name="enrichment" values="('ENTITIES', 'MORPHOLOGY')" as="xs:string*"/>
  
  <p:if test="$enrichment = 'ENTITIES'">
   <lae:enrich-by-entities 
    output-directory="{$output-directory}" 
    debug-path="{$debug-path}" 
    base-uri="{$base-uri}">
    <p:with-input port="settings" pipe="settings@enriching-data" />
    <p:with-input port="report-in" pipe="report-in@enriching-data" />
   </lae:enrich-by-entities>
  </p:if>
  
  <p:if test="$enrichment = 'MORPHOLOGY'">
   <lae:enrich-by-morphology
    output-directory="{$output-directory}" 
    debug-path="{$debug-path}" 
    base-uri="{$base-uri}">
    <p:with-input port="settings" pipe="settings@enriching-data" />
    <p:with-input port="report-in" pipe="report-in@enriching-data" />
   </lae:enrich-by-morphology>
  </p:if>
  
  
  <!--
  <lax:enrich-document-data p:use-when="true()"
   output-format="TEXT TEI"
   output-directory="{$main-output-directory}" 
   debug-path="{$debug-path}" 
   base-uri="{$base-uri}"
   pause-before-request="0"
   >
   <p:with-option name="enrichment" select="('ENTITIES', 'MORPHOLOGY')"></p:with-option>
   <p:with-input port="report-in" pipe="report@download-data" />
   <p:with-input port="settings" href="../settings/services.xml" />
  </lax:enrich-document-data>-->
  
  
 </p:declare-step>
 
 <p:declare-step type="lae:enrich-by-entities" name="enriching-by-entities">
  <p:documentation>
   <xhtml:section xml:lang="en">
    <xhtml:h2>Enrich by entities</xhtml:h2>
    <xhtml:p>Enriches available (textual) data by named entities.</xhtml:p>
   </xhtml:section>
   <xhtml:section xml:lang="cs">
    <xhtml:h2>Obohacení o entity</xhtml:h2>
    <xhtml:p>Obohatí dostupná (textová) data o pojmenované entity.</xhtml:p>
   </xhtml:section>
  </p:documentation>
  
  <!-- INPUT PORTS -->
  <p:input  port="source" primary="true" sequence="true">
   <p:documentation>
    <xhtml:p xml:lang="en">Sequence of virtual documents.</xhtml:p>
    <xhtml:p xml:lang="cs">Sekvence virtuálních dokumentů.</xhtml:p>
   </p:documentation>   
  </p:input>
  
  <p:input  port="settings" primary="false">
   <p:documentation>
    <xhtml:p xml:lang="en">Settings for web services for enrichement.</xhtml:p>
    <xhtml:p xml:lang="cs">Nastavení webových služeb pro obohacení.</xhtml:p>
   </p:documentation>
  </p:input>
  
  <p:input  port="report-in">
   <lar:report />
  </p:input>
  
  <!-- OUTPUT PORTS -->
  <p:output port="result" primary="true" sequence="true"  pipe="result@final">
   <p:documentation>
    <xhtml:p xml:lang="en">Sequence of virtual documents.</xhtml:p>
    <xhtml:p xml:lang="cs">Sekvence virtuálních dokumentů.</xhtml:p>
   </p:documentation>   
  </p:output>
  
  <p:output port="report" pipe="result@report-final" />
  
  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
  <p:option name="output-directory" required="true" as="xs:string" />
  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
    
  <!-- PIPELINE BODY -->
  
  <p:insert position="last-child" name="report-start">
   <p:with-input port="source" pipe="report-in@enriching-by-entities" />
   <p:with-input port="insertion">
    <p:inline><lax:step type="lae:enrich-by-entities" start="{current-dateTime()}" /></p:inline>
   </p:with-input>
  </p:insert>
  
  <lant:get-nametag-analyses 
   output-directory="{$output-directory}" 
   debug-path="{$debug-path}" 
   base-uri="{$base-uri}">
   <p:with-input port="source" pipe="source@enriching-by-entities" />
   <p:with-input port="settings" pipe="settings@enriching-by-entities" />
   <p:with-input port="report-in" pipe="result@report-start" />
  </lant:get-nametag-analyses>
  
  <p:identity name="final" />
  
  <p:add-attribute match="lax:step[@type='lae:enrich-by-entities'][not(@end)]" 
   attribute-name="end" 
   attribute-value="{current-dateTime()}"
   name="report-final">
   <p:with-input port="source" pipe="result@report-start" />
  </p:add-attribute>
 
 </p:declare-step>
 
 <p:declare-step type="lae:enrich-by-morphology" name="enriching-by-morphology">
  
  <p:documentation>
   <xhtml:section xml:lang="en">
    <xhtml:h2>Enrich by morphology</xhtml:h2>
    <xhtml:p>Enriches available (textual) data by morphological and syntactic analysis.</xhtml:p>
   </xhtml:section>
   <xhtml:section xml:lang="cs">
    <xhtml:h2>Obohacení o entity</xhtml:h2>
    <xhtml:p>Obohatí dostupná (textová) data o morfologickou a syntaktickou analýzu.</xhtml:p>
   </xhtml:section>
  </p:documentation>
  
  <!-- INPUT PORTS -->
  <p:input  port="source" primary="true" sequence="true">
   <p:documentation>
    <xhtml:p xml:lang="en">Sequence of virtual documents.</xhtml:p>
    <xhtml:p xml:lang="cs">Sekvence virtuálních dokumentů.</xhtml:p>
   </p:documentation>   
  </p:input>
  
  <p:input  port="settings" primary="false">
   <p:documentation>
    <xhtml:p xml:lang="en">Settings for web services for enrichement.</xhtml:p>
    <xhtml:p xml:lang="cs">Nastavení webových služeb pro obohacení.</xhtml:p>
   </p:documentation>
  </p:input>
  
  <p:input  port="report-in">
   <p:inline><lar:report /></p:inline>
  </p:input>
  
  <!-- OUTPUT PORTS -->
  <p:output port="result" primary="true" sequence="true" pipe="result@final" />
  <p:output port="report" pipe="result@report-final" />
  
  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
  <p:option name="output-directory" required="true" as="xs:string" />
  
  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  
  
  <!-- PIPELINE BODY -->
  <p:insert position="last-child" name="report-start">
   <p:with-input port="source" pipe="report-in@enriching-by-morphology" />
   <p:with-input port="insertion">
    <p:inline><lax:step type="lae:enrich-by-morphology" start="{current-dateTime()}" /></p:inline>
   </p:with-input>
  </p:insert>
  
  <p:identity>
   <p:with-input port="source" pipe="source@enriching-by-morphology" />
  </p:identity>
  
  <p:identity name="final" />
  
  <p:add-attribute match="lax:step[@type='lae:enrich-by-morphology'][not(@end)]" 
   attribute-name="end" 
   attribute-value="{current-dateTime()}"
   name="report-final">
   <p:with-input port="source" pipe="result@report-start" />
  </p:add-attribute>

 </p:declare-step>
 
</p:library>
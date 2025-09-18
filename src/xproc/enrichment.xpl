<p:library  xmlns:p="http://www.w3.org/ns/xproc" 
 xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:lad="https://www.mzk.cz/ns/libri-augmentati/documents/1.0"
 xmlns:lap="https://www.mzk.cz/ns/libri-augmentati/processing/1.0"
 xmlns:las="https://www.mzk.cz/ns/libri-augmentati/settings/1.0"
 xmlns:lar="https://www.mzk.cz/ns/libri-augmentati/report/1.0"
 xmlns:lax="https://www.mzk.cz/ns/libri-augmentati/xproc/1.0"
 xmlns:lae="https://www.mzk.cz/ns/libri-augmentati/enrichment/1.0"
 xmlns:lat="https://www.mzk.cz/ns/libri-augmentati/tei/1.0"
 xmlns:laa="https://www.mzk.cz/ns/libri-augmentati/alto/1.0"
 xmlns:latx="https://www.mzk.cz/ns/libri-augmentati/text/1.0"
 xmlns:lant="https://www.mzk.cz/ns/libri-augmentati/nametag/1.0"
 xmlns:laud="https://www.mzk.cz/ns/libri-augmentati/udpipe/1.0"
 xmlns:xhtml="http://www.w3.org/1999/xhtml"
 version="3.0">
 
 <p:import href="nametag.xpl"/>
 <p:import href="udpipe.xpl"/>
 <p:import href="alto.xpl"/>
 <p:import href="tei.xpl"/>
 <p:import href="text.xpl"/>
 
 <p:documentation>
  <xhtml:meta name="version" content="1.0.0" />
  <xhtml:section xml:lang="en">
   <xhtml:h1>Enrichment</xhtml:h1>
   <xhtml:p>The main programming library for enrichment data by external (web) services.</xhtml:p>
  </xhtml:section>
  <xhtml:section xml:lang="cs">
   <xhtml:h1>Obohacení</xhtml:h1>
   <xhtml:p>Hlavní programová knihovna pro obohacení dat pomocí externích (webových) služeb.</xhtml:p>
  </xhtml:section>
 </p:documentation>

 <!-- STEP -->
 <p:declare-step type="lae:enrich-data" name="enriching-data">
  <p:documentation>
   <xhtml:section xml:lang="en">
    <xhtml:h2>Enrich available data</xhtml:h2>
    <xhtml:p>Enriches available (textual) data by selected fetures.</xhtml:p>
   </xhtml:section>
   <xhtml:section xml:lang="cs">
    <xhtml:h2>Obohacení dostupných dat</xhtml:h2>
    <xhtml:p>Obohatí dostupná (textová) data o vybrané vlastnosti.</xhtml:p>
   </xhtml:section>
  </p:documentation>
  
  <!-- INPUT PORTS -->
  <p:input port="source" primary="true" sequence="true">
   <p:documentation>
    <xhtml:section xml:lang="en"><xhtml:p>Sequence of virtual documents.</xhtml:p></xhtml:section>
    <xhtml:section xml:lang="cs"><xhtml:p>Sekvence virtuálních dokumentů.</xhtml:p></xhtml:section>
   </p:documentation>
  </p:input>
  
  
  <p:input port="settings" primary="false">
   <p:documentation>
    <xhtml:section xml:lang="en"><xhtml:p>Settings for web services for enrichment.</xhtml:p></xhtml:section>
    <xhtml:section xml:lang="cs"><xhtml:p>Nastavení webových služeb pro obohacení.</xhtml:p></xhtml:section>
   </p:documentation>
  </p:input>
  
  <p:input port="report-in" sequence="true">
   <lar:report />
  </p:input>
  
  
  <!-- OUTPUT PORTS -->
  <p:output port="result" primary="true" sequence="true">
   <p:documentation>
    <xhtml:section xml:lang="en"><xhtml:p>Sequence of virtual documents.</xhtml:p></xhtml:section>
    <xhtml:section xml:lang="cs"><xhtml:p>Sekvence virtuálních dokumentů.</xhtml:p></xhtml:section>
   </p:documentation>
  </p:output>
  
  <p:output port="report" pipe="report-in@enriching-data" />
  
  
  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
  
  <p:option name="output-directory" required="true" as="xs:string" />
  <p:option name="pause-before-request" select="2" as="xs:integer"/>
  
  <p:option name="output-format" values="('ALTO', 'TEI', 'TEXT')" as="xs:string*" />
  <p:option name="enrichment" values="('ENTITIES', 'MORPHOLOGY')" as="xs:string*"/>

  <p:identity message="output formats: {string-join($output-format, '; ')}; enrichment: {string-join($enrichment, '; ')}" />

  <p:if test="$output-format = 'TEXT'">
   <lae:combine-text-pages
    output-directory="{$output-directory}" 
    debug-path="{$debug-path}" 
    base-uri="{$base-uri}"
    >
    <p:with-input port="settings" pipe="settings@enriching-data" />
    <p:with-input port="report-in" pipe="report-in@enriching-data" />
   </lae:combine-text-pages>
  </p:if>
  
  <!-- TODO: REDUNDAND? See lax:prepare-text-data -->
  <p:if test="$output-format = 'ALTO'">
   <lae:combine-alto-pages
    output-directory="{$output-directory}" 
    debug-path="{$debug-path}" 
    base-uri="{$base-uri}">
    <p:with-input port="settings" pipe="settings@enriching-data" />
    <p:with-input port="report-in" pipe="report-in@enriching-data" />
   </lae:combine-alto-pages>
  </p:if>
  
  <p:identity  message="   ... $enrichment = 'MORPHOLOGY': {$enrichment = 'MORPHOLOGY'}; "/>
  <p:identity  message="   ... $enrichment = 'ENTITIES': {$enrichment = 'ENTITIES'}"/>
 
  <p:if test="$enrichment = ('ENTITIES', 'MORPHOLOGY')">
   
   <lae:tokenize p:use-when="false()" 
    output-directory="{$output-directory}" 
    debug-path="{$debug-path}" 
    base-uri="{$base-uri}">
    <p:with-input port="settings" pipe="settings@enriching-data" />
    <p:with-input port="report-in" pipe="report-in@enriching-data" />
   </lae:tokenize>
   
   <p:if test="$enrichment = 'MORPHOLOGY'">
    <lae:enrich-by-morphology
     output-directory="{$output-directory}" 
     debug-path="{$debug-path}" 
     base-uri="{$base-uri}">
     <p:with-input port="settings" pipe="settings@enriching-data" />
     <p:with-input port="report-in" pipe="report-in@enriching-data" />
    </lae:enrich-by-morphology>
   </p:if>

   <p:if test="$enrichment = 'ENTITIES'">
    <lae:enrich-by-entities 
     output-directory="{$output-directory}" 
     debug-path="{$debug-path}" 
     base-uri="{$base-uri}">
     <p:with-input port="settings" pipe="settings@enriching-data" />
     <p:with-input port="report-in" pipe="report-in@enriching-data" />
    </lae:enrich-by-entities>
   </p:if>
   
  </p:if>
  
  
  
  <p:if test="$output-format = 'TEI'">
   <lae:convert-to-tei
    output-directory="{$output-directory}" 
    debug-path="{$debug-path}" 
    base-uri="{$base-uri}">
    <p:with-input port="settings" pipe="settings@enriching-data" />
    <p:with-input port="report-in" pipe="report-in@enriching-data" />
   </lae:convert-to-tei>
  </p:if>
  
 </p:declare-step>
 
 <!-- STEP -->
 <p:declare-step type="lae:tokenize" name="tokenizing">
  
  <p:documentation>
   <xhtml:section xml:lang="en">
    <xhtml:h2>Tokenize the text</xhtml:h2>
    <xhtml:p>Apply tokenization on text using morphological and syntactic analysis.</xhtml:p>
   </xhtml:section>
   <xhtml:section xml:lang="cs">
    <xhtml:h2>Tokenizace textu</xhtml:h2>
    <xhtml:p>Rozdělí vstupní text na tokeny pomocí morfologické a syntaktické analýzy.</xhtml:p>
   </xhtml:section>
  </p:documentation>
  
  <!-- INPUT PORTS -->
  <p:input  port="source" primary="true" sequence="true">
   <p:documentation>
    <xhtml:section xml:lang="en"><xhtml:p>Sequence of virtual documents.</xhtml:p></xhtml:section>
    <xhtml:section xml:lang="cs"><xhtml:p>Sekvence virtuálních dokumentů.</xhtml:p></xhtml:section>
   </p:documentation>
  </p:input>
  
  <p:input  port="settings" primary="false">
   <p:documentation>
    <xhtml:section xml:lang="en"><xhtml:p>Settings for web services for enrichment.</xhtml:p></xhtml:section>
    <xhtml:section xml:lang="cs"><xhtml:p>Nastavení webových služeb pro obohacení.</xhtml:p></xhtml:section>
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
  <p:variable name="debug-path-uri" select="p:urify($debug-path, $base-uri)" />
  
  
  <!-- PIPELINE BODY -->
  <p:insert position="last-child" name="report-start">
   <p:with-input port="source" pipe="report-in@tokenizing" />
   <p:with-input port="insertion">
    <p:inline><lax:step type="lae:tokenize" start="{current-dateTime()}" /></p:inline>
   </p:with-input>
  </p:insert>
  
  <!--<p:identity message="enriching morphology">
   <p:with-input port="source" pipe="source@enriching-by-morphology" />
  </p:identity>-->
  
  <p:viewport match="lad:document">
   <p:with-input pipe="source@tokenizing" />
   <p:variable name="document-id" select="if(exists(/lad:document/@nickname))
    then /lad:document/@nickname 
    else if(starts-with(/lad:document/@id, 'uuid:')) 
    then substring-after(/lad:document/@id, 'uuid:') 
    else  /lad:document/@id " />
   
   
   <laud:get-udpipe-tokens p:use-when="false()"
    output-directory="{$output-directory}/{$document-id}" 
    debug-path="{$debug-path}" 
    base-uri="{$base-uri}">
    <p:with-input port="settings" pipe="settings@tokenizing" />
    <p:with-input port="report-in" pipe="result@report-start" />
   </laud:get-udpipe-tokens>
   
  </p:viewport>
  <p:namespace-delete prefixes="laud xs xhtml" />
  <p:identity name="final" />
  
  <p:add-attribute match="lax:step[@type='lae:tokenize'][not(@end)]" 
   attribute-name="end" 
   attribute-value="{current-dateTime()}"
   name="report-final">
   <p:with-input port="source" pipe="result@report-start" />
  </p:add-attribute>
  
 </p:declare-step>
 <!-- STEP -->
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
    <xhtml:section xml:lang="en"><xhtml:p>Sequence of virtual documents.</xhtml:p></xhtml:section>
    <xhtml:section xml:lang="cs"><xhtml:p>Sekvence virtuálních dokumentů.</xhtml:p></xhtml:section>
   </p:documentation>   
  </p:input>
  
  <p:input  port="settings" primary="false">
   <p:documentation>
    <xhtml:section xml:lang="en"><xhtml:p>Settings for web services for enrichment.</xhtml:p></xhtml:section>
    <xhtml:section xml:lang="cs"><xhtml:p>Nastavení webových služeb pro obohacení.</xhtml:p></xhtml:section>
   </p:documentation>
  </p:input>
  
  <p:input  port="report-in">
   <lar:report />
  </p:input>
  
  <!-- OUTPUT PORTS -->
  <p:output port="result" primary="true" sequence="true"  pipe="result@final">
   <p:documentation>
    <xhtml:section xml:lang="en"><xhtml:p>Sequence of virtual documents.</xhtml:p></xhtml:section>
    <xhtml:section xml:lang="cs"><xhtml:p>Sekvence virtuálních dokumentů.</xhtml:p></xhtml:section>
   </p:documentation>   
  </p:output>
  
  <p:output port="report" pipe="result@report-final" />
  
  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
  <p:option name="output-directory" required="true" as="xs:string" />
  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="p:urify($debug-path, $base-uri)" />
    
  <!-- PIPELINE BODY -->
  <p:insert position="last-child" name="report-start">
   <p:with-input port="source" pipe="report-in@enriching-by-entities" />
   <p:with-input port="insertion">
    <p:inline><lax:step type="lae:enrich-by-entities" start="{current-dateTime()}" /></p:inline>
   </p:with-input>
  </p:insert>
  
  <p:viewport match="lad:document">
   <p:with-input pipe="source@enriching-by-entities" />
   <p:variable name="document-id" select="if(exists(/lad:document/@nickname))
    then /lad:document/@nickname 
    else if(starts-with(/lad:document/@id, 'uuid:')) 
    then substring-after(/lad:document/@id, 'uuid:') 
    else  /lad:document/@id " />
   
   <lant:get-nametag-analyses 
    output-directory="{$output-directory}/{$document-id}" 
    debug-path="{$debug-path}" 
    base-uri="{$base-uri}"
    p:message="get-nametag-analyses">
    <p:with-input port="settings" pipe="settings@enriching-by-entities" />
    <p:with-input port="report-in" pipe="result@report-start" />
   </lant:get-nametag-analyses>
  </p:viewport>
  <p:namespace-delete prefixes="lant xs xhtml" />
  <p:identity name="final" />
  
  <p:add-attribute match="lax:step[@type='lae:enrich-by-entities'][not(@end)]" 
   attribute-name="end" 
   attribute-value="{current-dateTime()}"
   name="report-final">
   <p:with-input port="source" pipe="result@report-start" />
  </p:add-attribute>
 
 </p:declare-step>
 
 <!-- STEP -->
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
    <xhtml:section xml:lang="en"><xhtml:p>Sequence of virtual documents.</xhtml:p></xhtml:section>
    <xhtml:section xml:lang="cs"><xhtml:p>Sekvence virtuálních dokumentů.</xhtml:p></xhtml:section>
   </p:documentation>
  </p:input>
  
  <p:input  port="settings" primary="false">
   <p:documentation>
    <xhtml:section xml:lang="en"><xhtml:p>Settings for web services for enrichment.</xhtml:p></xhtml:section>
    <xhtml:section xml:lang="cs"><xhtml:p>Nastavení webových služeb pro obohacení.</xhtml:p></xhtml:section>
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
  <p:variable name="debug-path-uri" select="p:urify($debug-path, $base-uri)" />
  
  
  <!-- PIPELINE BODY -->
  <p:insert position="last-child" name="report-start">
   <p:with-input port="source" pipe="report-in@enriching-by-morphology" />
   <p:with-input port="insertion">
    <p:inline><lax:step type="lae:enrich-by-morphology" start="{current-dateTime()}" /></p:inline>
   </p:with-input>
  </p:insert>
  
  <!--<p:identity message="enriching morphology">
   <p:with-input port="source" pipe="source@enriching-by-morphology" />
  </p:identity>-->
  
  <p:viewport match="lad:document">
   <p:with-input pipe="source@enriching-by-morphology" />
   <p:variable name="document-id" select="if(exists(/lad:document/@nickname))
    then /lad:document/@nickname 
    else if(starts-with(/lad:document/@id, 'uuid:')) 
    then substring-after(/lad:document/@id, 'uuid:') 
    else  /lad:document/@id " />
   
   
   <laud:get-udpipe-analyses 
    output-directory="{$output-directory}/{$document-id}" 
    debug-path="{$debug-path}" 
    base-uri="{$base-uri}">
    <p:with-input port="settings" pipe="settings@enriching-by-morphology" />
    <p:with-input port="report-in" pipe="result@report-start" />
   </laud:get-udpipe-analyses>
   
  </p:viewport>
  <p:namespace-delete prefixes="laud xs xhtml" />
  <p:identity name="final" />
  
  <p:add-attribute match="lax:step[@type='lae:enrich-by-morphology'][not(@end)]" 
   attribute-name="end" 
   attribute-value="{current-dateTime()}"
   name="report-final">
   <p:with-input port="source" pipe="result@report-start" />
  </p:add-attribute>

 </p:declare-step>
 
 <!-- STEP -->
 <p:declare-step type="lae:convert-to-tei" name="converting-to-tei">
  <p:documentation>
   <xhtml:section xml:lang="en">
    <xhtml:h2>Convert to TEI</xhtml:h2>
    <xhtml:p>Converts available (enriched textual) data to TEI P5 format.</xhtml:p>
   </xhtml:section>
   <xhtml:section xml:lang="cs">
    <xhtml:h2>Konverze do TEI</xhtml:h2>
    <xhtml:p>Zkonvertuje dostupná (obohacená textová) data do formátu TEI P5.</xhtml:p>
   </xhtml:section>
  </p:documentation>
  
  <!-- INPUT PORTS -->
  <p:input  port="source" primary="true" sequence="true">
   <p:documentation>
    <xhtml:section xml:lang="en"><xhtml:p>Sequence of virtual documents.</xhtml:p></xhtml:section>
    <xhtml:section xml:lang="cs"><xhtml:p>Sekvence virtuálních dokumentů.</xhtml:p></xhtml:section>
   </p:documentation>
  </p:input>
  
  <p:input  port="settings" primary="false">
   <p:documentation>
    <xhtml:section xml:lang="en"><xhtml:p>Settings for web services for enrichment.</xhtml:p></xhtml:section>
    <xhtml:section xml:lang="cs"><xhtml:p>Nastavení webových služeb pro obohacení.</xhtml:p></xhtml:section>
   </p:documentation>
  </p:input>
  
  <p:input  port="report-in">
   <lar:report />
  </p:input>
  
  <!-- OUTPUT PORTS -->
  <p:output port="result" primary="true" sequence="true"  pipe="result@final">
   <p:documentation>
    <xhtml:section xml:lang="en"><xhtml:p>Sequence of virtual documents.</xhtml:p></xhtml:section>
    <xhtml:section xml:lang="cs"><xhtml:p>Sekvence virtuálních dokumentů.</xhtml:p></xhtml:section>
   </p:documentation>
  </p:output>
  
  <p:output port="report" pipe="result@report-final" />
  
  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
  <p:option name="output-directory" required="true" as="xs:string" />
  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="p:urify($debug-path, $base-uri)" />
  <p:variable name="step-name" select="'lat:convert-to-tei'" />
  
  <!-- PIPELINE BODY -->
  <p:insert position="last-child" name="report-start">
   <p:with-input port="source" pipe="report-in@converting-to-tei" />
   <p:with-input port="insertion">
    <p:inline><lax:step type="{$step-name}" start="{current-dateTime()}" /></p:inline>
   </p:with-input>
  </p:insert>
   
  <p:viewport match="lad:document">
   <p:with-input pipe="source@converting-to-tei" />
   <p:variable name="document-id" select="if(exists(/lad:document/@nickname))
    then /lad:document/@nickname 
    else if(starts-with(/lad:document/@id, 'uuid:')) 
    then substring-after(/lad:document/@id, 'uuid:') 
    else  /lad:document/@id " />

   <lat:convert-to-tei 
    output-directory="{$output-directory}/{$document-id}" 
    debug-path="{$debug-path}" 
    base-uri="{$base-uri}"
    p:message="   convert-to-tei; output-directory: {$output-directory}/{$document-id}">
    <p:with-input port="report-in" pipe="result@report-start" />
   </lat:convert-to-tei>

  </p:viewport>
  
  <p:namespace-delete prefixes="lat xs xhtml" />
  <p:identity name="final" />
  
  <p:variable name="step-name" select="'lat:convert-to-tei'" />
  <p:add-attribute match="lax:step[@type='lat:convert-to-tei'][not(@end)]" 
   attribute-name="end" 
   attribute-value="{current-dateTime()}"
   name="report-final">
   <p:with-input port="source" pipe="result@report-start" />
  </p:add-attribute>
  
 </p:declare-step>
 
 <!-- STEP -->
 <p:declare-step type="lae:combine-text-pages" name="combining-text-pages">
  <p:documentation>
   <xhtml:section xml:lang="en">
    <xhtml:h2>Combine text pages</xhtml:h2>
    <xhtml:p>Combines available pages to one document.</xhtml:p>
   </xhtml:section>
   <xhtml:section xml:lang="cs">
    <xhtml:h2>Sloučení textových stránek</xhtml:h2>
    <xhtml:p>Sloučí text dostupných stránek do jednoho dokumentu.</xhtml:p>
   </xhtml:section>
  </p:documentation>
  
  <!-- INPUT PORTS -->
  <p:input  port="source" primary="true" sequence="true">
   <p:documentation>
    <xhtml:section xml:lang="en"><xhtml:p>Sequence of virtual documents.</xhtml:p></xhtml:section>
    <xhtml:section xml:lang="cs"><xhtml:p>Sekvence virtuálních dokumentů.</xhtml:p></xhtml:section>
   </p:documentation>   
  </p:input>
  
  <p:input  port="settings" primary="false">
   <p:documentation>
    <xhtml:section xml:lang="en"><xhtml:p>Settings for web services for enrichment.</xhtml:p></xhtml:section>
    <xhtml:section xml:lang="cs"><xhtml:p>Nastavení webových služeb pro obohacení.</xhtml:p></xhtml:section>
   </p:documentation>
  </p:input>
  
  <p:input  port="report-in">
   <lar:report />
  </p:input>
  
  <!-- OUTPUT PORTS -->
  <p:output port="result" primary="true" sequence="true"  pipe="result@final">
   <p:documentation>
    <xhtml:section xml:lang="en"><xhtml:p>Sequence of virtual documents.</xhtml:p></xhtml:section>
    <xhtml:section xml:lang="cs"><xhtml:p>Sekvence virtuálních dokumentů.</xhtml:p></xhtml:section>
   </p:documentation>   
  </p:output>
  
  <p:output port="report" pipe="result@report-final" />
  
  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
  <p:option name="output-directory" required="true" as="xs:string" />
  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="p:urify($debug-path, $base-uri)" />
  
  <!-- PIPELINE BODY -->
  <p:insert position="last-child" name="report-start">
   <p:with-input port="source" pipe="report-in@combining-text-pages" />
   <p:with-input port="insertion">
    <p:inline><lax:step type="lae:convert-to-tei" start="{current-dateTime()}" /></p:inline>
   </p:with-input>
  </p:insert>
  
  <p:viewport match="lad:document">
   <p:with-input pipe="source@combining-text-pages" />
   <p:variable name="document-id" select="if(exists(/lad:document/@nickname))
    then /lad:document/@nickname 
    else if(starts-with(/lad:document/@id, 'uuid:')) 
    then substring-after(/lad:document/@id, 'uuid:') 
    else  /lad:document/@id " />
   
   <latx:combine-text-pages 
    output-directory="{$output-directory}/{$document-id}" 
    debug-path="{$debug-path}" 
    base-uri="{$base-uri}"
    >
    <p:with-input port="report-in" pipe="result@report-start" />
   </latx:combine-text-pages>
   
  </p:viewport>
  
  <p:namespace-delete prefixes="lat xs xhtml" />
  <p:identity name="final" />
  
  <p:add-attribute match="lax:step[@type='lae:enrich-by-entities'][not(@end)]" 
   attribute-name="end" 
   attribute-value="{current-dateTime()}"
   name="report-final">
   <p:with-input port="source" pipe="result@report-start" />
  </p:add-attribute>
  
 </p:declare-step>
 
 <!-- STEP -->
 <p:declare-step type="lae:combine-alto-pages" name="combining-alto-pages">
  <p:documentation>
   <xhtml:section xml:lang="en">
    <xhtml:h2>Combine pages in ALTO format</xhtml:h2>
    <xhtml:p>Combines available pages to one document.</xhtml:p>
   </xhtml:section>
   <xhtml:section xml:lang="cs">
    <xhtml:h2>Sloučení stránek ve formátu ALTO</xhtml:h2>
    <xhtml:p>Sloučí text dostupných stránek do jednoho dokumentu.</xhtml:p>
   </xhtml:section>
  </p:documentation>
  
  <!-- INPUT PORTS -->
  <p:input  port="source" primary="true" sequence="true">
   <p:documentation>
    <xhtml:section xml:lang="en"><xhtml:p>Sequence of virtual documents.</xhtml:p></xhtml:section>
    <xhtml:section xml:lang="cs"><xhtml:p>Sekvence virtuálních dokumentů.</xhtml:p></xhtml:section>
   </p:documentation>   
  </p:input>
  
  <p:input  port="settings" primary="false">
   <p:documentation>
    <xhtml:section xml:lang="en"><xhtml:p>Settings for web services for enrichment.</xhtml:p></xhtml:section>
    <xhtml:section xml:lang="cs"><xhtml:p>Nastavení webových služeb pro obohacení.</xhtml:p></xhtml:section>
   </p:documentation>
  </p:input>
  
  <p:input  port="report-in">
   <lar:report />
  </p:input>
  
  <!-- OUTPUT PORTS -->
  <p:output port="result" primary="true" sequence="true"  pipe="result@final">
   <p:documentation>
    <xhtml:section xml:lang="en"><xhtml:p>Sequence of virtual documents.</xhtml:p></xhtml:section>
    <xhtml:section xml:lang="cs"><xhtml:p>Sekvence virtuálních dokumentů.</xhtml:p></xhtml:section>
   </p:documentation>   
  </p:output>
  
  <p:output port="report" pipe="result@report-final" />
  
  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
  <p:option name="output-directory" required="true" as="xs:string" />
  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="p:urify($debug-path, $base-uri)" />
  
  <!-- PIPELINE BODY -->
  <p:insert position="last-child" name="report-start">
   <p:with-input port="source" pipe="report-in@combining-alto-pages" />
   <p:with-input port="insertion">
    <p:inline><lax:step type="laa:combine-alto-pages" start="{current-dateTime()}" /></p:inline>
   </p:with-input>
  </p:insert>
  
  <p:viewport match="lad:document">
   <p:with-input pipe="source@combining-alto-pages" />
   <p:variable name="document-id" select="if(exists(/lad:document/@nickname))
    then /lad:document/@nickname 
    else if(starts-with(/lad:document/@id, 'uuid:')) 
    then substring-after(/lad:document/@id, 'uuid:') 
    else  /lad:document/@id " />
   
   <laa:combine-alto-pages 
    output-directory="{$output-directory}/{$document-id}" 
    debug-path="{$debug-path}" 
    base-uri="{$base-uri}"
    >
    <p:with-input port="report-in" pipe="result@report-start" />
   </laa:combine-alto-pages>
   
  </p:viewport>
  
  <p:namespace-delete prefixes="lat xs xhtml" />
  <p:identity name="final" />
  
  <p:add-attribute match="lax:step[@type='laa:combine-alto-pages'][not(@end)]" 
   attribute-name="end" 
   attribute-value="{current-dateTime()}"
   name="report-final">
   <p:with-input port="source" pipe="result@report-start" />
  </p:add-attribute>
  
 </p:declare-step>
 
</p:library>
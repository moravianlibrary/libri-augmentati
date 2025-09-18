<p:library  xmlns:p="http://www.w3.org/ns/xproc" 
 xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:lant="https://www.mzk.cz/ns/libri-augmentati/nametag/1.0"
 xmlns:las="https://www.mzk.cz/ns/libri-augmentati/settings/1.0"
 xmlns:lad="https://www.mzk.cz/ns/libri-augmentati/documents/1.0"
 xmlns:map = "http://www.w3.org/2005/xpath-functions/map"
 xmlns:xhtml="http://www.w3.org/1999/xhtml"
 version="3.0">
 
 <p:documentation>
  <xhtml:meta name="version" content="1.0.0" />
  <xhtml:section xml:lang="en">
   <xhtml:h1>Library for NameTag data processing</xhtml:h1>
   <xhtml:p>Steps for standalone operations with NameTag service and data.</xhtml:p>
  </xhtml:section>
  <xhtml:section xml:lang="cs">
   <xhtml:h1>Kihovna pro zpracování dat NameTag</xhtml:h1>
   <xhtml:p>Kroky pro samostatné operace se službou a daty NameTag.</xhtml:p>
  </xhtml:section>
 </p:documentation>
 
 
 <p:declare-step type="lant:get-nametag-analysis" name="getting-nametag-analysis">
  
  <p:documentation>
   <xhtml:section xml:lang="en">
    <xhtml:h2>Get NameTag analysis</xhtml:h2>
    <xhtml:p>It calls the REST API of the NameTag service, passes it the text to recognize, and returns the result in JSON format.</xhtml:p>
   </xhtml:section>
   <xhtml:section xml:lang="cs">
    <xhtml:h2>Analýza textu NameTagem</xhtml:h2>
    <xhtml:p>Zavolá rozhraní REST API služby NameTag, předá jí text k rozpoznání a vrátí výsledek ve formátu JSON.</xhtml:p>
   </xhtml:section>
  </p:documentation>
  
  <!-- INPUT PORTS -->
  <p:input port="source" primary="true">
   <p:documentation>
    <xhtml:section xml:lang="en">
     <xhtml:p>The plain text that the NameTag service should process and recognize entities in.</xhtml:p>
    </xhtml:section>
    <xhtml:section xml:lang="cs">
     <xhtml:p>Prostý text, který má služba NameTag zpracovat a rozpoznat v něm entity.</xhtml:p>
    </xhtml:section>
   </p:documentation>
  </p:input>
  
  <p:input port="settings" primary="false">
   <p:documentation>
    <xhtml:section xml:lang="en">
     <xhtml:p>Web service settings for retrieving text with analyzed entities.</xhtml:p>
    </xhtml:section>
    <xhtml:section xml:lang="cs">
     <xhtml:p>Nastavení webové služby pro získání textu s analýzovanými entitami.</xhtml:p>
    </xhtml:section>
   </p:documentation>
  </p:input>
  
  <p:input port="report-in" primary="false">
   <p:documentation>
    <xhtml:section xml:lang="en">
     <xhtml:p>XML document containing informations about the processing.</xhtml:p>
    </xhtml:section>
    <xhtml:section xml:lang="cs">
     <xhtml:p>XML dokument, který obsahuje informace o procesu zpracování.</xhtml:p>
    </xhtml:section>
   </p:documentation>
  </p:input>
  
  <!-- OUTPUT PORTS -->
  <p:output port="result"  primary="true" serialization="map{'indent' : true()}">
   <p:documentation>
    <xhtml:section xml:lang="en">
     <xhtml:p>Contains original text with recognized entities in JSON format.</xhtml:p>
    </xhtml:section>
    <xhtml:section xml:lang="cs">
     <xhtml:p>Obsahuje původní text s rozpoznanými entitami ve formátu JSON.</xhtml:p>
    </xhtml:section>
   </p:documentation>
  </p:output>
  
  <p:output port="report" serialization="map{'indent' : true()}" pipe="report-in@getting-nametag-analysis">
   <p:documentation>
    <xhtml:section xml:lang="en">
     <xhtml:p>XML document containing informations about the processing.</xhtml:p>
    </xhtml:section>
    <xhtml:section xml:lang="cs">
     <xhtml:p>XML dokument, který obsahuje informace o procesu zpracování.</xhtml:p>
    </xhtml:section>
   </p:documentation>
  </p:output>
  
  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
  <p:option name="file-stem" as="xs:string?" />

  <p:option name="language" as="xs:string?" select="'cze'"/>
 

  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="p:urify($debug-path, $base-uri)" />
  
  <p:variable name="language-models" select="map {
   'cze': 'czech',
   'ces': 'czech',
   'dut': 'dutch',
   'nld': 'dutch',
   'eng': 'english',
   'deu': 'german',
   'ger': 'german',
   'spa': 'spanish',
   'multi' : 'multilingual'
   }" />
  
  <!-- TODO: try all languages, take the best result -->
  <p:variable name="language-param" select="tokenize($language)[1]" />
  
  <p:variable name="language-model" 
   select="if(map:contains($language-models, $language-param)) 
   then $language-models?($language-param) 
    else $language-models?multi" />
  
  <p:variable name="service" select="//las:service[@code='nametag']" 
   pipe="settings@getting-nametag-analysis" />
  
  <p:variable name="service-url" select="$service/las:api/@url">
   <p:documentation>
    <xhtml:section xml:lang="en">
     <xhtml:p>URL of the REST service.</xhtml:p>
    </xhtml:section>
    <xhtml:section xml:lang="cs">
     <xhtml:p>URL RESTové služby.</xhtml:p>
    </xhtml:section>
   </p:documentation>
  </p:variable>
  
  <p:variable name="api-id" select="substring-after($service/las:api/@ref, '#')">
   <p:documentation>
    <xhtml:section xml:lang="en">
     <xhtml:p>Identifier of the REST service.</xhtml:p>
    </xhtml:section>
    <xhtml:section xml:lang="cs">
     <xhtml:p>Identifikátor RESTové služby.</xhtml:p>
    </xhtml:section>
   </p:documentation>
  </p:variable>
  
  <p:variable name="feature" 
   select="//las:api[@xml:id=$api-id]/las:feature[@type='entities'][@method='post']"
   pipe="settings@getting-nametag-analysis"/>
  <p:variable name="step-url" select="concat($service-url, $feature/@url)" />
<!--  <p:variable name="step-params" select="string-join($feature/las:param[@place='body'][not(@name =('data','model'))]//concat(@name, '=', @value), '&amp;') " />-->
  <p:variable name="step-params" select="string-join($feature/las:param[@place='body'][not(@name =('data','model'))]//concat(@name, '=', @value), '&amp;') " />
  <p:variable name="step-params" select="$step-params || '&amp;model=' || $language-model"  />
 
  <p:variable name="full-text" select="." />

  <p:if test="$debug">
   <p:store href="{$debug-path-uri}/nametag/{$file-stem}-http-request-input.txt" message="Storing {$debug-path-uri}/nametag/{$file-stem}-http-request-input.txt">
    <!--<p:with-input port="source" select="$full-text" />-->
   </p:store>
  </p:if>
  <!-- PIPELINE BODY -->
  <p:http-request href="{$step-url}" message="nametag: $api-id: {$api-id}; $step-url: {$step-url}; $step-params: {$step-params}">
   <p:with-option name="method" select="'POST'" />
   <p:documentation>
    <xhtml:section xml:lang="en">
     <xhtml:p>Calling the NameTag service API using the <b>POST</b> method. The input parameter to the service is plain text, encoded for the URI.</xhtml:p>
    </xhtml:section>
    <xhtml:section xml:lang="cs">
     <xhtml:p>Volání API služby NameTag pomocí metody<b>POST</b>. Jako vstupní parametr služby se předává prostý text, kódovaný pro URI.</xhtml:p>
    </xhtml:section>
   </p:documentation>
   <p:with-input>
    <p:inline content-type="application/x-www-form-urlencoded">{$step-params}&amp;data={$full-text}</p:inline>
   </p:with-input>
  </p:http-request>
  
  <p:identity name="final" />
  
  <p:if test="$debug">
   <p:store href="{$debug-path-uri}/nametag/{$file-stem}-http-request.json" message="Storing {$debug-path-uri}/nametag/{$file-stem}-http-request.json" />
  </p:if>
  
 </p:declare-step>
 
 <p:declare-step type="lant:convert-nametag-analysis-to-xml">
  
  <p:documentation>
   <xhtml:section xml:lang="en">
    <xhtml:h2>Convert NameTag analysis to XML</xhtml:h2>
    <xhtml:p>Converts the analysis output in JSON format to an XML document.</xhtml:p>
   </xhtml:section>
   <xhtml:section xml:lang="cs">
    <xhtml:h2>Konverze analýzy NameTagem do XML</xhtml:h2>
    <xhtml:p>Převede výstup analýzy ve formátu JSON na dokument ve formátu XML.</xhtml:p>
   </xhtml:section>
  </p:documentation>
  
  <!-- INPUT PORTS -->
  <p:input port="source" primary="true" content-types="application/json">
   <p:documentation>
    <xhtml:section xml:lang="en">
     <xhtml:p>Analysis output in JSON.</xhtml:p>
    </xhtml:section>
    <xhtml:section xml:lang="cs">
     <xhtml:p>Výstup analýzy ve formátu JSON.</xhtml:p>
    </xhtml:section>
   </p:documentation>
  </p:input>
  
  <!-- OUTPUT PORTS -->
  <p:output port="result" primary="true" content-types="application/xml">
   <p:documentation>
    <xhtml:section xml:lang="en">
     <xhtml:p>Analysis in the XML format.</xhtml:p>
    </xhtml:section>
    <xhtml:section xml:lang="cs">
     <xhtml:p>Analýza ve formátu XML.</xhtml:p>
    </xhtml:section>
   </p:documentation>
  </p:output>
  
  
  
  <!-- VARIABLES -->
  <p:variable name="model" select="normalize-space(.?model)" />
  
  <!-- PIPELINE BODY -->
  <p:cast-content-type content-type="application/xml">
   <p:with-input port="source" select=".?result" />
  </p:cast-content-type>
  
  <p:xslt version="3.0">
   <p:with-input port="stylesheet" href="../xslt/nametag/nametag-json-to-xml-text.xsl" />
  </p:xslt>
  
  <p:cast-content-type content-type="application/xml" />
  
  <p:choose>
   <p:when test=". instance of node()">
    <p:add-attribute attribute-name="model" attribute-value="{$model}" />
   </p:when>
   <p:otherwise>
    <p:identity>
     <p:with-input port="source">
      <p:inline><lant:result source="NameTag" /></p:inline>
     </p:with-input>
    </p:identity>    
   </p:otherwise>
  </p:choose>
  
 </p:declare-step>
 
 <p:declare-step type="lant:get-nametag-analyses" name="getting-nametag-analyses">
  
  <p:documentation>
   <xhtml:section xml:lang="en">
    <xhtml:h2>Get NameTag analyses</xhtml:h2>
    <xhtml:p>For each page of the virtual document, it gets its text, sends it to the REST interface of the <xhtml:a href="https://ufal.mff.cuni.cz/nametag/2" alt="NameTag">NameTag</xhtml:a> service, converts the result to XML format and stores it in a folder.</xhtml:p>
   </xhtml:section>
   <xhtml:section xml:lang="cs">
    <xhtml:h2>Analýzy textu NameTagem</xhtml:h2>
    <xhtml:p>Pro každou stránku virtuálního dokumentu získá její text, odešle ho na RESTové rozhraní služby <xhtml:a href="https://ufal.mff.cuni.cz/nametag/2" alt="NameTag">NameTag</xhtml:a>, výsledek konvertuje do formátu XML a uloží do složky.</xhtml:p>
   </xhtml:section>
  </p:documentation>
  
  <!-- INPUT PORTS -->
  <p:input port="source" primary="true">
   <p:documentation>
    <xhtml:section xml:lang="en">
     <xhtml:p>Virtual document with resources informations.</xhtml:p>
    </xhtml:section>
    <xhtml:section xml:lang="cs">
     <xhtml:p>Virtuální dokument s informacemi o zdrojích.</xhtml:p>
    </xhtml:section>
   </p:documentation>
  </p:input>
  
  <p:input port="settings" primary="false">
   <p:documentation>
    <xhtml:section xml:lang="en">
     <xhtml:p>Web service settings to retrieve text with analyzed entities.</xhtml:p>
    </xhtml:section>
    <xhtml:section xml:lang="cs">
     <xhtml:p>Nastavení webové služby pro získání textu s analyzovanými entitami.</xhtml:p>
    </xhtml:section>
   </p:documentation>
  </p:input>
  
  <p:input port="report-in" primary="false">
   <p:documentation>
    <xhtml:section xml:lang="en">
     <xhtml:p>XML document containing informations about the processing.</xhtml:p>
    </xhtml:section>
    <xhtml:section xml:lang="cs">
     <xhtml:p>XML dokument, který obsahuje informace o procesu zpracování.</xhtml:p>
    </xhtml:section>
   </p:documentation>
  </p:input>
  
  <!-- OUTPUT PORTS -->
  <p:output port="result" primary="true" serialization="map{'indent' : true()}" pipe="@final">
   <p:documentation>
    <xhtml:section xml:lang="en">
     <xhtml:p>A virtual document with information about the resources, supplemented by the resources taken in the current step.</xhtml:p>
    </xhtml:section>
    <xhtml:section xml:lang="cs">
     <xhtml:p>Virtuální dokument s informacemi o zdrojích doplněný o zdrojích pořízených v aktuálním kroku.</xhtml:p>
    </xhtml:section>
   </p:documentation>
  </p:output>
    
  <p:output port="report" serialization="map{'indent' : true()}" pipe="result@final-report">
   <p:documentation>
    <xhtml:section xml:lang="en">
     <xhtml:p>An XML document containing informations about the processing.</xhtml:p>
    </xhtml:section>
    <xhtml:section xml:lang="cs">
     <xhtml:p>XML dokument, který obsahuje informace o procesu zpracování.</xhtml:p>
    </xhtml:section>
   </p:documentation>
  </p:output>
  
  
  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
  <p:option name="output-directory" required="true" as="xs:string" />

  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="p:urify($debug-path, $base-uri)" />

  
<!--  <p:variable name="main-directory-path" select="//lant:request/@main-directory-path" />-->
  
  <p:variable name="result-directory-path" select="concat($output-directory, '/nametag')">
   <p:documentation>
    <xhtml:section xml:lang="en">
     <xhtml:p>The folder where downloaded documents are saved. The path to the folder can be absolute or relative.</xhtml:p>
    </xhtml:section>
    <xhtml:section xml:lang="cs">
     <xhtml:p>Složka, do níž se uloží stažené dokumenty. Cesta ke složce může být absolutní i relativní.</xhtml:p>
    </xhtml:section>
   </p:documentation>
  </p:variable>
  
  <p:variable name="result-directory-uri" select="p:urify($result-directory-path, $base-uri)" />
  
  <p:variable name="language" select="/lad:document/@language" />
  
  <!-- PIPELINE BODY -->
  <p:if test="$debug">
   <p:store href="{$debug-path-uri}/nametag/get-nametag-analyses.xml" 
    serialization="map{'indent' : true()}"  use-when="true()"
    >
    <p:with-input port="source" pipe="source@getting-nametag-analyses" />
   </p:store>   
  </p:if>
  
  

  <!--<p:viewport match="lad:pages/lad:page/lad:resource[@type='text'][@local-file-exists='true']" use-when="true()">-->
  <p:viewport match="lad:pages/lad:page/lad:resource[@type='udpipe'][@local-file-exists='true']" use-when="true()">
   <p:variable name="resource" select="/lad:resource" />
   <p:if test="exists($resource)">
     
     <p:variable name="file-stem" select="substring-before($resource/@name, '.')" />
     <p:variable name="result-file-name" select="concat($file-stem, '.xml')" />
     <p:variable name="saved-file-uri" select="concat($result-directory-uri, '/', $result-file-name)"/>
     
    <p:if test="not(doc-available($saved-file-uri))">
     <p:variable name="href" select="$resource/@local-uri" />
     
     <p:if test="$debug">
      <p:store href="{$debug-path-uri}/nametag/get-nametag-analysis/{$file-stem}-input.txt">
       <p:with-input port="source" select="unparsed-text($href)" />
      </p:store>
     </p:if>
     
     <!--<p:identity name="text">
      <p:with-input select="unparsed-text($href)" />
     </p:identity>-->
     <p:load href="{$href}" />
     
     <lant:get-nametag-analysis
      file-stem="{$file-stem}"
      language="{$language}"
      debug-path="{$debug-path}" base-uri="{$base-uri}">
      <p:with-input port="report-in" pipe="report-in@getting-nametag-analyses" />
      <p:with-input port="settings" pipe="settings@getting-nametag-analyses" />
     </lant:get-nametag-analysis>
     
     <p:if test="$debug">
      <p:store href="{$debug-path-uri}/nametag/get-nametag-analysis/{$file-stem}.json" />
     </p:if>
     
     <lant:convert-nametag-analysis-to-xml name="get-data"/>
     
     <p:if test="$debug">
      <p:store href="{$debug-path-uri}/nametag/get-nametag-analysis/{$file-stem}.xml" />
     </p:if>
     
     <p:if test="$result-directory-path">
      <p:store href="{$saved-file-uri}" message="Storing to {$saved-file-uri}" />
     </p:if>     
    </p:if>
    
    <p:identity name="item-metadata">
     <p:with-input>
      <lad:resource local-file-exists="true" name="{$result-file-name}" 
       local-path="{$result-directory-path}/{$result-file-name}"
       local-uri="{$saved-file-uri}"
       order="{$resource/@order}" 
       type="nametag"
      />
     </p:with-input>
    </p:identity>
    <p:namespace-delete prefixes="lant xs xhtml" />
    
    <p:identity>
     <p:with-input pipe="@item-metadata" select="($resource, .)" />
    </p:identity>
    
    </p:if>
  </p:viewport>
  
  <p:identity name="final" />
  
  <p:if test="$debug">
   <p:store href="{$debug-path-uri}/nametag/get-nametag-analyses/result-virtual-document.xml" message="Storing to {$debug-path-uri}/nametag/get-nametag-analyses/result-virtual-document.xml" />
  </p:if>
  
  <p:identity name="metadata" />
  
  <p:insert match="lant:report/lant:result" position="last-child" name="final-report">
   <p:with-input port="source" pipe="source@getting-nametag-analyses" />
   <p:with-input port="insertion" pipe="@metadata" />
  </p:insert>
  
 </p:declare-step>
 
 
 
</p:library>
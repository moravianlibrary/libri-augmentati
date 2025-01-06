<p:library  xmlns:p="http://www.w3.org/ns/xproc" 
 xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:laud="https://www.mzk.cz/ns/libri-augmentati/udpipe/1.0"
 xmlns:las="https://www.mzk.cz/ns/libri-augmentati/settings/1.0"
 xmlns:lad="https://www.mzk.cz/ns/libri-augmentati/documents/1.0"
 xmlns:xhtml="http://www.w3.org/1999/xhtml"
 xmlns:c="http://www.w3.org/ns/xproc-step"
 version="3.0">
 
 <p:documentation>
  <xhtml:section>
   <xhtml:h1></xhtml:h1>
   <xhtml:p></xhtml:p>
  </xhtml:section>
 </p:documentation>
 
 
 <p:declare-step type="laud:get-udpipe-analysis" name="getting-udpipe-analysis">
  
  <p:documentation>
   <xhtml:section xml:lang="en">
    <xhtml:h2>Get UDPipe analysis</xhtml:h2>
    <xhtml:p>Calls the REST API of the UDPipe service, passes it the text to recognize, and returns the result in JSON format.</xhtml:p>
   </xhtml:section>
   <xhtml:section xml:lang="cs">
    <xhtml:h2>Analýza textu pomocí UDPipe</xhtml:h2>
    <xhtml:p>Zavolá rozhraní REST API služby UDPipe, předá jí text k rozpoznání a vrátí výsledek ve formátu JSON.</xhtml:p>
   </xhtml:section>
  </p:documentation>
  
  <!-- INPUT PORTS -->
  <p:input port="source" primary="true">
  <p:documentation>
   <xhtml:section xml:lang="en">
    <xhtml:p>The plain text that the UDPipe service should process and return original text with morphosyntactic analysis and lemmatization.</xhtml:p>
   </xhtml:section>
   <xhtml:section xml:lang="cs">
    <xhtml:p>Prostý text, který má služba UDPipe zpracovat a vrátit původní text s morfosyntaktickou analýzou a lemmatizací.</xhtml:p>
   </xhtml:section>
  </p:documentation>
  </p:input>
  
  <p:input port="settings" primary="false">
   <p:documentation>
    <xhtml:section xml:lang="en">
     <xhtml:p>Web service settings for retrieving text with with morphosyntactic analysis and lemmatization.</xhtml:p>
    </xhtml:section>
    <xhtml:section xml:lang="cs">
     <xhtml:p>Nastavení webové služby pro získání textu s morfosyntaktickou analýzou a lemmatizací.</xhtml:p>
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
     <xhtml:p>Contains original text with morphosyntactic analysis and lemmatization in JSON format.</xhtml:p>
    </xhtml:section>
    <xhtml:section xml:lang="cs">
     <xhtml:p>Obsahuje původní text s morfosyntaktickou analýzou a lemmatizací ve formátu JSON.</xhtml:p>
    </xhtml:section>
   </p:documentation>
  </p:output>
  
  <p:output port="report" serialization="map{'indent' : true()}" pipe="report-in@getting-udpipe-analysis">
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
  
  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  
  
  <p:variable name="service" select="//las:service[@code='udpipe']" 
   pipe="settings@getting-udpipe-analysis" />
  
  <p:variable name="service-url" select="$service/las:api/@url">
   <p:documentation>
    <xhtml:section xml:lang="en">
     <xhtml:p>URL of the REST service</xhtml:p>
    </xhtml:section>
    <xhtml:section xml:lang="cs">
     <xhtml:p>URL RESTové služby</xhtml:p>
    </xhtml:section>
   </p:documentation>
  </p:variable>
  
  <p:variable name="api-id" select="substring-after($service/las:api/@ref, '#')">
   <p:documentation>
    <xhtml:section xml:lang="en">
     <xhtml:p>Identifier of the REST service</xhtml:p>
    </xhtml:section>
    <xhtml:section xml:lang="cs">
     <xhtml:p>Identifikátor RESTové služby</xhtml:p>
    </xhtml:section>
   </p:documentation>
  </p:variable>
  
  <p:variable name="feature" 
   select="//las:api[@xml:id=$api-id]/las:feature[@type='process'][@method='post']"
   pipe="settings@getting-udpipe-analysis"/>
  <p:variable name="step-url" select="concat($service-url, $feature/@url)" />
  <p:variable name="step-params" select="string-join($feature/las:param[@place='body'][@name !='data']/@name, '=&amp;')" />
  
  <p:variable name="full-text" select="." />
  
  <!-- PIPELINE BODY -->
  <p:http-request href="{$step-url}" message="udpipe: $api-id: {$api-id}; $step-url: {$step-url}">
   <p:with-option name="method" select="'POST'" />
   <p:documentation>
    <xhtml:section xml:lang="en">
     <xhtml:p>Calling the UDPipe service API using the <b>POST</b> method. The input parameter to the service is plain text, encoded for the URI.</xhtml:p>
    </xhtml:section>
    <xhtml:section xml:lang="cs">
     <xhtml:p>Volání API služby UDPipe pomocí metody<b>POST</b>. Jako vstupní parametr služby se předává prostý text, kódovaný pro URI.</xhtml:p>
    </xhtml:section>
   </p:documentation>
   <p:with-input>
    <p:inline content-type="application/x-www-form-urlencoded">{$step-params}&amp;data={$full-text}</p:inline>
   </p:with-input>
  </p:http-request>
  
  <p:identity name="final" />
  
  <p:if test="$debug">
   <p:store href="{$debug-path-uri}/udpipe/http-request.json" message="Storing {$debug-path-uri}/udpipe/http-request.json" />
  </p:if>
  
 </p:declare-step>
 
 <p:declare-step type="laud:convert-udpipe-analysis-to-text">
  <p:documentation>
   <xhtml:section xml:lang="en">
    <xhtml:h2>Convert UDPipe analysis to XML</xhtml:h2>
    <xhtml:p>Converts the analysis output in JSON format to an XML document.</xhtml:p>
   </xhtml:section>
   <xhtml:section xml:lang="cs">
    <xhtml:h2>Konverze analýzy UDPipe do XML</xhtml:h2>
    <xhtml:p>Převede výstup analýzy ve formátu JSON na dokument ve formátu XML.</xhtml:p>
   </xhtml:section>
  </p:documentation>
  
  <!-- INPUT PORTS -->
  <p:input port="source" primary="true" content-types="application/json">
   <p:documentation>
    <xhtml:section xml:lang="en">
     <xhtml:p>Analysis output in JSON</xhtml:p>
    </xhtml:section>
    <xhtml:section xml:lang="cs">
     <xhtml:p>Výstup analýzy ve formátu JSON</xhtml:p>
    </xhtml:section>
   </p:documentation>
  </p:input>
  
  <!-- OUTPUT PORTS -->
  <p:output port="result" primary="true" content-types="text/plain">
   <p:documentation>
    <xhtml:section xml:lang="en">
     <xhtml:p>Analysis in the plain text format</xhtml:p>
    </xhtml:section>
    <xhtml:section xml:lang="cs">
     <xhtml:p>Analýza ve formátu prostého textu</xhtml:p>
    </xhtml:section>
   </p:documentation>
  </p:output>
  
  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  
  <p:variable name="model" select="normalize-space(.?model)" />
  
  <!-- PIPELINE BODY -->
  
  <p:if test="$debug">
   <p:store href="{$debug-path}/udpipe/convert/input.json" 
    serialization="map{'indent' : true()}"
    message="Storing to {$debug-path}/udpipe/convert/input.json"
    use-when="true()" />
  </p:if>
  
  <p:identity>
   <p:documentation>
    <xhtml:section xml:lang="en">
     <xhtml:p>Convert JSON to plain text without escaping characters.</xhtml:p>
    </xhtml:section>
    <xhtml:section xml:lang="cs">
     <xhtml:p>Převod formátu JSON do TXT bez zbytečných escapovaných textů.</xhtml:p>
    </xhtml:section>
   </p:documentation>
   <p:with-input port="source">
    <laud:result source="UDPipe" model="{$model}">{.?result}</laud:result>
   </p:with-input>
  </p:identity>
  
  <p:if test="$debug">
   <p:store href="{$debug-path-uri}/udpipe/convert/input.xml" 
    serialization="map{'indent' : true()}"
    message="Storing to {$debug-path-uri}/udpipe/convert/input.xml"
    use-when="true()" />
  </p:if>

  <p:xslt version="3.0">
   <p:with-input port="stylesheet" href="../xslt/udpipe/udpipe-json-to-text.xsl" />
  </p:xslt>
  
  <p:if test="$debug">
   <p:store href="{$debug-path-uri}/udpipe/convert/output.txt" 
    serialization="map{'indent' : true()}"
    message="Storing to {$debug-path-uri}/udpipe/convert/output.txt"
    use-when="true()" />
  </p:if>

 </p:declare-step>
 
 <p:declare-step type="laud:get-udpipe-analyses" name="getting-udpipe-analyses">
  <p:documentation>
   <xhtml:section xml:lang="en">
    <xhtml:h2>Get UDPipe (Universal Dependencies) analyses</xhtml:h2>
    <xhtml:p>For each page of the virtual document, it gets its text, sends it to the REST interface of the <xhtml:a href="https://lindat.mff.cuni.cz/services/udpipe/" alt="UDPipe">UDPipe</xhtml:a> service, converts the result to XML format and stores it in a folder.</xhtml:p>
   </xhtml:section>
   <xhtml:section xml:lang="cs">
    <xhtml:h2>Analýzy textu UDPipe (Universal Dependencies)</xhtml:h2>
    <xhtml:p>Pro každou stránku virtuálního dokumentu získá její text, odešle ho na RESTové rozhraní služby <xhtml:a href="https://lindat.mff.cuni.cz/services/udpipe/" alt="UDPipe">UDPipe</xhtml:a>, výsledek konvertuje do formátu XML a uloží do složky.</xhtml:p>
   </xhtml:section>
  </p:documentation>
  
  <!-- INPUT PORTS -->
  <p:input port="source" primary="true">
   <p:documentation>
    <xhtml:section xml:lang="en">
     <xhtml:p>Virtual document with resources informations</xhtml:p>
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
     <xhtml:p>An XML document containing informations about the processing.</xhtml:p>
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
  
  <p:output port="data" serialization="map{'indent' : true()}" sequence="true">
   <p:documentation>
    <xhtml:section xml:lang="en">
     <xhtml:p></xhtml:p>
    </xhtml:section>
    <xhtml:section xml:lang="cs">
     <xhtml:p>Data ve formátu XML s rozpoznanými entitami pro jednotlivé strany.</xhtml:p>
    </xhtml:section>
   </p:documentation>
  </p:output>
  
  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
  <p:option name="output-directory" required="true" as="xs:string" />
  
  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  
  
  <!--  <p:variable name="main-directory-path" select="//lant:request/@main-directory-path" />-->
  
  <p:variable name="result-directory-path" select="concat($output-directory, '/udpipe')">
   <p:documentation>
    <xhtml:section xml:lang="en">
     <xhtml:p>The folder where downloaded documents are saved. The path to the folder can be absolute or relative.</xhtml:p>
    </xhtml:section>
    <xhtml:section xml:lang="cs">
     <xhtml:p>Složka, do níž se uloží stažené dokumenty. Cesta ke složce může být absolutní i relativní.</xhtml:p>
    </xhtml:section>
   </p:documentation>
  </p:variable>
  <p:variable name="result-directory-uri" select="resolve-uri($result-directory-path, $base-uri)" />
  
  <!-- PIPELINE BODY -->
  <p:if test="$debug">
   <p:store href="{$debug-path}/udpipe/get-udpipe-analyses.xml" 
    serialization="map{'indent' : true()}"  use-when="true()"
    >
    <p:with-input port="source" pipe="source@getting-udpipe-analyses" />
   </p:store>   
  </p:if>
  
  <p:viewport match="lad:pages/lad:page/lad:resource[@type='nametag'][@local-file-exists='true']" use-when="true()">
   <p:variable name="resource" select="/lad:resource" />
   <p:if test="exists($resource)">
    
    <p:variable name="file-stem" select="substring-before($resource/@name, '.')" />
    <p:variable name="result-file-name" select="concat($file-stem, '.txt')" />
    <p:variable name="saved-file-uri" select="concat($result-directory-uri, '/', $result-file-name)"/>
    
    <p:file-info href="{$saved-file-uri}" fail-on-error="false" />
    
    <p:if test="not(exists(/c:file))" message="Check if exists: {$saved-file-uri}">
     <p:variable name="href" select="$resource/@local-uri" />
     
     <p:load href="{$href}" />
     
     <p:choose message="content-type: {p:document-property(/, 'content-type')}">
      <p:when test="p:document-property(/, 'content-type') eq 'application/xml'">
       <p:xslt>
        <p:with-input port="stylesheet" href="../xslt/nametag/nametag-xml-to-vertical.xsl" />
       </p:xslt>
      </p:when>
      <p:otherwise>
       <p:identity name="text">
        <p:with-input select="unparsed-text($href)" />
       </p:identity>
      </p:otherwise>
     </p:choose>
     
     <p:if test="$debug">
      <p:store href="{$debug-path-uri}/udpipe/get-udpipe-analysis/{$file-stem}-input.txt" />
     </p:if>
     
     <laud:get-udpipe-analysis debug-path="{$debug-path}" base-uri="{$base-uri}">
      <p:with-input port="report-in" pipe="report-in@getting-udpipe-analyses" />
      <p:with-input port="settings" pipe="settings@getting-udpipe-analyses" />
     </laud:get-udpipe-analysis>
     
     <p:if test="$debug">
      <p:store href="{$debug-path-uri}/udpipe/get-udpipe-analysis/{$file-stem}.json" />
     </p:if>
     
     <laud:convert-udpipe-analysis-to-text debug-path="{$debug-path}" base-uri="{$base-uri}" name="get-data"/>
     
     <p:if test="$debug">
      <p:store href="{$debug-path-uri}/udpipe/get-udpipe-analysis/{$file-stem}.txt" />
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
       type="udpipe"
      />
     </p:with-input>
    </p:identity>
    <p:namespace-delete prefixes="laud xs xhtml c" />
    
    <p:identity>
     <p:with-input pipe="@item-metadata" select="($resource, .)" />
    </p:identity>
    
   </p:if>
  </p:viewport>
  
  <p:identity name="final" />
  
  <p:if test="$debug">
   <p:store href="{$debug-path-uri}/udpipe/get-udpipe-analyses/result-virtual-document.xml" message="Storing to {$debug-path-uri}/udpipe/get-udpipe-analyses/result-virtual-document.xml" />
  </p:if>
  
  <p:identity name="metadata" />
  
  <p:insert match="laud:report/laud:result" position="last-child" name="final-report">
   <p:documentation>Doplnění zprávy o zpracovaných prvcích.</p:documentation>
   <p:with-input port="source" pipe="source@getting-udpipe-analyses" />
   <p:with-input port="insertion" pipe="@metadata" />
  </p:insert>
  
 </p:declare-step>
 
</p:library>
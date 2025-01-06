<p:library  xmlns:p="http://www.w3.org/ns/xproc" 
 xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:lad="https://www.mzk.cz/ns/libri-augmentati/documents/1.0"
 xmlns:latx="https://www.mzk.cz/ns/libri-augmentati/text/1.0"
 xmlns:c="http://www.w3.org/ns/xproc-step"
 xmlns:xhtml="http://www.w3.org/1999/xhtml"
 version="3.0">
 
 <p:documentation>
  <xhtml:section>
   <xhtml:h1></xhtml:h1>
   <xhtml:p></xhtml:p>
  </xhtml:section>
 </p:documentation>
 
 <p:declare-step type="latx:combine-text-pages" name="combining-text-pages">
  <p:documentation>
   <xhtml:section>
    <xhtml:h2>Combine TEI pages</xhtml:h2>
    <xhtml:p>Combines available TEI pages to one document.</xhtml:p>
   </xhtml:section>
   <xhtml:section>
    <xhtml:h2>Sloučení stránek TEI</xhtml:h2>
    <xhtml:p>Sloučí dostupné TEI stránky do jednoho TEI dokumentu.</xhtml:p>
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
     <xhtml:p>Virtuální dokument s informacemi o zdrojích doplněný o zdroje pořízené v aktuálním kroku.</xhtml:p>
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
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  <p:variable name="result-directory-path" select="$output-directory">
   <p:documentation>
    <xhtml:section xml:lang="en">
     <xhtml:p>The folder where generated documents are saved. The path to the folder can be absolute or relative.</xhtml:p>
    </xhtml:section>
    <xhtml:section xml:lang="cs">
     <xhtml:p>Složka, do níž se uloží vygenerované dokumenty. Cesta ke složce může být absolutní i relativní.</xhtml:p>
    </xhtml:section>
   </p:documentation>
  </p:variable>
  <p:variable name="result-directory-uri" select="resolve-uri($result-directory-path, $base-uri)" />
  
  <!-- PIPELINE BODY -->
  <p:variable name="resources"  select="/lad:document/lad:pages/lad:page/lad:resource[@type='text'][@local-file-exists='true']" />
  
  <p:if test="$debug">
   <p:store href="{$debug-path-uri}/text/combine/source.xml" />
  </p:if>
  
  <p:if test="exists($resources)">
   
   <p:variable name="file-stem" select="'text'" />
   <p:variable name="result-file-name" select="concat($file-stem, '.txt')" />
   <p:variable name="saved-file-uri" select="concat($result-directory-uri, '/', $result-file-name)"/>
   
   <p:file-info href="{$saved-file-uri}" fail-on-error="false" message="" />
   
   <p:if test="not(exists(/c:file))" message="...combining text pages ...Check if exists: {$saved-file-uri}">
    
     <p:for-each message="...combining text pages ...for-each">
      <p:with-input select="$resources"/>
      <p:variable name="resource" select="/lad:resource" />
      <p:identity>
       <p:with-input port="source" href="{$resource/@local-uri}" />
      </p:identity>
     </p:for-each>
     <p:text-join />
    
    <p:if test="$result-directory-path">
     <p:store href="{$saved-file-uri}" message="Storing to {$saved-file-uri}" />
    </p:if>     
   </p:if>
   
   <p:identity name="item-metadata">
    <p:with-input>
     <lad:resource local-file-exists="true" name="{$result-file-name}" 
      local-path="{$result-directory-path}/{$result-file-name}"
      local-uri="{$saved-file-uri}"
      type="text"
     />
    </p:with-input>
   </p:identity>
   <p:namespace-delete prefixes="latx xs xhtml c" />
   
   <p:insert match="/lad:document/lad:resource[last()]" position="after">
    <p:with-input port="source" pipe="source@combining-text-pages" />
    <p:with-input port="insertion" pipe="@item-metadata" />
   </p:insert>
   
  </p:if>
  
  
  
  <p:identity name="final" />
  <p:identity name="final-report">
   <p:with-input port="source" pipe="report-in@combining-text-pages" />
  </p:identity>
  
 
 </p:declare-step>
 
</p:library>
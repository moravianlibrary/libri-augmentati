<p:library  xmlns:p="http://www.w3.org/ns/xproc" 
 xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:lant="https://www.mzk.cz/ns/libri-augmentati/nametag/1.0"
 xmlns:las="https://www.mzk.cz/ns/libri-augmentati/settings/1.0"
 xmlns:lad="https://www.mzk.cz/ns/libri-augmentati/documents/1.0"
 xmlns="http://www.w3.org/1999/xhtml"
 version="3.0">
 
 <p:documentation>
  <section></section>
 </p:documentation>
 
 
 <p:declare-step type="lant:get-nametag-analysis" name="getting-nametag-analysis">
  <p:documentation>
   <section>
    <p>Převede vstupní text na dokument ve formátu XML.</p>
    <p>Zavolá API služby NameTag, předá jí text k rozpoznání a výsledek (dokument JSON) převede pomocí XSLT transformace na validní XML.</p>
   </section>
  </p:documentation>
  
  <p:input port="source" primary="true">
   <p:documentation>Prostý text, který má aplikace NameTag zpracovat a rozpoznat v něm entity.</p:documentation>
  </p:input>
  
  <p:input port="settings" primary="false">
   <p:documentation>Nastavení webové služby pro získání textu s analýzovanými entitami.</p:documentation>
  </p:input>
  
  <p:input port="report-in" primary="false">
   <p:documentation>XML dokument, který obsahuje informace o procesu zpracování.</p:documentation>
  </p:input>
  
  <p:output port="result"  primary="true" serialization="map{'indent' : true()}">
   <p:documentation>Obsahuje reprezentaci rozpoznaných entit ve formátu XML.</p:documentation>
  </p:output>
  
  <p:output port="report" serialization="map{'indent' : true()}" pipe="report-in@getting-nametag-analysis">
   <p:documentation>XML dokument, který obsahuje informace o procesu zpracování.</p:documentation>
  </p:output>
  
  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
 

  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  
  
  <p:variable name="service" select="//las:service[@code='nametag']" 
   pipe="settings@getting-nametag-analysis" />
  
  <p:variable name="service-url" select="$service/las:api/@url">
   <p:documentation>URL RESTové služby.</p:documentation>
  </p:variable>
  
  <p:variable name="api-id" select="substring-after($service/las:api/@ref, '#')">
   <p:documentation>Identifikátor RESTové služby.</p:documentation>
  </p:variable>
  
  <p:variable name="feature" 
   select="//las:api[@xml:id=$api-id]/las:feature[@type='entities'][@method='post']"
   pipe="settings@getting-nametag-analysis"/>
  <p:variable name="step-url" select="concat($service-url, $feature/@url)" />
 
  <p:variable name="full-text" select="." />
  
  
  
  <p:http-request href="{$step-url}" message="nametag: $api-id: {$api-id}; $step-url: {$step-url}">
   <p:with-option name="method" select="'POST'" />
   <p:documentation>
    <section>
     <p>Volání API služby NameTag pomocí metody<b>POST</b>. Jako vstupní parametr služby se předává prostý text, kódovaný pro URI.</p>
    </section>
   </p:documentation>
   <p:with-input>
    <p:inline content-type="application/x-www-form-urlencoded">data={$full-text}</p:inline>
   </p:with-input>
  </p:http-request>
  
  <p:identity name="final" />
  
  
  
 </p:declare-step>
 
 <p:declare-step type="lant:convert-nametag-analysis-to-xml">
  
  <p:input port="source" primary="true" content-types="application/json" />
  <p:output port="result" primary="true" content-types="application/xml" />
  
  <p:variable name="model" select="normalize-space(?model)" />
  
  <p:cast-content-type content-type="application/xml">
   <p:with-input port="source" select="?result" />
  </p:cast-content-type>
  
  <p:xslt version="3.0">
   <p:with-input port="stylesheet">
    <p:inline>
     <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0">
      <xsl:output method="text" />
      <xsl:variable name="ns" select="concat('xmlns:dl4dh=', '&#x22;', 'https://system-kramerius.cz/ns/xproc/dl4dh/1.0', '&#x22;')" />
      <xsl:variable name="ns-lant" select="concat('xmlns:lant=', '&#x22;', 'https://www.mzk.cz/ns/libri-augmentati/nametag/1.0', '&#x22;')" />
      <xsl:template match="/">
       <xsl:variable name="text">
        <xsl:value-of select="string(/*/.) => replace('\\\\r\\\\n', '') => normalize-space()" />
       </xsl:variable>
       <xsl:value-of select="concat('&lt;lant:result source=', '&#x22;', 'NameTag', '&#x22;', ' ', $ns, ' ', $ns-lant ,'&gt;', $text, '&lt;/lant:result&gt;')" />
      </xsl:template>
     </xsl:stylesheet>
    </p:inline>
   </p:with-input>
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
  <p:documentation>Na základě metadat o zpracování odesílá textová data jednotlivých stran publikace na RESTové rozhraní služby <a href="https://ufal.mff.cuni.cz/nametag/2" alt="NameTag">NameTag</a>, výsledky konvertuje do formátu XML a ukládá do složky.</p:documentation>
  
  <p:input port="source" primary="true">
   <p:documentation>Virtuální dokument s informacemi o zdrojích.</p:documentation>
  </p:input>
  
  <p:input port="settings" primary="false">
   <p:documentation>Nastavení webové služby pro získání textu s analýzovanými entitami.</p:documentation>
  </p:input>
  
  <p:input port="report-in" primary="false">
   <p:documentation>XML dokument, který obsahuje informace o procesu zpracování.</p:documentation>
  </p:input>
  
  <p:output port="result" primary="true" serialization="map{'indent' : true()}" pipe="@final-report">
   <p:documentation>Metadata o zpracování doplněná o údaje z aktuálního kroku.</p:documentation>
  </p:output>
  
  <p:output port="report" serialization="map{'indent' : true()}" pipe="result@final-report">
   <p:documentation>XML dokument, který obsahuje informace o procesu zpracování.</p:documentation>
  </p:output>
  
  <p:output port="data" serialization="map{'indent' : true()}" sequence="true">
   <p:documentation>Data ve formátu XML s rozpoznanými entitami pro jednotlivé strany.</p:documentation>
  </p:output>
  
  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
  <p:option name="output-directory" required="true" as="xs:string" />

  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />

  
  
  <p:variable name="main-directory-path" select="//lant:request/@main-directory-path" />
  
  <p:variable name="result-directory-path" select="concat($output-directory, '/nametag')">
   <p:documentation>Složka, do níž se uloží stažené dokumenty. Cesta ke složce může být absolutní i relativní.</p:documentation>
  </p:variable>
  <p:variable name="result-directory-uri" select="resolve-uri($result-directory-path, $base-uri)" />
  
  <p:if test="$debug">
   <p:store href="{$debug-path}/nametag/get-nametag-analyses.xml" 
    serialization="map{'indent' : true()}"  use-when="true()"
    >
    <p:with-input port="source" pipe="source@getting-nametag-analyses" />
   </p:store>   
  </p:if>
  
  <p:variable name="input" select="//lad:page" pipe="source@getting-nametag-analyses" />
  <p:variable name="root" select="/*" pipe="source@getting-nametag-analyses" />
  
  <p:for-each name="loop" message="loop input: {count($input)}; root: {$root/name()}">
   <p:with-input select="//lad:pages/lad:page" />
   <p:output port="result" pipe="result@resource-loop" />
   <p:output port="data" primary="false" pipe="data@resource-loop"/>
   
   <p:variable name="page" select="/lad:page" />
   
   <p:for-each name="resource-loop">
    <p:with-input select="//lad:resource[@type='text'][@local-file-exists='true']" />
    <p:output port="result" pipe="result@item-metadata" />
    <p:output port="data" primary="false" pipe="result@get-data"/>
    
    <p:variable name="resource" select="/lad:resource" />
    
    <p:variable name="file-stem" select="substring-before($resource/@name, '.')" />
    <p:variable name="file-stem" select="$page/@stem" use-when="false()" />
    <p:variable name="result-file-name" select="concat($file-stem, '.xml')" />
    <p:variable name="saved-file-uri" select="concat($result-directory-uri, '/', $result-file-name)"/>
    
    <p:variable name="href" select="$resource/@local-uri" />
    
    <p:identity name="text">
     <p:with-input select="unparsed-text($href)" />
    </p:identity>
    
    <lant:get-nametag-analysis>
     <p:with-input port="report-in" pipe="report-in@getting-nametag-analyses" />
     <p:with-input port="settings" pipe="settings@getting-nametag-analyses" />
    </lant:get-nametag-analysis>
    
    <p:if test="$debug">
     <p:store href="{$debug-path-uri}/nametag/get-nametag-analysis.json" />
    </p:if>
    
    <lant:convert-nametag-analysis-to-xml name="get-data"/>
    
    <p:if test="$debug">
     <p:store href="{$debug-path-uri}/nametag/get-nametag-analysis.xml" />
    </p:if>
    
    <p:if test="$result-directory-path">
     <p:store href="{$saved-file-uri}" message="Storing to {$saved-file-uri}" />
    </p:if>
    
    <p:identity name="item-metadata">
     <p:with-input>
      <lad:resource local-file-exists="true" name="{$result-file-name}" local-path="{$saved-file-uri}"
       local-uri="{$saved-file-uri}"
       available="true" type="nametag"
      />
     </p:with-input>
    </p:identity>
    
   </p:for-each>
   

  </p:for-each>
  
  <p:identity name="data">
   <p:with-input port="source" pipe="data@loop" />
  </p:identity>
  
  
  <p:wrap-sequence wrapper="lant:step">
   <p:with-input port="source" pipe="result@loop" />
   <p:documentation>Zabalení sekvence elementů <b>&lt;lant:item&lt;</b> do nadřazeného elementu.</p:documentation>
  </p:wrap-sequence>
  <p:set-attributes match="/*" attributes="map{
   'name' :  'getting-nametag-analyses', 
   'result-directory-path' : $result-directory-path 
   }" />
  
  <p:identity name="metadata" />
  
  <p:insert match="lant:report/lant:result" position="last-child" name="final-report">
   <p:documentation>Doplnění zprávy o zpracovaných prvcích.</p:documentation>
   <p:with-input port="source" pipe="source@getting-nametag-analyses" />
   <p:with-input port="insertion" pipe="@metadata" />
  </p:insert>
  
 </p:declare-step>
 
 
 
</p:library>
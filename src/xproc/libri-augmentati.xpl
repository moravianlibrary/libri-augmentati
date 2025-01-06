<p:library xmlns:p="http://www.w3.org/ns/xproc" 
 xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:lad="https://www.mzk.cz/ns/libri-augmentati/documents/1.0"
 xmlns:lap="https://www.mzk.cz/ns/libri-augmentati/processing/1.0"
 xmlns:las="https://www.mzk.cz/ns/libri-augmentati/settings/1.0"
 xmlns:lar="https://www.mzk.cz/ns/libri-augmentati/report/1.0"
 xmlns:lax="https://www.mzk.cz/ns/libri-augmentati/xproc/1.0"
 xmlns:lae="https://www.mzk.cz/ns/libri-augmentati/enrichment/1.0"
 xmlns:lac="https://www.mzk.cz/ns/libri-augmentati/conversion/1.0"
 xmlns:xlog="https://www.daliboris.cz/ns/xproc/logging/1.0"
 xmlns:map="http://www.w3.org/2005/xpath-functions/map"
 xmlns:mox="http://www.xml-project.com/morganaxproc" 
 xmlns:c="http://www.w3.org/ns/xproc-step" 
 xmlns:err="http://www.w3.org/ns/xproc-error" 
 xmlns:array = "http://www.w3.org/2005/xpath-functions/array" 
 xmlns:xhtml="http://www.w3.org/1999/xhtml" 
 xmlns:mods="http://www.loc.gov/mods/v3"
 version="3.0">
 
 <!--<p:import href="../includes/log-xpc-lib/src/xproc/log-xpc-lib.xpl" />-->
 
 <p:import href="kramerius-7.xpl"/>
 <p:import href="kramerius-5.xpl"/>
 <p:import href="enrichment.xpl" />
 <p:import href="conversion.xpl" />
 
  <p:documentation>
   <xhtml:section xml:lang="en">
    <xhtml:h1>Libri augmentati</xhtml:h1>
    <xhtml:p>The main programming library for digital library data retrieval and enrichment.</xhtml:p>
   </xhtml:section>
   <xhtml:section xml:lang="cs">
    <xhtml:h1>Libri augmentati</xhtml:h1>
    <xhtml:p>Hlavní programová knihovna pro získání dat z digitálních knihoven a jejich obohacení.</xhtml:p>
   </xhtml:section>
  </p:documentation>
 
 <!-- OPTIONS -->
 <p:option name="resource-types" select="map {
  'text' : map {'extension' : '.txt'},
  'alto' : map {'extension' : '.xml'},
  'foxml' : map {'extension' : '.xml' },
  'dc' : map {'extension' : '.xml' },
  'mods' : map {'extension' : '.xml'},
  'image' : map {'extension' : '.jpg'},
  'tei' : map {'extension' : '.xml'},
  'info' : map {'extension' : '.txt'}
  }" static="true" />

 <!-- STEP -->
 <p:declare-step type="lax:build-virtual-document" name="building-virtual-document" visibility="public">
  <p:documentation>
   <xhtml:section xml:lang="en">
    <xhtml:h2>Build virtual document</xhtml:h2>
    <xhtml:p>Gathers all requested metadata about the publication. Creates the content of the virtual document with links to all requested resources.</xhtml:p>
   </xhtml:section>
   <xhtml:section xml:lang="cs">
    <xhtml:h2>Sestavení virtuálního dokumentu</xhtml:h2>
    <xhtml:p>Shromáždí všechna požadovaná metadata o publikaci. Vytvoří strukturu virutálního dokumentu s odkazy na všechny požadované zdroje.</xhtml:p>
   </xhtml:section>
  </p:documentation>
  
  <!-- INPUT PORTS -->
  <p:input port="source" primary="true" />
  <p:input port="settings" />
  <p:input  port="report-in">
   <p:inline><lar:report /></p:inline>
  </p:input>
  
  <!-- OUTPUT PORTS -->
  <p:output port="result" primary="true" serialization="map{'indent' : true()}" sequence="true"/>
  <p:output port="report" primary="false" sequence="false" pipe="report-in@building-virtual-document"/>
  
  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>

  <p:option name="library-code" as="xs:string" required="true"/>
  <p:option name="api-version" as="xs:string?"/>
  
  <p:option name="system" as="xs:string?" values="('Kramerius', 'Polona')" required="false"/>
  
  <p:option name="document-resources" as="xs:token*"/>
  <p:option name="page-resources" as="xs:token*"/>

  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  
  <p:variable name="library" 
   select="/las:digital-libraries/las:libraries/las:library[@code=$library-code]"
   pipe="settings@building-virtual-document" />
  
  <p:variable name="apis" 
   select="/las:digital-libraries/las:apis/las:api"
   pipe="settings@building-virtual-document" />
  
  <p:variable name="api" select="let $lib-apis := $apis[@xml:id =$library/las:api/@ref/substring-after(., '#')] return if(exists($api-version)) then $lib-apis[@version=$api-version] else $lib-apis[1] " />
  
  <p:variable name="base-url" select="$library/las:api[@ref=concat('#', $api/@xml:id)]/@url" />
  
  <!-- PIPELINE BODY -->
  <p:identity name="options">
   <p:with-input>
    <p:inline content-type="application/xml">
     <lad:options xmlns:lad="https://www.mzk.cz/ns/libri-augmentati/documents/1.0"
      base-url="{$base-url}" 
      system="{$api/@common-name}" 
      api-version="{$api/@version}" 
      document-resources="{$document-resources}" 
      page-resources="{$page-resources}"
     />
     {$api}
     {$library}
    </p:inline>
   </p:with-input>
  </p:identity>
  
  <p:for-each>
   <p:with-input select="/lad:documents/lad:document" pipe="source@building-virtual-document"/>
   <p:insert position="first-child">
    <p:with-input port="insertion" select="." pipe="result@options" />
   </p:insert>
   <lax:get-virtual-document-metadata debug-path="{$debug-path}" base-uri="{$base-uri}"  />
  </p:for-each>

 </p:declare-step>
 
 <!-- STEP -->
 <p:declare-step type="lax:get-virtual-document-metadata" name="getting-virtual-document-metadata" visibility="private">

  <p:documentation>
   <xhtml:section xml:lang="en">
    <xhtml:h2>Get virtual document metadata</xhtml:h2>
    <xhtml:p>Gathers all requested metadata about the publication. Downloads the content (files) of the virtual document from external targets.</xhtml:p>
    <xhtml:p>Saves data to the disk and enhance input data by adding info about local path of the requested resources.</xhtml:p>
   </xhtml:section>
   <xhtml:section xml:lang="cs">
    <xhtml:h2>Získání metadat virtuálního dokumentu</xhtml:h2>
    <xhtml:p>Shromáždí všechna požadovaná metadata publikace. Stáhne obsah (soubory) virutálního dokumentu z externích odkazů.</xhtml:p>
    <xhtml:p>Uloží data na disk a obohatí vstupní data přidáním informace o lokálním uložení zdrojů.</xhtml:p>
   </xhtml:section>
  </p:documentation>
  
  <!-- INPUT PORTS -->
  <p:input port="source" primary="true" />
  <p:input port="report-in">
   <lar:report />
  </p:input>
  
  <!-- OUTPUT PORTS -->
  <p:output port="result" primary="true" serialization="map{'indent' : true()}"/>
  <p:output port="report" primary="false" sequence="false" pipe="report-in@getting-virtual-document-metadata"/>
  
  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  
  <p:variable name="api-version" select="/lad:document/lad:options/@api-version"/>
  <p:variable name="system" select="/lad:document/lad:options/@system"/>
  <p:variable name="library-code" select="/lad:document/las:library/@code"/>
  <p:variable name="library" select="/lad:document/las:library"/>

  <p:choose message="Using system {$system}: version {$api-version} ({$library/las:institution/las:name[1]})">
   <p:when test="$system = 'Kramerius'">
    <p:choose>
     <p:when test="$api-version='5'">
      <lax:get-virtual-document-metadata-v5 debug-path="{$debug-path}" base-uri="{$base-uri}" />
     </p:when>
     <p:when test="$api-version='7'" >
      <lax:get-virtual-document-metadata-v7 debug-path="{$debug-path}" base-uri="{$base-uri}" />
     </p:when>
    </p:choose>
   </p:when>
  </p:choose>
  
  <p:namespace-delete prefixes="c xs map mox array" />
  
  <p:if test="$debug">
   <p:variable name="id" select="if(exists(/lad:document/@nickname))
    then /lad:document/@nickname 
    else if(starts-with(/lad:document/@id, 'uuid:')) 
    then substring-after(/lad:document/@id, 'uuid:') 
    else  /lad:document/@id" />
   <p:store href="{$debug-path-uri}/libri-augmentati/{$library-code}/{$id}/virtual-document-metadata-result.xml"  message="  - storing to {$debug-path-uri}/libri-augmentati/{$library-code}/{$id}/virtual-document-metadata-result.xml" />
  </p:if>
  
 </p:declare-step>

 <!-- STEP -->
 <p:declare-step type="lax:download-document-data" name="downloading-document-data" visibility="public">

  <p:documentation>
   <xhtml:section xml:lang="en">
    <xhtml:h2>Download document data</xhtml:h2>
    <xhtml:p>Gathers all requested data and metadata about the publication. Downloads the content (files) of the virtual document from external targets.</xhtml:p>
    <xhtml:p>Saves data to the disk and enhance input data by adding info about local path of the requested resources.</xhtml:p>
   </xhtml:section>
   <xhtml:section xml:lang="cs">
    <xhtml:h2>Stažení dat virtuálního dokumentu</xhtml:h2>
    <xhtml:p>Shromáždí všechna požadovaná data a metadata publikace. Stáhne obsah (soubory) virutálního dokumentu z externích odkazů.</xhtml:p>
    <xhtml:p>Uloží data na disk a obohatí vstupní data přidáním informace o lokálním uložení zdrojů.</xhtml:p>
   </xhtml:section>
  </p:documentation>
  
  <!-- INPUT PORTS -->
  <p:input port="source" primary="true" sequence="true">
   <p:documentation>Sekvence virtuálních dokumentů.</p:documentation>
  </p:input>
  <p:input port="report-in" sequence="true">
   <lar:report />
  </p:input>
  
  
  <!-- OUTPUT PORTS -->
  <p:output port="result" primary="true" sequence="true">
   <p:documentation>Sekvence virtuálních dokumentů.</p:documentation>
  </p:output>
  <p:output port="report" primary="false" sequence="false" pipe="report-in@downloading-document-data"/>
  
  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
  
  <p:option name="output-directory" required="true" as="xs:string" />
  <p:option name="pause-before-request" select="2" as="xs:integer"/>

  
  <!-- PIPELINE BODY -->
  <p:viewport match="lad:document">
   
   <p:variable name="options" select="/lad:document/lad:options" />
   <p:variable name="page-resources" select="tokenize($options/@page-resources) ! lower-case(.)" />
   <p:variable name="document-resources" select="tokenize($options/@document-resources) ! lower-case(.)" />

   <p:variable name="document-id" select="if(exists(/lad:document/@nickname))
    then /lad:document/@nickname 
    else if(starts-with(/lad:document/@id, 'uuid:')) 
    then substring-after(/lad:document/@id, 'uuid:') 
    else  /lad:document/@id " />

   <p:viewport match="lad:resource[@type=$document-resources][@available='true']">
    <p:variable name="type" select="/lad:resource/@type/data()" />
    <p:variable name="position" select="$type" />
    <lax:download-document-resources
     debug-path="{$debug-path}" base-uri="{$base-uri}" 
     output-directory="{$output-directory}/{$document-id}"
     pause-before-request="{$pause-before-request}" type="{$type}"
     position="{$position}"
     p:message="   - downloading {$type} resources for {$document-id} to {$output-directory}/{$document-id}" >
     <p:with-input port="source" select="/lad:resource" />
    </lax:download-document-resources>
   </p:viewport>
   
   <p:viewport match="lad:page/lad:resource[@type=$page-resources][@available='true']">
    <p:variable name="order" select="/lad:resource/@order" as="xs:integer" />
    <p:variable name="position" select="format-integer($order, '0000')" />
    <p:variable name="type" select="/lad:resource/@type/data()" />
    <lax:download-document-resources
     debug-path="{$debug-path}" base-uri="{$base-uri}" 
     output-directory="{$output-directory}/{$document-id}/{$type}"
     pause-before-request="{$pause-before-request}" type="{$type}"
     position="{$position}"
     p:message="  - downloading {$type} resources for {$document-id} to {$output-directory}/{$document-id}/{$type}" >
     <p:with-input port="source" select="/lad:resource" />
    </lax:download-document-resources>
   </p:viewport>
 
  </p:viewport>
  
  <p:viewport match="lad:document">
   
   <p:variable name="options" select="/lad:document/lad:options" />
   <p:variable name="document-resources" select="tokenize($options/@document-resources) ! lower-case(.)" />
   
   <p:variable name="metadata" select="/lad:document/lad:resource[@type=('mods', $document-resources)][1]" />
   <p:variable name="metadata-doc" select="doc($metadata/@local-uri)" />
   <p:variable name="title" select="$metadata-doc//mods:mods[1]/mods:titleInfo[1]/mods:title[1]"  />
   <p:variable name="author" select="$metadata-doc//mods:mods[1]/mods:name[@usage='primary'][1]/mods:namePart[1]"  />
   <p:if test="$title">
    <p:add-attribute attribute-name="title" attribute-value="{$title}" message="  - adding title: {$title}" /> 
   </p:if>
   <p:if test="$author">
    <p:add-attribute attribute-name="author" attribute-value="{$author}" message="  - adding author: {$author}" /> 
   </p:if>
  </p:viewport>
   
 </p:declare-step>
 
 <!-- STEP -->
 <p:declare-step type="lax:download-document-resources" visibility="private">
  
  <p:documentation>
   <xhtml:section xml:lang="en">
    <xhtml:h2>Download document resources</xhtml:h2>
    <xhtml:p>Downloads the content (files) of the document-related resources from external targets.</xhtml:p>
    <xhtml:p>Saves data to the disk and enhance input data by adding info about local path of the requested resources.</xhtml:p>
   </xhtml:section>
   <xhtml:section xml:lang="cs">
    <xhtml:h2>Stažení zdrojů dokumentu</xhtml:h2>
    <xhtml:p>Stáhne obsah (soubory) virutálního dokumentu z externích odkazů.</xhtml:p>
    <xhtml:p>Uloží data na disk a obohatí vstupní data přidáním informace o lokálním uložení zdrojů.</xhtml:p>
   </xhtml:section>
  </p:documentation>
  
  <!-- INPUT PORTS -->
  <p:input port="source" primary="true" sequence="true"/>
  
  <!-- OUTPUT PORTS -->
  <p:output port="result" primary="true" serialization="map{'indent' : true()}" sequence="true"/>
  
  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
  
  <p:option name="output-directory" required="true" as="xs:string"/>
  <p:option name="position" required="true" />
  <p:option name="type" required="true" as="xs:string"/>
  <p:option name="pause-before-request" required="true" as="xs:integer"/>
  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  <p:variable name="output-directory-uri" select="resolve-uri($output-directory, $base-uri)" />
  
  <!-- PIPELINE BODY -->
  <p:viewport match="lad:resource">
   <p:variable name="resource" select="/lad:resource"/>
   <p:variable name="url" select="/lad:resource/@url"/>
   <p:variable name="original-name" select="tokenize($url, '/')[. != ''][last()]"/>
   <p:variable name="extension" select="if(contains($original-name, '.')) 
    then concat('.', tokenize($original-name, '\.')[. != ''][last()])
    else $resource-types?($type)?extension" />
   <p:variable name="name" select="concat($position, $extension)" />
   <p:variable name="local-path" select="concat($output-directory, '/', $name)"/>
   <p:variable name="local-uri" select="resolve-uri($local-path, $base-uri)"/>
   <p:set-attributes attributes="map {
     'name' : $name, 
     'local-path' : $local-path, 
     'local-uri' : $local-uri 
     }" 
     message="Setting attributes: name = {$name}; local-path = {$local-path}; base-uri: {$base-uri} =&gt; {$local-uri}" />
   <lax:check-local-file-exists name="before-download" debug-path="{$debug-path}" base-uri="{$base-uri}"/>
   <p:variable name="file-exists" select="/*/@local-file-exists = 'true'" />
   <p:if test="not($file-exists) and $resource/@available='true'" message="File {$name} exists {$file-exists}">
    <lax:download-document url="{$url}" local-path="{$local-path}" 
     debug-path="{$debug-path}" base-uri="{$base-uri}" 
     pause-before-request="{$pause-before-request}"/>
   </p:if>
   <lax:check-local-file-exists debug-path="{$debug-path}" base-uri="{$base-uri}">
    <p:with-input port="source" pipe="result@before-download" />
   </lax:check-local-file-exists>
   
  </p:viewport>
  
 </p:declare-step>
 
 <!-- STEP -->
 <p:declare-step type="lax:check-local-file-exists" name="checking-local-file-exists">
  
  <p:documentation>
   <xhtml:section xml:lang="en">
    <xhtml:h2>Check local file exists</xhtml:h2>
    <xhtml:p>Checks if the file is stored on the local computer.</xhtml:p>
   </xhtml:section>
   <xhtml:section xml:lang="cs">
    <xhtml:h2>Zjištění existence místního souboru</xhtml:h2>
    <xhtml:p>Zjistí, jestli je soubor stažen na místním počítači.</xhtml:p>
   </xhtml:section>
  </p:documentation>
  
  <!-- INPUT PORTS -->
  <p:input port="source" primary="true" />
  
  <!-- OUTPUT PORTS -->
  <p:output port="result" primary="true" />
  
  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  <p:variable name="local-path" select="/*/@local-uri" />
  
  <!-- PIPELINE BODY -->
  <p:file-info href="{$local-path}" fail-on-error="false" message="Checking file {$local-path}"/>
  <p:variable name="file-exists" select="exists(/c:file)"/>
  <p:add-attribute attribute-name="local-file-exists" attribute-value="{$file-exists}">
   <p:with-input port="source" pipe="source@checking-local-file-exists" />
  </p:add-attribute>
 </p:declare-step>
 
 <!-- STEP -->
 <p:declare-step type="lax:download-document-data-items" visibility="private">
  
  <p:documentation>
   <xhtml:section xml:lang="en">
    <xhtml:h2>Download document data items</xhtml:h2>
    <xhtml:p></xhtml:p>
   </xhtml:section>
   <xhtml:section xml:lang="cs">
    <xhtml:h2></xhtml:h2>
    <xhtml:p></xhtml:p>
   </xhtml:section>
  </p:documentation>
  
  
  <!-- INPUT PORTS -->
  <p:input port="source" primary="true" sequence="true"/>
  
  <!-- OUTPUT PORTS -->
  <p:output port="result" primary="true" sequence="true"/>
  
  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
  
  <p:option name="output-directory" required="true"/>
  <p:option name="type" required="true" as="xs:string"/>
  <p:option name="pause-before-request" required="true" as="xs:integer"/>
  
  <!-- PIPELINE BODY -->
  <p:for-each>
   <p:with-input select="."/>
   <p:variable name="url" select="."/>
   <p:variable name="position" select="format-integer(p:iteration-position(), '0000')" />
   <p:variable name="original-name" select="tokenize($url, '/')[. != ''][last()]"/>
   <p:variable name="extension" select="if(contains($original-name, '.')) 
    then concat('.', tokenize($original-name, '\.')[. != ''][last()])
     else $resource-types?($type)?extension" />
   <p:variable name="name" select="concat($position, $extension)" />
   <p:variable name="local-path" select="concat($output-directory, '/', $name)"/>
   <p:file-info href="{$local-path}" fail-on-error="false"/>
   <p:variable name="file-exists" select="exists(/c:file)"/>
   <p:if test="not($file-exists)" message="File {$name} exists {$file-exists}">
    <lax:download-document url="{$url}" local-path="{$local-path}"
     debug-path="{$debug-path}" base-uri="{$base-uri}" 
     pause-before-request="{$pause-before-request}"/>
   </p:if>
  </p:for-each>
 </p:declare-step>

 <!-- STEP -->
 <p:declare-step type="lax:download-document" visibility="private">
  
  <p:documentation>
   <xhtml:section xml:lang="en">
    <xhtml:h2>Download document</xhtml:h2>
    <xhtml:p></xhtml:p>
   </xhtml:section>
   <xhtml:section xml:lang="cs">
    <xhtml:h2></xhtml:h2>
    <xhtml:p></xhtml:p>
   </xhtml:section>
  </p:documentation>
  
  <!-- INPUT PORTS -->
  <p:input port="source" sequence="true"/>
  
  <!-- OUTPUT PORTS -->
  <p:output port="result" primary="true" sequence="true"/>
  
  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
  
  <p:option name="url" as="xs:anyURI"/>
  <p:option name="local-path" as="xs:string"/>
  <p:option name="pause-before-request" required="true" as="xs:integer"/>

  <!-- VARIABLES -->
  <p:variable name="content-type" select="if(ends-with($url, '.txt')) then 'text/plain' else if(ends-with($url, '.djvu')) then 'image/vnd.djvu' else '*/*'"/>
  <p:variable name="local-path-uri" select="resolve-uri($local-path, $base-uri)" />
  
  <!-- PIPELINE BODY -->
  <p:try>
   <p:http-request href="{$url}" parameters="map {'mox:pause-before-request' : $pause-before-request, 'follow-redirect' : 3}" headers="map {'contet-type' : $content-type}" message="Downloading {$url}"/>
   <p:store href="{$local-path-uri}" message="Storing to {$local-path-uri} ({$local-path})"/>
   <p:catch code="err:XD0006">
    <!--
     when URL is redirected and storing:
     No value (p:empty) found for port 'source', but port is not declared as a sequence.
    -->
    <p:identity message="File is not downloaded">
     <p:with-input port="source">
      <c:error code="err:XD0006">File {$url} not downloaded</c:error>
     </p:with-input>
    </p:identity>
   </p:catch>
   <p:catch code="err:XC0126">
    <!-- 
    c:error code="err:XC0126"
     '.?status-code lt 400' evaluates to false()
     <number key="status-code">504</number>
   -->
    <p:identity message="File is not downloaded: err:XC0126">
     <p:with-input port="source">
      <c:error code="err:XCO126">File {$url} not downloaded</c:error>
     </p:with-input>
    </p:identity>
   </p:catch>
  </p:try>
 </p:declare-step>
 
 <!-- STEP -->
 <p:declare-step type="lax:enrich-document-data" visibility="public" name="enriching-document-data">
  
  <p:documentation>
   <xhtml:section xml:lang="en">
    <xhtml:h2>Enrich document data</xhtml:h2>
    <xhtml:p>Enriches available (textual) data of the digital book by available services.</xhtml:p>
   </xhtml:section>
   <xhtml:section xml:lang="cs">
    <xhtml:h2>Obohacení dat dokumentu</xhtml:h2>
    <xhtml:p>Obohatí dostupná dostupná (textová) data digitální publikací pomocí dostupných služeb.</xhtml:p>
   </xhtml:section>
  </p:documentation>
  
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
  
  <p:output port="report" pipe="report-in@enriching-document-data" />
  
  
  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
  
  <p:option name="output-directory" required="true" as="xs:string" />
  <p:option name="pause-before-request" select="2" as="xs:integer"/>
  
  <p:option name="output-format" values="('TEXT', 'TEI')" as="xs:string*" />
  <p:option name="enrichment" values="('ENTITIES', 'MORPHOLOGY')" as="xs:string*"/>
  
  <p:viewport match="lad:document" use-when="false()">
   <p:viewport match="lad:page">
    <p:variable name="page-local-uri" select="/lad:page/lad:resource[@type='text'][@local-file-exists='true']/@local-uri" />
    <p:if test="exists($page-local-uri)">
     <lae:enrich-data
      output-directory="{$output-directory}" 
      debug-path="{$debug-path}" 
      base-uri="{$base-uri}">
      <p:with-option name="output-format" select="$output-format" />
      <p:with-option name="enrichment" select="$enrichment" />
      <p:with-input port="settings" pipe="settings@enriching-document-data" />
      <p:with-input port="report-in" pipe="report-in@enriching-document-data" />
     </lae:enrich-data>
    </p:if>
   </p:viewport>
  </p:viewport>
  
  <lae:enrich-data
   output-directory="{$output-directory}" 
   debug-path="{$debug-path}" 
   base-uri="{$base-uri}">
   <p:with-option name="output-format" select="$output-format" />
   <p:with-option name="enrichment" select="$enrichment" />
   <p:with-input port="settings" pipe="settings@enriching-document-data" />
   <p:with-input port="report-in" pipe="report-in@enriching-document-data" />
  </lae:enrich-data>
  
  <!-- 
  <lae:enrich-by-entities apply="{$enrichment = 'ENTITIES'}">
    <p:with-input port="settings" pipe="settings@enriching-document-data" />
    <p:with-input port="report-in" pipe="report-in@enriching-document-data" />
   </lae:enrich-by-entities>
  
  <lae:enrich-by-morphology apply="{$enrichment = 'MORPHOLOGY'}">
    <p:with-input port="settings" pipe="settings@enriching-document-data" />
    <p:with-input port="report-in" pipe="report-in@enriching-document-data" />
   </lae:enrich-by-morphology>
  -->
 </p:declare-step>

 <!-- STEP -->
 <p:declare-step type="lax:create-report" name="creating-report">
  
  <p:documentation>
   <xhtml:section xml:lang="en">
    <xhtml:h2>Create report</xhtml:h2>
    <xhtml:p></xhtml:p>
   </xhtml:section>
   <xhtml:section xml:lang="cs">
    <xhtml:h2></xhtml:h2>
    <xhtml:p></xhtml:p>
   </xhtml:section>
  </p:documentation>
  
  
  <!-- INPUT PORTS -->
  <p:input port="source" primary="true" sequence="true"/>
  
  <!-- OUTPUT PORTS -->
  <p:output port="result" primary="true" sequence="true" pipe="result@documents-loop"/>
  <p:output port="result-uri" primary="false" sequence="true" pipe="result-uri@documents-loop"/>
  
  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>

  <p:option name="output-directory" select="()" as="xs:string?" />

  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  
  <p:variable name="save-output" select="$output-directory || '' ne ''" />
  <p:variable name="output-directory-uri" select="resolve-uri($output-directory, $base-uri)" />

  <!-- PIPELINE BODY -->
  <p:for-each name="documents-loop">
   <p:with-input select="/*"/>
   <p:output port="result" pipe="result@report" />
   <p:output port="result-uri" pipe="result-uri@save" />
   <p:variable name="library-code" select="/lad:document/las:library/@code"/>
   <p:variable name="document-id" select="if(exists(/lad:document/@nickname))
    then /lad:document/@nickname 
    else if(starts-with(/lad:document/@id, 'uuid:')) 
    then substring-after(/lad:document/@id, 'uuid:') 
    else  /lad:document/@id " />
   
   <p:if test="$save-output" name="xml-report-save">
    <p:store href="{$output-directory-uri}/{$library-code}-{$document-id}-report.xml" message="Storing XML report to {$output-directory}/{$library-code}-{$document-id}-report.xml" name="xml-report-store" />
   </p:if>
   
   <p:xslt>
    <p:with-input port="stylesheet" href="../xslt/report.xsl" />
   </p:xslt>
   
   <p:identity name="report" />
   <p:if test="$save-output" name="save">
    <p:output port="result-uri" primary="true" />
    <p:store href="{$output-directory-uri}/{$library-code}-{$document-id}-report.html" message="Storing HTML report to {$output-directory}/{$library-code}-{$document-id}-report.html" name="store" />
    <p:identity>
     <p:with-input port="source">
      <c:file xml:base="{$library-code}-{$document-id}-report.html" name="{$library-code}-{$document-id}-report.html" full-path="{$output-directory-uri}/{$library-code}-{$document-id}-report.html" parent-directory="{$output-directory-uri}" />
     </p:with-input>
    </p:identity>
    <p:namespace-delete prefixes="lax err xlog array mox lap xs map lad xhtml" />
    <p:namespace-delete prefixes="lae mods lar lac las" />
   </p:if>
  </p:for-each>
 </p:declare-step>

 <!-- STEP -->
 <p:declare-step type="lax:get-document-id">
  
  <p:documentation>
   <xhtml:section xml:lang="en">
    <xhtml:h2>Get document id</xhtml:h2>
    <xhtml:p></xhtml:p>
   </xhtml:section>
   <xhtml:section xml:lang="cs">
    <xhtml:h2></xhtml:h2>
    <xhtml:p></xhtml:p>
   </xhtml:section>
  </p:documentation>
  
  <!-- INPUT PORTS -->
  <p:input port="source" />
  
  <!-- OUTPUT PORTS -->
  <p:output port="result" primary="true" />
  
  <!-- PIPELINE BODY -->
  <p:identity>
   <p:with-input port="source">
    <p:inline content-type="text/plain">
     {
     if(exists(/lad:document/@nickname))
     then /lad:document/@nickname 
     else if(starts-with(/lad:document/@id, 'uuid:')) 
     then substring-after(/lad:document/@id, 'uuid:') 
     else  /lad:document/@id 
     }
    </p:inline>
   </p:with-input>
  </p:identity>
  
 </p:declare-step>

</p:library>

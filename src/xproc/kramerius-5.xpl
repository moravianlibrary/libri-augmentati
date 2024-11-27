<p:library  xmlns:p="http://www.w3.org/ns/xproc" 
 xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:lad="https://www.mzk.cz/ns/libri-augmentati/documents/1.0"
 xmlns:las="https://www.mzk.cz/ns/libri-augmentati/settings/1.0"
 xmlns:lax="https://www.mzk.cz/ns/libri-augmentati/xproc/1.0"
 xmlns:xlog="https://www.daliboris.cz/ns/xproc/logging/1.0"
 xmlns:map = "http://www.w3.org/2005/xpath-functions/map"
 xmlns:array = "http://www.w3.org/2005/xpath-functions/array"
 xmlns:xhtml="http://www.w3.org/1999/xhtml"
 version="3.0">
 
<!-- <p:import href="../includes/log-xpc-lib/src/xproc/log-xpc-lib.xpl" />-->
 
 <p:documentation>
  <xhtml:section xml:lang="en">
   <xhtml:h1>Kramerius 5</xhtml:h1>
   <xhtml:p>Programming library for communication with the system <xhtml:a href="https://system-kramerius.cz/en">Kramerius</xhtml:a>, <xhtml:a href="https://github.com/ceskaexpedice/kramerius/wiki/ClientAPIDEV">version 5</xhtml:a>.</xhtml:p>
  </xhtml:section>
  <xhtml:section xml:lang="cs">
   <xhtml:h1>Kramerius 5</xhtml:h1>
   <xhtml:p>Programová knihovna pro komunikaci se systémem <xhtml:a href="https://system-kramerius.cz">Kramerius</xhtml:a>, <xhtml:a href="https://github.com/ceskaexpedice/kramerius/wiki/ClientAPIDEV">verze 5</xhtml:a>.</xhtml:p>
  </xhtml:section>
 </p:documentation>
 
 <p:option name="url-fragments" select=" map {
  'alto' : '/streams/ALTO',
  'text' : '/streams/TEXT_OCR',
  'mods' : '/streams/BIBLIO_MODS',
  'dc' : '/streams/DC',
  'foxml' : '/foxml',
  'image' : '/full'
  }" static="true" />
 
 <p:declare-step type="lax:get-virtual-document-metadata-v5" name="getting-virtual-document-metadata">
  
  <p:documentation>
   <xhtml:section xml:lang="en">
    <xhtml:h2>Get virtual document metadata</xhtml:h2>
    <xhtml:p>Gathers all requested metadata about the publication. Creates the content of the virtual document with links to all requested resources.</xhtml:p>
    <xhtml:p>Enhance input data by adding requested resources on the document and page level.</xhtml:p>
   </xhtml:section>
   <xhtml:section xml:lang="cs">
    <xhtml:h2>Získání metadat virtuálního dokumentu</xhtml:h2>
    <xhtml:p>Shromáždí všechna požadovaná metadata o publikaci. Vytvoří strukturu virutálního dokumentu s odkazy na všechny požadované zdroje.</xhtml:p>
    <xhtml:p>Obohatí vstupní data přidáním požadovaných zdrojů na úrovni dokumentu a strany.</xhtml:p>
   </xhtml:section>
  </p:documentation>
  
  <!-- INPUT PORTS -->
  <p:input  port="source" primary="true"/>
  
  <!-- OUTPUT PORTS -->
  <p:output port="result" primary="true" serialization="map{'indent' : true()}" />
  
  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
    
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  
  
  <p:variable name="base-url" select="/lad:document/lad:options/@base-url" />
  <p:variable name="id" select="/lad:document/@id" />
  <p:variable name="guid" select="substring-after(/lad:document/@id, ':')" />
  <p:variable name="url" select="concat($base-url, '/item/', $id, '/children')" />
  
  <!-- PIPELINE BODY -->
  <p:insert match="/lad:document" position="last-child" message="Inserting document resources for {$id}">
   <p:with-input port="insertion">
    <p:inline>
     <lad:resource type="mods" url="{concat($base-url, '/item/', $id, $url-fragments?mods)}" available="true" />
     <lad:resource type="dc" url="{concat($base-url, '/item/', $id, $url-fragments?dc)}" available="true" />
     <lad:resource type="foxml" url="{concat($base-url, '/item/', $id, $url-fragments?foxml)}" available="true" />
    </p:inline>
   </p:with-input>
  </p:insert>
  
  <p:identity name="document-with-resources" />
  
  <lax:get-virtual-document-pages url="{$url}" document-id="{$guid}" debug-path="{$debug-path}" base-uri="{$base-uri}"/>
  
  <lax:get-available-formats base-url="{$base-url}" debug-path="{$debug-path}" base-uri="{$base-uri}"/>
  
  <lax:get-source-url base-url="{$base-url}" debug-path="{$debug-path}" base-uri="{$base-uri}"/>

  <p:identity name="pages" />
  
  <p:if test="$debug">
   <p:store href="{$debug-path-uri}/kramerius-5/virtual-document/metadata-pages.xml" />
  </p:if>
  
  <p:insert match="/lad:document" position="last-child" >
   <p:with-input port="source" pipe="result@document-with-resources" />
   <p:with-input port="insertion" pipe="result@pages" />
  </p:insert>
  
  <p:viewport match="lad:page">
   <p:variable name="page-order" select="p:iteration-position()" />
   <p:add-attribute attribute-name="order" attribute-value="{$page-order}" />
   <p:viewport match="lad:resource">
    <p:add-attribute attribute-name="order" attribute-value="{$page-order}" />            
   </p:viewport>
  </p:viewport>
  
  <p:if test="$debug">
   <p:store href="{$debug-path-uri}/kramerius-5/virtual-document/metadata-result.xml" />
  </p:if>
 
 </p:declare-step>

 <p:declare-step type="lax:get-virtual-document-data-v5" name="getting-virtual-document-data">

  <p:documentation>
   <xhtml:section xml:lang="en">
    <xhtml:h2>Get virtual document data</xhtml:h2>
    <xhtml:p>Gathers all requested data about the publication. Downloads the content (files) of the virtual document from external targets.</xhtml:p>
    <xhtml:p>Saves data to the disk and enhance input data by adding info about local path of the requested resources.</xhtml:p>
   </xhtml:section>
   <xhtml:section xml:lang="cs">
    <xhtml:h2>Získání dat virtuálního dokumentu</xhtml:h2>
    <xhtml:p>Shromáždí všechna požadovaná data publikace. Stáhne obsah (soubory) virutálního dokumentu z externích odkazů.</xhtml:p>
    <xhtml:p>Uloží data na disk a obohatí vstupní data přidáním informace o lokálním uložení zdrojů.</xhtml:p>
   </xhtml:section>
  </p:documentation>
  
  
  <!-- INPUT PORTS -->
  <p:input  port="source" primary="true"/>
  
  <!-- OUTPUT PORTS -->
  <p:output port="result" primary="true" serialization="map{'indent' : true()}" />
  
  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  
  <!-- PIPELINE BODY -->
  <p:insert position="last-child">
   <p:with-input port="insertion">
    <p:inline><lad:data /></p:inline>
   </p:with-input>
  </p:insert>
  
 </p:declare-step>
 
 <p:declare-step type="lax:get-virtual-document-pages" visibility="private">
  
  <p:documentation>
   <xhtml:section xml:lang="en">
    <xhtml:h2>Get virtual document pages</xhtml:h2>
    <xhtml:p>Creates element for each page of the document that contains basic data: identifier, type and (page) number.</xhtml:p>
    <xhtml:p>Returns element <xhtml:code>&lt;lad:pages&gt;</xhtml:code> </xhtml:p>
   </xhtml:section>
   <xhtml:section xml:lang="cs">
    <xhtml:h2>Získání stránek virtuálního dokumentu</xhtml:h2>
    <xhtml:p>Pro každou stránku dokumentu vytvoří element se základními údaji: identifikátor, typ a číslo (strany).</xhtml:p>
    <xhtml:p>Vrací element <xhtml:code>&lt;lad:pages&gt;</xhtml:code></xhtml:p>
   </xhtml:section>
  </p:documentation>
  
  <!-- OUTPUT PORTS -->
  <p:output port="result" primary="true"/>
  
  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
  
  <p:option name="url" as="xs:string" />
  <p:option name="document-id" as="xs:string" />
  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  
  <!-- PIPELINE BODY -->
  <p:http-request method="GET" href="{$url}" message="{$url}">
   <p:with-input port="source"><p:empty /></p:with-input>
  </p:http-request>

  <p:if test="$debug">
   <p:store href="{$debug-path-uri}/{$document-id}/http-children-response.json" message="Storing to {$debug-path-uri}/{$document-id}/http-children-response.json" />
  </p:if>
  
  <lax:pages-convert-json-to-xml debug-path="{$debug-path}" base-uri="{$base-uri}"/>
  
 </p:declare-step>
 
 <p:declare-step type="lax:pages-convert-json-to-xml">
  
  <p:documentation>
   <xhtml:section xml:lang="en">
    <xhtml:h2>Pages: convert JSON to XML</xhtml:h2>
    <xhtml:p>Converts from JSON to XML data about the document page. Creates element for the page with basic data: identifier, type and (page) number.</xhtml:p>
    <xhtml:p>Returns <xhtml:code>&lt;lad:page&gt;</xhtml:code> element.</xhtml:p>
   </xhtml:section>
   <xhtml:section xml:lang="cs">
    <xhtml:h2>Strany: konverze JSONu na XML</xhtml:h2>
    <xhtml:p>Zkonvertuje údje o stránce z JSONu do XML. Vytvoří element pro stránku dokumentu se základními údaji: identifikátor, typ a číslo (strany).</xhtml:p>
    <xhtml:p>Vrací element <xhtml:code>&lt;lad:page&gt;</xhtml:code>.</xhtml:p>
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
  
  <!-- PIPELINE BODY -->
  <p:for-each>
   <p:with-input select=".?*"/>
   <p:identity>
    <p:with-input port="source">
     <lad:page id="{.?pid}" title="{.?title}" type="{.?details?type}" />
    </p:with-input>
   </p:identity>
  </p:for-each>	
  
  <p:wrap-sequence wrapper="lad:pages"/>
  
 </p:declare-step>
 
 <p:declare-step type="lax:get-source-url" name="getting-source-url">
  
  <p:documentation>
   <xhtml:section xml:lang="en">
    <xhtml:h2>Get source URL</xhtml:h2>
    <xhtml:p>For a resource associated with a page, builds a URL from the base URL, API version, document identifier, etc.</xhtml:p>
    <xhtml:p>Creates <xhtml:code>@url</xhtml:code> attribute for the <xhtml:code>&lt;lad:page&gt;</xhtml:code> element.</xhtml:p>
   </xhtml:section>
   <xhtml:section xml:lang="cs">
    <xhtml:h2>Sestavení URL zdroje</xhtml:h2>
    <xhtml:p>Pro zdroj přiřazený ke stránce sestaví adresu URL ze základní adresy URL, verze rozhraní API, identifikátoru dokumentu apod.</xhtml:p>
    <xhtml:p>Vytvoří atribut <xhtml:code>@url</xhtml:code> v rámci elementu <xhtml:code>&lt;lad:page&gt;</xhtml:code>.</xhtml:p>
   </xhtml:section>
  </p:documentation>
  
  <!-- INPUT PORTS -->
  <p:input  port="source" primary="true"/>
  
  <!-- OUTPUT PORTS -->
  <p:output port="result" primary="true" serialization="map{'indent' : true()}" />
  
  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
  
  <p:option name="base-url" as="xs:anyURI" />
  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  
  <!-- PIPELINE BODY -->
  <p:viewport match="lad:page">
   <p:if test="/*/@alto = 'true'">
    <p:add-attribute attribute-name="alto" attribute-value="{concat($base-url, '/item/', /*/@id, $url-fragments?alto)}" />
   </p:if>
   <p:if test="/*/@text = 'true'">
    <p:add-attribute attribute-name="text" attribute-value="{concat($base-url, '/item/', /*/@id, $url-fragments?text)}" />
   </p:if>
   <p:if test="/*/@dc = 'true'">
    <p:add-attribute attribute-name="dc" attribute-value="{concat($base-url, '/item/', /*/@id, $url-fragments?dc)}" />
   </p:if>
   <p:if test="/*/@foxml = 'true'">
    <p:add-attribute attribute-name="foxml" attribute-value="{concat($base-url, '/item/', /*/@id, $url-fragments?foxml)}" />
   </p:if>
   <p:if test="/*/@mods = 'true'">
    <p:add-attribute attribute-name="mods" attribute-value="{concat($base-url, '/item/', /*/@id, $url-fragments?mods)}" />
   </p:if>
   <p:if test="/*/@image = 'true'">
    <p:add-attribute attribute-name="image" attribute-value="{concat($base-url, '/item/', /*/@id, $url-fragments?image)}" />
   </p:if>
  </p:viewport>
  
  
  <p:viewport match="lad:page">
   <p:variable name="id" select="/lad:page/@id" />
   <p:viewport match="lad:page/lad:resource[@available='true']" message="Page id: {$id}">
    <p:variable name="type" select="/*/@type/data()" />
    <p:add-attribute attribute-name="url" attribute-value="{concat($base-url, '/item/', $id, $url-fragments?($type))}" />
   </p:viewport>
  </p:viewport>
  
  
 </p:declare-step>

 <p:declare-step type="lax:get-available-formats" name="getting-available-formats">
  <p:documentation>
   <xhtml:section xml:lang="en">
    <xhtml:h2>Get available formats</xhtml:h2>
    <xhtml:p>Selects one page from the middle of the document and checks which resources are available on-line.</xhtml:p>
    <xhtml:p>For each requested <xhtml:code>&lt;resource&gt;</xhtml:code> adds <xhtml:code>@available</xhtml:code> attribute.</xhtml:p>
   </xhtml:section>
   <xhtml:section xml:lang="cs">
    <xhtml:h2>Zjištění dostupných formátů</xhtml:h2>
    <xhtml:p>Pro stránku zprostředka publikace zjistí, které všechny zdroje jsou dostupné on-line.</xhtml:p>
    <xhtml:p>Pro každý požadovaný zdroj vytvoří atribut <xhtml:code>@available</xhtml:code> v rámci elementu <xhtml:code>&lt;lad:resource&gt;</xhtml:code>.</xhtml:p>
   </xhtml:section>
  </p:documentation>
  
  
  <!-- INPUT PORTS -->
  <p:input  port="source" primary="true"/>
  
  <!-- OUTPUT PORTS -->
  <p:output port="result" primary="true" serialization="map{'indent' : true()}" />
  
  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
  
  <p:option name="base-url" as="xs:anyURI" />
  
  <!-- VARIABLES -->
  <p:variable name="size" select="count(/lad:pages/lad:page)" as="xs:integer" />
  <p:variable name="page" select="/lad:pages/lad:page[xs:integer($size div 2)]" />
  
  <p:variable name="url" select="concat($base-url, '/item/', $page/@id)" />
  
  <p:variable name="alto-url" select="concat($url, $url-fragments?alto)" />
  <p:variable name="text-url" select="concat($url, $url-fragments?text)" />
  <p:variable name="dc-url" select="concat($url, $url-fragments?dc)" />
  <p:variable name="foxml-url" select="concat($url, $url-fragments?foxml)" />
  <p:variable name="mods-url" select="concat($url, $url-fragments?mods)" />
  <p:variable name="image-url" select="concat($url, $url-fragments?image)" />
  
  <!-- PIPELINE BODY -->
  <lax:get-available-format url="{$alto-url}" format="alto" 
   debug-path="{$debug-path}" base-uri="{$base-uri}">
   <p:with-input port="source" select="$page" />
  </lax:get-available-format>
  
  <lax:get-available-format url="{$text-url}" format="text" debug-path="{$debug-path}" base-uri="{$base-uri}"/>
  <lax:get-available-format url="{$dc-url}" format="dc" debug-path="{$debug-path}" base-uri="{$base-uri}"/>
  <lax:get-available-format url="{$foxml-url}" format="foxml" debug-path="{$debug-path}" base-uri="{$base-uri}"/>
  <lax:get-available-format url="{$mods-url}" format="mods" debug-path="{$debug-path}" base-uri="{$base-uri}"/>
  <lax:get-available-format url="{$image-url}" format="image" debug-path="{$debug-path}" base-uri="{$base-uri}"/>
  
  <p:identity name="page-with-formats" />
  
  <p:variable name="page-formats" select="/*" />
  
  <p:insert match="lad:page" position="first-child">
   <p:with-input port="source" pipe="source@getting-available-formats" />
   <p:with-input port="insertion" select="/lad:page/lad:resource" pipe="result@page-with-formats" />
  </p:insert>
  
  <!--  <p:set-attributes match="lad:page" attributes="map {
   'alto' : $page-formats/@alto, 
   'text' : $page-formats/@text, 
   'dc' : $page-formats/@dc, 
   'foxml' : $page-formats/@foxml, 
   'mods' : $page-formats/@mods, 
   'image' : $page-formats/@image 
   }">-->
  <!--   <p:with-input port="source" pipe="source@getting-available-formats" />-->
  <!--</p:set-attributes>-->
  
  <p:namespace-delete prefixes="array" />
  
 </p:declare-step>

 

 <p:declare-step type="lax:get-available-format" name="getting-available-format">
  
  <p:documentation>
   <xhtml:section xml:lang="en">
    <xhtml:h2>Get available format</xhtml:h2>
    <xhtml:p>Checks if the resource is available on-line.</xhtml:p>
    <xhtml:p>Returns <xhtml:code>&lt;resource&gt;</xhtml:code> with the <xhtml:code>@available</xhtml:code> attribute.</xhtml:p>
   </xhtml:section>
   <xhtml:section xml:lang="cs">
    <xhtml:h2>Zjištění dostupnosti formátu</xhtml:h2>
    <xhtml:p>Zjistí, zda je požadovaný zdroj dostupný on-line.</xhtml:p>
    <xhtml:p>Vrací element <xhtml:code>&lt;lad:resource&gt;</xhtml:code> s atributem <xhtml:code>@available</xhtml:code>.</xhtml:p>
   </xhtml:section>
  </p:documentation>
  
  <!-- INPUT PORTS -->
  <p:input port="source" primary="true" />
  
  <!-- OUTPUT PORTS -->
  <p:output port="result" primary="true" />
  
  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
  
  <p:option name="url" as="xs:anyURI" required="true" />
  <p:option name="format" as="xs:string" required="true" />
  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  
  <!-- PIPELINE BODY -->
  <p:http-request href="{$url}" parameters="map{'status-only' : true(), 'follow-redirect' : 3 }" name="request" />
  <p:variable name="available" select=".?status-code = (200, 307, 301)" pipe="report@request" />
  
  <p:add-attribute attribute-name="{$format}" attribute-value="{$available}">
   <p:with-input port="source" pipe="source@getting-available-format" />
  </p:add-attribute>
  
  <p:insert match="lad:page" position="first-child">
   <p:with-input port="insertion">
    <p:inline>
     <lad:resource type="{$format}" available="{$available}" />
    </p:inline>
   </p:with-input>
  </p:insert>
  
 </p:declare-step>
 
</p:library>
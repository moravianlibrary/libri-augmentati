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
 
<!--    <p:import href="../includes/log-xpc-lib/src/xproc/log-xpc-lib.xpl" />-->
 
 <p:documentation>
     <xhtml:section xml:lang="en">
         <xhtml:h1>Kramerius 7</xhtml:h1>
         <xhtml:p>Programming library for communication with the <xhtml:a href="https://system-kramerius.cz/en">Kramerius</xhtml:a> system, <xhtml:a href="https://github.com/ceskaexpedice/kramerius/wiki/API-v7">version 7</xhtml:a>.</xhtml:p>
     </xhtml:section>
     <xhtml:section xml:lang="cs">
         <xhtml:h1>Kramerius 7</xhtml:h1>
         <xhtml:p>Programová knihovna pro komunikaci se systémem <xhtml:a href="https://system-kramerius.cz">Kramerius</xhtml:a>, <xhtml:a href="https://github.com/ceskaexpedice/kramerius/wiki/API-v7">verze 7</xhtml:a>.</xhtml:p>
     </xhtml:section>
 </p:documentation>
    
 <p:declare-step type="lax:get-virtual-document-metadata-v7" name="getting-virtual-document-metadata" >
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
     

     <p:variable name="resources" select="/lad:document/las:api/las:resource" />
     <p:variable name="library" select="/lad:document/las:library" />
     <p:variable name="base-url" select="/lad:document/lad:options/@base-url" />
     <p:variable name="id" select="replace(/lad:document/@id, ':', '%3A')" /> 
     <p:variable name="guid" select="substring-after(/lad:document/@id, ':')" />
     <p:variable name="url" select="concat($base-url, '/search/api/client/v7.0/search?fl=pid,page.number,page.type&amp;sort=rels_ext_index.sort%20asc&amp;rows=4000&amp;start=0&amp;q=own_parent.pid:', '%22', $id, '%22')" />
     
     <p:variable name="mods-url" select="$resources[@type='MODS']/@url ! replace(., '\{pid\}', $id)" />
     <p:variable name="dc-url" select="$resources[@type='DC']/@url ! replace(., '\{pid\}', $id)" />
     <p:variable name="foxml-url" select="$resources[@type='FOXML']/@url ! replace(., '\{pid\}', $id)" />
     
     <!-- PIPELINE BODY -->
     <p:insert match="/lad:document" position="last-child" message="Inserting document resources for {$id}">
         <p:with-input port="insertion">
             <p:inline>
                 <lad:resource type="mods" url="{concat($base-url, $mods-url)}" available="true" />
                 <lad:resource type="dc" url="{concat($base-url, $dc-url)}" available="true" />
                 <lad:resource type="foxml" url="{concat($base-url,  $foxml-url)}" available="true" />
             </p:inline>
         </p:with-input>
     </p:insert>
     <p:if test="$debug">
         <p:store href="{$debug-path-uri}/{$library/@code}/{$guid}/virtual-document-resources.xml" message="Storing to {$debug-path-uri}/{$library/@code}/{$guid}/virtual-document-pages.xml" serialization="map{'indent' : true()}" />
     </p:if>
     <p:identity name="document-with-resources" />
  
     <lax:get-virtual-document-pages-v7 url="{$url}" document-id="{$guid}" library-code="{$library/@code}" debug-path="{$debug-path}" base-uri="{$base-uri}"/>
     <p:if test="$debug">
         <p:store href="{$debug-path-uri}/{$library/@code}/{$guid}/virtual-document-pages.xml" message="Storing to {$debug-path-uri}/{$library/@code}/{$guid}/virtual-document-pages.xml" serialization="map{'indent' : true()}" />
     </p:if>
     <p:identity name="virutal-pages" />
     <p:insert match="lad:document" position="last-child">
         <p:with-input port="source" pipe="result@document-with-resources" />
         <p:with-input port="insertion" pipe="result@virutal-pages" />
     </p:insert>
     <p:if test="$debug">
         <p:store href="{$debug-path-uri}/{$library/@code}/{$guid}/virtual-document-pages-combined.xml" message="Storing to {$debug-path-uri}/{$library/@code}/{$guid}/virtual-document-pages-combined.xml" serialization="map{'indent' : true()}" />
     </p:if>
     
     <lax:get-available-formats-v7 base-url="{$base-url}" debug-path="{$debug-path}" base-uri="{$base-uri}"/>
     <p:if test="$debug">
         <p:store href="{$debug-path-uri}/{$library/@code}/{$guid}/available-formats.xml" message="Storing to {$debug-path-uri}/{$library/@code}/{$guid}/available-formats.xml" serialization="map{'indent' : true()}" />
     </p:if>
     
     <lax:get-source-url-v7 debug-path="{$debug-path}" base-uri="{$base-uri}"/>
     <p:namespace-delete prefixes="lax xlog array xs map xhtml" />
     <p:if test="$debug">
         <p:store href="{$debug-path-uri}/{$library/@code}/{$guid}/source-url.xml" message="Storing to {$debug-path-uri}/{$library/@code}/{$guid}/source-url.xml" serialization="map{'indent' : true()}" />
     </p:if>
  
  <!--
   {
{
    "response": {
        "docs": [
            {
                "page.number": "[1]",
                "pid": "uuid:73648039-1b21-4921-9b08-13161ae6d239"
            },
            {
                "page.number": "[2]",
                "pid": "uuid:2d666ced-fea9-4823-ac8e-b26641da6e35"
            },
            {
                "page.number": "3",
                "pid": "uuid:5f552dd5-9d36-4b15-8fc9-056ed06678f4"
            }
            ],
        "numFound": 4,
        "start": 0,
        "numFoundExact": true
    },
    "responseHeader": {
        "QTime": 3,
        "params": {
            "q": "own_parent.pid:\"uuid:de87a0e0-643b-11ea-a744-005056827e51\"",
            "fl": "pid,page.number",
            "start": "0",
            "hl.fragsize": "20",
            "sort": "rels_ext_index.sort asc",
            "rows": "4000",
            "wt": "json"
        },
        "status": 0
    }
}

  -->

    <p:viewport match="lad:page">
        <p:variable name="page-order" select="p:iteration-position()" />
        <p:add-attribute attribute-name="order" attribute-value="{$page-order}" />
        <p:viewport match="lad:resource">
            <p:add-attribute attribute-name="order" attribute-value="{$page-order}" />            
        </p:viewport>
    </p:viewport>
     <p:if test="$debug">
         <p:store href="{$debug-path-uri}/{$library/@code}/{$guid}/virtual-document-metadata-final.xml" message="Storing to {$debug-path-uri}/{$library/@code}/{$guid}/virtual-document-metadata-final.xml" serialization="map{'indent' : true()}" />
     </p:if>
     
     <p:insert match="/lad:document" position="last-child" use-when="false()">
         <p:with-input port="source" pipe="result@document-with-resources" />
         <p:with-input port="insertion" select="/lad:pages" pipe="result@pages" />
     </p:insert>

 </p:declare-step>
 
 <p:declare-step type="lax:get-virtual-document-data-v7" name="getting-virtual-document-data">
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
  
  
  <p:variable name="base-url" select="/lad:document/lad:options/@base-url" />
  <p:variable name="id" select="/lad:document/@id" />
  <p:variable name="guid" select="substring-after(/lad:document/@id, ':')" />
  <p:variable name="url" select="concat($base-url, '/item/', $id, '/children')" />


 </p:declare-step>

 <p:declare-step type="lax:get-virtual-document-pages-v7" visibility="private">
     
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
     <p:output port="result" primary="true" serialization="map{'indent' : true()}" />
        
     <!-- OPTIONS -->
     <p:option name="debug-path" select="()" as="xs:string?" />
     <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
        
     <p:option name="url" as="xs:string" required="true" />
     <p:option name="document-id" as="xs:string" required="true" />
     <p:option name="library-code" as="xs:string" required="true" />
        
     <!-- VARIABLES -->
     <p:variable name="debug" select="$debug-path || '' ne ''" />
     <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />

    <!-- PIPELINE BODY -->
    <p:try>
        <p:group>
            <p:http-request method="GET" href="{$url}" message="{$url}">
                <p:with-input port="source"><p:empty /></p:with-input>
            </p:http-request>
            
            <p:if test="$debug">
                <p:store href="{$debug-path-uri}/{$library-code}/{$document-id}/http-response.json" message="Storing to {$debug-path-uri}/{$library-code}/{$document-id}/http-response.json" serialization="map{'indent' : true()}" />
            </p:if>

            <lax:pages-convert-json-to-xml-v7 debug-path="{$debug-path}" base-uri="{$base-uri}"/>

        </p:group>
        <p:catch name="failed-to-download">
            <p:identity>
                <p:with-input port="source" pipe="error@failed-to-download" />
            </p:identity>
            <p:wrap wrapper="lad:pages" match="/*" />   
        </p:catch>
    </p:try>
        
 </p:declare-step>

 <p:declare-step type="lax:pages-convert-json-to-xml-v7">
     
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
       <p:with-input select=".?response?docs?*"/>
       <p:identity>
           <p:with-input port="source">
               <lad:page id="{.?pid}" title="{.?('page.number')}"  type="{.?('page.type')}" />
           </p:with-input>
       </p:identity>
   </p:for-each>
   
   <p:wrap-sequence wrapper="lad:pages"/>

 </p:declare-step>
 
 <p:declare-step type="lax:get-source-url-v7" visibility="private">
     
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
     
     <!-- VARIABLES -->
     <p:variable name="debug" select="$debug-path || '' ne ''" />
     <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
     
     <p:variable name="options" select="/lad:document/lad:options" />
     <p:variable name="resources" select="/lad:document/las:api/las:resource" />
     
     <!-- PIPELINE BODY -->
     <p:viewport match="lad:page">
         <p:variable name="page" select="/lad:page" />
         <p:variable name="id" select="$page/@id" />
         <p:viewport match="lad:page/lad:resource[@available='true']">
             <p:variable name="type" select="/*/@type/data()" />
             <p:variable name="resource" select="$resources[lower-case(@type) = $type]" />
             <p:variable name="url-suffix" select="$resource/@url ! replace(., '\{pid\}', $page/@id)" />
             <p:variable name="url" select="concat($options/@base-url, $url-suffix)" />
             <p:add-attribute attribute-name="url" attribute-value="{$url}" />
         </p:viewport>
     </p:viewport>

</p:declare-step>

 <p:declare-step type="lax:get-available-formats-v7" name="getting-available-formats">
     
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
     <p:variable name="size" select="count(/lad:document/lad:pages/lad:page)" as="xs:integer" />
     <p:variable name="page" select="/lad:document/lad:pages/lad:page[xs:integer($size div 2)]" />
     
    <p:variable name="options" select="/lad:document/lad:options" />
    
    <p:variable name="resources" select="/lad:document/las:api/las:resource[tokenize(@level) = 'page'][@type=tokenize($options/@page-resources)]" />
    
    <!-- PIPELINE BODY -->
    <p:for-each name="available-resources">
        <p:output port="result" primary="true" />
        <p:with-input select="$resources"/>
        <p:variable name="resource" select="/las:resource" />
        <p:variable name="url-suffix" select="$resource/@url ! replace(., '\{pid\}', $page/@id)" />
        <p:variable name="url" select="concat($options/@base-url, $url-suffix)" />
        <lax:get-available-format-v7 url="{$url}" format="{lower-case($resource/@type)}"
            debug-path="{$debug-path}" base-uri="{$base-uri}">
            <p:with-input port="source" select="$page" />
        </lax:get-available-format-v7>
    </p:for-each>
     
    
    <p:insert match="lad:page" position="first-child">
        <p:with-input port="source" pipe="source@getting-available-formats" />
        <p:with-input port="insertion" pipe="result@available-resources" />
    </p:insert>
    
    <p:namespace-delete prefixes="array" />
    
</p:declare-step>
    
 <p:declare-step type="lax:get-available-format-v7" name="getting-available-format">
     
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
    <p:http-request href="{$url}" 
        parameters="map{'status-only' : true(), 'follow-redirect' : 3 }"
        assert=".?status-code lt 500"
        name="request" />
    <p:variable name="available" select=".?status-code = (200, 307, 301)" pipe="report@request" />
    
    <p:add-attribute attribute-name="{$format}" attribute-value="{$available}">
        <p:with-input port="source" pipe="source@getting-available-format" />
    </p:add-attribute>
    
    <p:insert match="lad:page" position="first-child" use-when="false()">
        <p:with-input port="insertion">
            <p:inline>
                <lad:resource type="{$format}" available="{$available}" />
            </p:inline>
        </p:with-input>
    </p:insert>
     
     <p:identity>
         <p:with-input port="source">
             <p:inline>
                 <lad:resource type="{$format}" available="{$available}" />
             </p:inline>
         </p:with-input>
     </p:identity>

</p:declare-step>

</p:library>
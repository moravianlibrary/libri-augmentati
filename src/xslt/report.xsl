<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:lad="https://www.mzk.cz/ns/libri-augmentati/documents/1.0" 
 xmlns:las="https://www.mzk.cz/ns/libri-augmentati/settings/1.0"
 xmlns:c="http://www.w3.org/ns/xproc-step"
 xmlns:lax="https://www.mzk.cz/ns/libri-augmentati/xslt"
 exclude-result-prefixes="xs math xd lad las lax"
 version="3.0"
>
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Jun 4, 2024</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:strip-space elements="*"/>
 <xsl:output method="html" indent="true" />
 <xsl:mode on-no-match="shallow-skip"/>
 <xsl:param name="use-relative-paths" as="xs:boolean" select="true()" />
 <xsl:param name="docker-data-root" select="'/data/'" />
 
 <xsl:template match="/">
  <html>
   <head>
    <title>Libri augmentati Report</title>
    <style>
     table.pages {
     background-color: #FFFFFF;
     border-collapse: collapse;
     border-width: 2px;
     border-color: #7EA8F8;
     border-style: solid;
     color: #000000;
     }
     
     table.pages td, table.pages th {
     border-width: 2px;
     border-color: #7EA8F8;
     border-style: solid;
     padding: 0.5em;
     }
     
     table.pages thead {
     background-color: #7EA8F8;
     }
     
     .container {
     display: grid;
     grid-template-columns: 5fr 2fr;
     grid-template-rows: auto auto;
     gap: 10px;
     }
     
     .container div {
      border-bottom-width: 1em;
      border-bottom-color: #7EA8F8;
      border-bottom-style: solid;
     }
     
     img.logo {
      width: 30px;
      height: 30px;
     }
     
    </style>
   </head>
   <body>
    <div class="container">
     <xsl:apply-templates />     
    </div>
   </body>
  </html>
 </xsl:template>
 
 <xsl:template match="las:api">
  <xsl:variable name="api" select="."/>
  <aside>
   <h3>API</h3>
   <xsl:if test="@common-name">
    <p><xsl:value-of select="concat(@common-name, ' ', @version)"/></p>
   </xsl:if>
   <xsl:if test="@documentation">
    <p><a href="{@documentation}">Documentation</a></p>
   </xsl:if>
   <xsl:variable name="levels" select="las:resource/@level => distinct-values() => string-join(' ') => tokenize() => distinct-values()"/>
   <h4>Resources</h4>
   <dl>
    <xsl:for-each select="$levels">
     <xsl:variable name="level" select="."/>
      <dt><xsl:value-of select="$level"/></dt>
     <dd><xsl:value-of select="$api/las:resource[tokenize(@level) = $level]/@type => distinct-values() => string-join(', ')"/></dd>
    </xsl:for-each>
    
   </dl>
  </aside>
 </xsl:template>
 
 <xsl:template match="lad:document">
  <xsl:variable name="view-url" select="lax:get-view-url(lad:pages/lad:page[1])"/>
  <div>
   <section>
    <xsl:if test="@author | @title">
     <h1><xsl:value-of select="@author"/>
      <xsl:if test="@author and @title"><xsl:text>: </xsl:text></xsl:if> 
      <xsl:value-of select="@title"/></h1> 
    </xsl:if>
    
    <h2>Document ID <a href="{$view-url}"><xsl:value-of select="@id"/></a></h2>
    <xsl:call-template name="resource-table" />
    <xsl:apply-templates select="* except (las:api, las:library, lad:options)" />
   </section>   
  </div>
  <div>
   <xsl:apply-templates select="las:library, lad:options, las:api " />
  </div>
 </xsl:template>
 
 <xsl:template name="resource-table">
  <table class="pages">
   <thead>
    <tr>
     <xsl:apply-templates select="lad:resource" mode="head" />
    </tr>
   </thead>
   <tbody>
    <tr>
     <xsl:apply-templates select="lad:resource" mode="body" />
    </tr>
   </tbody>
  </table>
 </xsl:template>
 
 <xsl:template match="lad:resource" mode="head">
  <td><xsl:value-of select="@type/data()"/></td>
 </xsl:template>
 
 <xsl:template match="lad:resource" mode="body">
  <td>
   <xsl:if test="@url">
    <a href="{@url}">on-line</a> 
   </xsl:if>
   <xsl:if test="@url and @local-file-exists = 'true'">
    <xsl:text> | </xsl:text>    
   </xsl:if>
   <xsl:if test="@local-file-exists = 'true'">
    <xsl:call-template name="get-local-path">
     <xsl:with-param name="resource" select="." />
    </xsl:call-template>
   </xsl:if>
  </td>
 </xsl:template>
 
 <xsl:template match="lad:options">
  <aside>
   <h1>Options</h1>
   <table class="pages">
    <thead>
     <tr>
      <th>option</th>
      <th>value</th>
     </tr>
    </thead>
    <tbody>
     <xsl:for-each select="@*">
      <tr>
       <td><xsl:value-of select="name(.)"/></td>
       <td><xsl:value-of select="data(.)"/></td>
      </tr>
     </xsl:for-each>
    </tbody>
   </table>
  </aside>
 </xsl:template>
 
 <xsl:template match="las:library">
  <aside>
   <h1>Digital Library</h1>
   <table class="pages">
    <tbody>
      <tr>
       <td><xsl:value-of select="las:institution/las:name[1]"/></td>
       <td rowspan="2"><img class="logo" src="{@logo}" alt="{las:institution/las:name[1]}" /></td>
      </tr>
     <tr>
      <td><a href="{las:institution/las:web}"><xsl:value-of select="las:institution/las:web"/></a></td>
     </tr>
     <tr>
      <xsl:apply-templates select="las:institution/las:address" />
     </tr>
    </tbody>
   </table>
  </aside>
 </xsl:template>
 
 <xsl:template match="las:address">
  <td>
   <xsl:apply-templates select="las:street" /><br />
   <xsl:apply-templates select="las:city" /><br />
   <xsl:apply-templates select="las:zip" /><br />
   <xsl:apply-templates select="las:state" />
  </td>
 </xsl:template>
 
 <xsl:template match="las:address/*">
  <xsl:value-of select="."/>
 </xsl:template>
 
 <xsl:template match="lad:pages">
  <section>
   <h3>Document pages</h3>
   <table class="pages">
    <thead>
     <xsl:apply-templates select="lad:page[1]" mode="head" />
    </thead>
    <tbody>
      <xsl:apply-templates />  
    </tbody>
   </table>
   
  </section>
 </xsl:template>
 
 <xsl:template match="lad:page" mode="head">
  <tr>
   <td>#</td>
   <xsl:for-each select="@* except(@alto, @ocr, @mods, @foxml, @dc, @image, @id)">
    <td><xsl:value-of select="name(.)"/></td>
   </xsl:for-each>
   <xsl:apply-templates select="lad:resource" mode="head" />
   <!--<xsl:for-each select="lad:resource">
    <td><xsl:value-of select="@type/data()"/></td>
   </xsl:for-each>-->
  </tr>
 </xsl:template>
 
 <xsl:template match="lad:page">
  <xsl:variable name="view-url" select="lax:get-view-url(.)"/>
  <tr>
   <td><a href="{$view-url}"><xsl:value-of select="position()"/></a></td>
   <xsl:for-each select="@* except(@alto, @ocr, @mods, @foxml, @dc, @image, @id)">
    <xsl:variable name="text" select="data(.)"/>
    <td>
     <xsl:choose>
      <xsl:when test="starts-with(., 'http')">
       <a href="{$text}">on-line</a>
       <xsl:text> | </xsl:text>
       <a href="{$text}">local</a>
      </xsl:when>
      <xsl:otherwise>
       <xsl:value-of select="data(.)"/>
      </xsl:otherwise>
     </xsl:choose>
     
    </td>
   </xsl:for-each>
   <xsl:apply-templates select="lad:resource" mode="body" />
   <xsl:for-each select="lad:resource" use-when="false()">
    <td>
       <a href="{@url}">on-line</a>
       <xsl:if test="@local-file-exists = 'true'">
        <xsl:text> | </xsl:text>
        <xsl:call-template name="get-local-path">
         <xsl:with-param name="resource" select="." />
        </xsl:call-template> 
       </xsl:if>
    </td>
   </xsl:for-each>
  </tr>
 </xsl:template>
 
 <xsl:template match="lad:page" use-when="false()">
  <tr>
   <xsl:for-each select="@*">
    <xsl:variable name="text" select="data(.)"/>
    <td>
     <xsl:choose>
      <xsl:when test="starts-with(., 'http')">
       <a href="{$text}">on-line</a>
       <xsl:text> | </xsl:text>
       <a href="{$text}">local</a>
      </xsl:when>
      <xsl:otherwise>
       <xsl:value-of select="data(.)"/>
      </xsl:otherwise>
     </xsl:choose>
     
    </td>
   </xsl:for-each>
  </tr>
 </xsl:template>
 
 <xsl:template match="c:result">
  <ul>
   <xsl:apply-templates />
  </ul>
 </xsl:template>
 
 <xsl:template match="c:file">
  <li><a href="{@full-path}"><xsl:value-of select="@name"/></a></li>
 </xsl:template>
 
 <xsl:function name="lax:get-view-url">
  <xsl:param name="context" as="node()"/>
  <xsl:variable name="root" select="$context/ancestor::lad:document"/>
  <xsl:variable name="library-api" select="$context/ancestor::lad:document/las:library/las:api"/>
  <xsl:variable name="view-url" select="replace($library-api/@client-url-pattern, '\{document-id\}', $root/@id) => replace('\{page-id\}', $context/@id)"/>
  <xsl:value-of select="$view-url"/>
 </xsl:function>
 
 <xsl:template name="get-local-path">
  <xsl:param name="resource" as="element(lad:resource)?" />
  <xsl:variable name="local-path" select="if($use-relative-paths and starts-with($resource/@local-path, '/'))
    then replace($resource/@local-path, $docker-data-root, '../') 
    else $resource/@local-path"/>
  <xsl:if test="$resource/@local-file-exists = 'true'">
   <xsl:choose>
    <xsl:when test="$use-relative-paths">
     <a href="{$local-path}">local</a>
    </xsl:when>
    <xsl:otherwise>
     <a href="{@local-uri}">local</a>
    </xsl:otherwise>
   </xsl:choose>      
  </xsl:if>
 </xsl:template>
 
</xsl:stylesheet>
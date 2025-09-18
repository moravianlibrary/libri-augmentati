<p:library  xmlns:p="http://www.w3.org/ns/xproc" 
 xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:lad="https://www.mzk.cz/ns/libri-augmentati/documents/1.0"
 xmlns:las="https://www.mzk.cz/ns/libri-augmentati/settings/1.0"
 xmlns:laa="https://www.mzk.cz/ns/libri-augmentati/alto/1.0"
 xmlns:lar="https://www.mzk.cz/ns/libri-augmentati/report/1.0"
 xmlns:xhtml="http://www.w3.org/1999/xhtml"
 version="3.0">
 
 <p:documentation>
  <xhtml:meta name="version" content="1.0.0" />
  <xhtml:section xml:lang="en">
   <xhtml:h1>Library for ALTO format manipulation</xhtml:h1>
   <xhtml:p>Steps for standalone ALTO data operations.</xhtml:p>
  </xhtml:section>
  <xhtml:section xml:lang="cs">
   <xhtml:h1>Knihovna pro zpracování dat ve formátu ALTO</xhtml:h1>
   <xhtml:p>Kroky pro samostatné operace s daty ve formátu ALTO.</xhtml:p>
  </xhtml:section>
 </p:documentation>
 
 <!-- STEP -->
 <p:declare-step type="laa:combine-alto-pages" name="combining-alto-pages">
  <p:documentation>
   <xhtml:section xml:lang="en">
    <xhtml:h2>Merge multiple pages</xhtml:h2>
    <xhtml:p>Merges separate ALTO documents into one document, including metadata (styles) and textcontent (pages).</xhtml:p>
   </xhtml:section>
   <xhtml:section xml:lang="cs">
    <xhtml:h2>Spojení stran</xhtml:h2>
    <xhtml:p>Spojí samostatné dokumenty ve formátu ALTO do jednoho dokumentu, včetně metadat (stylu) a textového obsahu (stran).</xhtml:p>
   </xhtml:section>
  </p:documentation>
  
  <!-- INPUT PORTS -->
  <p:input port="source" primary="true" sequence="true">
   <p:documentation>
    <xhtml:section xml:lang="en"><xhtml:p>Sequence of virtual documents.</xhtml:p></xhtml:section>
    <xhtml:section xml:lang="cs"><xhtml:p>Sekvence virtuálních dokumentů.</xhtml:p></xhtml:section>
   </p:documentation>
  </p:input>
  
  
  <p:input port="report-in" sequence="true">
   <lar:report />
  </p:input>
  
  <!-- OUTPUT PORTS -->
  <p:output port="result" primary="true" sequence="true" serialization="map{'indent' : true()}" pipe="@final">
   <p:documentation>
    <xhtml:section xml:lang="en"><xhtml:p>Sequence of virtual documents.</xhtml:p></xhtml:section>
    <xhtml:section xml:lang="cs"><xhtml:p>Sekvence virtuálních dokumentů.</xhtml:p></xhtml:section>
   </p:documentation>
  </p:output>
  
  <p:output port="report" pipe="report-in@combining-alto-pages" />
  
  
  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>

  <p:option name="output-directory" required="true" as="xs:string" />

  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="p:urify($debug-path, $base-uri)" />
  <p:variable name="library-code" select="/lad:document/las:library/@code"/>
  
  <p:variable name="id" select="if(exists(/lad:document/@nickname))
   then /lad:document/@nickname 
   else if(starts-with(/lad:document/@id, 'uuid:')) 
   then substring-after(/lad:document/@id, 'uuid:') 
   else  /lad:document/@id" />
  
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
  <p:variable name="result-directory-uri" select="p:urify($result-directory-path, $base-uri)" />
  
  <!-- PIPELINE BODY -->
  
  <p:variable name="alto-pages" select="/lad:document/lad:pages[lad:page[lad:resource[@type='alto']]]" />
  
  <p:if test="$debug">
   <p:store href="{$debug-path-uri}/alto/combine/source.xml" />
  </p:if>
  
  <p:if test="exists($alto-pages)">
   <p:variable name="file-stem" select="'alto'" />
   <p:variable name="result-file-name" select="concat($file-stem, '.xml')" />
   <p:variable name="saved-file-uri" select="concat($result-directory-uri, '/', $result-file-name)"/>
   
   <p:variable name="file-exists" select="doc-available($saved-file-uri)" />
   
   <p:if test="not($file-exists)">
    <p:for-each>
     <p:with-input select="$alto-pages/lad:page[lad:resource[@type='alto']]"/>
     <laa:process-page />
    </p:for-each>
    
    <p:wrap-sequence wrapper="laa:pages" />
    
    <p:if test="$debug">
     <p:store href="{$debug-path-uri}/alto/{$library-code}/{$id}/separate-pages.xml" />
    </p:if>
    
    <p:xslt>
     <p:with-input port="stylesheet" href="../xslt/alto/alto-merge-alto-pages.xsl" />
    </p:xslt>
    
    <p:if test="$debug">
     <p:store href="{$debug-path-uri}/alto/{$library-code}/{$id}/merged-pages.xml" />
    </p:if>
    
    <p:xslt>
     <p:with-input port="stylesheet" href="../xslt/alto/alto-merge-prepare-styles.xsl" />
    </p:xslt>
    
    <p:if test="$debug">
     <p:store href="{$debug-path-uri}/alto/{$library-code}/{$id}/prepared-styles.xml" />
    </p:if>
    
    <p:xslt>
     <p:with-input port="stylesheet" href="../xslt/alto/alto-merge-clean-styles.xsl" />
    </p:xslt>
    
    <p:if test="$debug">
     <p:store href="{$debug-path-uri}/alto/{$library-code}/{$id}/cleaned-styles.xml" />
    </p:if>
    
    <p:if test="$result-directory-path">
     <p:store href="{$saved-file-uri}" message="Storing to {$saved-file-uri}" />
    </p:if>   
    
    <p:identity name="item-metadata">
     <p:with-input>
      <lad:resource local-file-exists="true" name="{$result-file-name}" 
       local-path="{$result-directory-path}/{$result-file-name}"
       local-uri="{$saved-file-uri}"
       type="alto"
      />
     </p:with-input>
    </p:identity>
    
    <p:namespace-delete prefixes="laa xs xhtml" />
    
    <p:insert match="/lad:document/lad:resource[last()]" position="after">
     <p:with-input port="source" pipe="source@combining-alto-pages" />
     <p:with-input port="insertion" pipe="@item-metadata" />
    </p:insert>
    
   </p:if>
   
   
   
   
   
   <p:namespace-delete prefixes="xs lar laa xhtml" />
   
  </p:if>

  
  <p:identity name="final" />
  <p:identity name="final-report">
   <p:with-input port="source" pipe="report-in@combining-alto-pages" />
  </p:identity>
 
 </p:declare-step>
 
 <p:declare-step type="laa:process-page" name="processing-page">
  <p:documentation>
   <xhtml:section xml:lang="en">
    <xhtml:h2>Proces single page</xhtml:h2>
    <xhtml:p>Aplies modifications on one ALTO document to prepare it for merging, especialy assigning unique indentifires.</xhtml:p>
   </xhtml:section>
   <xhtml:section xml:lang="cs">
    <xhtml:h2>Zpracování jedné strany</xhtml:h2>
    <xhtml:p>Aplikuje úpravy na jeden dokument ve formátu ALTO, aby ho bylo možné spojit s ostatními, zejména jde o přiřazení jedinečných identifikátorů.</xhtml:p>
   </xhtml:section>
  </p:documentation>
  
  <!-- INPUT PORTS -->
  <p:input port="source" primary="true">
   <p:documentation>
    <xhtml:section xml:lang="en"><xhtml:p>One page from virtual document.</xhtml:p></xhtml:section>
    <xhtml:section xml:lang="cs"><xhtml:p>Jenda strana z virtuálního dokumentu.</xhtml:p></xhtml:section>
   </p:documentation>
  </p:input>

 <!-- OUTPUT PORTS -->
 <p:output port="result" primary="true" />
 
  <!-- PIPELINE BODY -->
 <p:viewport match="lad:page">
  
  <p:variable name="page" select="/lad:page" />
  <p:variable name="page-uri" select="$page/lad:resource[@type='alto']/@local-uri" />

  
  <p:xslt>
   <p:with-input port="source" href="{$page-uri}" />
   <p:with-input port="stylesheet" href="../xslt/alto/alto-set-element-id.xsl" />
   <p:with-option name="parameters" select="map {'page-order' : $page/@order }" />
  </p:xslt>
 </p:viewport>
 
 </p:declare-step>
 
</p:library>
<p:library  xmlns:p="http://www.w3.org/ns/xproc" 
 xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:lac="https://www.mzk.cz/ns/libri-augmentati/conversion/1.0"
 xmlns:lad="https://www.mzk.cz/ns/libri-augmentati/documents/1.0"
 xmlns:c="http://www.w3.org/ns/xproc-step" 
 xmlns:xhtml="http://www.w3.org/1999/xhtml"
 version="3.0">
 
 <p:documentation>
  <xhtml:section>
   <xhtml:h1></xhtml:h1>
   <xhtml:p></xhtml:p>
  </xhtml:section>
 </p:documentation>
 
 <p:declare-step type="lac:convert-conllu-to-tei" name="converting-conllu-to-tei">
  <p:documentation>
   <xhtml:section>
    <xhtml:h2></xhtml:h2>
    <xhtml:p></xhtml:p>
   </xhtml:section>
  </p:documentation>
  
  <!-- INPUT PORTS -->
  <p:input  port="source" primary="true" />
  
  <!-- OUTPUT PORTS -->
  <p:output port="result" primary="true" />
  
  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
 
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  
  
  <!-- PIPELINE BODY -->
  <p:variable name="udpipe-text" select="." />
  
  <p:xslt parameters="map{'input': $udpipe-text}">
   <p:with-input port="stylesheet" href="../xslt/conversion/conllu-to-xml.xsl" />
  </p:xslt>
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/conversion/conllu-xml-to-hierarchy.xsl"/>
  </p:xslt>
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/conversion/conllu-xml-hierarchy-to-tei.xsl"/>
  </p:xslt>
  
  
 </p:declare-step>
 
 <p:declare-step type="lac:convert-nametag-xml-to-tei" name="converting-nametag-xml-to-tei">
  <p:documentation>
   <xhtml:section>
    <xhtml:h2></xhtml:h2>
    <xhtml:p></xhtml:p>
   </xhtml:section>
  </p:documentation>
  
  <!-- INPUT PORTS -->
  <p:input  port="source" primary="true" />
  
  <!-- OUTPUT PORTS -->
  <p:output port="result" primary="true" />
  
  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  
  
  <!-- PIPELINE BODY -->
  <p:variable name="udpipe-text" select="." />
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/namegtag/nametag-xml-to-tei.xsl" />
  </p:xslt>
  
 </p:declare-step>
 
 <p:declare-step type="lac:convert-djvu" visibility="public">
  
  <p:documentation>
   <xhtml:section xml:lang="en">
    <xhtml:h2>Convert DjVu</xhtml:h2>
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
  
  <p:option name="main-input-directory" as="xs:anyURI" required="true"/>
  <p:option name="main-output-directory" as="xs:anyURI" required="true"/>
  <p:option name="output-file" as="xs:string" required="true"/>
  <p:option name="format" values="('pdf', 'tiff')" select="'pdf'" />
  <p:option name="pdfbox-path" as="xs:string" required="true"/>
  <p:option name="ddjvu-path" as="xs:string" required="true"/>
  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  
  
  <!-- PIPELINE BODY -->
  <p:viewport match="lad:document">
   
   <p:variable name="document-id" select="if(exists(/lad:document/@nickname))
    then /lad:document/@nickname 
    else if(starts-with(/lad:document/@id, 'uuid:')) 
    then substring-after(/lad:document/@id, 'uuid:') 
    else  /lad:document/@id " />
   
   <lac:convert-djvu-item output-file="{$main-output-directory}/{$document-id}/batch/{$output-file}" 
    input-directory="{$main-output-directory}/{$document-id}/image" 
    output-directory="{$main-output-directory}/{$document-id}/pdf" 
    pdfbox-path="{$pdfbox-path}"
    ddjvu-path="{$ddjvu-path}"
    debug-path="{$debug-path}" base-uri="{$base-uri}"
   />
   
  </p:viewport>
  
 </p:declare-step>
 
 <p:declare-step type="lac:convert-djvu-item" visibility="private">
  
  <p:documentation>
   <xhtml:section xml:lang="en">
    <xhtml:h2>Convert DjVu item</xhtml:h2>
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
  <p:output port="result" primary="true" sequence="true" />
  
  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
  
  <p:option name="input-directory" as="xs:anyURI" required="true"/>
  <p:option name="output-directory" as="xs:anyURI" required="true"/>
  <p:option name="output-file" as="xs:anyURI" required="true"/>
  <p:option name="format" values="('pdf', 'tiff')" select="'pdf'" />
  <p:option name="pdfbox-path" as="xs:string" required="true"/>
  <p:option name="ddjvu-path" as="xs:string" required="true"/>
  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  
  
  <!-- PIPELINE BODY -->
  <p:directory-list path="{$input-directory}" />
  
  <p:for-each>
   <p:with-input select="//c:file"/>
   <p:variable name="filename" select="/*/@name"/>
   <p:variable name="new-filename" select="concat(substring-before($filename, '.'), '.', $format)"/>
   <p:identity>
    <p:with-input port="source">
     <p:inline content-type="text/plain">{$ddjvu-path} -format={$format} -mode=color {resolve-uri(concat($input-directory, '/', $filename),static-base-uri())} {resolve-uri(concat($output-directory, '/', $new-filename), static-base-uri())}</p:inline>
    </p:with-input>
   </p:identity>
   <lac:fix-path name="pdf-merge" debug-path="{$debug-path}" base-uri="{$base-uri}"/>
  </p:for-each>
  
  
  <p:text-join separator="&#xa;" name="djvu-conversion" />
  
  <p:identity>
   <p:with-input port="source">
    <p:inline content-type="text/plain">java -jar {$pdfbox-path} PDFMerger {resolve-uri(concat($output-directory, '/*.pdf'),static-base-uri())} {resolve-uri(concat($output-directory, '/../Full.pdf'),static-base-uri())}</p:inline>
   </p:with-input>
  </p:identity>
  <lac:fix-path name="pdf-merge" debug-path="{$debug-path}" base-uri="{$base-uri}"/>
  
  
  <p:text-join separator="&#xa;">
   <p:with-input port="source" pipe="@djvu-conversion @pdf-merge" />
  </p:text-join>
  
  <p:store href="{$output-file}" message="Storing to {$output-file}" />
  
  <p:file-mkdir href="{$output-directory}" />
  
 </p:declare-step>
 
 
 <p:declare-step type="lac:fix-path" name="fixing-path">
  
  <p:documentation>
   <xhtml:section xml:lang="en">
    <xhtml:h2>Fix path</xhtml:h2>
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
  
  <!-- OPTIONS -->
  <p:option name="debug-path" select="()" as="xs:string?" />
  <p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  
  
  <!-- PIPELINE BODY -->
  <p:file-info href="file:///C:/Windows" fail-on-error="false" />
  <p:if test="exists(/c:directory[@name='Windows'])">
   <p:text-replace pattern="file:///" replacement="">
    <p:with-input port="source" pipe="source@fixing-path" />
   </p:text-replace>
   <p:text-replace pattern="/" replacement="\\" />
  </p:if>
  
 </p:declare-step>
 
 
</p:library>
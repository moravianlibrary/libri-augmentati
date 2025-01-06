<p:library  xmlns:p="http://www.w3.org/ns/xproc" 
 xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:lad="https://www.mzk.cz/ns/libri-augmentati/documents/1.0"
 xmlns:lat="https://www.mzk.cz/ns/libri-augmentati/tei/1.0"
 xmlns:tei = "http://www.tei-c.org/ns/1.0" 
 xmlns:xhtml="http://www.w3.org/1999/xhtml"
 version="3.0">
 
 <p:documentation>
  <xhtml:section>
   <xhtml:h1></xhtml:h1>
   <xhtml:p></xhtml:p>
  </xhtml:section>
 </p:documentation>
 
 <!-- STEP -->
 <p:declare-step type="lat:convert-alto-to-tei" name="converting-alto-to-tei">
  <p:documentation>
   <xhtml:section>
    <xhtml:h2></xhtml:h2>
    <xhtml:p></xhtml:p>
   </xhtml:section>
   <xhtml:section>
    <xhtml:h2></xhtml:h2>
    <xhtml:p></xhtml:p>
   </xhtml:section>
  </p:documentation>
  
  <!-- INPUT PORTS -->
  <p:input port="source" primary="true">
   <p:documentation>
    <xhtml:section xml:lang="en">
     <xhtml:p>One page of the document in ALTO format</xhtml:p>
    </xhtml:section>
    <xhtml:section xml:lang="cs">
     <xhtml:p>Jedna strana dokumentu ve formátu ALTO</xhtml:p>
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
     <xhtml:p>One page of the document in TEI format</xhtml:p>
    </xhtml:section>
    <xhtml:section xml:lang="cs">
     <xhtml:p>Jedna strana dokumentu ve formátu TEI</xhtml:p>
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
  <p:option name="page-number" as="xs:string?" />
<!--  <p:option name="output-directory" required="true" as="xs:string" />-->
  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  
  <p:xslt message="  - transforming from ALTO to TEI">
   <p:with-input port="stylesheet" href="../xslt/conversion/alto2tei.xsl" />
   <p:with-option name="parameters" select="map {'page-number' : $page-number }" />
  </p:xslt>
  
  <p:identity name="final" />
  
  <p:identity name="final-report">
   <p:with-input port="source" pipe="report-in@converting-alto-to-tei" />
  </p:identity>
  
 </p:declare-step>
 
 <!-- STEP -->
 <p:declare-step type="lat:convert-nametag-to-tei" name="converting-nametag-to-tei">
  <p:documentation>
   <xhtml:section>
    <xhtml:h2></xhtml:h2>
    <xhtml:p></xhtml:p>
   </xhtml:section>
   <xhtml:section>
    <xhtml:h2></xhtml:h2>
    <xhtml:p></xhtml:p>
   </xhtml:section>
  </p:documentation>
  
  <!-- INPUT PORTS -->
  <p:input port="source" primary="true">
   <p:documentation>
    <xhtml:section xml:lang="en">
     <xhtml:p>One page of the document with recognized entities in XML format</xhtml:p>
    </xhtml:section>
    <xhtml:section xml:lang="cs">
     <xhtml:p>Jedna strana dokumentu s rozpoznanými entitami ve formátu XML</xhtml:p>
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
     <xhtml:p>One page of the document with recognized entities in TEI format</xhtml:p>
    </xhtml:section>
    <xhtml:section xml:lang="cs">
     <xhtml:p>Jedna strana dokumentu s rozpoznanými entitami ve formátu TEI</xhtml:p>
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
  <p:option name="page-number" as="xs:string?" />
<!--  <p:option name="output-directory" required="true" as="xs:string" />-->
  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  
  <p:xslt message="  - transforming from NameTag to TEI">
   <p:with-input port="stylesheet" href="../xslt/nametag/nametag-xml-to-tei.xsl" />
   <p:with-option name="parameters" select="map {'page-number' : $page-number }" />
  </p:xslt>
  
  <p:identity name="final" />
  
  <p:identity name="final-report">
   <p:with-input port="source" pipe="report-in@converting-nametag-to-tei" />
  </p:identity>
  
  
 </p:declare-step>
 
 <!-- STEP -->
 <p:declare-step type="lat:convert-udpipe-to-tei" name="converting-udpipe-to-tei">
  <p:documentation>
   <xhtml:section>
    <xhtml:h2></xhtml:h2>
    <xhtml:p></xhtml:p>
   </xhtml:section>
   <xhtml:section>
    <xhtml:h2></xhtml:h2>
    <xhtml:p></xhtml:p>
   </xhtml:section>
  </p:documentation>
  
  <!-- INPUT PORTS -->
  <p:input port="source" primary="true">
   <p:documentation>
    <xhtml:section xml:lang="en">
     <xhtml:p>One page of the document with moprhosyntactic analysis and lemmatization in XML format</xhtml:p>
    </xhtml:section>
    <xhtml:section xml:lang="cs">
     <xhtml:p>Jedna strana dokumentu s morfosyntaktickou analýzou a lemmatizací ve formátu XML</xhtml:p>
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
     <xhtml:p>One page of the document with moprhosyntactic analysis and lemmatization in TEI format</xhtml:p>
    </xhtml:section>
    <xhtml:section xml:lang="cs">
     <xhtml:p>Jedna strana dokumentu s morfosyntaktickou analýzou a lemmatizací ve formátu TEI</xhtml:p>
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
  <p:option name="page-number" as="xs:string?" />
<!--  <p:option name="output-directory" required="true" as="xs:string" />-->
  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
  
  
  <!-- PIPELINE -->
  <p:variable name="udpipe-text" select="." />
  <p:if test="$debug">
   <p:store href="{$debug-path-uri}/tei/udpipe-to-tei/input.txt" />
  </p:if>

  <p:xslt parameters="map{'input': $udpipe-text}" message="  - transforming from UDPipe to TEI">
   <p:with-input port="stylesheet" href="../xslt/conversion/conllu-to-xml.xsl" />
  </p:xslt>
  <p:if test="$debug">
   <p:store href="{$debug-path-uri}/tei/udpipe-to-tei/conllu-to-xml.xml" />
  </p:if>
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/conversion/conllu-xml-to-hierarchy.xsl"/>
  </p:xslt>
  <p:if test="$debug">
   <p:store href="{$debug-path-uri}/tei/udpipe-to-tei/conllu-xml-to-hierarchy.xml" />
  </p:if>
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../xslt/conversion/conllu-xml-hierarchy-to-tei.xsl"/>
   <p:with-option name="parameters" select="map {'page-number' : $page-number }" />
  </p:xslt>
  <p:if test="$debug">
   <p:store href="{$debug-path-uri}/tei/udpipe-to-tei/conllu-xml-hierarchy-to-tei.xml" />
  </p:if>
  
  <p:identity name="final" />
  
  <p:identity name="final-report">
   <p:with-input port="source" pipe="report-in@converting-udpipe-to-tei" />
  </p:identity>
  
  
 </p:declare-step>
 
 <!-- STEP -->
 <p:declare-step type="lat:merge-tei-representations" name="merging-tei-representations">
  <p:documentation>
   <xhtml:section>
    <xhtml:h2></xhtml:h2>
    <xhtml:p></xhtml:p>
   </xhtml:section>
   <xhtml:section>
    <xhtml:h2></xhtml:h2>
    <xhtml:p></xhtml:p>
   </xhtml:section>
  </p:documentation>
  
  <!-- INPUT PORTS -->
  <p:input port="source" primary="true">
   <p:documentation>
    <xhtml:section xml:lang="en">
     <xhtml:p>One page of the document with recognized entities in TEI format</xhtml:p>
    </xhtml:section>
    <xhtml:section xml:lang="cs">
     <xhtml:p>Jedna strana dokumentu s rozpoznanými entitami ve formátu TEI</xhtml:p>
    </xhtml:section>
   </p:documentation>
  </p:input>
  
  <p:input port="udpipe" primary="false">
   <p:documentation>
    <xhtml:section xml:lang="en">
     <xhtml:p>One page of the document with moprhosyntactic analysis and lemmatization in TEI format</xhtml:p>
    </xhtml:section>
    <xhtml:section xml:lang="cs">
     <xhtml:p>Jedna strana dokumentu s morfosyntaktickou analýzou a lemmatizací ve formátu TEI</xhtml:p>
    </xhtml:section>
   </p:documentation>
  </p:input>
  
  <p:input port="alto" primary="false">
   <p:documentation>
    <xhtml:section xml:lang="en">
     <xhtml:p>One page of the document in TEI format</xhtml:p>
    </xhtml:section>
    <xhtml:section xml:lang="cs">
     <xhtml:p>Jedna strana dokumentu ve formátu TEI</xhtml:p>
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
<!--  <p:option name="output-directory" required="true" as="xs:string" />-->
  
  <!-- VARIABLES -->
  <p:variable name="debug" select="$debug-path || '' ne ''" />
  <p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
 <!-- <p:variable name="result-directory-path" select="concat($output-directory, '/tei')">
   <p:documentation>
    <xhtml:section xml:lang="en">
     <xhtml:p>The folder where generated documents are saved. The path to the folder can be absolute or relative.</xhtml:p>
    </xhtml:section>
    <xhtml:section xml:lang="cs">
     <xhtml:p>Složka, do níž se uloží vygenerované dokumenty. Cesta ke složce může být absolutní i relativní.</xhtml:p>
    </xhtml:section>
   </p:documentation>
  </p:variable>
  <p:variable name="result-directory-uri" select="resolve-uri($result-directory-path, $base-uri)" />-->
  
  <p:variable name="udpipe-root" select="/*" pipe="udpipe@merging-tei-representations" />
  
  <p:xslt parameters="map{'udpipe': $udpipe-root}" message="  - merging TEI from NameTag and UDPipe">
   <p:with-input port="stylesheet" href="../xslt/tei/merge-nametag-with-udpipe.xsl" />
  </p:xslt>
  <p:if test="$debug">
   <p:store href="{$debug-path-uri}/tei/merge/merge-nametag-with-udpipe.xml" />
  </p:if>
  
  <p:identity name="final" />
  
  <p:identity name="final-report">
   <p:with-input port="source" pipe="report-in@merging-tei-representations" />
  </p:identity>
  
 </p:declare-step>
 
 <!-- STEP -->
 <p:declare-step type="lat:convert-to-tei" name="converting-to-tei">
  <p:documentation>
   <xhtml:section>
    <xhtml:h2></xhtml:h2>
    <xhtml:p></xhtml:p>
   </xhtml:section>
   <xhtml:section>
    <xhtml:h2></xhtml:h2>
    <xhtml:p></xhtml:p>
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
  <p:variable name="result-directory-path" select="concat($output-directory, '/tei')">
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
  <p:viewport match="lad:pages/lad:page" use-when="true()">
   <p:variable name="page"    select="/lad:page" />
   <p:variable name="nametag" select="$page/lad:resource[@type='nametag'][@local-file-exists='true']" />
   <p:variable name="udpipe"  select="$page/lad:resource[@type='udpipe'][@local-file-exists='true']" />
   <p:variable name="alto"    select="$page/lad:resource[@type='alto'][@local-file-exists='true']" />
   <p:if test="exists($nametag) and exists($udpipe) and exists($alto)">
    
    <p:variable name="file-stem" select="format-integer($page/@order, '0000')" />
    <p:variable name="result-file-name" select="concat($file-stem, '.xml')" />
    <p:variable name="saved-file-uri" select="concat($result-directory-uri, '/', $result-file-name)"/>
    
    
    <p:if test="not(doc-available($saved-file-uri))">
     
     <lat:convert-nametag-to-tei name="nametag-tei" 
      debug-path="{$debug-path}" 
      base-uri="{$base-uri}"
      page-number="{$page/@title}"
      >
      <p:with-input port="source" href="{$nametag/@local-uri}" />
      <p:with-input port="report-in" pipe="report-in@converting-to-tei" />
     </lat:convert-nametag-to-tei>
     <p:if test="$debug">
      <p:store href="{$debug-path-uri}/tei/nametag/{$result-file-name}" />
     </p:if>
     
     <lat:convert-udpipe-to-tei name="udpipe-tei"
      debug-path="{$debug-path}" 
      base-uri="{$base-uri}"
      page-number="{$page/@title}"
      >
      <p:with-input port="source" href="{$udpipe/@local-uri}" />
      <p:with-input port="report-in" pipe="report@nametag-tei" />
     </lat:convert-udpipe-to-tei>
     <p:if test="$debug">
      <p:store href="{$debug-path-uri}/tei/udpipe/{$result-file-name}" />
     </p:if>
     
     <lat:convert-alto-to-tei name="alto-tei"
      debug-path="{$debug-path}" 
      base-uri="{$base-uri}"
      page-number="{$page/@title}"
      >
      <p:with-input port="source" href="{$alto/@local-uri}" />
      <p:with-input port="report-in" pipe="report@udpipe-tei" />
     </lat:convert-alto-to-tei>
     <p:if test="$debug">
      <p:store href="{$debug-path-uri}/tei/alto/{$result-file-name}" />
     </p:if>
     
     <lat:merge-tei-representations
      debug-path="{$debug-path}" 
      base-uri="{$base-uri}"
      name="merge-tei">
      <p:with-input port="source" pipe="result@nametag-tei" />
      <p:with-input port="udpipe" pipe="result@udpipe-tei" />
      <p:with-input port="alto" pipe="result@alto-tei" />
      <p:with-input port="report-in" pipe="report@alto-tei" />
     </lat:merge-tei-representations>
     
     <p:if test="$debug">
      <p:store href="{$debug-path-uri}/tei/merged/{$result-file-name}" />
     </p:if>
     
     <p:identity>
      <p:with-input pipe="@merge-tei" />
     </p:identity>
     <p:if test="$result-directory-path">
      <p:store href="{$saved-file-uri}" message="Storing to {$saved-file-uri}" />
     </p:if>     
    </p:if>
    
    <p:identity name="item-metadata">
     <p:with-input>
      <lad:resource local-file-exists="true" name="{$result-file-name}" 
       local-path="{$result-directory-path}/{$result-file-name}"
       local-uri="{$saved-file-uri}"
       order="{$page/@order}" 
       type="tei"
      />
     </p:with-input>
    </p:identity>
    <p:namespace-delete prefixes="lat xs xhtml" />
    
    <p:identity>
     <p:with-input pipe="@item-metadata" select="($page/lad:resource, .)" />
    </p:identity>
    <p:wrap-sequence wrapper="lad:page" />
    <p:set-attributes match="lad:page" 
     attributes="map{
     'order' : $page/@order/data(),
     'id' : $page/@id/data(),
     'title' : $page/@title/data(),
     'type' : $page/@type/data()
     }" />
   </p:if>
  </p:viewport>
  
  <p:identity name="mid-final" />
  
  <p:identity name="mid-report">
   <p:with-input port="source" pipe="report-in@converting-to-tei" />
  </p:identity>
  
  <lat:combine-tei-pages 
   output-directory="{$output-directory}" 
   debug-path="{$debug-path}" 
   base-uri="{$base-uri}"
   name="combining-tei-pages">
   <p:with-input port="source" pipe="@mid-final" />
   <p:with-input port="report-in" pipe="@mid-report" />
  </lat:combine-tei-pages>
  
  <p:identity name="final" />
  <p:identity name="final-report">
   <p:with-input port="source" pipe="report@combining-tei-pages" />
  </p:identity>
 
 </p:declare-step>
 
 <!-- STEP -->
 <p:declare-step type="lat:combine-tei-pages" name="combining-tei-pages">
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
  <p:variable name="foxml" select="/lad:document/lad:resource[@type='foxml'][@local-file-exists='true']" />
  <p:variable name="teis"  select="/lad:document/lad:pages/lad:page/lad:resource[@type='tei'][@local-file-exists='true']" />
  
  <p:if test="$debug">
   <p:store href="{$debug-path-uri}/tei/combine/source.xml" />
  </p:if>
  
  <p:if test="exists($foxml) and exists($teis)">
    
    <p:variable name="file-stem" select="'tei'" />
    <p:variable name="result-file-name" select="concat($file-stem, '.xml')" />
    <p:variable name="saved-file-uri" select="concat($result-directory-uri, '/', $result-file-name)"/>
    
    
    <p:if test="not(doc-available($saved-file-uri))">
     
     <p:identity name="first-tei-page">
      <p:with-input port="source">
       <p:document href="{$teis[1]/@local-uri}" />
      </p:with-input>
     </p:identity>
     <p:variable name="first-page" select="/*" />
     
     <p:xslt message="$first-page: {local-name($first-page)}; {$teis[1]/@local-uri}">
      <p:with-input port="source" href="{$foxml/@local-uri}" />
      <p:with-input port="stylesheet" href="../xslt/conversion/foxml-to-tei.xsl" />
      <p:with-option name="parameters" select="map {'tei-page' : $first-page }" />
     </p:xslt>
     <p:identity name="tei-skeleton" />
     
     <p:if test="$debug">
      <p:store href="{$debug-path-uri}/tei/combine/foxml-to-tei.xml" />
     </p:if>

     <p:viewport match="tei:body">
      <p:for-each>
       <p:with-input select="$teis"/>
       <p:variable name="tei" select="/lad:resource" />
       <p:identity>
        <p:with-input port="source" href="{$tei/@local-uri}" select="/tei:TEI/tei:text/tei:body/*" />
       </p:identity>
      </p:for-each>
      <p:wrap-sequence wrapper="tei:body" />
     </p:viewport>
     
     <p:if test="$result-directory-path">
      <p:store href="{$saved-file-uri}" message="Storing to {$saved-file-uri}" />
     </p:if>     
    </p:if>
    
    <p:identity name="item-metadata">
     <p:with-input>
      <lad:resource local-file-exists="true" name="{$result-file-name}" 
       local-path="{$result-directory-path}/{$result-file-name}"
       local-uri="{$saved-file-uri}"
       type="tei"
      />
     </p:with-input>
    </p:identity>
    <p:namespace-delete prefixes="lat xs xhtml" />
    
    <p:insert match="/lad:document/lad:resource[last()]" position="after">
     <p:with-input port="source" pipe="source@combining-tei-pages" />
     <p:with-input port="insertion" pipe="@item-metadata" />
    </p:insert>
    
   </p:if>
  
  
  
  <p:identity name="final" />
  <p:identity name="final-report">
   <p:with-input port="source" pipe="report-in@combining-tei-pages" />
  </p:identity>
  
 </p:declare-step>
 
</p:library>
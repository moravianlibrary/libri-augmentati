<p:declare-step 
	xmlns:p="http://www.w3.org/ns/xproc" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:laa="https://www.mzk.cz/ns/libri-augmentati/alto/1.0"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	version="3.0">
	
	<p:import href="../../xproc/alto.xpl" />
	
	<p:documentation>
		<xhtml:section>
			<xhtml:h2></xhtml:h2>
			<xhtml:p></xhtml:p>
		</xhtml:section>
	</p:documentation>
   
	<!-- INPUT PORTS -->
  <p:input port="source" primary="true">
  	<p:document href="../../_temp/client/virtual-document-02-downloaded.xml" />
<!--  	<p:document href="../../_temp/sample-book/virtual-document-02-downloaded.xml" />-->
<!--  	<p:document href="../../_temp/test-samples/mzk-jadro-otazky-report.xml" />  	-->
  </p:input>
   
	<!-- OUTPUT PORTS -->
	<p:output port="result" primary="true" />
	
	<!-- OPTIONS -->
<!--	<p:option name="debug-path" select="()" as="xs:string?" />-->
	<p:option name="debug-path" select="'../_debug'" as="xs:string?" />
	<p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
	<p:option name="output-directory" as="xs:anyURI" select="'../_temp/alto'"/>
	
	<!-- VARIABLES -->
	<p:variable name="debug" select="$debug-path || '' ne ''" />
	<p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
	
	<!-- PIPELINE BODY -->
	<laa:combine-alto-pages
		output-directory="{$output-directory}"
		debug-path="{$debug-path}">
		<p:with-input port="settings" href="../../settings/libraries.xml" use-when="false()" />
	</laa:combine-alto-pages>
	

</p:declare-step>

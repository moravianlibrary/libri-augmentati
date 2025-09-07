<p:declare-step 
	xmlns:p="http://www.w3.org/ns/xproc" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns:lax="https://www.mzk.cz/ns/libri-augmentati/xproc/1.0"
	version="3.0">
	
	<p:documentation>
		<xhtml:section>
			<xhtml:h2></xhtml:h2>
			<xhtml:p></xhtml:p>
		</xhtml:section>
	</p:documentation>
	
	<p:import href="../../xproc/libri-augmentati.xpl" />
   
	<!--
   >>>>>>>>>>>>>>>>>
   >> INPUT PORTS >>
   >>>>>>>>>>>>>>>>>
  -->
  <p:input port="source" primary="true">
  	<p:document href="../../_temp/zapisky/report.xml" />
  </p:input>
   
	<!--
   <<<<<<<<<<<<<<<<<<
   << OUTPUT PORTS <<
   <<<<<<<<<<<<<<<<<<
  -->
	<p:output port="result" primary="true" />
	
	<!--
   +++++++++++++
   ++ OPTIONS ++
   +++++++++++++
  -->
	<p:option name="debug-path" as="xs:string?" select="()" />
	<p:option name="base-uri" as="xs:anyURI" select="static-base-uri()" />
	
	<!--
   ÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷
   ÷÷ VARIABLES ÷÷
   ÷÷÷÷÷÷÷÷÷÷÷÷÷÷÷
  -->
	<p:variable name="debug" select="$debug-path || '' ne ''" />
	<p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
	
	<!--
   *******************
   ** PIPELINE BODY **
   *******************
  -->
	<lax:create-report />
	
	<p:store href="../../_temp/zapisky/report.html" serialization="map{'indent' : true()}" message="Storing result to ../../_temp/zapisky/report.html" />
	

</p:declare-step>

<p:declare-step 
	xmlns:p="http://www.w3.org/ns/xproc" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	version="3.0">

	<p:documentation>
		<xhtml:section>
			<xhtml:h2></xhtml:h2>
			<xhtml:p></xhtml:p>
		</xhtml:section>
	</p:documentation>
   
	<!--
   >>>>>>>>>>>>>>>>>
   >> INPUT PORTS >>
   >>>>>>>>>>>>>>>>>
  -->
  <p:input port="source" primary="true">
  	<p:document href="../data/nametag-input.txt" />
  </p:input>
   
	<!--
   <<<<<<<<<<<<<<<<<<
   << OUTPUT PORTS <<
   <<<<<<<<<<<<<<<<<<
  -->
	<p:output port="result" primary="true" serialization="map { 'indent' : true()}"  pipe="result@request" />
	
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
	
	<p:variable name="full-text" select="." />
	
	<p:variable name="step-params" select="'input=conllu&amp;output=xml'" />
	
	<!--
   *******************
   ** PIPELINE BODY **
   *******************
  -->
	<p:http-request
		assert=".?status-code lt 500"
		href="https://lindat.mff.cuni.cz/services/nametag/api/recognize" 
		method="POST" 
		name="request">
		<p:with-input>
			<p:inline content-type="application/x-www-form-urlencoded">{$step-params}&amp;data={$full-text}</p:inline>
		</p:with-input>
	</p:http-request>
	

</p:declare-step>

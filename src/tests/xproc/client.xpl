<p:declare-step 
	xmlns:p="http://www.w3.org/ns/xproc" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:lad="https://www.mzk.cz/ns/libri-augmentati/documents/1.0"
	xmlns:las="https://www.mzk.cz/ns/libri-augmentati/settings/1.0"
	xmlns:lax="https://www.mzk.cz/ns/libri-augmentati/xproc/1.0"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	version="3.0">

	<p:import href="../../xproc/libri-augmentati.xpl" />
	
	<p:documentation>
		<xhtml:section>
			<xhtml:h2></xhtml:h2>
			<xhtml:p></xhtml:p>
		</xhtml:section>
	</p:documentation>
   
	<!-- INPUT PORTS -->
<!--  <p:input port="source" primary="true">
  	<p:document href="" />
  </p:input>
	-->
   
	<!-- OUTPUT PORTS -->
	<p:output port="result" primary="true" serialization="map{'indent' : true()}" />
	
	<!-- OPTIONS -->
	<!-- TODO: 
		to disable debug messages and files 
		uncomment following option and comment next one 
	-->
	<!--	<p:option name="debug-path" select="()" as="xs:string?" />-->
	<p:option name="debug-path" as="xs:string" select="'../../_debug/client'" />
	<p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
	
	<p:option name="output-directory" as="xs:string" select="'../../_temp/client'" />
	
	<p:option name="library-code" as="xs:string" required="true"/>
	<p:option name="api-version" as="xs:string" required="true"/>
	<p:option name="document-resources" as="xs:string" required="true"/>
	<p:option name="page-resources" as="xs:string" required="true"/>
	<p:option name="document-id" as="xs:string" required="true"/>
	<p:option name="nickname" as="xs:string" required="true"/>
	
	
	<!-- VARIABLES -->
	<p:variable name="debug" select="$debug-path || '' ne ''" />
	<p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
	
	<!-- PIPELINE BODY -->
	
	<p:identity message="Processing document with following parameters: 	
		library-code: {$library-code}; 
		api-version: {$api-version}; 
		document-resources: {$document-resources}; 
		page-resources: {$page-resources}; 
		document-id: {$document-id}; 
		nickname: {$nickname}">
		<p:with-input port="source"><lad:document /></p:with-input>
	</p:identity>
	
		<lax:build-virtual-document p:use-when="true()"
			name="virtual-document"
			library-code="{$library-code}" 
			api-version="{$api-version}" 
			document-resources="{$document-resources}"
			page-resources="{$page-resources}"
			debug-path="{$debug-path}"
			base-uri="{$base-uri}">
			<p:with-input port="source">
				<p:inline>
					<lad:documents>
						<lad:document id="{$document-id}" nickname="{$nickname}" /> 
					</lad:documents>
				</p:inline>
			</p:with-input>
			<p:with-input port="settings" href="../../settings/libraries.xml" />
		</lax:build-virtual-document>
	
	<p:identity  />
	
	<p:if test="$debug">
		<p:store href="{$debug-path-uri}/virtual-document-01.xml" />
	</p:if>
	
	<p:store href="{$output-directory}/virtual-document-01-builded.xml" serialization="map{'indent' : true()}"  use-when="true()" />

	<lax:download-document-data p:use-when="true()"
		output-directory="{$output-directory}" 
		debug-path="{$debug-path}" 
		base-uri="{$base-uri}"
		pause-before-request="0"
		name="download-data">
		<p:with-input port="report-in" pipe="report@virtual-document" />
	</lax:download-document-data>
	
	<p:store href="{$output-directory}/virtual-document-02-downloaded.xml" serialization="map{'indent' : true()}"  use-when="true()" />
	
	<lax:enrich-document-data p:use-when="false()"
		output-directory="{$output-directory}" 
		debug-path="{$debug-path}" 
		base-uri="{$base-uri}"
		pause-before-request="0">
		<p:with-option name="output-format" select="('TEXT', 'TEI')" />
		<p:with-option name="enrichment" select="('ENTITIES', 'MORPHOLOGY')" />
		<p:with-input port="report-in" pipe="report@download-data" />
		<p:with-input port="settings" href="../../settings/services.xml" />
	</lax:enrich-document-data>
	
	<p:store href="{$output-directory}/report.xml" serialization="map{'indent' : true()}"  use-when="true()" />
	
	<lax:create-report output-directory="{output-directory}"/>
	<p:store href="{$output-directory}/report.html" />
	<p:identity>
		<p:with-input port="source" pipe="result-uri" />
	</p:identity>
	
</p:declare-step>

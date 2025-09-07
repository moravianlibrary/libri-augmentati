<p:declare-step 
	xmlns:p="http://www.w3.org/ns/xproc" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:lad="https://www.mzk.cz/ns/libri-augmentati/documents/1.0"
	xmlns:las="https://www.mzk.cz/ns/libri-augmentati/settings/1.0"
	xmlns:lax="https://www.mzk.cz/ns/libri-augmentati/xproc/1.0"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	version="3.0" name="client">

	<p:import href="../../xproc/libri-augmentati.xpl" />
	
	<p:documentation>
		<xhtml:section>
			<xhtml:h2></xhtml:h2>
			<xhtml:p></xhtml:p>
		</xhtml:section>
	</p:documentation>
   
	<!-- INPUT PORTS -->
  <p:input port="source" primary="true">
  	<p:inline><lad:document /></p:inline>
  </p:input>
	
   
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
	<p:option name="document-id" as="xs:string?" required="false"/>
	<p:option name="nickname" as="xs:string?" required="false"/>
	
	
	<!-- VARIABLES -->
	<p:variable name="debug" select="$debug-path || '' ne ''" />
	<p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
	
	<p:variable name="input-documents" select="//lad:document[@id]" pipe="source@client" />
	
	<!-- PIPELINE BODY -->
	
	<p:if test="empty($input-documents)">
		<p:identity>
			<p:with-input port="source">
				<lad:documents>
					<lad:document id="{$document-id}" nickname="{$nickname}" /> 
				</lad:documents>
			</p:with-input>
		</p:identity>
	</p:if>
	
	<p:identity message="Processing document with following parameters: 	
		library-code: {$library-code}; 
		api-version: {$api-version}; 
		document-resources: {$document-resources}; 
		page-resources: {$page-resources};
		input documents: {count(//lad:document[@id])}
		document-id: {$document-id}; 
		nickname: {$nickname}">
	</p:identity>
	
		<lax:build-virtual-document p:use-when="true()"
			name="virtual-document"
			library-code="{$library-code}" 
			api-version="{$api-version}" 
			document-resources="{$document-resources}"
			page-resources="{$page-resources}"
			debug-path="{$debug-path}"
			base-uri="{$base-uri}">
			<p:with-input port="settings" href="../../settings/libraries.xml" />
		</lax:build-virtual-document>
	
	<p:identity  />
	
	<p:if test="$debug">
		<p:for-each>
			<p:with-input select="//lad:document"/>
			<p:variable name="nickname" select="/lad:document/@nickname" />
			<p:store href="{$debug-path-uri}/{$nickname}/virtual-document-01.xml" />
		</p:for-each>
	</p:if>

	<p:for-each>
		<p:with-input select="//lad:document"/>
		<p:variable name="nickname" select="/lad:document/@nickname" />
		<p:store href="{$output-directory}/{$nickname}/virtual-document-01-builded.xml" serialization="map{'indent' : true()}"  use-when="true()" />
	</p:for-each>

	<lax:download-document-data p:use-when="true()"
		output-directory="{$output-directory}" 
		debug-path="{$debug-path}" 
		base-uri="{$base-uri}"
		pause-before-request="0"
		name="download-data">
		<p:with-input port="report-in" pipe="report@virtual-document" />
	</lax:download-document-data>
	
	<p:for-each>
		<p:with-input select="//lad:document"/>
		<p:variable name="nickname" select="/lad:document/@nickname" />
		<p:store href="{$output-directory}/{$nickname}/virtual-document-02-downloaded.xml" serialization="map{'indent' : true()}"  use-when="true()" />
		
		<lax:prepare-text-data p:use-when="false()"
			output-directory="{$output-directory}" 
			debug-path="{$debug-path}" 
			base-uri="{$base-uri}"
			name="preparing-text-data">
			<p:with-input port="report-in" pipe="report@download-data" />
		</lax:prepare-text-data>
		
		<p:store href="{$output-directory}/{$nickname}/virtual-document-03-prepared-text.xml" serialization="map{'indent' : true()}"  use-when="true()" />
		
		<lax:enrich-document-data p:use-when="true()"
			output-directory="{$output-directory}" 
			debug-path="{$debug-path}" 
			base-uri="{$base-uri}"
			pause-before-request="0">
			<p:with-option name="output-format" select="('ALTO', 'TEXT', 'TEI')" />
			<p:with-option name="enrichment" select="('ENTITIES', 'MORPHOLOGY')" />
<!--			<p:with-input port="report-in" pipe="report@preparing-text-data" />-->
			<p:with-input port="report-in" pipe="report@virtual-document" />
			<p:with-input port="settings" href="../../settings/services.xml" />
		</lax:enrich-document-data>
		
		<p:store href="{$output-directory}/{$nickname}/virtual-document-04-enriched.xml" serialization="map{'indent' : true()}"  use-when="true()" />
		
	</p:for-each>
	
	<!--<p:for-each>
		<p:with-input select="//lad:document"/>
	
	</p:for-each>-->
	
	<!--<p:for-each>
		<p:with-input select="//lad:document"/>
		<p:variable name="nickname" select="/lad:document/@nickname" />
		<p:store href="{$output-directory}/{$nickname}/virtual-document-03-prepared-text.xml" serialization="map{'indent' : true()}"  use-when="true()" />
	</p:for-each>-->

	<!--<lax:enrich-document-data p:use-when="true()"
		output-directory="{$output-directory}" 
		debug-path="{$debug-path}" 
		base-uri="{$base-uri}"
		pause-before-request="0">
		<p:with-option name="output-format" select="('ALTO', 'TEXT', 'TEI')" />
		<p:with-option name="enrichment" select="('ENTITIES', 'MORPHOLOGY')" />
		<p:with-input port="report-in" pipe="report@preparing-text-data" />
		<p:with-input port="settings" href="../../settings/services.xml" />
	</lax:enrich-document-data>-->

	<!--<p:for-each>
		<p:with-input select="//lad:document"/>
		<p:variable name="nickname" select="/lad:document/@nickname" />
		<p:store href="{$output-directory}/{$nickname}/virtual-document-04-enriched.xml" serialization="map{'indent' : true()}"  use-when="true()" />
	</p:for-each>-->

	<p:wrap-sequence wrapper="lad:documents" />
	<p:store href="{$output-directory}/report.xml" serialization="map{'indent' : true()}"  use-when="true()" />
	
	<lax:create-report output-directory="{output-directory}"/>
	<p:store href="{$output-directory}/report.html" />
	<p:identity>
		<p:with-input port="source" pipe="result-uri" />
	</p:identity>
	
</p:declare-step>

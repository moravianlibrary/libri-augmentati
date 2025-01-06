<p:declare-step 
	xmlns:p="http://www.w3.org/ns/xproc" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:err="http://www.w3.org/ns/xproc-error"
	xmlns:lad="https://www.mzk.cz/ns/libri-augmentati/documents/1.0"
	xmlns:las="https://www.mzk.cz/ns/libri-augmentati/settings/1.0"
	xmlns:lax="https://www.mzk.cz/ns/libri-augmentati/xproc/1.0"
	xmlns:lat="https://www.mzk.cz/ns/libri-augmentati/test"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns:c="http://www.w3.org/ns/xproc-step"
	version="3.0" name="tests">
	
	<p:import href="../../xproc/libri-augmentati.xpl" />
	
	<p:documentation>
		<xhtml:section>
			<xhtml:h2></xhtml:h2>
			<xhtml:p></xhtml:p>
		</xhtml:section>
	</p:documentation>
   
	<!-- INPUT PORTS -->
  <p:input port="source" primary="true">
  	<p:document href="../../settings/libraries.xml" />
  </p:input>
   
	<!-- OUTPUT PORTS -->
	<p:output port="result" primary="true" sequence="true" serialization="map{'indent' : true()}" />
	
	<!-- OPTIONS -->
	<!-- TODO: 
		to disable debug messages and files 
		uncomment following option and comment next one 
	-->
<!--	<p:option name="debug-path" select="()" as="xs:string?" />-->
	<p:option name="debug-path" as="xs:string" select="'../../_debug/test-samples'" />
	<p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
	
	<p:option name="output-directory" as="xs:string" select="'../../_temp/test-samples'" />
	
	<!-- TODO: 
		to disable downloading data files 
		uncomment following option and comment next one 
	-->
<!--	<p:option name="download-data" as="xs:boolean" select="false()" />-->
	<p:option name="download-data" as="xs:boolean" select="true()" />
	
	<!-- TODO: 
		to disable enriching text data  
		uncomment following option and comment next one 
	-->
<!--	<p:option name="enrich-data" as="xs:boolean" select="false()" />-->
	<p:option name="enrich-data" as="xs:boolean" select="true()" />
	
	<!-- INNER STEPS -->
	<p:declare-step type="lat:build-virtual-document">
		
		<!-- INPUT PORTS -->
		<p:input port="source" primary="true" />
		
		
		<!-- OUTPUT PORTS -->
		<p:output port="result" primary="true" sequence="true" />
		<p:output port="result-uri" primary="false" sequence="true" />
		
		<!-- OPTIONS -->
		<p:option name="debug-path" select="()" as="xs:string?" />
		<p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
		<p:option name="output-directory" required="true" as="xs:string"  />
		
		<p:option name="download-data" select="false()" as="xs:boolean" />
		
		<!-- VARIABLES -->
		<p:variable name="debug" select="$debug-path || '' ne ''" />
		<p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
		
		<p:variable name="apis" select="/las:digital-libraries/las:apis/las:api" />
		<p:variable name="samples" select="/las:digital-libraries/las:samples/las:sample" />
		
		<p:for-each>
			<p:with-input select="/las:digital-libraries/las:libraries/las:library"/>
			<p:variable name="library" select="/las:library" />
			<p:variable name="lib-apis" select="$apis[@xml:id = $library/las:api/tokenize(@ref) ! translate(., '#', '')]" />
			
			<p:for-each message="Library {$library/las:institution/las:name[1]} ({$library/@code})">
				<p:with-input select="$lib-apis"/>
				<p:variable name="api" select="." />
				
				<p:variable name="lib-samples" select="$samples[@xml:id = $library/las:api[@ref='#' || $api/las:api/@xml:id]/las:samples/tokenize(@ref) ! translate(., '#', '')]" />
				
				<p:for-each message="api/@xml:id = {$api/las:api/@xml:id}; count $lib-samples: {count($lib-samples)}">
					<p:with-input select="$lib-samples"/>
					<p:variable name="sample" select="." />
					<p:variable name="document-id" select="if(exists($sample/las:sample/@nickname))
						then $sample/las:sample/@nickname 
						else if(starts-with($sample/las:sample/las:document/@id, 'uuid:')) 
						then substring-after($sample/las:sample/las:document/@id, 'uuid:') 
						else  $sample/las:sample/las:document/@id 
						"></p:variable>
					
					<lax:build-virtual-document p:use-when="true()" 
						debug-path="{$debug-path}" base-uri="{$base-uri}"
						library-code="{$library/@code}" 
						api-version="{$api/las:api/@version}"
						document-resources="{$api/las:api/las:resource[tokenize(@level)= 'document']/@type}"
						page-resources="{$api/las:api/las:resource[tokenize(@level)= 'page']/@type}"
						p:message="Processing {$sample/las:sample/@name}; document-id: {$document-id}; building virtual document with: {$api/las:api/las:resource[tokenize(@level)= 'document']/@type}, and {$api/las:api/las:resource[tokenize(@level)= 'page']/@type}"
						>
						<p:with-input port="source">
							<p:inline>
								<lad:documents>
									<lad:document id="{$sample/las:sample/las:document/@id}" nickname="{$sample/las:sample/@nickname}"/>
								</lad:documents>
							</p:inline>
						</p:with-input>
						<p:with-input port="settings" href="../../settings/libraries.xml" />
					</lax:build-virtual-document>
					
					<p:if test="$debug">
						<p:store href="{$debug-path-uri}/{$library/@code}/{$document-id}-virtual.xml" />
					</p:if>
					
					<p:if test="$download-data" name="download-data">
						<p:output port="result" pipe="result@download-document-data" primary="true" />
						<p:output port="report" pipe="report@download-document-data" />
						<lax:download-document-data 
							output-directory="{$output-directory}/{$library/@code}" 
							debug-path="{$debug-path}" 
							base-uri="{$base-uri}" 
							pause-before-request="0" 
							p:message=" - downloading virtual document data to {$output-directory}/{$library/@code}"
							name="download-document-data"
						/>
					</p:if>
					
					<p:if test="$debug">
						<p:store href="{$debug-path-uri}/{$library/@code}/{$document-id}-virtual-data.xml" />
					</p:if>
					
					<p:if test="$download-data">
						<lax:enrich-document-data 
							output-directory="{$output-directory}/{$library/@code}" 
							debug-path="{$debug-path}" 
							base-uri="{$base-uri}" 
							pause-before-request="0" 
							p:message=" - enriching document data to {$output-directory}/{$library/@code}">
							<p:with-option name="output-format" select="('TEXT', 'TEI')" />
							<p:with-option name="enrichment" select="('ENTITIES', 'MORPHOLOGY')" />
							<p:with-input port="report-in" pipe="report@download-data" />
							<p:with-input port="settings" href="../../settings/services.xml" />
						</lax:enrich-document-data>
					</p:if>
					<p:if test="$debug">
						<p:store href="{$debug-path-uri}/{$library/@code}/{$document-id}-enriched-data.xml" />
					</p:if>
					
				</p:for-each>
				
			</p:for-each>
			
		</p:for-each>
		
		<lax:create-report output-directory="{$output-directory}" debug-path="{$debug-path}" base-uri="{$base-uri}" />
		<p:identity>
			<p:with-input port="source" pipe="result-uri" />
		</p:identity>
		
	</p:declare-step>
	
	
	<!-- VARIABLES -->
	<p:variable name="debug" select="$debug-path || '' ne ''" />
	<p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
	
	<!-- PIPELINE BODY -->
	
	<lat:build-virtual-document debug-path="{$debug-path}" base-uri="{$base-uri}" output-directory="{$output-directory}" download-data="{$download-data}" />
	<p:wrap-sequence wrapper="c:result" />

	
	<p:if test="$debug">
		<p:store href="{$debug-path-uri}/report.xml" />
	</p:if>
	
	<p:store href="{$output-directory}/report.xml" serialization="map{'indent' : true()}" message="Storing result to {$output-directory}/report.xml" />
	
	<p:xslt>
		<p:with-input port="stylesheet" href="../../xslt/report.xsl" />
	</p:xslt>
	<p:store href="{$output-directory}/report.html" serialization="map{'indent' : true()}" message="Storing summary report to {$output-directory}/report.html" />
	
</p:declare-step>

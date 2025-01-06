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
		<xhtml:section xml:lang="en">
			<xhtml:h2>Pipeline for processing sample book</xhtml:h2>
			<xhtml:p>Creates a virtual document, saves data from a digital library, and enriches text data for a single book.</xhtml:p>
		</xhtml:section>
		<xhtml:section xml:lang="cs">
			<xhtml:h2>Linka pro zpracování vzorové knihy</xhtml:h2>
			<xhtml:p>Vytvoří virtuální dokument, uloží data z digitální knihovny a obohatí textová data pro jednu knihu.</xhtml:p>
		</xhtml:section>
	</p:documentation>
   
	<!-- OUTPUT PORTS -->
	<p:output port="result" primary="true" serialization="map{'indent' : true()}" />
	
	<!-- OPTIONS -->
	<!-- TODO: 
		to disable debug messages and files 
		uncomment following option and comment next one 
	-->
<!--		<p:option name="debug-path" select="()" as="xs:string?" />-->
	<p:option name="debug-path" as="xs:string" select="'../../_debug/sample-book'" />
	<p:option name="base-uri" as="xs:anyURI" select="static-base-uri()"/>
	
	<p:option name="output-directory" as="xs:string" select="'../../_temp/sample-book'" />
	
	<!-- VARIABLES -->
	<p:variable name="debug" select="$debug-path || '' ne ''" />
	<p:variable name="debug-path-uri" select="resolve-uri($debug-path, $base-uri)" />
	
	<!-- PIPELINE BODY -->
	
		<lax:build-virtual-document p:use-when="true()"
			name="virtual-document"
			library-code="mzk" 
			api-version="7" 
			document-resources="MODS DC FOXML"
			page-resources="ALTO TEXT FOXML DC MODS IMAGE"
			debug-path="{$debug-path}"
			base-uri="{$base-uri}">
			<p:with-input port="source">
				<p:inline>
					<lad:documents>
						<lad:document id="uuid:de87a0e0-643b-11ea-a744-005056827e51" nickname="Postural-defects" /> 
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
	
	<lax:enrich-document-data p:use-when="true()"
		output-directory="{$output-directory}" 
		debug-path="{$debug-path}" 
		base-uri="{$base-uri}"
		pause-before-request="0">
		<p:with-option name="output-format" select="('TEXT', 'TEI')" />
		<p:with-option name="enrichment" select="('ENTITIES', 'MORPHOLOGY')" />
		<p:with-input port="report-in" pipe="report@download-data" />
		<p:with-input port="settings" href="../../settings/services.xml" />
	</lax:enrich-document-data>
	
	<p:store href="{$output-directory}/virtual-document-03-enriched.xml" serialization="map{'indent' : true()}"  use-when="true()" />
	
	<lax:create-report output-directory="{output-directory}"/>
	<p:store href="{$output-directory}/report.html" message="Storing report to {$output-directory}/report.html" />
	<p:identity>
		<p:with-input port="source" pipe="result-uri" />
	</p:identity>
	
</p:declare-step>

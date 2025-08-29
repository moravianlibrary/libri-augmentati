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
	
	<!--
					name="virtual-document"
			library-code="mzk" 
			api-version="7" 
			document-resources="MODS DC FOXML"
			page-resources="ALTO TEXT FOXML DC MODS IMAGE"
	-->
	
		<lax:build-virtual-document p:use-when="true()"
			name="virtual-document"
			library-code="nkp" 
			api-version="5" 
			document-resources="MODS DC FOXML"
			page-resources="ALTO TEXT FOXML DC MODS IMAGE"
			debug-path="{$debug-path}"
			base-uri="{$base-uri}"
			p:message=" :: BUILDING VIRTUAL DOCUMENT :: ">
			<p:with-input port="source">
				<p:inline>
					<lad:documents>
<!--						<lad:document id="uuid:de87a0e0-643b-11ea-a744-005056827e51" nickname="Postural-defects" /> 
						<lad:document id="uuid:75c6c0e0-ccc8-11ef-854b-0050568d319f" nickname="Secondary-schools" /> 
-->
						<lad:document id="uuid:0333c8b0-880b-11e3-997d-005056827e52" />
						<!--
						<lad:document id="uuid:fabc31e0-2e38-11e2-89c9-005056827e51" /> 
						<lad:document id="uuid:16b2cba0-0b12-11e3-9923-005056827e52" /> 
						<lad:document id="uuid:06a8ef00-fda2-11e2-9923-005056827e52" /> 
						<lad:document id="uuid:dced42e0-a5b0-11e2-8b87-005056827e51" /> 
						<lad:document id="uuid:4e8c96d0-4d7f-11e5-8b04-5ef3fc9bb22f" /> 
						<lad:document id="uuid:f6bb9870-2fbd-11e2-b987-005056827e52" /> 
						<lad:document id="uuid:0333c8b0-880b-11e3-997d-005056827e52" /> 
						<lad:document id="uuid:c9c2ce00-161c-11e4-8e0d-005056827e51" /> 
						<lad:document id="uuid:cf7d8160-ff33-11e2-beb8-005056827e51" /> 
						<lad:document id="uuid:30e5f630-cd37-11e4-97af-005056827e51" /> 
						<lad:document id="uuid:bf16c310-5070-11e9-936e-005056827e52" /> 
						<lad:document id="uuid:dfbf9190-3f7a-11e2-b246-005056827e52" /> 
						<lad:document id="uuid:855351f0-6fa4-11e8-87bd-005056827e52" /> 
						<lad:document id="uuid:ce7dbae0-ac00-11e2-8b87-005056827e51" /> 
						<lad:document id="uuid:fe12db20-0c5a-11ea-a20e-005056827e51" /> 
						<lad:document id="uuid:9b731af0-b284-11e9-9209-005056827e51" /> 
						<lad:document id="uuid:be82d750-55dd-11e9-8854-005056827e51" /> 
						<lad:document id="uuid:eebe0280-b1ce-11e9-9209-005056827e51" /> 
						<lad:document id="uuid:bac13370-a937-11e9-8fdf-005056827e52" /> 
						<lad:document id="uuid:14507aa0-517a-11ea-a3ba-005056827e52" /> 
						<lad:document id="uuid:48435df0-3955-11eb-b577-005056827e52" /> 
						<lad:document id="uuid:767a56a0-3e10-11eb-a9f6-005056827e51" /> 
						<lad:document id="uuid:d1620400-3eb0-11eb-b577-005056827e52" /> 
						<lad:document id="uuid:772367e0-3e10-11eb-a9f6-005056827e51" /> 
						<lad:document id="uuid:973e3c50-7b3a-11eb-9f97-005056827e51" /> 
						<lad:document id="uuid:bebccf20-22b4-11e4-8f64-005056827e52" /> 
						<lad:document id="uuid:8165c8e0-244d-11e3-9319-005056827e51" /> 
						<lad:document id="uuid:beed96b0-08d7-11e4-b1a4-005056827e52" /> 
						<lad:document id="uuid:21ca6070-8499-11e2-b238-005056827e52" /> 
						<lad:document id="uuid:83551b30-4d1d-11e3-ad8c-005056827e52" /> 
						<lad:document id="uuid:d8cdcc50-00c5-11e3-beb8-005056827e51" /> 
						<lad:document id="uuid:700797c0-ef89-11e2-9923-005056827e52" /> 
						<lad:document id="uuid:8fafc2c0-adf9-11e4-a7a2-005056827e51" /> 
						<lad:document id="uuid:24a27cd0-a124-11e3-a744-005056827e52" /> 
						<lad:document id="uuid:992ab2d0-a11e-11e3-8e84-005056827e51" /> 
						<lad:document id="uuid:ddfc0ae0-b658-11e8-bbaa-005056827e52" /> 
						<lad:document id="uuid:49a27c90-0725-11e8-b1a1-005056827e52" /> 
						<lad:document id="uuid:22b5c760-4722-11ea-9ac7-005056827e51" /> 
						<lad:document id="uuid:9bfe6dc0-47ef-11ea-81b3-005056827e52" /> 
						<lad:document id="uuid:23911700-15b0-11ea-af21-005056827e52" /> 
						<lad:document id="uuid:a88aef70-436d-11e2-9b88-005056827e51" /> 
						<lad:document id="uuid:05fc89f0-ae3e-11e5-b5dc-005056827e51" /> 
						<lad:document id="uuid:cc42ae20-5888-11ea-9076-005056827e52" /> 
						<lad:document id="uuid:cdbff240-e6c3-11e8-8d10-5ef3fc9ae867" /> 
						<lad:document id="uuid:ec525c50-e6c0-11e8-9210-5ef3fc9bb22f" /> 
						<lad:document id="uuid:33ddda30-ddd5-11e8-bc37-005056827e51" /> 
						<lad:document id="uuid:d16c8fe0-0c09-11e5-9eb3-005056827e52" /> 
						<lad:document id="uuid:77460da0-00ae-11e9-8d10-5ef3fc9ae867" /> 
						<lad:document id="uuid:c53fbc80-6ed8-11e8-9690-005056827e51" /> 
						<lad:document id="uuid:4cf3e520-a346-11e7-ae0a-005056827e52" /> 
-->					</lad:documents>
				</p:inline>
			</p:with-input>
			<p:with-input port="settings" href="../../settings/libraries.xml" />
		</lax:build-virtual-document>
	
	<p:wrap-sequence wrapper="lad:documents" />
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
		name="download-data"
		p:message=" :: DOWNLOADING DOCUMENT DATA :: ">
		<p:with-input port="report-in" pipe="report@virtual-document" />
	</lax:download-document-data>
	
	<p:store href="{$output-directory}/virtual-document-02-downloaded.xml" serialization="map{'indent' : true()}"  use-when="true()" />
	
	<p:store href="{$output-directory}/virtual-document-03-prepared.xml" serialization="map{'indent' : true()}"  use-when="true()" message="  - storing to {$output-directory}/virtual-document-03-prepared.xml" />
	
	<lax:enrich-document-data p:use-when="true()"
		output-directory="{$output-directory}" 
		debug-path="{$debug-path}" 
		base-uri="{$base-uri}"
		pause-before-request="0"
		p:message=" :: ENRICHING DOCUMENT DATA :: ">
		<p:with-option name="output-format" select="('ALTO', 'TEXT', 'TEI')" />
		<p:with-option name="enrichment" select="('ENTITIES', 'MORPHOLOGY')" />
		<p:with-input port="report-in" pipe="report@download-data" />
		<p:with-input port="settings" href="../../settings/services.xml" />
	</lax:enrich-document-data>
	
	<p:store href="{$output-directory}/virtual-document-04-enriched.xml" serialization="map{'indent' : true()}"  use-when="true()" message="   storing {$output-directory}/virtual-document-04-enriched.xml" />
	
	<lax:create-report output-directory="{output-directory}" p:message=" :: CREATING REPORT :: "/>
	<p:store href="{$output-directory}/report.html" message="Storing report to {$output-directory}/report.html" />

	<p:identity>
		<p:with-input port="source" pipe="result-uri" />
	</p:identity>
	
</p:declare-step>

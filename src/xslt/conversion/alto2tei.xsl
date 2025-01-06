<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:ns="http://www.namescape.nl/" 
 xmlns:alto="http://schema.ccs-gmbh.com/ALTO"
 xmlns:alto-v2="http://www.loc.gov/standards/alto/ns-v2#" 
 xmlns:tei="http://www.tei-c.org/ns/1.0" 
 xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 exclude-result-prefixes="tei xd"
 xpath-default-namespace="http://www.tei-c.org/ns/1.0" 
 xmlns="http://www.tei-c.org/ns/1.0" 
 version="2.0">
 <xsl:import href="alto2tei-graphics.xsl"/>

 <xsl:param name="page-number" as="xs:string?" required="no" />

 <xsl:strip-space elements="*"/>
 <xsl:output indent="yes" method="xml"/>
 <xsl:variable name="version" select="'1.2.0'"/>

 <!--
<String ID="P1_ST03570" HPOS="3324" VPOS="3090" WIDTH=
"33" HEIGHT="19" CONTENT="on" SUBS_TYPE="HypPart1" SUBS_CONTENT="onderaardsche" WC="0.62" CC="460"/>
                                                <HYP HPOS="3357" VPOS="3090" WIDTH="15" CONTENT="-"/>
                                        </TextLine>
                                        <TextLine ID="P1_TL00560" HPOS="2598" VPOS="3119" WIDTH="365" 
HEIGHT="35">
                                                <String ID="P1_ST03571" HPOS="2598" VPOS="3122" WIDTH=
"196" HEIGHT="28" CONTENT="deraardsche" SUBS_TYPE="HypPart2" SUBS_CONTENT="onderaardsche" WC="0.49" CC
="03487904473"/>

TextStyle
Required: No.
Usage: A text style defines font properties of text.
Attributes: ID, FONTWIDTH, FONTTYPE, FONTSTYLE, FONTFAMILY, FONTCOLOR, FONTSIZE.
Contains: EMPTY ELEMENT.
Contained by: Styles.
ParagraphStyle
Required: No.
Usage: A paragraph style defines formatting properties of text blocks.
Attributes: ID, RIGHT, LEFT, ALIGN, LINESPACE, FIRSTLINE
Contains: EMPTY ELEMENT.
Contained by: Styles.

<String ID="String190" CONTENT="on" HEIGHT="23" WIDTH="52" HPOS="1282" VPOS="1733" WC="1" CC="000" SUBS_TYPE="HypPart1" SUBS_CONTENT="onbefchaamdheid,"/>
<String ID="String191" CONTENT="befchaamdheid," HEIGHT="43" WIDTH="279" HPOS="394" VPOS="1779" WC="1" CC="00000000000000" SUBS_TYPE="HypPart2" SUBS_CONTENT="onbefchaamdheid,"/>
-->

 <xsl:param name="generateIds">true</xsl:param>
 <xsl:param name="scale">1</xsl:param>
 <xsl:param name="zone-hierarchy" select="true()" />
 <xsl:param name="app-info">
  <appInfo>
   <application version="{$version}" ident="alto2tei.xsl" notAfter="{current-dateTime()}">
    <label>alto2tei.xsl</label>
    <p>Konverze z formátu ALTO do TEI.</p>
   </application>
  </appInfo>
 </xsl:param>
 
 <xsl:param name="page-uuid"  />
 <xsl:param name="base-url" />
 

 <xsl:variable name="page-url">
  <xsl:if test="$page-uuid != ''">
   <xsl:value-of select="replace($base-url, '/uuid/', concat('/', $page-uuid, '/'))"/>
  </xsl:if>
 </xsl:variable>

 <xsl:template name="setIdNoFacs">
  <xsl:if test="@ID or $generateIds = 'true'">
   <xsl:attribute name="xml:id">
    <xsl:choose>
     <xsl:when test="@ID">
      <xsl:value-of select="@ID"/>
     </xsl:when>
     <xsl:otherwise>e<xsl:number level="any" count="*"/></xsl:otherwise>
    </xsl:choose>
   </xsl:attribute>
  </xsl:if>
 </xsl:template>

 <xsl:template name="setId">
  <xsl:if test="@ID or $generateIds = 'true'">
   <xsl:attribute name="xml:id">
    <xsl:choose>
     <xsl:when test="@ID">
      <xsl:value-of select="@ID"/>
     </xsl:when>
     <xsl:otherwise>e<xsl:number level="any" count="*"/></xsl:otherwise>
    </xsl:choose>
   </xsl:attribute>
   <xsl:attribute name="facs">
    <xsl:choose>
     <xsl:when test="@ID">#f<xsl:value-of select="@ID"/></xsl:when>
     <xsl:otherwise>#f<xsl:number level="any" count="*"/></xsl:otherwise>
    </xsl:choose>
   </xsl:attribute>
  </xsl:if>
  <xsl:if test="@STYLEREFS">
   <xsl:attribute name="rendition">#<xsl:value-of select="replace(@STYLEREFS, ' ', ' #')"/></xsl:attribute>
  </xsl:if>
  <xsl:if test="@STYLE">
   <xsl:attribute name="rend">
    <xsl:value-of select="@STYLE"/>
   </xsl:attribute>
  </xsl:if>
 </xsl:template>


 <xsl:template match="/">
  <TEI>
   <teiHeader>
    <fileDesc>
     <titleStmt>
      <title>TEI file</title>
     </titleStmt>
     <publicationStmt>
      <p>(Information about distribution of the resource)</p>
     </publicationStmt>
     <sourceDesc>
      <p>(Information about source from which the resource derives)</p>
     </sourceDesc>
    </fileDesc>
    <encodingDesc>
     <xsl:copy-of select="$app-info"/>
     <tagsDecl>
      <xsl:for-each select=".//*[local-name() = 'TextStyle']">
       <rendition scheme="other">
        <xsl:call-template name="setIdNoFacs"/>
        <xsl:for-each select="@*">
         <xsl:value-of select="name(.)"/> : <xsl:value-of select="."/>; </xsl:for-each>
       </rendition>
       <xsl:text>
</xsl:text>
      </xsl:for-each>
      <xsl:apply-templates select=".//alto-v2:Styles/alto-v2:ParagraphStyle"></xsl:apply-templates>
     </tagsDecl>
    </encodingDesc>
   </teiHeader>

   <facsimile>
    <surface>
     <graphic url="{$page-url}" />
     <xsl:apply-templates select=".//*[local-name() = 'Layout']" mode="facsimile"/>
    </surface>
   </facsimile>
   <text>
    <body>
     <div>
      <xsl:if test="$page-number != ''">
       <pb n="{$page-number}" />
      </xsl:if>
      <xsl:apply-templates select=".//*[local-name() = 'Layout']"/>
     </div>
    </body>
   </text>
  </TEI>
 </xsl:template>
 
 <xsl:template match="alto-v2:ParagraphStyle">
  <rendition scheme="other">
   <xsl:call-template name="setIdNoFacs"/>
   <xsl:for-each select="@*">
    <xsl:value-of select="name(.)"/> : <xsl:value-of select="."/>; </xsl:for-each>
  </rendition>
 </xsl:template>

 <xsl:template match="*[local-name() = 'Layout']">
  <xsl:apply-templates/>
 </xsl:template>

 <xsl:template match="*[local-name() = 'TextBlock']">
  <ab>
   <xsl:attribute name="type">
    <xsl:value-of select="name(.)"/>
   </xsl:attribute>
   <xsl:call-template name="setId"/>
   <xsl:apply-templates/>
  </ab>
 </xsl:template>

 <xsl:template match="*[local-name() = 'TextLine']">
  <xsl:apply-templates/>
  <lb>
   <xsl:call-template name="setId"/>
  </lb>
 </xsl:template>

 <xsl:template match="*[local-name() = 'SP']">
  <xsl:text> </xsl:text>
 </xsl:template>

 <xsl:template match="*[local-name() = 'String'][@SUBS_TYPE = 'HypPart1']" priority="5">
  <reg>
   <!--<xsl:attribute name="orig"><xsl:value-of select="@CONTENT"/>|<xsl:variable name="s1"><xsl:value-of select="@CONTENT"/></xsl:variable><xsl:variable name="s2"><xsl:value-of select="@SUBS_CONTENT"/></xsl:variable><xsl:value-of select="substring-after($s2,$s1)"/></xsl:attribute>-->
   <w>
    <xsl:call-template name="setId"/>
    <xsl:value-of select="@SUBS_CONTENT"/>
   </w>
  </reg>
 </xsl:template>

 <xsl:template match="*[local-name() = 'String'][@SUBS_TYPE = 'HypPart2']" priority="5"/>

 <xsl:template match="*[local-name() = 'String']">
  <w>
   <xsl:call-template name="setId"/>
   <xsl:value-of select="@CONTENT"/>
  </w>
 </xsl:template>


 <xsl:template match="*[local-name() = 'Layout' 
  or local-name() = 'PrintSpace' 
  or local-name() = 'Page' 
  or local-name() = 'TextLine' 
  or local-name() = 'Page' 
  or local-name() = 'TextBlock' 
  or local-name() = 'String']" mode="facsimile">
  <xsl:choose>
   <xsl:when test="not($zone-hierarchy) and local-name() != 'String'">
    <xsl:apply-templates mode="#current" />
   </xsl:when>
   <xsl:otherwise>
    <zone>
     <xsl:attribute name="type">
      <xsl:value-of select="name(.)"/>
     </xsl:attribute>
     <xsl:call-template name="setId_facs"/>
     <xsl:if test="@HPOS and @WIDTH">
      <xsl:attribute name="ulx" select="ns:scaleCoordinates(xs:integer(@HPOS))"/>
      <xsl:attribute name="uly" select="ns:scaleCoordinates(xs:integer(@VPOS))"/>
      <xsl:attribute name="lrx" select="ns:scaleCoordinates(xs:integer(@HPOS)) + ns:scaleCoordinates(xs:integer(@WIDTH))"/>
      <xsl:attribute name="lry" select="ns:scaleCoordinates(xs:integer(@VPOS)) + ns:scaleCoordinates(xs:integer(@HEIGHT))"/>
     </xsl:if>
     <xsl:apply-templates mode="#current"/>
    </zone>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

</xsl:stylesheet>

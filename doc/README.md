# XProc Analysis Report

## alto.xpl (version: 1.0.0)
#### Documentation (176)
    
##### Library for ALTO format manipulation
Steps for standalone ALTO data operations.
##### Knihovna pro zpracování dat ve formátu ALTO
Kroky pro samostatné operace s daty ve formátu ALTO.
#### Namespaces (8)
    
| prefix | string |
| --- | --- |
| laa | https://www.mzk.cz/ns/libri-augmentati/alto/1.0 |
| lad | https://www.mzk.cz/ns/libri-augmentati/documents/1.0 |
| lar | https://www.mzk.cz/ns/libri-augmentati/report/1.0 |
| las | https://www.mzk.cz/ns/libri-augmentati/settings/1.0 |
| p | http://www.w3.org/ns/xproc |
| xhtml | http://www.w3.org/1999/xhtml |
| xs | http://www.w3.org/2001/XMLSchema |
| xml | http://www.w3.org/XML/1998/namespace |

### Steps  (2 + 0)
      
#### Documentation (176)
    
##### Library for ALTO format manipulation
Steps for standalone ALTO data operations.
##### Knihovna pro zpracování dat ve formátu ALTO
Kroky pro samostatné operace s daty ve formátu ALTO.

#### **laa:combine-alto-pages** (combining-alto-pages)
#### Documentation (253)
    
##### Merge multiple pages
Merges separate ALTO documents into one document, including metadata (styles) and textcontent (pages).
##### Spojení stran
Spojí samostatné dokumenty ve formátu ALTO do jednoho dokumentu, včetně metadat (stylu) a textového obsahu (stran).
#### Options (3)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| output-directory | name = output-directory \| required = true \| as = xs:string |

#### Ports (4)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| input | report-in | false |
| output | **result** | true |
| output | report | false |

### Steps  (0 + 11)
      
#### Documentation (253)
    
##### Merge multiple pages
Merges separate ALTO documents into one document, including metadata (styles) and textcontent (pages).
##### Spojení stran
Spojí samostatné dokumenty ve formátu ALTO do jednoho dokumentu, včetně metadat (stylu) a textového obsahu (stran).


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:variable | library-code |   |   | 
|   |   |   | select | /lad:document/las:library/@code | 
| 4 | p:variable | id |   |   | 
|   |   |   | select | if(exists(/lad:document/@nickname))    then /lad:document/@nickname     else if(starts-with(/lad:document/@id, 'uuid:'))     then substring-after(/lad:document/@id, 'uuid:')     else  /lad:document/@id | 
| 5 | p:variable | result-directory-path |   |   | 
|   |   |   | p:documentation | 
    
     The folder where generated documents are saved. The path to the folder can be absolute or relative.
    
    
     Složka, do níž se uloží vygenerované dokumenty. Cesta ke složce může být absolutní i relativní.
    
    | 
|   |   |   | select | $output-directory | 
| 6 | p:variable | result-directory-uri |   |   | 
|   |   |   | select | resolve-uri($result-directory-path, $base-uri) | 
| 7 | p:variable | alto-pages |   |   | 
|   |   |   | select | /lad:document/lad:pages[lad:page[lad:resource[@type='alto']]] | 
| 8 | p:if |  |   |   | 
|   |   |   | p:store |  | 
|   |   |   | test | $debug | 
| 9 | p:if |  |   |   | 
|   |   |   | p:if | 
    
     
     
    
    
    
    
    
     
    
    
    
     
    
    
    
     
    
    
    
     
    
    
    
     
    
    
    
     
    
    
    
     
    
    
    
     
       
    
    
     
      
     
    
    
    
    
    
     
     
    
    
    | 
|   |   |   | p:namespace-delete |  | 
|   |   |   | p:variable |  | 
|   |   |   | p:variable |  | 
|   |   |   | p:variable |  | 
|   |   |   | p:variable |  | 
|   |   |   | test | exists($alto-pages) | 
| 10 | p:identity | final |   |   | 
| 11 | p:identity | final-report |   |   | 
|   |   |   | pipe | report-in@combining-alto-pages | 


#### **laa:process-page** (processing-page)
#### Documentation (293)
    
##### Proces single page
Aplies modifications on one ALTO document to prepare it for merging, especialy assigning unique indentifires.
##### Zpracování jedné strany
Aplikuje úpravy na jeden dokument ve formátu ALTO, aby ho bylo možné spojit s ostatními, zejména jde o přiřazení jedinečných identifikátorů.
#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 1)
      
#### Documentation (293)
    
##### Proces single page
Aplies modifications on one ALTO document to prepare it for merging, especialy assigning unique indentifires.
##### Zpracování jedné strany
Aplikuje úpravy na jeden dokument ve formátu ALTO, aby ho bylo možné spojit s ostatními, zejména jde o přiřazení jedinečných identifikátorů.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:viewport |  |   |   | 
|   |   |   | match | lad:page | 
|   |   |   | p:variable |  | 
|   |   |   | p:variable |  | 
|   |   |   | p:xslt | 
   
   
   
   | 



## conversion.xpl (version: 1.0.0)
#### Documentation (194)
    
##### Library for data conversion
Steps for standalone data operations and conversion to other formats.
##### Knihovna pro konverzi dat
Kroky pro samostatné operace s daty a jejich převod do jiných formátů.
#### Namespaces (7)
    
| prefix | string |
| --- | --- |
| c | http://www.w3.org/ns/xproc-step |
| lac | https://www.mzk.cz/ns/libri-augmentati/conversion/1.0 |
| lad | https://www.mzk.cz/ns/libri-augmentati/documents/1.0 |
| p | http://www.w3.org/ns/xproc |
| xhtml | http://www.w3.org/1999/xhtml |
| xs | http://www.w3.org/2001/XMLSchema |
| xml | http://www.w3.org/XML/1998/namespace |

### Steps  (5 + 0)
      
#### Documentation (194)
    
##### Library for data conversion
Steps for standalone data operations and conversion to other formats.
##### Knihovna pro konverzi dat
Kroky pro samostatné operace s daty a jejich převod do jiných formátů.

#### **lac:convert-conllu-to-tei** (converting-conllu-to-tei)
#### Documentation (174)
    
##### Convert CoNLL-U to TEI
Converts CoNLLLu data generated by UDPipe to TEI P5.
##### Konverze CoNLL-U na TEI
Převede data ve formátu CoNLLLu, který generuje UDPipe, do formátu TEI P5.
#### Options (2)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 6)
      
#### Documentation (174)
    
##### Convert CoNLL-U to TEI
Converts CoNLLLu data generated by UDPipe to TEI P5.
##### Konverze CoNLL-U na TEI
Převede data ve formátu CoNLLLu, který generuje UDPipe, do formátu TEI P5.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:variable | udpipe-text |   |   | 
|   |   |   | select | . | 
| 4 | p:xslt |  |   |   | 
|   |   |   | parameters | map{'input': $udpipe-text} | 
|   |   |   | href | ../xslt/conversion/conllu-to-xml.xsl | 
| 5 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/conversion/conllu-xml-to-hierarchy.xsl | 
| 6 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/conversion/conllu-xml-hierarchy-to-tei.xsl | 


#### **lac:convert-nametag-xml-to-tei** (converting-nametag-xml-to-tei)
#### Documentation (176)
    
##### Convert NameTag XML to TEI
Converts XML data generated by NameTag to TEI P5.
##### Konverze NameTag XML na TEI
Převede data ve formátu XML, který generuje NameTag, do formátu TEI P5.
#### Options (2)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 4)
      
#### Documentation (176)
    
##### Convert NameTag XML to TEI
Converts XML data generated by NameTag to TEI P5.
##### Konverze NameTag XML na TEI
Převede data ve formátu XML, který generuje NameTag, do formátu TEI P5.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:variable | udpipe-text |   |   | 
|   |   |   | select | . | 
| 4 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/namegtag/nametag-xml-to-tei.xsl | 


#### **lac:convert-djvu**
#### Documentation (224)
    
##### Convert DjVu
Prepares script for conversion images from one virtual document in DjVu format to PDF or TIFF.
##### Konverze DjVu
Připraví skript pro konverzi obrázků z jednoho virtuálního dokumentu ve formátu DjVu do PDF nebo TIFF.
#### Options (8)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| main-input-directory | name = main-input-directory \| as = xs:anyURI \| required = true |
| main-output-directory | name = main-output-directory \| as = xs:anyURI \| required = true |
| output-file | name = output-file \| as = xs:string \| required = true |
| format | name = format \| values = ('pdf', 'tiff') \| select = 'pdf' |
| pdfbox-path | name = pdfbox-path \| as = xs:string \| required = true |
| ddjvu-path | name = ddjvu-path \| as = xs:string \| required = true |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 3)
      
#### Documentation (224)
    
##### Convert DjVu
Prepares script for conversion images from one virtual document in DjVu format to PDF or TIFF.
##### Konverze DjVu
Připraví skript pro konverzi obrázků z jednoho virtuálního dokumentu ve formátu DjVu do PDF nebo TIFF.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:viewport |  |   |   | 
|   |   |   | lac:convert-djvu-item |  | 
|   |   |   | match | lad:document | 
|   |   |   | p:variable |  | 


#### **lac:convert-djvu-item**
#### Documentation (229)
    
##### Convert DjVu item
Prepares script for conversion idividual images from folder in DjVu format to PDF or TIFF.
##### Konverze jednotlivých DjVu
Připraví skript pro konverzi jednotlivých obrázků ve složce ve formátu DjVu do PDF nebo TIFF.
#### Options (8)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| input-directory | name = input-directory \| as = xs:anyURI \| required = true |
| output-directory | name = output-directory \| as = xs:anyURI \| required = true |
| output-file | name = output-file \| as = xs:anyURI \| required = true |
| format | name = format \| values = ('pdf', 'tiff') \| select = 'pdf' |
| pdfbox-path | name = pdfbox-path \| as = xs:string \| required = true |
| ddjvu-path | name = ddjvu-path \| as = xs:string \| required = true |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | source | false |
| output | **result** | true |

### Steps  (0 + 10)
      
#### Documentation (229)
    
##### Convert DjVu item
Prepares script for conversion idividual images from folder in DjVu format to PDF or TIFF.
##### Konverze jednotlivých DjVu
Připraví skript pro konverzi jednotlivých obrázků ve složce ve formátu DjVu do PDF nebo TIFF.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:directory-list |  |   |   | 
|   |   |   | path | {$input-directory} | 
| 4 | p:for-each |  |   |   | 
|   |   |   | select | //c:file | 
| 5 | p:text-join | djvu-conversion |   |   | 
|   |   |   | separator | 
 | 
| 6 | p:identity |  |   |   | 
| 7 | lac:fix-path | pdf-merge |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug-path | {$debug-path} | 
| 8 | p:text-join |  |   |   | 
|   |   |   | separator | 
 | 
|   |   |   | pipe | @djvu-conversion @pdf-merge | 
| 9 | p:store |  |   |   | 
|   |   |   | href | {$output-file} | 
| 10 | p:file-mkdir |  |   |   | 
|   |   |   | href | {$output-directory} | 


#### **lac:fix-path** (fixing-path)
#### Documentation (185)
    
##### Fix path
Fixes file path URI to path with backslashes if operating system is Windows.
##### Úprava cesty
Opraví cestu k souboru na cestu se zpětnými lomítky, pokud je operační systém Windows.
#### Options (2)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | source | false |
| output | **result** | true |

### Steps  (0 + 4)
      
#### Documentation (185)
    
##### Fix path
Fixes file path URI to path with backslashes if operating system is Windows.
##### Úprava cesty
Opraví cestu k souboru na cestu se zpětnými lomítky, pokud je operační systém Windows.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:file-info |  |   |   | 
|   |   |   | fail-on-error | false | 
|   |   |   | href | file:///C:/Windows | 
| 4 | p:if |  |   |   | 
|   |   |   | p:text-replace | 
    
    | 
|   |   |   | p:text-replace |  | 
|   |   |   | test | exists(/c:directory[@name='Windows']) | 



## enrichment.xpl (version: 1.0.0)
#### Documentation (178)
    
##### Enrichment
The main programming library for enrichment data by external (web) services.
##### Obohacení
Hlavní programová knihovna pro obohacení dat pomocí externích (webových) služeb.
#### Namespaces (15)
    
| prefix | string |
| --- | --- |
| laa | https://www.mzk.cz/ns/libri-augmentati/alto/1.0 |
| lad | https://www.mzk.cz/ns/libri-augmentati/documents/1.0 |
| lae | https://www.mzk.cz/ns/libri-augmentati/enrichment/1.0 |
| lant | https://www.mzk.cz/ns/libri-augmentati/nametag/1.0 |
| lap | https://www.mzk.cz/ns/libri-augmentati/processing/1.0 |
| lar | https://www.mzk.cz/ns/libri-augmentati/report/1.0 |
| las | https://www.mzk.cz/ns/libri-augmentati/settings/1.0 |
| lat | https://www.mzk.cz/ns/libri-augmentati/tei/1.0 |
| latx | https://www.mzk.cz/ns/libri-augmentati/text/1.0 |
| laud | https://www.mzk.cz/ns/libri-augmentati/udpipe/1.0 |
| lax | https://www.mzk.cz/ns/libri-augmentati/xproc/1.0 |
| p | http://www.w3.org/ns/xproc |
| xhtml | http://www.w3.org/1999/xhtml |
| xs | http://www.w3.org/2001/XMLSchema |
| xml | http://www.w3.org/XML/1998/namespace |

#### Imports (0)
    

### Steps  (7 + 0)
      
#### Documentation (178)
    
##### Enrichment
The main programming library for enrichment data by external (web) services.
##### Obohacení
Hlavní programová knihovna pro obohacení dat pomocí externích (webových) služeb.

#### **lae:enrich-data** (enriching-data)
#### Documentation (155)
    
##### Enrich available data
Enriches available (textual) data by selected fetures.
##### Obohacení dostupných dat
Obohatí dostupná (textová) data o vybrané vlastnosti.
#### Options (6)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| output-directory | name = output-directory \| required = true \| as = xs:string |
| pause-before-request | name = pause-before-request \| select = 2 \| as = xs:integer |
| output-format | name = output-format \| values = ('ALTO', 'TEI', 'TEXT') \| as = xs:string* |
| enrichment | name = enrichment \| values = ('ENTITIES', 'MORPHOLOGY') \| as = xs:string* |

#### Ports (5)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| input | settings | false |
| input | report-in | false |
| output | **result** | true |
| output | report | false |

### Steps  (0 + 7)
      
#### Documentation (155)
    
##### Enrich available data
Enriches available (textual) data by selected fetures.
##### Obohacení dostupných dat
Obohatí dostupná (textová) data o vybrané vlastnosti.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:identity |  |   |   | 
| 2 | p:if |  |   |   | 
|   |   |   | lae:combine-text-pages | 
    
    
    | 
|   |   |   | test | $output-format = 'TEXT' | 
| 3 | p:if |  |   |   | 
|   |   |   | lae:combine-alto-pages | 
    
    
    | 
|   |   |   | test | $output-format = 'ALTO' | 
| 4 | p:identity |  |   |   | 
| 5 | p:identity |  |   |   | 
| 6 | p:if |  |   |   | 
|   |   |   | lae:tokenize | 
    
    
    | 
|   |   |   | p:if | 
    
     
     
    
    | 
|   |   |   | p:if | 
    
     
     
    
    | 
|   |   |   | test | $enrichment = ('ENTITIES', 'MORPHOLOGY') | 
| 7 | p:if |  |   |   | 
|   |   |   | lae:convert-to-tei | 
    
    
    | 
|   |   |   | test | $output-format = 'TEI' | 


#### **lae:tokenize** (tokenizing)
#### Documentation (179)
    
##### Tokenize the text
Apply tokenization on text using morphological and syntactic analysis.
##### Tokenizace textu
Rozdělí vstupní text na tokeny pomocí morfologické a syntaktické analýzy.
#### Options (3)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| output-directory | name = output-directory \| required = true \| as = xs:string |

#### Ports (5)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| input | settings | false |
| input | report-in | false |
| output | **result** | true |
| output | report | false |

### Steps  (0 + 7)
      
#### Documentation (179)
    
##### Tokenize the text
Apply tokenization on text using morphological and syntactic analysis.
##### Tokenizace textu
Rozdělí vstupní text na tokeny pomocí morfologické a syntaktické analýzy.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:insert | report-start |   |   | 
|   |   |   | position | last-child | 
|   |   |   | pipe | report-in@tokenizing | 
| 4 | p:viewport |  |   |   | 
|   |   |   | pipe | source@tokenizing | 
|   |   |   | laud:get-udpipe-tokens | 
    
    
    | 
|   |   |   | match | lad:document | 
|   |   |   | p:variable |  | 
| 5 | p:namespace-delete |  |   |   | 
|   |   |   | prefixes | laud xs xhtml | 
| 6 | p:identity | final |   |   | 
| 7 | p:add-attribute | report-final |   |   | 
|   |   |   | attribute-name | end | 
|   |   |   | attribute-value | {current-dateTime()} | 
|   |   |   | match | lax:step[@type='lae:tokenize'][not(@end)] | 
|   |   |   | pipe | result@report-start | 


#### **lae:enrich-by-entities** (enriching-by-entities)
#### Documentation (144)
    
##### Enrich by entities
Enriches available (textual) data by named entities.
##### Obohacení o entity
Obohatí dostupná (textová) data o pojmenované entity.
#### Options (3)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| output-directory | name = output-directory \| required = true \| as = xs:string |

#### Ports (5)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| input | settings | false |
| input | report-in | false |
| output | **result** | true |
| output | report | false |

### Steps  (0 + 7)
      
#### Documentation (144)
    
##### Enrich by entities
Enriches available (textual) data by named entities.
##### Obohacení o entity
Obohatí dostupná (textová) data o pojmenované entity.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:insert | report-start |   |   | 
|   |   |   | position | last-child | 
|   |   |   | pipe | report-in@enriching-by-entities | 
| 4 | p:viewport |  |   |   | 
|   |   |   | pipe | source@enriching-by-entities | 
|   |   |   | lant:get-nametag-analyses | 
    
    
    | 
|   |   |   | match | lad:document | 
|   |   |   | p:variable |  | 
| 5 | p:namespace-delete |  |   |   | 
|   |   |   | prefixes | lant xs xhtml | 
| 6 | p:identity | final |   |   | 
| 7 | p:add-attribute | report-final |   |   | 
|   |   |   | attribute-name | end | 
|   |   |   | attribute-value | {current-dateTime()} | 
|   |   |   | match | lax:step[@type='lae:enrich-by-entities'][not(@end)] | 
|   |   |   | pipe | result@report-start | 


#### **lae:enrich-by-morphology** (enriching-by-morphology)
#### Documentation (186)
    
##### Enrich by morphology
Enriches available (textual) data by morphological and syntactic analysis.
##### Obohacení o entity
Obohatí dostupná (textová) data o morfologickou a syntaktickou analýzu.
#### Options (3)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| output-directory | name = output-directory \| required = true \| as = xs:string |

#### Ports (5)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| input | settings | false |
| input | report-in | false |
| output | **result** | true |
| output | report | false |

### Steps  (0 + 7)
      
#### Documentation (186)
    
##### Enrich by morphology
Enriches available (textual) data by morphological and syntactic analysis.
##### Obohacení o entity
Obohatí dostupná (textová) data o morfologickou a syntaktickou analýzu.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:insert | report-start |   |   | 
|   |   |   | position | last-child | 
|   |   |   | pipe | report-in@enriching-by-morphology | 
| 4 | p:viewport |  |   |   | 
|   |   |   | pipe | source@enriching-by-morphology | 
|   |   |   | laud:get-udpipe-analyses | 
    
    
    | 
|   |   |   | match | lad:document | 
|   |   |   | p:variable |  | 
| 5 | p:namespace-delete |  |   |   | 
|   |   |   | prefixes | laud xs xhtml | 
| 6 | p:identity | final |   |   | 
| 7 | p:add-attribute | report-final |   |   | 
|   |   |   | attribute-name | end | 
|   |   |   | attribute-value | {current-dateTime()} | 
|   |   |   | match | lax:step[@type='lae:enrich-by-morphology'][not(@end)] | 
|   |   |   | pipe | result@report-start | 


#### **lae:convert-to-tei** (converting-to-tei)
#### Documentation (156)
    
##### Convert to TEI
Converts available (enriched textual) data to TEI P5 format.
##### Konverze do TEI
Zkonvertuje dostupná (obohacená textová) data do formátu TEI P5.
#### Options (3)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| output-directory | name = output-directory \| required = true \| as = xs:string |

#### Ports (5)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| input | settings | false |
| input | report-in | false |
| output | **result** | true |
| output | report | false |

### Steps  (0 + 9)
      
#### Documentation (156)
    
##### Convert to TEI
Converts available (enriched textual) data to TEI P5 format.
##### Konverze do TEI
Zkonvertuje dostupná (obohacená textová) data do formátu TEI P5.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:variable | step-name |   |   | 
|   |   |   | select | 'lat:convert-to-tei' | 
| 4 | p:insert | report-start |   |   | 
|   |   |   | position | last-child | 
|   |   |   | pipe | report-in@converting-to-tei | 
| 5 | p:viewport |  |   |   | 
|   |   |   | pipe | source@converting-to-tei | 
|   |   |   | lat:convert-to-tei | 
    
    | 
|   |   |   | match | lad:document | 
|   |   |   | p:variable |  | 
| 6 | p:namespace-delete |  |   |   | 
|   |   |   | prefixes | lat xs xhtml | 
| 7 | p:identity | final |   |   | 
| 8 | p:variable | step-name |   |   | 
|   |   |   | select | 'lat:convert-to-tei' | 
| 9 | p:add-attribute | report-final |   |   | 
|   |   |   | attribute-name | end | 
|   |   |   | attribute-value | {current-dateTime()} | 
|   |   |   | match | lax:step[@type='lat:convert-to-tei'][not(@end)] | 
|   |   |   | pipe | result@report-start | 


#### **lae:combine-text-pages** (combining-text-pages)
#### Documentation (140)
    
##### Combine text pages
Combines available pages to one document.
##### Sloučení textových stránek
Sloučí text dostupných stránek do jednoho dokumentu.
#### Options (3)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| output-directory | name = output-directory \| required = true \| as = xs:string |

#### Ports (5)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| input | settings | false |
| input | report-in | false |
| output | **result** | true |
| output | report | false |

### Steps  (0 + 7)
      
#### Documentation (140)
    
##### Combine text pages
Combines available pages to one document.
##### Sloučení textových stránek
Sloučí text dostupných stránek do jednoho dokumentu.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:insert | report-start |   |   | 
|   |   |   | position | last-child | 
|   |   |   | pipe | report-in@combining-text-pages | 
| 4 | p:viewport |  |   |   | 
|   |   |   | pipe | source@combining-text-pages | 
|   |   |   | latx:combine-text-pages | 
    
    | 
|   |   |   | match | lad:document | 
|   |   |   | p:variable |  | 
| 5 | p:namespace-delete |  |   |   | 
|   |   |   | prefixes | lat xs xhtml | 
| 6 | p:identity | final |   |   | 
| 7 | p:add-attribute | report-final |   |   | 
|   |   |   | attribute-name | end | 
|   |   |   | attribute-value | {current-dateTime()} | 
|   |   |   | match | lax:step[@type='lae:enrich-by-entities'][not(@end)] | 
|   |   |   | pipe | result@report-start | 


#### **lae:combine-alto-pages** (combining-alto-pages)
#### Documentation (156)
    
##### Combine pages in ALTO format
Combines available pages to one document.
##### Sloučení stránek ve formátu ALTO
Sloučí text dostupných stránek do jednoho dokumentu.
#### Options (3)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| output-directory | name = output-directory \| required = true \| as = xs:string |

#### Ports (5)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| input | settings | false |
| input | report-in | false |
| output | **result** | true |
| output | report | false |

### Steps  (0 + 7)
      
#### Documentation (156)
    
##### Combine pages in ALTO format
Combines available pages to one document.
##### Sloučení stránek ve formátu ALTO
Sloučí text dostupných stránek do jednoho dokumentu.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:insert | report-start |   |   | 
|   |   |   | position | last-child | 
|   |   |   | pipe | report-in@combining-alto-pages | 
| 4 | p:viewport |  |   |   | 
|   |   |   | pipe | source@combining-alto-pages | 
|   |   |   | laa:combine-alto-pages | 
    
    | 
|   |   |   | match | lad:document | 
|   |   |   | p:variable |  | 
| 5 | p:namespace-delete |  |   |   | 
|   |   |   | prefixes | lat xs xhtml | 
| 6 | p:identity | final |   |   | 
| 7 | p:add-attribute | report-final |   |   | 
|   |   |   | attribute-name | end | 
|   |   |   | attribute-value | {current-dateTime()} | 
|   |   |   | match | lax:step[@type='laa:combine-alto-pages'][not(@end)] | 
|   |   |   | pipe | result@report-start | 



## kramerius-5.xpl (version: 1.0.0)
#### Documentation (166)
    
##### Kramerius 5
Programming library for communication with the system Kramerius, version 5.
##### Kramerius 5
Programová knihovna pro komunikaci se systémem Kramerius, verze 5.
#### Namespaces (10)
    
| prefix | string |
| --- | --- |
| array | http://www.w3.org/2005/xpath-functions/array |
| lad | https://www.mzk.cz/ns/libri-augmentati/documents/1.0 |
| las | https://www.mzk.cz/ns/libri-augmentati/settings/1.0 |
| lax | https://www.mzk.cz/ns/libri-augmentati/xproc/1.0 |
| map | http://www.w3.org/2005/xpath-functions/map |
| p | http://www.w3.org/ns/xproc |
| xhtml | http://www.w3.org/1999/xhtml |
| xlog | https://www.daliboris.cz/ns/xproc/logging/1.0 |
| xs | http://www.w3.org/2001/XMLSchema |
| xml | http://www.w3.org/XML/1998/namespace |

#### Options (0)
      
| name | properties |
| --- | --- |

### Steps  (7 + 0)
      
#### Documentation (166)
    
##### Kramerius 5
Programming library for communication with the system Kramerius, version 5.
##### Kramerius 5
Programová knihovna pro komunikaci se systémem Kramerius, verze 5.

#### **lax:get-virtual-document-metadata-v5** (getting-virtual-document-metadata)
#### Documentation (495)
    
##### Get virtual document metadata
Gathers all requested metadata about the publication. Creates the content of the virtual document with links to all requested resources.
Enhance input data by adding requested resources on the document and page level.
##### Získání metadat virtuálního dokumentu
Shromáždí všechna požadovaná metadata o publikaci. Vytvoří strukturu virutálního dokumentu s odkazy na všechny požadované zdroje.
Obohatí vstupní data přidáním požadovaných zdrojů na úrovni dokumentu a strany.
#### Options (2)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 16)
      
#### Documentation (495)
    
##### Get virtual document metadata
Gathers all requested metadata about the publication. Creates the content of the virtual document with links to all requested resources.
Enhance input data by adding requested resources on the document and page level.
##### Získání metadat virtuálního dokumentu
Shromáždí všechna požadovaná metadata o publikaci. Vytvoří strukturu virutálního dokumentu s odkazy na všechny požadované zdroje.
Obohatí vstupní data přidáním požadovaných zdrojů na úrovni dokumentu a strany.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:variable | base-url |   |   | 
|   |   |   | select | /lad:document/lad:options/@base-url | 
| 4 | p:variable | id |   |   | 
|   |   |   | select | /lad:document/@id | 
| 5 | p:variable | guid |   |   | 
|   |   |   | select | substring-after(/lad:document/@id, ':') | 
| 6 | p:variable | url |   |   | 
|   |   |   | select | concat($base-url, '/item/', $id, '/children') | 
| 7 | p:insert |  |   |   | 
|   |   |   | match | /lad:document | 
|   |   |   | position | last-child | 
| 8 | p:identity | document-with-resources |   |   | 
| 9 | lax:get-virtual-document-pages |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug-path | {$debug-path} | 
|   |   |   | document-id | {$guid} | 
|   |   |   | url | {$url} | 
| 10 | lax:get-available-formats |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | base-url | {$base-url} | 
|   |   |   | debug-path | {$debug-path} | 
| 11 | lax:get-source-url |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | base-url | {$base-url} | 
|   |   |   | debug-path | {$debug-path} | 
| 12 | p:identity | pages |   |   | 
| 13 | p:if |  |   |   | 
|   |   |   | p:store |  | 
|   |   |   | test | $debug | 
| 14 | p:insert |  |   |   | 
|   |   |   | pipe | result@pages | 
|   |   |   | match | /lad:document | 
|   |   |   | position | last-child | 
|   |   |   | pipe | result@document-with-resources | 
| 15 | p:viewport |  |   |   | 
|   |   |   | match | lad:page | 
|   |   |   | p:add-attribute |  | 
|   |   |   | p:variable |  | 
|   |   |   | p:viewport | 
                
    | 
| 16 | p:if |  |   |   | 
|   |   |   | p:store |  | 
|   |   |   | test | $debug | 


#### **lax:get-virtual-document-data-v5** (getting-virtual-document-data)
#### Documentation (490)
    
##### Get virtual document data
Gathers all requested data about the publication. Downloads the content (files) of the virtual document from external targets.
Saves data to the disk and enhance input data by adding info about local path of the requested resources.
##### Získání dat virtuálního dokumentu
Shromáždí všechna požadovaná data publikace. Stáhne obsah (soubory) virutálního dokumentu z externích odkazů.
Uloží data na disk a obohatí vstupní data přidáním informace o lokálním uložení zdrojů.
#### Options (2)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 3)
      
#### Documentation (490)
    
##### Get virtual document data
Gathers all requested data about the publication. Downloads the content (files) of the virtual document from external targets.
Saves data to the disk and enhance input data by adding info about local path of the requested resources.
##### Získání dat virtuálního dokumentu
Shromáždí všechna požadovaná data publikace. Stáhne obsah (soubory) virutálního dokumentu z externích odkazů.
Uloží data na disk a obohatí vstupní data přidáním informace o lokálním uložení zdrojů.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:insert |  |   |   | 
|   |   |   | position | last-child | 


#### **lax:get-virtual-document-pages**
#### Documentation (331)
    
##### Get virtual document pages
Creates element for each page of the document that contains basic data: identifier, type and (page) number.
Returns element <lad:pages>.
##### Získání stránek virtuálního dokumentu
Pro každou stránku dokumentu vytvoří element se základními údaji: identifikátor, typ a číslo (strany).
Vrací element <lad:pages>.
#### Options (4)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| url | name = url \| as = xs:string |
| document-id | name = document-id \| as = xs:string |

#### Ports (1)
    
| direction | value | primary |
| --- | --- | ---| 
| output | **result** | true |

### Steps  (0 + 5)
      
#### Documentation (331)
    
##### Get virtual document pages
Creates element for each page of the document that contains basic data: identifier, type and (page) number.
Returns element <lad:pages>.
##### Získání stránek virtuálního dokumentu
Pro každou stránku dokumentu vytvoří element se základními údaji: identifikátor, typ a číslo (strany).
Vrací element <lad:pages>.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:http-request |  |   |   | 
|   |   |   | href | {$url} | 
|   |   |   | method | GET | 
| 4 | p:if |  |   |   | 
|   |   |   | p:store |  | 
|   |   |   | test | $debug | 
| 5 | lax:pages-convert-json-to-xml |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug-path | {$debug-path} | 


#### **lax:pages-convert-json-to-xml**
#### Documentation (387)
    
##### Pages: convert JSON to XML
Converts from JSON to XML data about the document page. Creates element for the page with basic data: identifier, type and (page) number.
Returns <lad:page> element.
##### Strany: konverze JSONu na XML
Zkonvertuje údje o stránce z JSONu do XML. Vytvoří element pro stránku dokumentu se základními údaji: identifikátor, typ a číslo (strany).
Vrací element <lad:page>.
#### Options (2)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 4)
      
#### Documentation (387)
    
##### Pages: convert JSON to XML
Converts from JSON to XML data about the document page. Creates element for the page with basic data: identifier, type and (page) number.
Returns <lad:page> element.
##### Strany: konverze JSONu na XML
Zkonvertuje údje o stránce z JSONu do XML. Vytvoří element pro stránku dokumentu se základními údaji: identifikátor, typ a číslo (strany).
Vrací element <lad:page>.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:for-each |  |   |   | 
|   |   |   | select | .?* | 
| 4 | p:wrap-sequence |  |   |   | 
|   |   |   | wrapper | lad:pages | 


#### **lax:get-source-url** (getting-source-url)
#### Documentation (371)
    
##### Get source URL
For a resource associated with a page, builds a URL from the base URL, API version, document identifier, etc.
Creates @url attribute for the <lad:page> element.
##### Sestavení URL zdroje
Pro zdroj přiřazený ke stránce sestaví adresu URL ze základní adresy URL, verze rozhraní API, identifikátoru dokumentu apod.
Vytvoří atribut @url v rámci elementu <lad:page>.
#### Options (3)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| base-url | name = base-url \| as = xs:anyURI |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 4)
      
#### Documentation (371)
    
##### Get source URL
For a resource associated with a page, builds a URL from the base URL, API version, document identifier, etc.
Creates @url attribute for the <lad:page> element.
##### Sestavení URL zdroje
Pro zdroj přiřazený ke stránce sestaví adresu URL ze základní adresy URL, verze rozhraní API, identifikátoru dokumentu apod.
Vytvoří atribut @url v rámci elementu <lad:page>.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:viewport |  |   |   | 
|   |   |   | match | lad:page | 
|   |   |   | p:if | 
    
    | 
|   |   |   | p:if | 
    
    | 
|   |   |   | p:if | 
    
    | 
|   |   |   | p:if | 
    
    | 
|   |   |   | p:if | 
    
    | 
|   |   |   | p:if | 
    
    | 
| 4 | p:viewport |  |   |   | 
|   |   |   | match | lad:page | 
|   |   |   | p:variable |  | 
|   |   |   | p:viewport | 
    
    
    | 


#### **lax:get-available-formats** (getting-available-formats)
#### Documentation (378)
    
##### Get available formats
Selects one page from the middle of the document and checks which resources are available on-line.
For each requested <resource> adds @available attribute.
##### Zjištění dostupných formátů
Pro stránku zprostředka publikace zjistí, které všechny zdroje jsou dostupné on-line.
Pro každý požadovaný zdroj vytvoří atribut @available v rámci elementu <lad:resource>.
#### Options (3)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| base-url | name = base-url \| as = xs:anyURI |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 19)
      
#### Documentation (378)
    
##### Get available formats
Selects one page from the middle of the document and checks which resources are available on-line.
For each requested <resource> adds @available attribute.
##### Zjištění dostupných formátů
Pro stránku zprostředka publikace zjistí, které všechny zdroje jsou dostupné on-line.
Pro každý požadovaný zdroj vytvoří atribut @available v rámci elementu <lad:resource>.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | size |   |   | 
|   |   |   | as | xs:integer | 
|   |   |   | select | count(/lad:pages/lad:page) | 
| 2 | p:variable | page |   |   | 
|   |   |   | select | /lad:pages/lad:page[xs:integer($size div 2)] | 
| 3 | p:variable | url |   |   | 
|   |   |   | select | concat($base-url, '/item/', $page/@id) | 
| 4 | p:variable | alto-url |   |   | 
|   |   |   | select | concat($url, $url-fragments?alto) | 
| 5 | p:variable | text-url |   |   | 
|   |   |   | select | concat($url, $url-fragments?text) | 
| 6 | p:variable | dc-url |   |   | 
|   |   |   | select | concat($url, $url-fragments?dc) | 
| 7 | p:variable | foxml-url |   |   | 
|   |   |   | select | concat($url, $url-fragments?foxml) | 
| 8 | p:variable | mods-url |   |   | 
|   |   |   | select | concat($url, $url-fragments?mods) | 
| 9 | p:variable | image-url |   |   | 
|   |   |   | select | concat($url, $url-fragments?image) | 
| 10 | lax:get-available-format |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug-path | {$debug-path} | 
|   |   |   | format | alto | 
|   |   |   | select | $page | 
|   |   |   | url | {$alto-url} | 
| 11 | lax:get-available-format |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug-path | {$debug-path} | 
|   |   |   | format | text | 
|   |   |   | url | {$text-url} | 
| 12 | lax:get-available-format |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug-path | {$debug-path} | 
|   |   |   | format | dc | 
|   |   |   | url | {$dc-url} | 
| 13 | lax:get-available-format |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug-path | {$debug-path} | 
|   |   |   | format | foxml | 
|   |   |   | url | {$foxml-url} | 
| 14 | lax:get-available-format |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug-path | {$debug-path} | 
|   |   |   | format | mods | 
|   |   |   | url | {$mods-url} | 
| 15 | lax:get-available-format |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug-path | {$debug-path} | 
|   |   |   | format | image | 
|   |   |   | url | {$image-url} | 
| 16 | p:identity | page-with-formats |   |   | 
| 17 | p:variable | page-formats |   |   | 
|   |   |   | select | /* | 
| 18 | p:insert |  |   |   | 
|   |   |   | select | /lad:page/lad:resource | 
|   |   |   | pipe | result@page-with-formats | 
|   |   |   | match | lad:page | 
|   |   |   | position | first-child | 
|   |   |   | pipe | source@getting-available-formats | 
| 19 | p:namespace-delete |  |   |   | 
|   |   |   | prefixes | array | 


#### **lax:get-available-format** (getting-available-format)
#### Documentation (247)
    
##### Get available format
Checks if the resource is available on-line.
Returns <resource> with the @available attribute.
##### Zjištění dostupnosti formátu
Zjistí, zda je požadovaný zdroj dostupný on-line.
Vrací element <lad:resource> s atributem @available.
#### Options (4)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| url | name = url \| as = xs:anyURI \| required = true |
| format | name = format \| as = xs:string \| required = true |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 6)
      
#### Documentation (247)
    
##### Get available format
Checks if the resource is available on-line.
Returns <resource> with the @available attribute.
##### Zjištění dostupnosti formátu
Zjistí, zda je požadovaný zdroj dostupný on-line.
Vrací element <lad:resource> s atributem @available.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:http-request | request |   |   | 
|   |   |   | href | {$url} | 
|   |   |   | parameters | map{'status-only' : true(), 'follow-redirect' : 3 } | 
| 4 | p:variable | available |   |   | 
|   |   |   | pipe | report@request | 
|   |   |   | select | .?status-code = (200, 307, 301) | 
| 5 | p:add-attribute |  |   |   | 
|   |   |   | attribute-name | {$format} | 
|   |   |   | attribute-value | {$available} | 
|   |   |   | pipe | source@getting-available-format | 
| 6 | p:insert |  |   |   | 
|   |   |   | match | lad:page | 
|   |   |   | position | first-child | 



## kramerius-7.xpl (version: 1.0.0)
#### Documentation (166)
    
##### Kramerius 7
Programming library for communication with the Kramerius system, version 7.
##### Kramerius 7
Programová knihovna pro komunikaci se systémem Kramerius, verze 7.
#### Namespaces (10)
    
| prefix | string |
| --- | --- |
| array | http://www.w3.org/2005/xpath-functions/array |
| lad | https://www.mzk.cz/ns/libri-augmentati/documents/1.0 |
| las | https://www.mzk.cz/ns/libri-augmentati/settings/1.0 |
| lax | https://www.mzk.cz/ns/libri-augmentati/xproc/1.0 |
| map | http://www.w3.org/2005/xpath-functions/map |
| p | http://www.w3.org/ns/xproc |
| xhtml | http://www.w3.org/1999/xhtml |
| xlog | https://www.daliboris.cz/ns/xproc/logging/1.0 |
| xs | http://www.w3.org/2001/XMLSchema |
| xml | http://www.w3.org/XML/1998/namespace |

### Steps  (7 + 0)
      
#### Documentation (166)
    
##### Kramerius 7
Programming library for communication with the Kramerius system, version 7.
##### Kramerius 7
Programová knihovna pro komunikaci se systémem Kramerius, verze 7.

#### **lax:get-virtual-document-metadata-v7** (getting-virtual-document-metadata)
#### Documentation (495)
    
##### Get virtual document metadata
Gathers all requested metadata about the publication. Creates the content of the virtual document with links to all requested resources.
Enhance input data by adding requested resources on the document and page level.
##### Získání metadat virtuálního dokumentu
Shromáždí všechna požadovaná metadata o publikaci. Vytvoří strukturu virutálního dokumentu s odkazy na všechny požadované zdroje.
Obohatí vstupní data přidáním požadovaných zdrojů na úrovni dokumentu a strany.
#### Options (2)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 27)
      
#### Documentation (495)
    
##### Get virtual document metadata
Gathers all requested metadata about the publication. Creates the content of the virtual document with links to all requested resources.
Enhance input data by adding requested resources on the document and page level.
##### Získání metadat virtuálního dokumentu
Shromáždí všechna požadovaná metadata o publikaci. Vytvoří strukturu virutálního dokumentu s odkazy na všechny požadované zdroje.
Obohatí vstupní data přidáním požadovaných zdrojů na úrovni dokumentu a strany.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:variable | resources |   |   | 
|   |   |   | select | /lad:document/las:api/las:resource | 
| 4 | p:variable | library |   |   | 
|   |   |   | select | /lad:document/las:library | 
| 5 | p:variable | base-url |   |   | 
|   |   |   | select | /lad:document/lad:options/@base-url | 
| 6 | p:variable | id |   |   | 
|   |   |   | select | replace(/lad:document/@id, ':', '%3A') | 
| 7 | p:variable | guid |   |   | 
|   |   |   | select | substring-after(/lad:document/@id, ':') | 
| 8 | p:variable | url |   |   | 
|   |   |   | select | concat($base-url, '/search/api/client/v7.0/search?fl=pid,page.number,page.type&sort=rels_ext_index.sort%20asc&rows=4000&start=0&q=own_parent.pid:', '%22', $id, '%22') | 
| 9 | p:variable | mods-url |   |   | 
|   |   |   | select | $resources[@type='MODS']/@url ! replace(., '\{pid\}', $id) | 
| 10 | p:variable | dc-url |   |   | 
|   |   |   | select | $resources[@type='DC']/@url ! replace(., '\{pid\}', $id) | 
| 11 | p:variable | foxml-url |   |   | 
|   |   |   | select | $resources[@type='FOXML']/@url ! replace(., '\{pid\}', $id) | 
| 12 | p:insert |  |   |   | 
|   |   |   | match | /lad:document | 
|   |   |   | position | last-child | 
| 13 | p:if |  |   |   | 
|   |   |   | p:store |  | 
|   |   |   | test | $debug | 
| 14 | p:identity | document-with-resources |   |   | 
| 15 | lax:get-virtual-document-pages-v7 |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug-path | {$debug-path} | 
|   |   |   | document-id | {$guid} | 
|   |   |   | library-code | {$library/@code} | 
|   |   |   | url | {$url} | 
| 16 | p:if |  |   |   | 
|   |   |   | p:store |  | 
|   |   |   | test | $debug | 
| 17 | p:identity | virutal-pages |   |   | 
| 18 | p:insert |  |   |   | 
|   |   |   | pipe | result@virutal-pages | 
|   |   |   | match | lad:document | 
|   |   |   | position | last-child | 
|   |   |   | pipe | result@document-with-resources | 
| 19 | p:if |  |   |   | 
|   |   |   | p:store |  | 
|   |   |   | test | $debug | 
| 20 | lax:get-available-formats-v7 |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | base-url | {$base-url} | 
|   |   |   | debug-path | {$debug-path} | 
| 21 | p:if |  |   |   | 
|   |   |   | p:store |  | 
|   |   |   | test | $debug | 
| 22 | lax:get-source-url-v7 |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug-path | {$debug-path} | 
| 23 | p:namespace-delete |  |   |   | 
|   |   |   | prefixes | lax xlog array xs map xhtml | 
| 24 | p:if |  |   |   | 
|   |   |   | p:store |  | 
|   |   |   | test | $debug | 
| 25 | p:viewport |  |   |   | 
|   |   |   | match | lad:page | 
|   |   |   | p:add-attribute |  | 
|   |   |   | p:variable |  | 
|   |   |   | p:viewport | 
                        
         | 
| 26 | p:if |  |   |   | 
|   |   |   | p:store |  | 
|   |   |   | test | $debug | 
| 27 | p:insert |  |   |   | 
|   |   |   | select | /lad:pages | 
|   |   |   | pipe | result@pages | 
|   |   |   | match | /lad:document | 
|   |   |   | position | last-child | 
|   |   |   | pipe | result@document-with-resources | 
|   |   |   | use-when | false() | 


#### **lax:get-virtual-document-data-v7** (getting-virtual-document-data)
#### Documentation (490)
    
##### Get virtual document data
Gathers all requested data about the publication. Downloads the content (files) of the virtual document from external targets.
Saves data to the disk and enhance input data by adding info about local path of the requested resources.
##### Získání dat virtuálního dokumentu
Shromáždí všechna požadovaná data publikace. Stáhne obsah (soubory) virutálního dokumentu z externích odkazů.
Uloží data na disk a obohatí vstupní data přidáním informace o lokálním uložení zdrojů.
#### Options (2)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 6)
      
#### Documentation (490)
    
##### Get virtual document data
Gathers all requested data about the publication. Downloads the content (files) of the virtual document from external targets.
Saves data to the disk and enhance input data by adding info about local path of the requested resources.
##### Získání dat virtuálního dokumentu
Shromáždí všechna požadovaná data publikace. Stáhne obsah (soubory) virutálního dokumentu z externích odkazů.
Uloží data na disk a obohatí vstupní data přidáním informace o lokálním uložení zdrojů.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:variable | base-url |   |   | 
|   |   |   | select | /lad:document/lad:options/@base-url | 
| 4 | p:variable | id |   |   | 
|   |   |   | select | /lad:document/@id | 
| 5 | p:variable | guid |   |   | 
|   |   |   | select | substring-after(/lad:document/@id, ':') | 
| 6 | p:variable | url |   |   | 
|   |   |   | select | concat($base-url, '/item/', $id, '/children') | 


#### **lax:get-virtual-document-pages-v7**
#### Documentation (331)
    
##### Get virtual document pages
Creates element for each page of the document that contains basic data: identifier, type and (page) number.
Returns element <lad:pages>.
##### Získání stránek virtuálního dokumentu
Pro každou stránku dokumentu vytvoří element se základními údaji: identifikátor, typ a číslo (strany).
Vrací element <lad:pages>.
#### Options (5)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| url | name = url \| as = xs:string \| required = true |
| document-id | name = document-id \| as = xs:string \| required = true |
| library-code | name = library-code \| as = xs:string \| required = true |

#### Ports (1)
    
| direction | value | primary |
| --- | --- | ---| 
| output | **result** | true |

### Steps  (0 + 3)
      
#### Documentation (331)
    
##### Get virtual document pages
Creates element for each page of the document that contains basic data: identifier, type and (page) number.
Returns element <lad:pages>.
##### Získání stránek virtuálního dokumentu
Pro každou stránku dokumentu vytvoří element se základními údaji: identifikátor, typ a číslo (strany).
Vrací element <lad:pages>.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:try |  |   |   | 
|   |   |   | p:catch | 
            
                
            
               
         | 
|   |   |   | p:group | 
            
                
            
            
            
                
            

            

         | 


#### **lax:pages-convert-json-to-xml-v7**
#### Documentation (387)
    
##### Pages: convert JSON to XML
Converts from JSON to XML data about the document page. Creates element for the page with basic data: identifier, type and (page) number.
Returns <lad:page> element.
##### Strany: konverze JSONu na XML
Zkonvertuje údje o stránce z JSONu do XML. Vytvoří element pro stránku dokumentu se základními údaji: identifikátor, typ a číslo (strany).
Vrací element <lad:page>.
#### Options (2)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 4)
      
#### Documentation (387)
    
##### Pages: convert JSON to XML
Converts from JSON to XML data about the document page. Creates element for the page with basic data: identifier, type and (page) number.
Returns <lad:page> element.
##### Strany: konverze JSONu na XML
Zkonvertuje údje o stránce z JSONu do XML. Vytvoří element pro stránku dokumentu se základními údaji: identifikátor, typ a číslo (strany).
Vrací element <lad:page>.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:for-each |  |   |   | 
|   |   |   | select | .?response?docs?* | 
| 4 | p:wrap-sequence |  |   |   | 
|   |   |   | wrapper | lad:pages | 


#### **lax:get-source-url-v7**
#### Documentation (371)
    
##### Get source URL
For a resource associated with a page, builds a URL from the base URL, API version, document identifier, etc.
Creates @url attribute for the <lad:page> element.
##### Sestavení URL zdroje
Pro zdroj přiřazený ke stránce sestaví adresu URL ze základní adresy URL, verze rozhraní API, identifikátoru dokumentu apod.
Vytvoří atribut @url v rámci elementu <lad:page>.
#### Options (2)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 5)
      
#### Documentation (371)
    
##### Get source URL
For a resource associated with a page, builds a URL from the base URL, API version, document identifier, etc.
Creates @url attribute for the <lad:page> element.
##### Sestavení URL zdroje
Pro zdroj přiřazený ke stránce sestaví adresu URL ze základní adresy URL, verze rozhraní API, identifikátoru dokumentu apod.
Vytvoří atribut @url v rámci elementu <lad:page>.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:variable | options |   |   | 
|   |   |   | select | /lad:document/lad:options | 
| 4 | p:variable | resources |   |   | 
|   |   |   | select | /lad:document/las:api/las:resource | 
| 5 | p:viewport |  |   |   | 
|   |   |   | match | lad:page | 
|   |   |   | p:variable |  | 
|   |   |   | p:variable |  | 
|   |   |   | p:viewport | 
             
             
             
             
             
          | 


#### **lax:get-available-formats-v7** (getting-available-formats)
#### Documentation (378)
    
##### Get available formats
Selects one page from the middle of the document and checks which resources are available on-line.
For each requested <resource> adds @available attribute.
##### Zjištění dostupných formátů
Pro stránku zprostředka publikace zjistí, které všechny zdroje jsou dostupné on-line.
Pro každý požadovaný zdroj vytvoří atribut @available v rámci elementu <lad:resource>.
#### Options (3)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| base-url | name = base-url \| as = xs:anyURI |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 7)
      
#### Documentation (378)
    
##### Get available formats
Selects one page from the middle of the document and checks which resources are available on-line.
For each requested <resource> adds @available attribute.
##### Zjištění dostupných formátů
Pro stránku zprostředka publikace zjistí, které všechny zdroje jsou dostupné on-line.
Pro každý požadovaný zdroj vytvoří atribut @available v rámci elementu <lad:resource>.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | size |   |   | 
|   |   |   | as | xs:integer | 
|   |   |   | select | count(/lad:document/lad:pages/lad:page) | 
| 2 | p:variable | page |   |   | 
|   |   |   | select | /lad:document/lad:pages/lad:page[xs:integer($size div 2)] | 
| 3 | p:variable | options |   |   | 
|   |   |   | select | /lad:document/lad:options | 
| 4 | p:variable | resources |   |   | 
|   |   |   | select | /lad:document/las:api/las:resource[tokenize(@level) = 'page'][@type=tokenize($options/@page-resources)] | 
| 5 | p:for-each |  |   |   | 
|   |   |   | select | $resources | 
| 6 | p:insert |  |   |   | 
|   |   |   | pipe | result@available-resources | 
|   |   |   | match | lad:page | 
|   |   |   | position | first-child | 
|   |   |   | pipe | source@getting-available-formats | 
| 7 | p:namespace-delete |  |   |   | 
|   |   |   | prefixes | array | 


#### **lax:get-available-format-v7** (getting-available-format)
#### Documentation (247)
    
##### Get available format
Checks if the resource is available on-line.
Returns <resource> with the @available attribute.
##### Zjištění dostupnosti formátu
Zjistí, zda je požadovaný zdroj dostupný on-line.
Vrací element <lad:resource> s atributem @available.
#### Options (4)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| url | name = url \| as = xs:anyURI \| required = true |
| format | name = format \| as = xs:string \| required = true |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 7)
      
#### Documentation (247)
    
##### Get available format
Checks if the resource is available on-line.
Returns <resource> with the @available attribute.
##### Zjištění dostupnosti formátu
Zjistí, zda je požadovaný zdroj dostupný on-line.
Vrací element <lad:resource> s atributem @available.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:http-request | request |   |   | 
|   |   |   | assert | .?status-code lt 500 | 
|   |   |   | href | {$url} | 
|   |   |   | parameters | map{'status-only' : true(), 'follow-redirect' : 3 } | 
| 4 | p:variable | available |   |   | 
|   |   |   | pipe | report@request | 
|   |   |   | select | .?status-code = (200, 307, 301) | 
| 5 | p:add-attribute |  |   |   | 
|   |   |   | attribute-name | {$format} | 
|   |   |   | attribute-value | {$available} | 
|   |   |   | pipe | source@getting-available-format | 
| 6 | p:insert |  |   |   | 
|   |   |   | match | lad:page | 
|   |   |   | position | first-child | 
|   |   |   | use-when | false() | 
| 7 | p:identity |  |   |   | 



## libri-augmentati.xpl (version: 1.0.0)
#### Documentation (199)
    
##### Libri augmentati
The main programming library for digital library data retrieval and enrichment.
##### Libri augmentati
Hlavní programová knihovna pro získání dat z digitálních knihoven a jejich obohacení.
#### Namespaces (19)
    
| prefix | string |
| --- | --- |
| array | http://www.w3.org/2005/xpath-functions/array |
| c | http://www.w3.org/ns/xproc-step |
| err | http://www.w3.org/ns/xproc-error |
| laa | https://www.mzk.cz/ns/libri-augmentati/alto/1.0 |
| lac | https://www.mzk.cz/ns/libri-augmentati/conversion/1.0 |
| lad | https://www.mzk.cz/ns/libri-augmentati/documents/1.0 |
| lae | https://www.mzk.cz/ns/libri-augmentati/enrichment/1.0 |
| lap | https://www.mzk.cz/ns/libri-augmentati/processing/1.0 |
| lar | https://www.mzk.cz/ns/libri-augmentati/report/1.0 |
| las | https://www.mzk.cz/ns/libri-augmentati/settings/1.0 |
| lax | https://www.mzk.cz/ns/libri-augmentati/xproc/1.0 |
| map | http://www.w3.org/2005/xpath-functions/map |
| mods | http://www.loc.gov/mods/v3 |
| mox | http://www.xml-project.com/morganaxproc |
| p | http://www.w3.org/ns/xproc |
| xhtml | http://www.w3.org/1999/xhtml |
| xlog | https://www.daliboris.cz/ns/xproc/logging/1.0 |
| xs | http://www.w3.org/2001/XMLSchema |
| xml | http://www.w3.org/XML/1998/namespace |

#### Imports (0)
    

#### Options (0)
      
| name | properties |
| --- | --- |

### Steps  (11 + 0)
      
#### Documentation (199)
    
##### Libri augmentati
The main programming library for digital library data retrieval and enrichment.
##### Libri augmentati
Hlavní programová knihovna pro získání dat z digitálních knihoven a jejich obohacení.

#### **lax:build-virtual-document** (building-virtual-document)
#### Documentation (321)
    
##### Build virtual document
Gathers all requested metadata about the publication. Creates the content of the virtual document with links to all requested resources.
##### Sestavení virtuálního dokumentu
Shromáždí všechna požadovaná metadata o publikaci. Vytvoří strukturu virutálního dokumentu s odkazy na všechny požadované zdroje.
#### Options (7)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| library-code | name = library-code \| as = xs:string \| required = true |
| api-version | name = api-version \| as = xs:string? |
| system | name = system \| as = xs:string? \| values = ('Kramerius', 'Polona') \| required = false |
| document-resources | name = document-resources \| as = xs:token* |
| page-resources | name = page-resources \| as = xs:token* |

#### Ports (5)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| input | settings | false |
| input | report-in | false |
| output | **result** | true |
| output | report | false |

### Steps  (0 + 8)
      
#### Documentation (321)
    
##### Build virtual document
Gathers all requested metadata about the publication. Creates the content of the virtual document with links to all requested resources.
##### Sestavení virtuálního dokumentu
Shromáždí všechna požadovaná metadata o publikaci. Vytvoří strukturu virutálního dokumentu s odkazy na všechny požadované zdroje.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:variable | library |   |   | 
|   |   |   | pipe | settings@building-virtual-document | 
|   |   |   | select | /las:digital-libraries/las:libraries/las:library[@code=$library-code] | 
| 4 | p:variable | apis |   |   | 
|   |   |   | pipe | settings@building-virtual-document | 
|   |   |   | select | /las:digital-libraries/las:apis/las:api | 
| 5 | p:variable | api |   |   | 
|   |   |   | select | let $lib-apis := $apis[@xml:id =$library/las:api/@ref/substring-after(., '#')] return if(exists($api-version)) then $lib-apis[@version=$api-version] else $lib-apis[1]  | 
| 6 | p:variable | base-url |   |   | 
|   |   |   | select | $library/las:api[@ref=concat('#', $api/@xml:id)]/@url | 
| 7 | p:identity | options |   |   | 
| 8 | p:for-each |  |   |   | 
|   |   |   | select | /lad:documents/lad:document | 
|   |   |   | pipe | source@building-virtual-document | 


#### **lax:get-virtual-document-metadata** (getting-virtual-document-metadata)
#### Documentation (506)
    
##### Get virtual document metadata
Gathers all requested metadata about the publication. Downloads the content (files) of the virtual document from external targets.
Saves data to the disk and enhance input data by adding info about local path of the requested resources.
##### Získání metadat virtuálního dokumentu
Shromáždí všechna požadovaná metadata publikace. Stáhne obsah (soubory) virutálního dokumentu z externích odkazů.
Uloží data na disk a obohatí vstupní data přidáním informace o lokálním uložení zdrojů.
#### Options (2)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |

#### Ports (4)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| input | report-in | false |
| output | **result** | true |
| output | report | false |

### Steps  (0 + 9)
      
#### Documentation (506)
    
##### Get virtual document metadata
Gathers all requested metadata about the publication. Downloads the content (files) of the virtual document from external targets.
Saves data to the disk and enhance input data by adding info about local path of the requested resources.
##### Získání metadat virtuálního dokumentu
Shromáždí všechna požadovaná metadata publikace. Stáhne obsah (soubory) virutálního dokumentu z externích odkazů.
Uloží data na disk a obohatí vstupní data přidáním informace o lokálním uložení zdrojů.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:variable | api-version |   |   | 
|   |   |   | select | /lad:document/lad:options/@api-version | 
| 4 | p:variable | system |   |   | 
|   |   |   | select | /lad:document/lad:options/@system | 
| 5 | p:variable | library-code |   |   | 
|   |   |   | select | /lad:document/las:library/@code | 
| 6 | p:variable | library |   |   | 
|   |   |   | select | /lad:document/las:library | 
| 7 | p:choose |  |   |   | 
| 8 | p:namespace-delete |  |   |   | 
|   |   |   | prefixes | c xs map mox array | 
| 9 | p:if |  |   |   | 
|   |   |   | p:store |  | 
|   |   |   | p:variable |  | 
|   |   |   | test | $debug | 


#### **lax:prepare-text-data** (preparing-text-data)
#### Options (4)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| output-directory | name = output-directory \| required = true \| as = xs:string |
| pause-before-request | name = pause-before-request \| select = 2 \| as = xs:integer |

#### Ports (4)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| input | report-in | false |
| output | **result** | true |
| output | report | false |

### Steps  (0 + 3)
      


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | laa:combine-alto-pages |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug-path | {$debug-path} | 
|   |   |   | output-directory | {$output-directory} | 
|   |   |   | pipe | report-in@preparing-text-data | 


#### **lax:download-document-data** (downloading-document-data)
#### Documentation (511)
    
##### Download document data
Gathers all requested data and metadata about the publication. Downloads the content (files) of the virtual document from external targets.
Saves data to the disk and enhance input data by adding info about local path of the requested resources.
##### Stažení dat virtuálního dokumentu
Shromáždí všechna požadovaná data a metadata publikace. Stáhne obsah (soubory) virutálního dokumentu z externích odkazů.
Uloží data na disk a obohatí vstupní data přidáním informace o lokálním uložení zdrojů.
#### Options (4)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| output-directory | name = output-directory \| required = true \| as = xs:string |
| pause-before-request | name = pause-before-request \| select = 2 \| as = xs:integer |

#### Ports (4)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| input | report-in | false |
| output | **result** | true |
| output | report | false |

### Steps  (0 + 2)
      
#### Documentation (511)
    
##### Download document data
Gathers all requested data and metadata about the publication. Downloads the content (files) of the virtual document from external targets.
Saves data to the disk and enhance input data by adding info about local path of the requested resources.
##### Stažení dat virtuálního dokumentu
Shromáždí všechna požadovaná data a metadata publikace. Stáhne obsah (soubory) virutálního dokumentu z externích odkazů.
Uloží data na disk a obohatí vstupní data přidáním informace o lokálním uložení zdrojů.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:viewport |  |   |   | 
|   |   |   | match | lad:document | 
|   |   |   | p:add-attribute |  | 
|   |   |   | p:variable |  | 
|   |   |   | p:variable |  | 
|   |   |   | p:variable |  | 
|   |   |   | p:variable |  | 
|   |   |   | p:viewport | 
    
    
    
     
    
    | 
|   |   |   | p:viewport | 
    
    
    
    
     
    
    | 
| 2 | p:viewport |  |   |   | 
|   |   |   | match | lad:document | 
|   |   |   | p:if | 
     
    | 
|   |   |   | p:if | 
     
    | 
|   |   |   | p:if | 
     
    | 
|   |   |   | p:variable |  | 
|   |   |   | p:variable |  | 
|   |   |   | p:variable |  | 
|   |   |   | p:variable |  | 
|   |   |   | p:variable |  | 
|   |   |   | p:variable |  | 
|   |   |   | p:variable |  | 


#### **lax:download-document-resources**
#### Documentation (398)
    
##### Download document resources
Downloads the content (files) of the document-related resources from external targets.
Saves data to the disk and enhance input data by adding info about local path of the requested resources.
##### Stažení zdrojů dokumentu
Stáhne obsah (soubory) virutálního dokumentu z externích odkazů.
Uloží data na disk a obohatí vstupní data přidáním informace o lokálním uložení zdrojů.
#### Options (6)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| output-directory | name = output-directory \| required = true \| as = xs:string |
| position | name = position \| required = true |
| type | name = type \| required = true \| as = xs:string |
| pause-before-request | name = pause-before-request \| required = true \| as = xs:integer |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 4)
      
#### Documentation (398)
    
##### Download document resources
Downloads the content (files) of the document-related resources from external targets.
Saves data to the disk and enhance input data by adding info about local path of the requested resources.
##### Stažení zdrojů dokumentu
Stáhne obsah (soubory) virutálního dokumentu z externích odkazů.
Uloží data na disk a obohatí vstupní data přidáním informace o lokálním uložení zdrojů.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:variable | output-directory-uri |   |   | 
|   |   |   | select | resolve-uri($output-directory, $base-uri) | 
| 4 | p:viewport |  |   |   | 
|   |   |   | lax:check-local-file-exists |  | 
|   |   |   | lax:check-local-file-exists | 
    
    | 
|   |   |   | match | lad:resource | 
|   |   |   | p:if | 
    
    | 
|   |   |   | p:set-attributes |  | 
|   |   |   | p:variable |  | 
|   |   |   | p:variable |  | 
|   |   |   | p:variable |  | 
|   |   |   | p:variable |  | 
|   |   |   | p:variable |  | 
|   |   |   | p:variable |  | 
|   |   |   | p:variable |  | 
|   |   |   | p:variable |  | 


#### **lax:check-local-file-exists** (checking-local-file-exists)
#### Documentation (164)
    
##### Check local file exists
Checks if the file is stored on the local computer.
##### Zjištění existence místního souboru
Zjistí, jestli je soubor stažen na místním počítači.
#### Options (2)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 6)
      
#### Documentation (164)
    
##### Check local file exists
Checks if the file is stored on the local computer.
##### Zjištění existence místního souboru
Zjistí, jestli je soubor stažen na místním počítači.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:variable | local-path |   |   | 
|   |   |   | select | /*/@local-uri | 
| 4 | p:file-info |  |   |   | 
|   |   |   | fail-on-error | false | 
|   |   |   | href | {$local-path} | 
| 5 | p:variable | file-exists |   |   | 
|   |   |   | select | exists(/c:file) | 
| 6 | p:add-attribute |  |   |   | 
|   |   |   | attribute-name | local-file-exists | 
|   |   |   | attribute-value | {$file-exists} | 
|   |   |   | pipe | source@checking-local-file-exists | 


#### **lax:download-document-data-items**
#### Documentation (147)
    
##### Download document data items
Downloads all data of the virtual document.
##### Stáhnout všechna data dokumentu
Stáhne všechna data virtuálního dokumentu.
#### Options (5)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| output-directory | name = output-directory \| required = true |
| type | name = type \| required = true \| as = xs:string |
| pause-before-request | name = pause-before-request \| required = true \| as = xs:integer |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 1)
      
#### Documentation (147)
    
##### Download document data items
Downloads all data of the virtual document.
##### Stáhnout všechna data dokumentu
Stáhne všechna data virtuálního dokumentu.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:for-each |  |   |   | 
|   |   |   | select | . | 


#### **lax:download-document**
#### Documentation (102)
    
##### Download document
Downloads one document from the web.
##### Stáhnout dokument
Stáhne z webu jeden dokument.
#### Options (5)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| url | name = url \| as = xs:anyURI |
| local-path | name = local-path \| as = xs:string |
| pause-before-request | name = pause-before-request \| required = true \| as = xs:integer |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | source | false |
| output | **result** | true |

### Steps  (0 + 3)
      
#### Documentation (102)
    
##### Download document
Downloads one document from the web.
##### Stáhnout dokument
Stáhne z webu jeden dokument.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | content-type |   |   | 
|   |   |   | select | if(ends-with($url, '.txt')) then 'text/plain' else if(ends-with($url, '.djvu')) then 'image/vnd.djvu' else '*/*' | 
| 2 | p:variable | local-path-uri |   |   | 
|   |   |   | select | resolve-uri($local-path, $base-uri) | 
| 3 | p:try |  |   |   | 
|   |   |   | p:catch | 
    
    
     
      File {$url} not downloaded
     
    
    | 
|   |   |   | p:catch | 
    
    
     
      File {$url} not downloaded
     
    
    | 
|   |   |   | p:http-request |  | 
|   |   |   | p:if | 
    
    | 
|   |   |   | p:store |  | 


#### **lax:enrich-document-data** (enriching-document-data)
#### Documentation (208)
    
##### Enrich document data
Enriches available (textual) data of the digital book by available services.
##### Obohacení dat dokumentu
Obohatí dostupná dostupná (textová) data digitální publikací pomocí dostupných služeb.
#### Options (6)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| output-directory | name = output-directory \| required = true \| as = xs:string |
| pause-before-request | name = pause-before-request \| select = 2 \| as = xs:integer |
| output-format | name = output-format \| values = ('ALTO', 'TEXT', 'TEI') \| as = xs:string* |
| enrichment | name = enrichment \| values = ('ENTITIES', 'MORPHOLOGY') \| as = xs:string* |

#### Ports (5)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| input | settings | false |
| input | report-in | false |
| output | **result** | true |
| output | report | false |

### Steps  (0 + 2)
      
#### Documentation (208)
    
##### Enrich document data
Enriches available (textual) data of the digital book by available services.
##### Obohacení dat dokumentu
Obohatí dostupná dostupná (textová) data digitální publikací pomocí dostupných služeb.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:viewport |  |   |   | 
|   |   |   | match | lad:document | 
|   |   |   | p:viewport | 
    
    
     
      
      
      
      
     
    
    | 
|   |   |   | use-when | false() | 
| 2 | lae:enrich-data |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug-path | {$debug-path} | 
|   |   |   | enrichment | $enrichment | 
|   |   |   | output-directory | {$output-directory} | 
|   |   |   | output-format | $output-format | 
|   |   |   | pipe | report-in@enriching-document-data | 
|   |   |   | pipe | settings@enriching-document-data | 


#### **lax:create-report** (creating-report)
#### Documentation (162)
    
##### Create report
Creates report with links to original, downloaded and enriched data.
##### Vytvořit přehled
Vytvoří přehled s odkazy na původní, stažená a obohacená data.
#### Options (3)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| output-directory | name = output-directory \| select = () \| as = xs:string? |

#### Ports (3)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |
| output | result-uri | false |

### Steps  (0 + 5)
      
#### Documentation (162)
    
##### Create report
Creates report with links to original, downloaded and enriched data.
##### Vytvořit přehled
Vytvoří přehled s odkazy na původní, stažená a obohacená data.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:variable | save-output |   |   | 
|   |   |   | select | $output-directory \|\| '' ne '' | 
| 4 | p:variable | output-directory-uri |   |   | 
|   |   |   | select | resolve-uri($output-directory, $base-uri) | 
| 5 | p:for-each |  |   |   | 
|   |   |   | select | /* | 


#### **lax:get-document-id**
#### Documentation (215)
    
##### Get document id
Gets nickname or id of the document (without leading 'uuid:') in plain text.
##### Získat id dokumentu
Získá uživatelské jméno nedo identifikátor dokumentu (bez úvodního 'uuid:') ve formátu prostého textu.
#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | source | false |
| output | **result** | true |

### Steps  (0 + 1)
      
#### Documentation (215)
    
##### Get document id
Gets nickname or id of the document (without leading 'uuid:') in plain text.
##### Získat id dokumentu
Získá uživatelské jméno nedo identifikátor dokumentu (bez úvodního 'uuid:') ve formátu prostého textu.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:identity |  |   |   | 



## nametag.xpl (version: 1.0.0)
#### Documentation (189)
    
##### Library for NameTag data processing
Steps for standalone operations with NameTag service and data.
##### Kihovna pro zpracování dat NameTag
Kroky pro samostatné operace se službou a daty NameTag.
#### Namespaces (8)
    
| prefix | string |
| --- | --- |
| lad | https://www.mzk.cz/ns/libri-augmentati/documents/1.0 |
| lant | https://www.mzk.cz/ns/libri-augmentati/nametag/1.0 |
| las | https://www.mzk.cz/ns/libri-augmentati/settings/1.0 |
| map | http://www.w3.org/2005/xpath-functions/map |
| p | http://www.w3.org/ns/xproc |
| xhtml | http://www.w3.org/1999/xhtml |
| xs | http://www.w3.org/2001/XMLSchema |
| xml | http://www.w3.org/XML/1998/namespace |

### Steps  (3 + 0)
      
#### Documentation (189)
    
##### Library for NameTag data processing
Steps for standalone operations with NameTag service and data.
##### Kihovna pro zpracování dat NameTag
Kroky pro samostatné operace se službou a daty NameTag.

#### **lant:get-nametag-analysis** (getting-nametag-analysis)
#### Documentation (264)
    
##### Get NameTag analysis
It calls the REST API of the NameTag service, passes it the text to recognize, and returns the result in JSON format.
##### Analýza textu NameTagem
Zavolá rozhraní REST API služby NameTag, předá jí text k rozpoznání a vrátí výsledek ve formátu JSON.
#### Options (4)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| file-stem | name = file-stem \| as = xs:string? |
| language | name = language \| as = xs:string? \| select = 'cze' |

#### Ports (5)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| input | settings | false |
| input | report-in | false |
| output | **result** | true |
| output | report | false |

### Steps  (0 + 16)
      
#### Documentation (264)
    
##### Get NameTag analysis
It calls the REST API of the NameTag service, passes it the text to recognize, and returns the result in JSON format.
##### Analýza textu NameTagem
Zavolá rozhraní REST API služby NameTag, předá jí text k rozpoznání a vrátí výsledek ve formátu JSON.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:variable | language-models |   |   | 
|   |   |   | select | map {    'cze': 'czech',    'ces': 'czech',    'dut': 'dutch',    'nld': 'dutch',    'eng': 'english',    'deu': 'german',    'ger': 'german',    'spa': 'spanish',    'multi' : 'multilingual'    } | 
| 4 | p:variable | language-model |   |   | 
|   |   |   | select | if(map:contains($language-models, $language))      then $language-models?($language)      else $language-models?multi | 
| 5 | p:variable | service |   |   | 
|   |   |   | pipe | settings@getting-nametag-analysis | 
|   |   |   | select | //las:service[@code='nametag'] | 
| 6 | p:variable | service-url |   |   | 
|   |   |   | p:documentation | 
    
     URL of the REST service.
    
    
     URL RESTové služby.
    
    | 
|   |   |   | select | $service/las:api/@url | 
| 7 | p:variable | api-id |   |   | 
|   |   |   | p:documentation | 
    
     Identifier of the REST service.
    
    
     Identifikátor RESTové služby.
    
    | 
|   |   |   | select | substring-after($service/las:api/@ref, '#') | 
| 8 | p:variable | feature |   |   | 
|   |   |   | pipe | settings@getting-nametag-analysis | 
|   |   |   | select | //las:api[@xml:id=$api-id]/las:feature[@type='entities'][@method='post'] | 
| 9 | p:variable | step-url |   |   | 
|   |   |   | select | concat($service-url, $feature/@url) | 
| 10 | p:variable | step-params |   |   | 
|   |   |   | select | string-join($feature/las:param[@place='body'][not(@name =('data','model'))]//concat(@name, '=', @value), '&')  | 
| 11 | p:variable | step-params |   |   | 
|   |   |   | select | $step-params \|\| '&model=' \|\| $language-model | 
| 12 | p:variable | full-text |   |   | 
|   |   |   | select | . | 
| 13 | p:if |  |   |   | 
|   |   |   | p:store | 
    
    | 
|   |   |   | test | $debug | 
| 14 | p:http-request |  |   |   | 
|   |   |   | href | {$step-url} | 
|   |   |   | method | 'POST' | 
|   |   |   | p:documentation | 
    
     Calling the NameTag service API using the POST method. The input parameter to the service is plain text, encoded for the URI.
    
    
     Volání API služby NameTag pomocí metodyPOST. Jako vstupní parametr služby se předává prostý text, kódovaný pro URI.
    
    | 
| 15 | p:identity | final |   |   | 
| 16 | p:if |  |   |   | 
|   |   |   | p:store |  | 
|   |   |   | test | $debug | 


#### **lant:convert-nametag-analysis-to-xml**
#### Documentation (196)
    
##### Convert NameTag analysis to XML
Converts the analysis output in JSON format to an XML document.
##### Konverze analýzy NameTagem do XML
Převede výstup analýzy ve formátu JSON na dokument ve formátu XML.
#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 5)
      
#### Documentation (196)
    
##### Convert NameTag analysis to XML
Converts the analysis output in JSON format to an XML document.
##### Konverze analýzy NameTagem do XML
Převede výstup analýzy ve formátu JSON na dokument ve formátu XML.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | model |   |   | 
|   |   |   | select | normalize-space(.?model) | 
| 2 | p:cast-content-type |  |   |   | 
|   |   |   | content-type | application/xml | 
|   |   |   | select | .?result | 
| 3 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/nametag/nametag-json-to-xml-text.xsl | 
|   |   |   | version | 3.0 | 
| 4 | p:cast-content-type |  |   |   | 
|   |   |   | content-type | application/xml | 
| 5 | p:choose |  |   |   | 


#### **lant:get-nametag-analyses** (getting-nametag-analyses)
#### Documentation (375)
    
##### Get NameTag analyses
For each page of the virtual document, it gets its text, sends it to the REST interface of the NameTag service, converts the result to XML format and stores it in a folder.
##### Analýzy textu NameTagem
Pro každou stránku virtuálního dokumentu získá její text, odešle ho na RESTové rozhraní služby NameTag, výsledek konvertuje do formátu XML a uloží do složky.
#### Options (3)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| output-directory | name = output-directory \| required = true \| as = xs:string |

#### Ports (5)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| input | settings | false |
| input | report-in | false |
| output | **result** | true |
| output | report | false |

### Steps  (0 + 11)
      
#### Documentation (375)
    
##### Get NameTag analyses
For each page of the virtual document, it gets its text, sends it to the REST interface of the NameTag service, converts the result to XML format and stores it in a folder.
##### Analýzy textu NameTagem
Pro každou stránku virtuálního dokumentu získá její text, odešle ho na RESTové rozhraní služby NameTag, výsledek konvertuje do formátu XML a uloží do složky.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:variable | result-directory-path |   |   | 
|   |   |   | p:documentation | 
    
     The folder where downloaded documents are saved. The path to the folder can be absolute or relative.
    
    
     Složka, do níž se uloží stažené dokumenty. Cesta ke složce může být absolutní i relativní.
    
    | 
|   |   |   | select | concat($output-directory, '/nametag') | 
| 4 | p:variable | result-directory-uri |   |   | 
|   |   |   | select | resolve-uri($result-directory-path, $base-uri) | 
| 5 | p:variable | language |   |   | 
|   |   |   | select | /lad:document/@language | 
| 6 | p:if |  |   |   | 
|   |   |   | p:store | 
    
    | 
|   |   |   | test | $debug | 
| 7 | p:viewport |  |   |   | 
|   |   |   | match | lad:pages/lad:page/lad:resource[@type='udpipe'][@local-file-exists='true'] | 
|   |   |   | p:if | 
     
     
     
     
     
    
     
     
     
      
       
      
     
     
     
     
     
     
      
      
     
     
     
      
     
     
     
     
     
      
     
     
     
      
          
    
    
    
     
      
     
    
    
    
    
     
    
    
     | 
|   |   |   | p:variable |  | 
|   |   |   | use-when | true() | 
| 8 | p:identity | final |   |   | 
| 9 | p:if |  |   |   | 
|   |   |   | p:store |  | 
|   |   |   | test | $debug | 
| 10 | p:identity | metadata |   |   | 
| 11 | p:insert | final-report |   |   | 
|   |   |   | pipe | @metadata | 
|   |   |   | match | lant:report/lant:result | 
|   |   |   | position | last-child | 
|   |   |   | pipe | source@getting-nametag-analyses | 



## tei.xpl (version: 1.0.0)
#### Documentation (161)
    
##### Library for TEI data processing
Steps for standalone operations with TEI data.
##### Kihovna pro zpracování dat TEI
Kroky pro samostatné operace s daty ve formátu TEI.
#### Namespaces (7)
    
| prefix | string |
| --- | --- |
| lad | https://www.mzk.cz/ns/libri-augmentati/documents/1.0 |
| lat | https://www.mzk.cz/ns/libri-augmentati/tei/1.0 |
| p | http://www.w3.org/ns/xproc |
| tei | http://www.tei-c.org/ns/1.0 |
| xhtml | http://www.w3.org/1999/xhtml |
| xs | http://www.w3.org/2001/XMLSchema |
| xml | http://www.w3.org/XML/1998/namespace |

### Steps  (6 + 0)
      
#### Documentation (161)
    
##### Library for TEI data processing
Steps for standalone operations with TEI data.
##### Kihovna pro zpracování dat TEI
Kroky pro samostatné operace s daty ve formátu TEI.

#### **lat:convert-alto-to-tei** (converting-alto-to-tei)
#### Documentation (148)
    
##### Convert ALTO to TEI
Converts one document in ALTO format to TEI P5.
##### Konverze ALTO na TEI
Konvertuje jeden dokument ve formátu ALTO na formát TEI P5.
#### Options (3)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| page-number | name = page-number \| as = xs:string? |

#### Ports (4)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| input | report-in | false |
| output | **result** | true |
| output | report | false |

### Steps  (0 + 5)
      
#### Documentation (148)
    
##### Convert ALTO to TEI
Converts one document in ALTO format to TEI P5.
##### Konverze ALTO na TEI
Konvertuje jeden dokument ve formátu ALTO na formát TEI P5.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:xslt |  |   |   | 
|   |   |   | parameters | map {'page-number' : $page-number } | 
|   |   |   | href | ../xslt/conversion/alto2tei.xsl | 
| 4 | p:identity | final |   |   | 
| 5 | p:identity | final-report |   |   | 
|   |   |   | pipe | report-in@converting-alto-to-tei | 


#### **lat:convert-nametag-to-tei** (converting-nametag-to-tei)
#### Documentation (176)
    
##### Convert NameTag XML to TEI
Converts one document in NameTag XML format to TEI P5.
##### Konverze NameTag XML na TEI
Konvertuje jeden dokument ve formátu NameTag XML na formát TEI P5.
#### Options (3)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| page-number | name = page-number \| as = xs:string? |

#### Ports (4)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| input | report-in | false |
| output | **result** | true |
| output | report | false |

### Steps  (0 + 5)
      
#### Documentation (176)
    
##### Convert NameTag XML to TEI
Converts one document in NameTag XML format to TEI P5.
##### Konverze NameTag XML na TEI
Konvertuje jeden dokument ve formátu NameTag XML na formát TEI P5.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:xslt |  |   |   | 
|   |   |   | parameters | map {'page-number' : $page-number } | 
|   |   |   | href | ../xslt/nametag/nametag-xml-to-tei.xsl | 
| 4 | p:identity | final |   |   | 
| 5 | p:identity | final-report |   |   | 
|   |   |   | pipe | report-in@converting-nametag-to-tei | 


#### **lat:convert-udpipe-to-tei** (converting-udpipe-to-tei)
#### Documentation (204)
    
##### :Convert UDPipe to TEI
Converts one page in CoNLLLu format, generated by UDPipe to TEI P5.
##### :Konverze UDPipe na TEI
Převede jednu stranu s daty ve formátu CoNLLLu, který generuje UDPipe, do formátu TEI P5.
#### Options (3)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| page-number | name = page-number \| as = xs:string? |

#### Ports (4)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| input | report-in | false |
| output | **result** | true |
| output | report | false |

### Steps  (0 + 12)
      
#### Documentation (204)
    
##### :Convert UDPipe to TEI
Converts one page in CoNLLLu format, generated by UDPipe to TEI P5.
##### :Konverze UDPipe na TEI
Převede jednu stranu s daty ve formátu CoNLLLu, který generuje UDPipe, do formátu TEI P5.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:variable | udpipe-text |   |   | 
|   |   |   | select | . | 
| 4 | p:if |  |   |   | 
|   |   |   | p:store |  | 
|   |   |   | test | $debug | 
| 5 | p:xslt |  |   |   | 
|   |   |   | parameters | map{'input': $udpipe-text} | 
|   |   |   | href | ../xslt/conversion/conllu-to-xml.xsl | 
| 6 | p:if |  |   |   | 
|   |   |   | p:store |  | 
|   |   |   | test | $debug | 
| 7 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/conversion/conllu-xml-to-hierarchy.xsl | 
| 8 | p:if |  |   |   | 
|   |   |   | p:store |  | 
|   |   |   | test | $debug | 
| 9 | p:xslt |  |   |   | 
|   |   |   | parameters | map {'page-number' : $page-number } | 
|   |   |   | href | ../xslt/conversion/conllu-xml-hierarchy-to-tei.xsl | 
| 10 | p:if |  |   |   | 
|   |   |   | p:store |  | 
|   |   |   | test | $debug | 
| 11 | p:identity | final |   |   | 
| 12 | p:identity | final-report |   |   | 
|   |   |   | pipe | report-in@converting-udpipe-to-tei | 


#### **lat:merge-tei-representations** (merging-tei-representations)
#### Documentation (300)
    
##### Merge TEI representations
Merge different representation of one page in TEI, comming from different sources, like ALTO, NameTag, and UDPipe.
##### Kombinace reprezentace TEI
Zkombinuje různé reprezentace stejné stránky ve formátu TEI, které pocházejí z různých zdrojů, jako např. ALTO, NameTag nebo UDPipe.
#### Options (3)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| file-stem | name = file-stem \| as = xs:string? |

#### Ports (6)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| input | udpipe | false |
| input | alto | false |
| input | report-in | false |
| output | **result** | true |
| output | report | false |

### Steps  (0 + 7)
      
#### Documentation (300)
    
##### Merge TEI representations
Merge different representation of one page in TEI, comming from different sources, like ALTO, NameTag, and UDPipe.
##### Kombinace reprezentace TEI
Zkombinuje různé reprezentace stejné stránky ve formátu TEI, které pocházejí z různých zdrojů, jako např. ALTO, NameTag nebo UDPipe.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:variable | udpipe-root |   |   | 
|   |   |   | pipe | udpipe@merging-tei-representations | 
|   |   |   | select | /* | 
| 4 | p:xslt |  |   |   | 
|   |   |   | parameters | map{'udpipe': $udpipe-root} | 
|   |   |   | href | ../xslt/tei/merge-nametag-with-udpipe.xsl | 
| 5 | p:if |  |   |   | 
|   |   |   | p:store |  | 
|   |   |   | test | $debug | 
| 6 | p:identity | final |   |   | 
| 7 | p:identity | final-report |   |   | 
|   |   |   | pipe | report-in@merging-tei-representations | 


#### **lat:convert-to-tei** (converting-to-tei)
#### Documentation (233)
    
##### Convert to TEI
Converts a virtual document to TEI P5 format, both at the page level and the whole document level.
##### Konverze do TEI
Konvertuje virtuální dokument do formátu TEI P5, a to na úrovni jednotlivýh stránek i celého dokumentu.
#### Options (3)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| output-directory | name = output-directory \| required = true \| as = xs:string |

#### Ports (4)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| input | report-in | false |
| output | **result** | true |
| output | report | false |

### Steps  (0 + 10)
      
#### Documentation (233)
    
##### Convert to TEI
Converts a virtual document to TEI P5 format, both at the page level and the whole document level.
##### Konverze do TEI
Konvertuje virtuální dokument do formátu TEI P5, a to na úrovni jednotlivýh stránek i celého dokumentu.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:variable | result-directory-path |   |   | 
|   |   |   | p:documentation | 
    
     The folder where generated documents are saved. The path to the folder can be absolute or relative.
    
    
     Složka, do níž se uloží vygenerované dokumenty. Cesta ke složce může být absolutní i relativní.
    
    | 
|   |   |   | select | concat($output-directory, '/tei') | 
| 4 | p:variable | result-directory-uri |   |   | 
|   |   |   | select | resolve-uri($result-directory-path, $base-uri) | 
| 5 | p:viewport |  |   |   | 
|   |   |   | match | lad:pages/lad:page | 
|   |   |   | p:if | 
    
    
    
    
    
    
    
     
     
      
      
     
     
      
     
     
     
      
      
     
     
      
     
     
     
      
      
     
     
      
     
     
     
      
      
      
      
     
     
     
      
     
     
     
      
     
     
      
          
    
    
    
     
      
     
    
    
    
    
     
    
    
    
    | 
|   |   |   | p:variable |  | 
|   |   |   | p:variable |  | 
|   |   |   | p:variable |  | 
|   |   |   | p:variable |  | 
|   |   |   | use-when | true() | 
| 6 | p:identity | mid-final |   |   | 
| 7 | p:identity | mid-report |   |   | 
|   |   |   | pipe | report-in@converting-to-tei | 
| 8 | lat:combine-tei-pages | combining-tei-pages |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug-path | {$debug-path} | 
|   |   |   | output-directory | {$output-directory} | 
|   |   |   | pipe | @mid-report | 
|   |   |   | pipe | @mid-final | 
| 9 | p:identity | final |   |   | 
| 10 | p:identity | final-report |   |   | 
|   |   |   | pipe | report@combining-tei-pages | 


#### **lat:combine-tei-pages** (combining-tei-pages)
#### Documentation (138)
    
##### Combine TEI pages
Combines available TEI pages to one document.
##### Sloučení stránek TEI
Sloučí dostupné TEI stránky do jednoho TEI dokumentu.
#### Options (3)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| output-directory | name = output-directory \| required = true \| as = xs:string |

#### Ports (4)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| input | report-in | false |
| output | **result** | true |
| output | report | false |

### Steps  (0 + 10)
      
#### Documentation (138)
    
##### Combine TEI pages
Combines available TEI pages to one document.
##### Sloučení stránek TEI
Sloučí dostupné TEI stránky do jednoho TEI dokumentu.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:variable | result-directory-path |   |   | 
|   |   |   | p:documentation | 
    
     The folder where generated documents are saved. The path to the folder can be absolute or relative.
    
    
     Složka, do níž se uloží vygenerované dokumenty. Cesta ke složce může být absolutní i relativní.
    
    | 
|   |   |   | select | $output-directory | 
| 4 | p:variable | result-directory-uri |   |   | 
|   |   |   | select | resolve-uri($result-directory-path, $base-uri) | 
| 5 | p:variable | foxml |   |   | 
|   |   |   | select | /lad:document/lad:resource[@type='foxml'][@local-file-exists='true'] | 
| 6 | p:variable | teis |   |   | 
|   |   |   | select | /lad:document/lad:pages/lad:page/lad:resource[@type='tei'][@local-file-exists='true'] | 
| 7 | p:if |  |   |   | 
|   |   |   | p:store |  | 
|   |   |   | test | $debug | 
| 8 | p:if |  |   |   | 
|   |   |   | p:identity | 
     
      
     
     | 
|   |   |   | p:if | 
     
     
      
       
      
     
     
     
     
      
      
      
     
     
     
     
      
     

     
      
       
       
       
        
       
      
      
     
     
     
      
          
     | 
|   |   |   | p:insert | 
     
     
     | 
|   |   |   | p:namespace-delete |  | 
|   |   |   | p:variable |  | 
|   |   |   | p:variable |  | 
|   |   |   | p:variable |  | 
|   |   |   | test | exists($foxml) and exists($teis) | 
| 9 | p:identity | final |   |   | 
| 10 | p:identity | final-report |   |   | 
|   |   |   | pipe | report-in@combining-tei-pages | 



## text.xpl (version: 1.0.0)
#### Documentation (192)
    
##### Library for plain text data processing
Steps for standalone operations with plain text data.
##### Kihovna pro zpracování textových dat
Kroky pro samostatné operace s daty ve formátu prostého textu.
#### Namespaces (7)
    
| prefix | string |
| --- | --- |
| c | http://www.w3.org/ns/xproc-step |
| lad | https://www.mzk.cz/ns/libri-augmentati/documents/1.0 |
| latx | https://www.mzk.cz/ns/libri-augmentati/text/1.0 |
| p | http://www.w3.org/ns/xproc |
| xhtml | http://www.w3.org/1999/xhtml |
| xs | http://www.w3.org/2001/XMLSchema |
| xml | http://www.w3.org/XML/1998/namespace |

### Steps  (1 + 0)
      
#### Documentation (192)
    
##### Library for plain text data processing
Steps for standalone operations with plain text data.
##### Kihovna pro zpracování textových dat
Kroky pro samostatné operace s daty ve formátu prostého textu.

#### **latx:combine-text-pages** (combining-text-pages)
#### Documentation (138)
    
##### Combine TEI pages
Combines available TEI pages to one document.
##### Sloučení stránek TEI
Sloučí dostupné TEI stránky do jednoho TEI dokumentu.
#### Options (3)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| output-directory | name = output-directory \| required = true \| as = xs:string |

#### Ports (4)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| input | report-in | false |
| output | **result** | true |
| output | report | false |

### Steps  (0 + 9)
      
#### Documentation (138)
    
##### Combine TEI pages
Combines available TEI pages to one document.
##### Sloučení stránek TEI
Sloučí dostupné TEI stránky do jednoho TEI dokumentu.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:variable | result-directory-path |   |   | 
|   |   |   | p:documentation | 
    
     The folder where generated documents are saved. The path to the folder can be absolute or relative.
    
    
     Složka, do níž se uloží vygenerované dokumenty. Cesta ke složce může být absolutní i relativní.
    
    | 
|   |   |   | select | $output-directory | 
| 4 | p:variable | result-directory-uri |   |   | 
|   |   |   | select | resolve-uri($result-directory-path, $base-uri) | 
| 5 | p:variable | resources |   |   | 
|   |   |   | select | /lad:document/lad:pages/lad:page/lad:resource[@type='text'][@local-file-exists='true'] | 
| 6 | p:if |  |   |   | 
|   |   |   | p:store |  | 
|   |   |   | test | $debug | 
| 7 | p:if |  |   |   | 
|   |   |   | p:file-info |  | 
|   |   |   | p:identity | 
    
     
    
    | 
|   |   |   | p:if | 
    
     
      
      
      
       
      
     
     
    
    
     
         
    | 
|   |   |   | p:insert | 
    
    
    | 
|   |   |   | p:namespace-delete |  | 
|   |   |   | p:variable |  | 
|   |   |   | p:variable |  | 
|   |   |   | p:variable |  | 
|   |   |   | test | exists($resources) | 
| 8 | p:identity | final |   |   | 
| 9 | p:identity | final-report |   |   | 
|   |   |   | pipe | report-in@combining-text-pages | 



## udpipe.xpl (version: 1.0.0)
#### Documentation (185)
    
##### Library for UDPipe data processing
Steps for standalone operations with UDPipe service and data.
##### Kihovna pro zpracování dat UDPipe
Kroky pro samostatné operace se službou a daty UDPipe.
#### Namespaces (8)
    
| prefix | string |
| --- | --- |
| c | http://www.w3.org/ns/xproc-step |
| lad | https://www.mzk.cz/ns/libri-augmentati/documents/1.0 |
| las | https://www.mzk.cz/ns/libri-augmentati/settings/1.0 |
| laud | https://www.mzk.cz/ns/libri-augmentati/udpipe/1.0 |
| p | http://www.w3.org/ns/xproc |
| xhtml | http://www.w3.org/1999/xhtml |
| xs | http://www.w3.org/2001/XMLSchema |
| xml | http://www.w3.org/XML/1998/namespace |

### Steps  (3 + 0)
      
#### Documentation (185)
    
##### Library for UDPipe data processing
Steps for standalone operations with UDPipe service and data.
##### Kihovna pro zpracování dat UDPipe
Kroky pro samostatné operace se službou a daty UDPipe.

#### **laud:get-udpipe-analysis** (getting-udpipe-analysis)
#### Documentation (262)
    
##### Get UDPipe analysis
Calls the REST API of the UDPipe service, passes it the text to recognize, and returns the result in JSON format.
##### Analýza textu pomocí UDPipe
Zavolá rozhraní REST API služby UDPipe, předá jí text k rozpoznání a vrátí výsledek ve formátu JSON.
#### Options (3)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| language | name = language \| as = xs:string? \| select = 'cze' |

#### Ports (5)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| input | settings | false |
| input | report-in | false |
| output | **result** | true |
| output | report | false |

### Steps  (0 + 13)
      
#### Documentation (262)
    
##### Get UDPipe analysis
Calls the REST API of the UDPipe service, passes it the text to recognize, and returns the result in JSON format.
##### Analýza textu pomocí UDPipe
Zavolá rozhraní REST API služby UDPipe, předá jí text k rozpoznání a vrátí výsledek ve formátu JSON.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:variable | service |   |   | 
|   |   |   | pipe | settings@getting-udpipe-analysis | 
|   |   |   | select | //las:service[@code='udpipe'] | 
| 4 | p:variable | service-url |   |   | 
|   |   |   | p:documentation | 
    
     URL of the REST service
    
    
     URL RESTové služby
    
    | 
|   |   |   | select | $service/las:api/@url | 
| 5 | p:variable | api-id |   |   | 
|   |   |   | p:documentation | 
    
     Identifier of the REST service
    
    
     Identifikátor RESTové služby
    
    | 
|   |   |   | select | substring-after($service/las:api/@ref, '#') | 
| 6 | p:variable | feature |   |   | 
|   |   |   | pipe | settings@getting-udpipe-analysis | 
|   |   |   | select | //las:api[@xml:id=$api-id]/las:feature[@type='process'][@method='post'] | 
| 7 | p:variable | step-url |   |   | 
|   |   |   | select | concat($service-url, $feature/@url) | 
| 8 | p:variable | step-params |   |   | 
|   |   |   | select | string-join($feature/las:param[@place='body'][not(@name =('data','model'))]//concat(@name, '=', @value), '&') | 
| 9 | p:variable | step-params |   |   | 
|   |   |   | select | $step-params \|\| '&model=' \|\| $language | 
| 10 | p:variable | full-text |   |   | 
|   |   |   | select | . | 
| 11 | p:http-request |  |   |   | 
|   |   |   | href | {$step-url} | 
|   |   |   | method | 'POST' | 
|   |   |   | p:documentation | 
    
     Calling the UDPipe service API using the POST method. The input parameter to the service is plain text, encoded for the URI.
    
    
     Volání API služby UDPipe pomocí metodyPOST. Jako vstupní parametr služby se předává prostý text, kódovaný pro URI.
    
    | 
| 12 | p:identity | final |   |   | 
| 13 | p:if |  |   |   | 
|   |   |   | p:store |  | 
|   |   |   | test | $debug | 


#### **laud:convert-udpipe-analysis-to-text**
#### Documentation (192)
    
##### Convert UDPipe analysis to XML
Converts the analysis output in JSON format to an XML document.
##### Konverze analýzy UDPipe do XML
Převede výstup analýzy ve formátu JSON na dokument ve formátu XML.
#### Options (3)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| file-stem | name = file-stem \| as = xs:string? |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 8)
      
#### Documentation (192)
    
##### Convert UDPipe analysis to XML
Converts the analysis output in JSON format to an XML document.
##### Konverze analýzy UDPipe do XML
Převede výstup analýzy ve formátu JSON na dokument ve formátu XML.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:variable | model |   |   | 
|   |   |   | select | normalize-space(.?model) | 
| 4 | p:if |  |   |   | 
|   |   |   | p:store |  | 
|   |   |   | test | $debug | 
| 5 | p:identity |  |   |   | 
|   |   |   | p:documentation | 
    
     Convert JSON to plain text without escaping characters.
    
    
     Převod formátu JSON do TXT bez zbytečných escapovaných textů.
    
    | 
| 6 | p:if |  |   |   | 
|   |   |   | p:store |  | 
|   |   |   | test | $debug | 
| 7 | p:xslt |  |   |   | 
|   |   |   | href | ../xslt/udpipe/udpipe-json-to-text.xsl | 
|   |   |   | version | 3.0 | 
| 8 | p:if |  |   |   | 
|   |   |   | p:store |  | 
|   |   |   | test | $debug | 


#### **laud:get-udpipe-analyses** (getting-udpipe-analyses)
#### Documentation (419)
    
##### Get UDPipe (Universal Dependencies) analyses
For each page of the virtual document, it gets its text, sends it to the REST interface of the UDPipe service, converts the result to XML format and stores it in a folder.
##### Analýzy textu UDPipe (Universal Dependencies)
Pro každou stránku virtuálního dokumentu získá její text, odešle ho na RESTové rozhraní služby UDPipe, výsledek konvertuje do formátu XML a uloží do složky.
#### Options (3)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| output-directory | name = output-directory \| required = true \| as = xs:string |

#### Ports (5)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| input | settings | false |
| input | report-in | false |
| output | **result** | true |
| output | report | false |

### Steps  (0 + 12)
      
#### Documentation (419)
    
##### Get UDPipe (Universal Dependencies) analyses
For each page of the virtual document, it gets its text, sends it to the REST interface of the UDPipe service, converts the result to XML format and stores it in a folder.
##### Analýzy textu UDPipe (Universal Dependencies)
Pro každou stránku virtuálního dokumentu získá její text, odešle ho na RESTové rozhraní služby UDPipe, výsledek konvertuje do formátu XML a uloží do složky.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:variable | result-directory-path |   |   | 
|   |   |   | p:documentation | 
    
     The folder where downloaded documents are saved. The path to the folder can be absolute or relative.
    
    
     Složka, do níž se uloží stažené dokumenty. Cesta ke složce může být absolutní i relativní.
    
    | 
|   |   |   | select | concat($output-directory, '/udpipe') | 
| 4 | p:variable | result-directory-uri |   |   | 
|   |   |   | select | resolve-uri($result-directory-path, $base-uri) | 
| 5 | p:variable | language |   |   | 
|   |   |   | select | /lad:document/@language | 
| 6 | p:if |  |   |   | 
|   |   |   | p:store | 
    
    | 
|   |   |   | test | $debug | 
| 7 | p:identity |  |   |   | 
| 8 | p:viewport |  |   |   | 
|   |   |   | pipe | source@getting-udpipe-analyses | 
|   |   |   | match | lad:pages/lad:page/lad:resource[@type='text'][@local-file-exists='true'] | 
|   |   |   | p:if | 
    
    
    
    
    
    
    
    
     
     
     
     
     
      
       
        
       
      
      
       
       
       
       
      
      
       
        
       
       
      
     
     
     
      
     
     
     
      
      
     
     
     
      
     
     
     
     
     
      
     
     
     
      
          
    
    
    
     
      
     
    
    
    
    
     
    
    
    | 
|   |   |   | p:variable |  | 
|   |   |   | use-when | true() | 
| 9 | p:identity | final |   |   | 
| 10 | p:if |  |   |   | 
|   |   |   | p:store |  | 
|   |   |   | test | $debug | 
| 11 | p:identity | metadata |   |   | 
| 12 | p:insert | final-report |   |   | 
|   |   |   | pipe | @metadata | 
|   |   |   | match | laud:report/laud:result | 
|   |   |   | p:documentation | Doplnění zprávy o zpracovaných prvcích. | 
|   |   |   | position | last-child | 
|   |   |   | pipe | source@getting-udpipe-analyses | 




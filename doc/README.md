# XProc Analysis Report

## alto.xpl
#### Documentation (0)
    
##### 

#### Namespaces (5)
    
| prefix | string |
| --- | --- |
| p | http://www.w3.org/ns/xproc |
| xf | https://www.example.com/ns/xproc/function |
| xhtml | http://www.w3.org/1999/xhtml |
| xs | http://www.w3.org/2001/XMLSchema |
| xml | http://www.w3.org/XML/1998/namespace |

### Steps  (1 + 0)
      
#### Documentation (0)
    
##### 


#### **xf:first-function-alto** (fist-function)
#### Documentation (0)
    
##### 

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
      
#### Documentation (0)
    
##### 



| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:xslt |  |   |   | 
|   |   |   | parameters | map {'parameter' : 'value' } | 
|   |   |   | href | ../Xslt/?.xsl | 
| 4 | p:if |  |   |   | 
|   |   |   | p:store |  | 
|   |   |   | test | $debug | 



## conversion.xpl
#### Documentation (0)
    
##### 

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

### Steps  (4 + 0)
      
#### Documentation (0)
    
##### 


#### **lac:convert** (fist-function)
#### Documentation (0)
    
##### 

#### Options (4)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| source-format | name = source-format \| as = xs:string \| values = ('djvu') |
| target-format | name = target-format \| as = xs:string \| values = ('pdf', 'tiff') |

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 4)
      
#### Documentation (0)
    
##### 



| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:xslt |  |   |   | 
|   |   |   | parameters | map {'parameter' : 'value' } | 
|   |   |   | href | ../Xslt/?.xsl | 
| 4 | p:if |  |   |   | 
|   |   |   | p:store |  | 
|   |   |   | test | $debug | 


#### **lac:convert-djvu**
#### Documentation (12)
    
##### Convert DjVu

##### 

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
      
#### Documentation (12)
    
##### Convert DjVu

##### 



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
#### Documentation (17)
    
##### Convert DjVu item

##### 

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
      
#### Documentation (17)
    
##### Convert DjVu item

##### 



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
#### Documentation (8)
    
##### Fix path

##### 

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
      
#### Documentation (8)
    
##### Fix path

##### 



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



## enrichment.xpl
#### Documentation (178)
    
##### Enrichment
The main programming library for enrichment data by external (web) services.
##### Obohacení
Hlavní programová knihovna pro obohacení dat pomocí externích (webových) služeb.
#### Namespaces (11)
    
| prefix | string |
| --- | --- |
| lad | https://www.mzk.cz/ns/libri-augmentati/documents/1.0 |
| lae | https://www.mzk.cz/ns/libri-augmentati/enrichment/1.0 |
| lant | https://www.mzk.cz/ns/libri-augmentati/nametag/1.0 |
| lap | https://www.mzk.cz/ns/libri-augmentati/processing/1.0 |
| lar | https://www.mzk.cz/ns/libri-augmentati/report/1.0 |
| las | https://www.mzk.cz/ns/libri-augmentati/settings/1.0 |
| lax | https://www.mzk.cz/ns/libri-augmentati/xproc/1.0 |
| p | http://www.w3.org/ns/xproc |
| xhtml | http://www.w3.org/1999/xhtml |
| xs | http://www.w3.org/2001/XMLSchema |
| xml | http://www.w3.org/XML/1998/namespace |

#### Imports (0)
    

### Steps  (3 + 0)
      
#### Documentation (178)
    
##### Enrichment
The main programming library for enrichment data by external (web) services.
##### Obohacení
Hlavní programová knihovna pro obohacení dat pomocí externích (webových) služeb.

#### **lae:enrich-data** (enriching-data)
#### Options (6)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| output-directory | name = output-directory \| required = true \| as = xs:string |
| pause-before-request | name = pause-before-request \| select = 2 \| as = xs:integer |
| output-format | name = output-format \| values = ('TEXT', 'TEI') \| as = xs:string* |
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
      


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:if |  |   |   | 
|   |   |   | lae:enrich-by-entities | 
    
    
    | 
|   |   |   | test | $enrichment = 'ENTITIES' | 
| 2 | p:if |  |   |   | 
|   |   |   | lae:enrich-by-morphology | 
    
    
    | 
|   |   |   | test | $enrichment = 'MORPHOLOGY' | 


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

### Steps  (0 + 6)
      
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
| 4 | lant:get-nametag-analyses |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug-path | {$debug-path} | 
|   |   |   | output-directory | {$output-directory} | 
|   |   |   | pipe | result@report-start | 
|   |   |   | pipe | settings@enriching-by-entities | 
|   |   |   | pipe | source@enriching-by-entities | 
| 5 | p:identity | final |   |   | 
| 6 | p:add-attribute | report-final |   |   | 
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

### Steps  (0 + 6)
      
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
| 4 | p:identity |  |   |   | 
|   |   |   | pipe | source@enriching-by-morphology | 
| 5 | p:identity | final |   |   | 
| 6 | p:add-attribute | report-final |   |   | 
|   |   |   | attribute-name | end | 
|   |   |   | attribute-value | {current-dateTime()} | 
|   |   |   | match | lax:step[@type='lae:enrich-by-morphology'][not(@end)] | 
|   |   |   | pipe | result@report-start | 



## kramerius-5.xpl
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
#### Documentation (329)
    
##### Get virtual document pages
Creates element for each page of the document that contains basic data: identifier, type and (page) number.
Returns element <lad:pages>
##### Získání stránek virtuálního dokumentu
Pro každou stránku dokumentu vytvoří element se základními údaji: identifikátor, typ a číslo (strany).
Vrací element <lad:pages>
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
      
#### Documentation (329)
    
##### Get virtual document pages
Creates element for each page of the document that contains basic data: identifier, type and (page) number.
Returns element <lad:pages>
##### Získání stránek virtuálního dokumentu
Pro každou stránku dokumentu vytvoří element se základními údaji: identifikátor, typ a číslo (strany).
Vrací element <lad:pages>


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



## kramerius-7.xpl
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
#### Documentation (329)
    
##### Get virtual document pages
Creates element for each page of the document that contains basic data: identifier, type and (page) number.
Returns element <lad:pages>
##### Získání stránek virtuálního dokumentu
Pro každou stránku dokumentu vytvoří element se základními údaji: identifikátor, typ a číslo (strany).
Vrací element <lad:pages>
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
      
#### Documentation (329)
    
##### Get virtual document pages
Creates element for each page of the document that contains basic data: identifier, type and (page) number.
Returns element <lad:pages>
##### Získání stránek virtuálního dokumentu
Pro každou stránku dokumentu vytvoří element se základními údaji: identifikátor, typ a číslo (strany).
Vrací element <lad:pages>


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



## libri-augmentati.xpl
#### Documentation (199)
    
##### Libri augmentati
The main programming library for digital library data retrieval and enrichment.
##### Libri augmentati
Hlavní programová knihovna pro získání dat z digitálních knihoven a jejich obohacení.
#### Namespaces (18)
    
| prefix | string |
| --- | --- |
| array | http://www.w3.org/2005/xpath-functions/array |
| c | http://www.w3.org/ns/xproc-step |
| err | http://www.w3.org/ns/xproc-error |
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

### Steps  (10 + 0)
      
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
#### Documentation (28)
    
##### Download document data items

##### 

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
      
#### Documentation (28)
    
##### Download document data items

##### 



| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:for-each |  |   |   | 
|   |   |   | select | . | 


#### **lax:download-document**
#### Documentation (17)
    
##### Download document

##### 

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
      
#### Documentation (17)
    
##### Download document

##### 



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
| output-format | name = output-format \| values = ('TEXT', 'TEI') \| as = xs:string* |
| enrichment | name = enrichment \| values = ('ENTITIES', 'MORPHOLOGY') \| as = xs:string* |

#### Ports (5)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| input | settings | false |
| input | report-in | false |
| output | **result** | true |
| output | report | false |

### Steps  (0 + 1)
      
#### Documentation (208)
    
##### Enrich document data
Enriches available (textual) data of the digital book by available services.
##### Obohacení dat dokumentu
Obohatí dostupná dostupná (textová) data digitální publikací pomocí dostupných služeb.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | lae:enrich-data |  |   |   | 
|   |   |   | base-uri | {$base-uri} | 
|   |   |   | debug-path | {$debug-path} | 
|   |   |   | enrichment | $enrichment | 
|   |   |   | output-directory | {$output-directory} | 
|   |   |   | output-format | $output-format | 
|   |   |   | pipe | report-in@enriching-document-data | 
|   |   |   | pipe | settings@enriching-document-data | 


#### **lax:create-report** (creating-report)
#### Documentation (13)
    
##### Create report

##### 

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
      
#### Documentation (13)
    
##### Create report

##### 



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
#### Documentation (15)
    
##### Get document id

##### 

#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | source | false |
| output | **result** | true |

### Steps  (0 + 1)
      
#### Documentation (15)
    
##### Get document id

##### 



| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:identity |  |   |   | 



## nametag.xpl
#### Documentation (0)
    
#### Namespaces (7)
    
| prefix | string |
| --- | --- |
|  | http://www.w3.org/1999/xhtml |
| lad | https://www.mzk.cz/ns/libri-augmentati/documents/1.0 |
| lant | https://www.mzk.cz/ns/libri-augmentati/nametag/1.0 |
| las | https://www.mzk.cz/ns/libri-augmentati/settings/1.0 |
| p | http://www.w3.org/ns/xproc |
| xs | http://www.w3.org/2001/XMLSchema |
| xml | http://www.w3.org/XML/1998/namespace |

### Steps  (3 + 0)
      
#### Documentation (0)
    

#### **lant:get-nametag-analysis** (getting-nametag-analysis)
#### Documentation (178)
    
Převede vstupní text na dokument ve formátu XML.
Zavolá API služby NameTag, předá jí text k rozpoznání a výsledek (dokument JSON) převede pomocí XSLT transformace na validní XML.
#### Options (2)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |

#### Ports (5)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| input | settings | false |
| input | report-in | false |
| output | **result** | true |
| output | report | false |

### Steps  (0 + 10)
      
#### Documentation (178)
    
Převede vstupní text na dokument ve formátu XML.
Zavolá API služby NameTag, předá jí text k rozpoznání a výsledek (dokument JSON) převede pomocí XSLT transformace na validní XML.


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:variable | service |   |   | 
|   |   |   | pipe | settings@getting-nametag-analysis | 
|   |   |   | select | //las:service[@code='nametag'] | 
| 4 | p:variable | service-url |   |   | 
|   |   |   | p:documentation | URL RESTové služby. | 
|   |   |   | select | $service/las:api/@url | 
| 5 | p:variable | api-id |   |   | 
|   |   |   | p:documentation | Identifikátor RESTové služby. | 
|   |   |   | select | substring-after($service/las:api/@ref, '#') | 
| 6 | p:variable | feature |   |   | 
|   |   |   | pipe | settings@getting-nametag-analysis | 
|   |   |   | select | //las:api[@xml:id=$api-id]/las:feature[@type='entities'][@method='post'] | 
| 7 | p:variable | step-url |   |   | 
|   |   |   | select | concat($service-url, $feature/@url) | 
| 8 | p:variable | full-text |   |   | 
|   |   |   | select | . | 
| 9 | p:http-request |  |   |   | 
|   |   |   | href | {$step-url} | 
|   |   |   | method | 'POST' | 
|   |   |   | p:documentation | 
    
     Volání API služby NameTag pomocí metodyPOST. Jako vstupní parametr služby se předává prostý text, kódovaný pro URI.
    
    | 
| 10 | p:identity | final |   |   | 


#### **lant:convert-nametag-analysis-to-xml**
#### Ports (2)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |

### Steps  (0 + 5)
      


| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | model |   |   | 
|   |   |   | select | normalize-space(?model) | 
| 2 | p:cast-content-type |  |   |   | 
|   |   |   | content-type | application/xml | 
|   |   |   | select | ?result | 
| 3 | p:xslt |  |   |   | 
|   |   |   | version | 3.0 | 
| 4 | p:cast-content-type |  |   |   | 
|   |   |   | content-type | application/xml | 
| 5 | p:choose |  |   |   | 


#### **lant:get-nametag-analyses** (getting-nametag-analyses)
#### Documentation (172)
    
NameTag#### Options (3)
      
| name | properties |
| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| output-directory | name = output-directory \| required = true \| as = xs:string |

#### Ports (6)
    
| direction | value | primary |
| --- | --- | ---| 
| input | **source** | true |
| input | settings | false |
| input | report-in | false |
| output | **result** | true |
| output | report | false |
| output | data | false |

### Steps  (0 + 14)
      
#### Documentation (172)
    
NameTag

| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:variable | main-directory-path |   |   | 
|   |   |   | select | //lant:request/@main-directory-path | 
| 4 | p:variable | result-directory-path |   |   | 
|   |   |   | p:documentation | Složka, do níž se uloží stažené dokumenty. Cesta ke složce může být absolutní i relativní. | 
|   |   |   | select | concat($output-directory, '/nametag') | 
| 5 | p:variable | result-directory-uri |   |   | 
|   |   |   | select | resolve-uri($result-directory-path, $base-uri) | 
| 6 | p:if |  |   |   | 
|   |   |   | p:store | 
    
    | 
|   |   |   | test | $debug | 
| 7 | p:variable | input |   |   | 
|   |   |   | pipe | source@getting-nametag-analyses | 
|   |   |   | select | //lad:page | 
| 8 | p:variable | root |   |   | 
|   |   |   | pipe | source@getting-nametag-analyses | 
|   |   |   | select | /* | 
| 9 | p:for-each |  |   |   | 
|   |   |   | select | //lad:pages/lad:page | 
| 10 | p:identity | data |   |   | 
|   |   |   | pipe | data@loop | 
| 11 | p:wrap-sequence |  |   |   | 
|   |   |   | p:documentation | Zabalení sekvence elementů <lant:item< do nadřazeného elementu. | 
|   |   |   | pipe | result@loop | 
|   |   |   | wrapper | lant:step | 
| 12 | p:set-attributes |  |   |   | 
|   |   |   | attributes | map{    'name' :  'getting-nametag-analyses',     'result-directory-path' : $result-directory-path     } | 
|   |   |   | match | /* | 
| 13 | p:identity | metadata |   |   | 
| 14 | p:insert | final-report |   |   | 
|   |   |   | pipe | @metadata | 
|   |   |   | match | lant:report/lant:result | 
|   |   |   | p:documentation | Doplnění zprávy o zpracovaných prvcích. | 
|   |   |   | position | last-child | 
|   |   |   | pipe | source@getting-nametag-analyses | 



## tei.xpl
#### Documentation (0)
    
##### 

#### Namespaces (5)
    
| prefix | string |
| --- | --- |
| p | http://www.w3.org/ns/xproc |
| xf | https://www.example.com/ns/xproc/function |
| xhtml | http://www.w3.org/1999/xhtml |
| xs | http://www.w3.org/2001/XMLSchema |
| xml | http://www.w3.org/XML/1998/namespace |

### Steps  (1 + 0)
      
#### Documentation (0)
    
##### 


#### **xf:first-function-tei** (fist-function)
#### Documentation (0)
    
##### 

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
      
#### Documentation (0)
    
##### 



| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:xslt |  |   |   | 
|   |   |   | parameters | map {'parameter' : 'value' } | 
|   |   |   | href | ../Xslt/?.xsl | 
| 4 | p:if |  |   |   | 
|   |   |   | p:store |  | 
|   |   |   | test | $debug | 



## udpipe.xpl
#### Documentation (0)
    
##### 

#### Namespaces (5)
    
| prefix | string |
| --- | --- |
| p | http://www.w3.org/ns/xproc |
| xf | https://www.example.com/ns/xproc/function |
| xhtml | http://www.w3.org/1999/xhtml |
| xs | http://www.w3.org/2001/XMLSchema |
| xml | http://www.w3.org/XML/1998/namespace |

### Steps  (1 + 0)
      
#### Documentation (0)
    
##### 


#### **xf:first-function-udpipe** (fist-function)
#### Documentation (0)
    
##### 

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
      
#### Documentation (0)
    
##### 



| position | step | name | parameter | value | 
| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:xslt |  |   |   | 
|   |   |   | parameters | map {'parameter' : 'value' } | 
|   |   |   | href | ../Xslt/?.xsl | 
| 4 | p:if |  |   |   | 
|   |   |   | p:store |  | 
|   |   |   | test | $debug | 




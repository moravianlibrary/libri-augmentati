# XProc Analysis Report



    



    

| --- | --- |
| p | http://www.w3.org/ns/xproc |
| xf | https://www.example.com/ns/xproc/function |
| xhtml | http://www.w3.org/1999/xhtml |
| xs | http://www.w3.org/2001/XMLSchema |
| xml | http://www.w3.org/XML/1998/namespace |


      
#### Documentation (0)
    



#### **xf:first-function-alto** (fist-function)

    



      

| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |


    

| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |


      
#### Documentation (0)
    





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

    



    

| --- | --- |
| c | http://www.w3.org/ns/xproc-step |
| lac | https://www.mzk.cz/ns/libri-augmentati/conversion/1.0 |
| lad | https://www.mzk.cz/ns/libri-augmentati/documents/1.0 |
| p | http://www.w3.org/ns/xproc |
| xhtml | http://www.w3.org/1999/xhtml |
| xs | http://www.w3.org/2001/XMLSchema |
| xml | http://www.w3.org/XML/1998/namespace |


      
#### Documentation (0)
    



#### **lac:convert** (fist-function)

    



      

| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| source-format | name = source-format \| as = xs:string \| values = ('djvu') |
| target-format | name = target-format \| as = xs:string \| values = ('pdf', 'tiff') |


    

| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |


      
#### Documentation (0)
    





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

    





      

| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| main-input-directory | name = main-input-directory \| as = xs:anyURI \| required = true |
| main-output-directory | name = main-output-directory \| as = xs:anyURI \| required = true |
| output-file | name = output-file \| as = xs:string \| required = true |
| format | name = format \| values = ('pdf', 'tiff') \| select = 'pdf' |
| pdfbox-path | name = pdfbox-path \| as = xs:string \| required = true |
| ddjvu-path | name = ddjvu-path \| as = xs:string \| required = true |


    

| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |


      
#### Documentation (12)
    







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

    





      

| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| input-directory | name = input-directory \| as = xs:anyURI \| required = true |
| output-directory | name = output-directory \| as = xs:anyURI \| required = true |
| output-file | name = output-file \| as = xs:anyURI \| required = true |
| format | name = format \| values = ('pdf', 'tiff') \| select = 'pdf' |
| pdfbox-path | name = pdfbox-path \| as = xs:string \| required = true |
| ddjvu-path | name = ddjvu-path \| as = xs:string \| required = true |


    

| --- | --- | ---| 
| input | source | false |
| output | **result** | true |


      
#### Documentation (17)
    







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

    





      

| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |


    

| --- | --- | ---| 
| input | source | false |
| output | **result** | true |


      
#### Documentation (8)
    







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


    


      
#### Documentation (178)
    





#### **lae:enrich-data** (enriching-data)

      

| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| output-directory | name = output-directory \| required = true \| as = xs:string |
| pause-before-request | name = pause-before-request \| select = 2 \| as = xs:integer |
| output-format | name = output-format \| values = ('TEXT', 'TEI') \| as = xs:string* |
| enrichment | name = enrichment \| values = ('ENTITIES', 'MORPHOLOGY') \| as = xs:string* |


    

| --- | --- | ---| 
| input | **source** | true |
| input | settings | false |
| input | report-in | false |
| output | **result** | true |
| output | report | false |


      



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

    





      

| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| output-directory | name = output-directory \| required = true \| as = xs:string |


    

| --- | --- | ---| 
| input | **source** | true |
| input | settings | false |
| input | report-in | false |
| output | **result** | true |
| output | report | false |


      
#### Documentation (144)
    







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

    





      

| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| output-directory | name = output-directory \| required = true \| as = xs:string |


    

| --- | --- | ---| 
| input | **source** | true |
| input | settings | false |
| input | report-in | false |
| output | **result** | true |
| output | report | false |


      
#### Documentation (186)
    







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


      

| --- | --- |


      
#### Documentation (166)
    





#### **lax:get-virtual-document-metadata-v5** (getting-virtual-document-metadata)

    







      

| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |


    

| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |


      
#### Documentation (495)
    









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

    







      

| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |


    

| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |


      
#### Documentation (490)
    









| --- | --- | --- | --- | --- | 
| 1 | p:variable | debug |   |   | 
|   |   |   | select | $debug-path \|\| '' ne '' | 
| 2 | p:variable | debug-path-uri |   |   | 
|   |   |   | select | resolve-uri($debug-path, $base-uri) | 
| 3 | p:insert |  |   |   | 
|   |   |   | position | last-child | 


#### **lax:get-virtual-document-pages**

    







      

| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| url | name = url \| as = xs:string |
| document-id | name = document-id \| as = xs:string |


    

| --- | --- | ---| 
| output | **result** | true |


      
#### Documentation (329)
    









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

    







      

| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |


    

| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |


      
#### Documentation (387)
    









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

    







      

| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| base-url | name = base-url \| as = xs:anyURI |


    

| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |


      
#### Documentation (371)
    









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

    







      

| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| base-url | name = base-url \| as = xs:anyURI |


    

| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |


      
#### Documentation (378)
    









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

    







      

| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| url | name = url \| as = xs:anyURI \| required = true |
| format | name = format \| as = xs:string \| required = true |


    

| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |


      
#### Documentation (247)
    









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


      
#### Documentation (166)
    





#### **lax:get-virtual-document-metadata-v7** (getting-virtual-document-metadata)

    







      

| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |


    

| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |


      
#### Documentation (495)
    









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

    







      

| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |


    

| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |


      
#### Documentation (490)
    









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

    







      

| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| url | name = url \| as = xs:string \| required = true |
| document-id | name = document-id \| as = xs:string \| required = true |
| library-code | name = library-code \| as = xs:string \| required = true |


    

| --- | --- | ---| 
| output | **result** | true |


      
#### Documentation (329)
    









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

    







      

| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |


    

| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |


      
#### Documentation (387)
    









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

    







      

| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |


    

| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |


      
#### Documentation (371)
    









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

    







      

| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| base-url | name = base-url \| as = xs:anyURI |


    

| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |


      
#### Documentation (378)
    









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

    







      

| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| url | name = url \| as = xs:anyURI \| required = true |
| format | name = format \| as = xs:string \| required = true |


    

| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |


      
#### Documentation (247)
    









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


    


      

| --- | --- |


      
#### Documentation (199)
    





#### **lax:build-virtual-document** (building-virtual-document)

    





      

| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| library-code | name = library-code \| as = xs:string \| required = true |
| api-version | name = api-version \| as = xs:string? |
| system | name = system \| as = xs:string? \| values = ('Kramerius', 'Polona') \| required = false |
| document-resources | name = document-resources \| as = xs:token* |
| page-resources | name = page-resources \| as = xs:token* |


    

| --- | --- | ---| 
| input | **source** | true |
| input | settings | false |
| input | report-in | false |
| output | **result** | true |
| output | report | false |


      
#### Documentation (321)
    







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

    







      

| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |


    

| --- | --- | ---| 
| input | **source** | true |
| input | report-in | false |
| output | **result** | true |
| output | report | false |


      
#### Documentation (506)
    









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

    







      

| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| output-directory | name = output-directory \| required = true \| as = xs:string |
| pause-before-request | name = pause-before-request \| select = 2 \| as = xs:integer |


    

| --- | --- | ---| 
| input | **source** | true |
| input | report-in | false |
| output | **result** | true |
| output | report | false |


      
#### Documentation (511)
    









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

    







      

| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| output-directory | name = output-directory \| required = true \| as = xs:string |
| position | name = position \| required = true |
| type | name = type \| required = true \| as = xs:string |
| pause-before-request | name = pause-before-request \| required = true \| as = xs:integer |


    

| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |


      
#### Documentation (398)
    









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

    





      

| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |


    

| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |


      
#### Documentation (164)
    







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

    





      

| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| output-directory | name = output-directory \| required = true |
| type | name = type \| required = true \| as = xs:string |
| pause-before-request | name = pause-before-request \| required = true \| as = xs:integer |


    

| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |


      
#### Documentation (28)
    







| --- | --- | --- | --- | --- | 
| 1 | p:for-each |  |   |   | 
|   |   |   | select | . | 


#### **lax:download-document**

    





      

| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| url | name = url \| as = xs:anyURI |
| local-path | name = local-path \| as = xs:string |
| pause-before-request | name = pause-before-request \| required = true \| as = xs:integer |


    

| --- | --- | ---| 
| input | source | false |
| output | **result** | true |


      
#### Documentation (17)
    







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

    





      

| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| output-directory | name = output-directory \| required = true \| as = xs:string |
| pause-before-request | name = pause-before-request \| select = 2 \| as = xs:integer |
| output-format | name = output-format \| values = ('TEXT', 'TEI') \| as = xs:string* |
| enrichment | name = enrichment \| values = ('ENTITIES', 'MORPHOLOGY') \| as = xs:string* |


    

| --- | --- | ---| 
| input | **source** | true |
| input | settings | false |
| input | report-in | false |
| output | **result** | true |
| output | report | false |


      
#### Documentation (208)
    







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

    





      

| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| output-directory | name = output-directory \| select = () \| as = xs:string? |


    

| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |
| output | result-uri | false |


      
#### Documentation (13)
    







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

    





    

| --- | --- | ---| 
| input | source | false |
| output | **result** | true |


      
#### Documentation (15)
    







| --- | --- | --- | --- | --- | 
| 1 | p:identity |  |   |   | 



## nametag.xpl

    

    

| --- | --- |
|  | http://www.w3.org/1999/xhtml |
| lad | https://www.mzk.cz/ns/libri-augmentati/documents/1.0 |
| lant | https://www.mzk.cz/ns/libri-augmentati/nametag/1.0 |
| las | https://www.mzk.cz/ns/libri-augmentati/settings/1.0 |
| p | http://www.w3.org/ns/xproc |
| xs | http://www.w3.org/2001/XMLSchema |
| xml | http://www.w3.org/XML/1998/namespace |


      
#### Documentation (0)
    

#### **lant:get-nametag-analysis** (getting-nametag-analysis)

    



      

| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |


    

| --- | --- | ---| 
| input | **source** | true |
| input | settings | false |
| input | report-in | false |
| output | **result** | true |
| output | report | false |


      
#### Documentation (178)
    





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

    

| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |


      



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

    

      

| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |
| output-directory | name = output-directory \| required = true \| as = xs:string |


    

| --- | --- | ---| 
| input | **source** | true |
| input | settings | false |
| input | report-in | false |
| output | **result** | true |
| output | report | false |
| output | data | false |


      
#### Documentation (172)
    



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

    



    

| --- | --- |
| p | http://www.w3.org/ns/xproc |
| xf | https://www.example.com/ns/xproc/function |
| xhtml | http://www.w3.org/1999/xhtml |
| xs | http://www.w3.org/2001/XMLSchema |
| xml | http://www.w3.org/XML/1998/namespace |


      
#### Documentation (0)
    



#### **xf:first-function-tei** (fist-function)

    



      

| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |


    

| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |


      
#### Documentation (0)
    





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

    



    

| --- | --- |
| p | http://www.w3.org/ns/xproc |
| xf | https://www.example.com/ns/xproc/function |
| xhtml | http://www.w3.org/1999/xhtml |
| xs | http://www.w3.org/2001/XMLSchema |
| xml | http://www.w3.org/XML/1998/namespace |


      
#### Documentation (0)
    



#### **xf:first-function-udpipe** (fist-function)

    



      

| --- | --- |
| debug-path | name = debug-path \| select = () \| as = xs:string? |
| base-uri | name = base-uri \| as = xs:anyURI \| select = static-base-uri() |


    

| --- | --- | ---| 
| input | **source** | true |
| output | **result** | true |


      
#### Documentation (0)
    





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



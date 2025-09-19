xquery version "3.1" encoding "utf-8";

declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace alto2 = "http://www.loc.gov/standards/alto/ns-v2#";
declare namespace saxon="http://saxon.sf.net/";


declare option saxon:output "indent=yes";

declare option saxon:output "saxon:indent-spaces=2";
declare option saxon:output "saxon:line-length=300";


declare variable $root external := /;

declare function local:text($line as element()) as xs:string {

  fold-left($line/*, "", function( $text as xs:string, $item as element()) {

  let $current-text :=
   switch (name($item)) 
  case "String" return ($item/@SUBS_CONTENT, $item/@CONTENT)[1]
  case "SP" return " "
  default return ""
  return concat($text, $current-text)
  })
  
};

declare function local:find ($root as document-node()) as node() {

let $indent-threshold := 10

let $pages := $root/alto2:alto/alto2:Layout/alto2:Page

let $result :=
for $page in $pages
return <page ID="{$page/@ID}"> { 
let $blocks :=
$page/alto2:PrintSpace/alto2:TextBlock


for $block in $blocks
   let $text := fold-left($block/alto2:TextLine, "", function($text as xs:string, $line as element()) {
    concat($text, local:text($line))
   })
   return <block ID="{$block/@ID}" text="{$text}">{
   let $textlines := $block/alto2:TextLine
   let $lines := for $line in $textlines
   let $text := local:text($line)
   return <line 
   hpos="{$line/@HPOS}" 
   width="{$line/@WIDTH}" 
   string="{count($line/alto2:String)}"
   sp="{count($line/alto2:SP)}"
   length="{sum($line/alto2:String/string-length(@CONTENT))}"
   hyphen="{if(matches($line/alto2:String[last()]/@CONTENT, '[=\-¬⸗]$') or $line/*[last()][self::alto2:HYP]) then 1 else 0}"
   uppercase="{if(matches($line/alto2:String[1]/@CONTENT, '^\p{P}?\p{Lu}'))  then 1 else 0}"
   id="{$line/@ID}"
   text="{$text}"
   />
  let $avg := <avg 
   hpos="{avg($lines/@hpos) => floor()}"
   hpos-min="{min($lines/@hpos)}"
   hpos-max="{max($lines/@hpos)}"
   width="{avg($lines/@width) => floor()}"
   width-min="{min($lines/@width)}"
   width-max="{max($lines/@width)}"
   string="{avg($lines/@string) => floor()}"
   sp="{avg($lines/@sp) => floor()}"
   length="{avg($lines/@length) => floor()}"
   />
   let $lines := for $line in $lines
     return if(
      (xs:integer($avg/@hpos-min) + $indent-threshold) ge xs:integer($avg/@hpos-max)
      or (xs:integer($avg/@width-min) + $indent-threshold) ge xs:integer($avg/@width-max)
      )
     then $line
     else if($line/@hyphen = '1') 
      then $line
     else if(
       xs:integer($line/@hpos) gt xs:integer($avg/@hpos)
       and $line/@uppercase = '1'
       and xs:integer($line/@width) lt xs:integer($avg/@width)
     ) then
      <line>{$line/@*, attribute role {"start"}}</line>
      else if(
       xs:integer($line/@hpos) lt (xs:integer($avg/@hpos) + $indent-threshold)
       and xs:integer($line/@width) lt xs:integer($avg/@width)
     ) then
     <line>{$line/@*, attribute role {"end"}}</line>
      else $line

   return ($avg/@*, $lines)
 } </block>
 }
 </page>
return <result>
{$result}
</result>
};

local:find($root)


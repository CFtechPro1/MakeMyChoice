<!---
AUTHOR:
 Fuseware Software
 http://www.fuseware.com
 
NAME: <CF_ImageSize>

DESCRIPTION: <CF_ImageSize> is a ColdFusion tag that returns
			 the width, height, and type of a given image.

ATTRIBUTES: 

 CF_ImageSize
 ================
  FILE			(Required) Full path to the image.

  
RETURNS:
========
Width:  The width of the image
Height: The height of the image
Type:   returns the Precision if JPG, and Gif Type if GIF
  

EXAMPLE:
========
 
  <CF_ImageSize file="C:\inetpub\wwwroot\myimage.gif">
     
  to display:
  
  <cfoutput>#width# #height# #type#</cfoutput>

--->
<CFLOOP index="Attribute" list="file">
	<CFIF not IsDefined( 'Attributes.' & Attribute )>
		<HR>
		<H4>Missing Attribute</H4>

		You need to specify a value for the '<B><CFOUTPUT>#Attribute#</CFOUTPUT></B>' attribute. This attribute is required for the <B>cf_imagesize</B> tag.
		<HR>
		<CFABORT>
	</CFIF>
</CFLOOP>
<cffile action="READ" file="#Attributes.file#" variable="Gif">
<CFSET Type_JPG="ÿØÿà">
<CFSET Type_GIF="GIF8">
<CFSET Width="">
<CFSET Height="">
<CFSET Header="">
<CFSET ImageType=Left(GIF,4)>
<CFIF ImageType is Type_JPG>
	<CFSET MYString="">
	<CFSET POSITION = 1> 
	<CFLOOP Condition="Position LE Len(GIF)">
		<CFSET C=Mid(Gif,Position,1)>
		<CFIF  (ASC(C) is 218) >
			<CFBREAK>
		</CFIF> 
		<CFSET Header=ListAppend(Header,ASC(C))>
		<CFSET POSITION = Position +1>
	</cfloop>
	
	<CFSET Position=0>
	<CFSET POSITION = Find("255,192",Header)>
	<CFIF Position is 0>
		<CFSET POSITION = Find("255,193",Header)>
	</cfif>
	<CFIF Position is 0>
		<CFSET POSITION = Find("255,194",Header)>
	</cfif>
	<CFIF Position is 0>
		<CFSET POSITION = Find("255,195",Header)>
	</cfif>
	<CFIF Position is 0>
		<CFSET POSITION = Find("255,196",Header)>
	</cfif>
	<CFIF Position is 0>
		<CFSET POSITION = Find("255,197",Header)>
	</cfif>
	<CFIF Position is 0>
		<CFSET POSITION = Find("255,198",Header)>
	</cfif>
	<CFIF Position is 0>
		<CFSET POSITION = Find("255,199",Header)>
	</cfif>
	<CFIF Position is 0>
		<CFSET POSITION = Find("255,201",Header)>
	</cfif>
	<CFIF Position is 0>
		<CFSET POSITION = Find("255,202",Header)>
	</cfif>
	<CFIF Position is 0>
		<CFSET POSITION = Find("255,203",Header)>
	</cfif>
	<CFIF Position is 0>
		<CFSET POSITION = Find("255,205",Header)>
	</cfif>
	<CFIF Position is 0>
		<CFSET POSITION = Find("255,206",Header)>
	</cfif>
	<CFIF Position is 0>
		<CFSET POSITION = Find("255,207",Header)>
	</cfif>
	<CFIF Position is 0>
		ERROR
	<CFELSE>
		<CFSET Header=Mid(Header,POSITION,Len(Header) - POsition)>
		<CFSET CompressionType=ListGetAt(Header,2)>
		<CFSET Length=ListGetAt(Header,3) & " " & ListGetAt(Header,4)>
		<CFSET Caller.Type=ListGetAt(Header,5)>
		<CFSET Caller.Height=(ListGetAt(Header,6)*256) + ListGetAt(Header,7)>
		<CFSET Caller.Width=(ListGetAt(Header,8)*256) + ListGetAt(Header,9)>
	</cfif>
<CFELSEIF ImageType is Type_GIF>
	<CFSET Caller.Width=(ASC(Mid(Gif, 7, 1)) + (ASC(Mid(Gif, 8, 1)))*256)>
	<CFSET Caller.Height=(ASC(Mid(Gif, 9, 1)) + (ASC(Mid(Gif, 10, 1)))*256)>
	<CFSET Caller.Type=Mid(Gif, 1, 6)>
<CFELSE>
 ERROR:
</cfif> 

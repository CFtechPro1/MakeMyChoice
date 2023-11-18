<meta name="robots" content="noindex" />
<meta name="googlebot" content="index" />


<cfoutput>
	#GetCurrentTemplatePath()#
</cfoutput>

<cfoutput>
	#GetBaseTemplatePath()#
</cfoutput>


<!--- Get request from ColdFusion page contenxt. --->
<cfset objRequest = GetPageContext().GetRequest() />
 

<!--- Get requested URL from request object. --->
<cfset strUrl = objRequest.GetRequestUrl().Append(
"?" & objRequest.GetQueryString()
).ToString()
/>

<cfoutput>#strUrl#</cfoutput>



<cfform>
<cftextarea richtext="yes" toolbar="Basic" name="somefield"></cftextarea>
<input type="Submit">
</cfform>
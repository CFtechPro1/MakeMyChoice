


<cfparam name="form.function" default=0>


	<cfif form.function eq "switchOrg">
    
     	<cfquery name="get" datasource="#application.dsn#">
        	SELECT org_name 
            FROM t_orgs
            WHERE orgid = #form.orgid#
        </cfquery>   
        
          <!--- Set org client vars --->
			
            <cfset client.org_name = get.org_name>
            <cfset client.orgid = form.orgid>
     
            <cfoutput>
                <cflocation url="../index.cfm?fa=my_profile&updated=1">
            </cfoutput>
            
	</cfif>
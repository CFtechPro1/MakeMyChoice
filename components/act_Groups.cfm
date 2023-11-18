<cfparam name="form.function" default=0>
<cfparam name="url.delMembers" default=0>

	<!--- Call Component/function to update Group Members that are Typed in --->
<cfif form.function eq "typedMembers">
	<cfscript>
		objTypedMembers = createObject("component","GroupsCFC");
    </cfscript>   
     
    <cfparam name="url.ab_mid" default=0>
    <cfparam name="url.gid" default=0>
    

    
    <cfset toNum = (Listlen(form.fieldnames) - 2) / 3> 
    
<!---        <cfoutput>
    #form.fieldnames# - #toNum# - #url.ab_mid# - #url.gid#
    </cfoutput>
    <cfabort>   --->   
      
    <cfloop from="1" to="#toNum#" index="i">
    	<cfscript>
    		isTypedMembers = objTypedMembers.typedGroupMembers(
			gid = url.gid,
			ab_mid = url.ab_mid,
			firstName = evaluate("form.firstName_g_" & i), 
			lastName = evaluate("form.lastName_g_" & i), 
			emailAddress = evaluate("form.emailAddress_g_" & i) 
			); 
		</cfscript>
    </cfloop>
	
			<cfoutput>
                <cflocation url="../index.cfm?fa=group_members_add&gid=#url.gid#&updated=1" addtoken="no">
            </cfoutput>
</cfif> 


	<!--- Call Component/function to add member from profile --->
<cfif form.function eq "addMember">
	<cfscript>
		objMembers = createObject("component","GroupsCFC");
    </cfscript>   
     
    <cfparam name="form.gid" default=0>
    <cfparam name="form.mid" default=0>

    	<cfquery name="check" datasource="#application.dsn#">
        	SELECT id FROM t_group_members
            WHERE mid = #form.mid#
            	AND gid = #form.gid#
                AND ab_mid = #client.mid#
        </cfquery>
        
        	<cfif check.recordcount neq 0>
				<cfoutput>
                    <cflocation url="../index.cfm?fa=profile&mid=#form.mid#&existed=1" addtoken="no">
                </cfoutput>            
            </cfif>
	         
			<cfquery name="m" datasource="#application.dsn#">
                SELECT m.username, m.first_name, m.last_name, m.email_address,
							p.d_first_name, p.d_last_name, p.d_email_address 
                FROM 
					t_members m 
						INNER JOIN t_profile_display p
							ON m.id = p.mid
                	WHERE m.id = #form.mid#
            </cfquery>
			
			
    	<cfscript>
    		isMembers = objMembers.addMember(
			gid = form.gid,
			mid = form.mid,
			ab_mid = client.mid,
			firstName = m.first_name, 
			lastName = m.last_name, 
			emailAddress = m.email_address 
			); 
		</cfscript>

	
			<cfoutput>
                <cflocation url="../index.cfm?fa=profile&mid=#form.mid#&gid=#form.gid#&added=1" addtoken="no">
            </cfoutput>
</cfif> 


	<!--- Call Component/function to delete Group Members that are Removed from the List. --->
<cfif url.delMembers eq 1>
	<cfscript>
		objDeleteMembers = createObject("component","GroupsCFC");
    </cfscript>   
     
    <cfparam name="url.ab_mid" default=0>
    <cfparam name="url.gid" default=0>
    
    <cfset memberList = form.fieldnames> 
   
<!---     <cfoutput>
    #form.fieldnames# - #url.ab_mid# - #url.gid#
    </cfoutput>
    <cfabort>    --->   

    	<cfscript>
    		isDeleteMembers = objDeleteMembers.deleteGroupMembers(
			gid = url.gid,
			ab_mid = url.ab_mid,
			memberList = '#memberList#'
			); 
		</cfscript>
	
			<cfoutput>
                <cflocation url="../index.cfm?fa=group_members_add&gid=#url.gid#&updated=1" addtoken="no">
            </cfoutput>
</cfif> 

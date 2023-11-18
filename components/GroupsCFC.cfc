<cfcomponent hint="Component for Group functions">

	<cffunction name="init" output="false">
    	<cfreturn this />
	</cffunction>

    	<!--- Function for Typed Group Members. --->
	<cffunction name="typedGroupMembers" returntype="string">
      
     	<cfargument name="gid" required="yes">
		<cfargument name="ab_mid" required="yes">
		<cfargument name="firstName" required="yes">
        <cfargument name="lastName" required="no" default="">
        <cfargument name="emailAddress" required="yes">
		<cfargument name="profile" required="no" default=0>
        
            <cfquery name="g" datasource="#application.dsn#">
                SELECT id, mid, group_name
                FROM t_groups 
                	WHERE id = #arguments.gid#
            </cfquery>
			
            <cfquery name="isMember" datasource="#application.dsn#" maxrows="1">
                SELECT id, username, email_address
                FROM t_members 
                	WHERE email_address = '#trim(arguments.emailAddress)#'
            </cfquery>			
			                 
            <cfquery name="add_member" datasource="#application.dsn#">
                INSERT INTO t_group_members
                (<cfif isMember.recordcount neq 0>mid, </cfif>gid, ab_mid, firstName, lastName, emailAddress, date_created)
                VALUES
                (<cfif isMember.recordcount neq 0>#isMember.id#, </cfif>'#arguments.gid#','#arguments.ab_mid#', '#arguments.firstName#', '#arguments.lastName#','#arguments.emailAddress#',
                	CURRENT_TIMESTAMP)
            </cfquery>	
  
 		<cfif isMember.recordcount neq 0>
			 <cfquery name="add_m" datasource="#application.dsn#">
                INSERT INTO t_messages
                (s_mid, s_email, r_mid, r_email, m_subject, m_text, date_created, personal)
                VALUES
                ('#client.mid#','#client.email_address#', '#isMember.id#', '#isMember.email_address#',
                	'You have been invited to join a Group!',
					'Hello #arguments.firstName# #arguments.lastName#,
    						<br /><br />
							#client.username# has invited you to become a member 
							<br />
							of the MakeMyChoice.com Group: <strong>#g.group_name#</strong>
							<br /><br />
							Click on the link below to accept membership, or to opt out of this group.
							<br /><br />
							<a href="http://www.MakeMyChoice.com/index.cfm?fa=group_confirm&mid=#arguments.ab_mid#&gid=#arguments.gid#" class="bodylink">
								http://www.MakeMyChoice.com/index.cfm?fa=group_confirm&mid=#arguments.ab_mid#&gid=#arguments.gid#
							</a>
							<br><br>'
					, CURRENT_TIMESTAMP, 1)
            </cfquery>	 
		</cfif>        

<cfif arguments.emailAddress CONTAINS "@" AND arguments.emailAddress CONTAINS ".">

	<!--- Send out group invitation email --->
 	<cfmail from="#client.email_address#" to="#arguments.emailAddress#" subject="#client.name#'s Group: #g.group_name#"  type="html">

    	<cfinclude template="../email_invite.cfm">
    
	</cfmail>	
    
</cfif>
      	
	
	</cffunction>

    	<!--- Function for Adding Group Members from Profile. --->
	<cffunction name="addMember" returntype="string">
      
     	<cfargument name="gid" required="yes">
		<cfargument name="mid" required="yes">
		<cfargument name="ab_mid" required="yes">
		<cfargument name="firstName" required="yes">
        <cfargument name="lastName" required="no" default="">
        <cfargument name="emailAddress" required="yes">
		<cfargument name="profile" required="no" default=1>
        
            <cfquery name="g" datasource="#application.dsn#">
                SELECT id, mid, group_name
                FROM t_groups 
                	WHERE id = #arguments.gid#
            </cfquery>
			
		                 
            <cfquery name="add_member" datasource="#application.dsn#">
                INSERT INTO t_group_members
                (mid, gid, ab_mid, firstName, lastName, emailAddress, date_created)
                VALUES
                (#arguments.mid#, '#arguments.gid#','#arguments.ab_mid#', '#arguments.firstName#', '#arguments.lastName#','#arguments.emailAddress#',
                	CURRENT_TIMESTAMP)
            </cfquery>	
			

			 <cfquery name="add_m" datasource="#application.dsn#">
                INSERT INTO t_messages
                (s_mid, s_email, r_mid, r_email, m_subject, m_text, date_created, personal)
                VALUES
                ('#client.mid#','#client.email_address#', '#isMember.id#', '#isMember.email_address#',
                	'You have been invited to join a Group!',
					'Hello #arguments.firstName# #arguments.lastName#,
    						<br /><br />
							#client.username# has invited you to become a member 
							<br />
							of the MakeMyChoice.com Group: <strong>#g.group_name#</strong>
							<br /><br />
							Click on the link below to accept membership, or to opt out of this group.
							<br /><br />
							<a href="http://www.MakeMyChoice.com/index.cfm?fa=group_confirm&mid=#arguments.ab_mid#&gid=#arguments.gid#" class="bodylink">
								http://www.MakeMyChoice.com/index.cfm?fa=group_confirm&mid=#arguments.ab_mid#&gid=#arguments.gid#
							</a>
								<br /><br />
								See their member profile:	
								<a href="http://www.MakeMyChoice.com/index.cfm?fa=profile&mid=#arguments.ab_mid#" class="bodylink">
									http://www.MakeMyChoice.com/index.cfm?fa=profile&mid=#arguments.ab_mid#
								</a>		
							<br><br>'
					, CURRENT_TIMESTAMP, 1)
            </cfquery>	 
       

<cfif arguments.emailAddress CONTAINS "@" AND arguments.emailAddress CONTAINS ".">
	<!--- Send out group invitation email to this member. --->
 	<cfmail from="info@makemychoice.com" to="#arguments.emailAddress#" subject="#client.username#'s Group: #g.group_name#"  type="html">

    	<cfinclude template="../email_invite.cfm">
    
	</cfmail>	
    
</cfif>
      	
	
	</cffunction>

    	<!--- Function for deleting Group Members. --->
	<cffunction name="deleteGroupMembers" returntype="string">
      
     	<cfargument name="gid" required="yes">
		<cfargument name="ab_mid" required="yes">
		<cfargument name="memberList" required="yes">
                            
            <cfquery name="add_feedback" datasource="#application.dsn#">
                DELETE t_group_members
                WHERE id NOT IN (#arguments.memberList#)
                	AND ab_mid = #arguments.ab_mid#
                    AND gid = #arguments.gid#
            </cfquery>	

	</cffunction>
    
</cfcomponent>
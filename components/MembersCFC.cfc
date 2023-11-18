



<cfcomponent hint="Component for Member login and sign up functions">

	<!--- Function to login in a client. --->
	<cffunction name="memberLogin" returnType="string" output="yes">
	
		<cfargument name="username" required="yes">
		<cfargument name="password" required="yes">
        <cfargument name="mid" required="no" default=0>
		<cfargument name="cid" required="no" default=0>
		<cfargument name="gid" required="no" default=0>

		
	
		<cfquery name="login" datasource="#application.dsn#">
			SELECT id, username, password, first_name, last_name, email_address
			FROM t_members
			WHERE username = '#trim(arguments.username)#'
				AND password = '#trim(arguments.password)#'
		</cfquery>
		

	
		<cfif login.recordcount eq 0>
			
    		<cfoutput>
                <cflocation url="../index.cfm?fa=login&denied=1&mid=#arguments.mid#&cid=#arguments.cid#&gid=#arguments.gid#">
			</cfoutput>
            
		<cfelse>		
		
			
			<!--- Set client vars --->
			<cfset client.mid = login.id>
			<cfset client.email_address = login.email_address>
			<cfset client.username = login.username>
			<cfset client.name = login.first_name & " " & login.last_name>

			<cfif arguments.cid neq 0>
				<cfif arguments.gid eq 0>
            		<cflocation url="../index.cfm?fa=choice_feedback&loggedin=1&mid=#arguments.mid#&cid=#arguments.cid#">
				<cfelse>
					<cflocation url="../index.cfm?fa=choice_feedback&loggedin=1&mid=#arguments.mid#&cid=#arguments.cid#&gid=#arguments.gid#">
				</cfif>
			<cfelseif arguments.gid neq 0>
            	<cfparam name="gr.confirmed" default="">
				<cfquery name="gr" datasource="#application.dsn#">
					SELECT confirmed 
                    FROM t_group_members
					WHERE gid = #arguments.gid#
					AND mid = #client.mid#
				</cfquery>
				<cfquery name="group" datasource="#application.dsn#">
                    SELECT     id, mid
                    FROM         t_groups
                    WHERE     id = #arguments.gid#
				</cfquery>
             <cfoutput>
                <cfif gr.confirmed eq 0>
                   <cflocation url="../index.cfm?fa=group_confirm&gid=#arguments.gid#&mid=#client.mid#&i_mid=#group.mid#">	
                <cfelseif gr.confirmed eq 1>
                   <cflocation url="../groups/?gid=#arguments.gid#">
                <cfelseif gr.confirmed eq "">
                   <cflocation url="../index.cfm?fa=my_groups&nog=1">
                </cfif>
             </cfoutput>
            <cfelse>		
                <cflocation url="../index.cfm?fa=new_choice&loggedin=1">
            </cfif>
            
		</cfif>
	
	</cffunction>

	<!--- Function for Sign Up add Member --->
	<cffunction name="addMember" returntype="string">
	
		<cfargument name="first_name" required="yes">
		<cfargument name="last_name" required="yes">
		<cfargument name="username" required="yes">
		<cfargument name="password" required="yes">
		<cfargument name="email_address" required="yes">
		<cfargument name="country" required="yes">
		<cfargument name="zip_code" required="yes">
		<cfargument name="birth_month" required="yes">
		<cfargument name="birth_day" required="yes">
		<cfargument name="birth_year" required="yes">
		<cfargument name="gender" required="yes">
		<cfargument name="marital_status" required="yes">
		<cfargument name="cultural_heritage" required="yes">
		<cfargument name="other_heritage" required="no" default="">
		<cfargument name="children" required="yes">
		<cfargument name="hobbies" required="no" default="">
		<cfargument name="profession" required="no" default="">
        <cfargument name="referred_by" required="no" default="">
        <cfargument name="cid" required="no" default=0>
        <cfargument name="mid" required="no" default=0>
        <cfargument name="remote_addr" required="no" default=0>
        <cfargument name="remote_ident" required="no" default=0>
		<cfargument name="catList" required="yes" default="">
		<cfargument name="gid" required="no" default=0>
		
<!---   		<cfoutput>
			#catList#
		</cfoutput>
		<cfabort>  		 --->

		<cfset variables.dob = arguments.birth_month & "/" & arguments.birth_day & "/" & arguments.birth_year>
		   
		<cfquery name="signup" datasource="#application.dsn#">
			INSERT INTO t_members
			(first_name, last_name, username, password, email_address, country, zip_code, dob, gender, marital_status, cultural_heritage, children, hobbies, profession, date_created, remote_addr, remote_ident, referred_by)
			VALUES
			('#arguments.first_name#', '#arguments.last_name#', '#arguments.username#', '#arguments.password#', '#arguments.email_address#', '#arguments.country#', '#arguments.zip_code#', '#variables.dob#',  '#arguments.gender#', '#arguments.marital_status#', '#arguments.cultural_heritage#', '#arguments.children#', '#arguments.hobbies#', '#arguments.profession#', CURRENT_TIMESTAMP,'#arguments.remote_addr#','#arguments.remote_ident#','#arguments.referred_by#')
	
		SELECT @@IDENTITY  AS mid

		</cfquery>	
                 
                 <!--- Sets default values for profile display   --->  	
        <cfquery name="pd" datasource="#application.dsn#">
        	INSERT INTO t_profile_display
            	(mid)
            VALUES
            	(#signup.mid#)
        </cfquery>


		
      	<cfloop list="#arguments.catList#" index="i">
            <cfquery name="add_cats" datasource="#application.dsn#">
                INSERT INTO t_member_cats
                    (mid, cat_id)
                  VALUES (#signup.mid#, #i#)
            </cfquery>   
        </cfloop>
	
		<cfdirectory action="create" directory="#application.filepath#media\#signup.mid#">

		<cfset url.mid = signup.mid>
		
		<!--- Send welcome EMAIL to new member --->
     <cfmail from="info@MakeMyChoice.com" to="#arguments.email_address#" subject="MakeMyChoice.com Member Info" server="mail.makemychoice.com" type="HTML">
	
		<cfinclude template="../email_welcome.cfm">
		
	</cfmail>	
    
   	<cfmail from="info@MakeMyChoice.com" to="dom@makemychoice.com,jonathan@makemychoice.com" subject="MakeMyChoice.com New Member Sign up" server="mail.makemychoice.com" type="HTML">
	
		<cfinclude template="../email_welcome.cfm">
		
	</cfmail>	
    	
			
			<!--- Set client vars --->
			<cfset client.mid = signup.mid>
			<cfset client.email_address = arguments.email_address>
			<cfset client.username = arguments.username>
			<cfset client.name = arguments.first_name & " " & arguments.last_name>


		<cfif arguments.cid neq 0>		
        	<cfoutput>
        		<cflocation url="../index.cfm?fa=choice_feedback&mid=#arguments.mid#&cid=#arguments.cid#">
            </cfoutput>		
		<cfelseif arguments.gid neq 0>
			<cfquery name="gr" datasource="#application.dsn#">
				SELECT mid FROM t_groups
				WHERE id = #arguments.gid#
			</cfquery>
			<cfoutput>
        		<cflocation url="../index.cfm?fa=group_confirm&gid=#arguments.gid#&mid=#client.mid#&i_mid=#gr.mid#">
            </cfoutput>		
        <cfelse>
			<cflocation url="../index.cfm?fa=new_choice&signedup=1">	
        </cfif>
	
	</cffunction>
    

	<!--- Function to update Member's Profile --->
	<cffunction name="updateMember" returntype="string">
	
		<cfargument name="first_name" required="yes">
		<cfargument name="last_name" required="yes">
		<cfargument name="username" required="yes">
		<cfargument name="password" required="yes">
		<cfargument name="email_address" required="yes">
		<cfargument name="country" required="yes">
		<cfargument name="zip_code" required="yes">
		<cfargument name="gender" required="yes">
		<cfargument name="marital_status" required="yes">
		<cfargument name="cultural_heritage" required="yes">
		<cfargument name="children" required="no" default=0>
		<cfargument name="hobbies" required="no" default="">
		<cfargument name="profession" required="no" default="">
 		<cfargument name="birth_month" required="no" default=0>
        <cfargument name="birth_day" required="no" default=0>   
        <cfargument name="birth_year" required="no" default=0>    
        
        <cfargument name="d_first_name" required="yes">
		<cfargument name="d_email_address" required="yes">
		<cfargument name="d_country" required="yes">
		<cfargument name="d_zip_code" required="yes">
		<cfargument name="d_gender" required="yes">
		<cfargument name="d_marital_status" required="yes">
		<cfargument name="d_cultural_heritage" required="yes">
		<cfargument name="d_children" required="no" default=0>
		<cfargument name="d_hobbies" required="no" default="">
		<cfargument name="d_profession" required="no" default="">
        <cfargument name="d_dob" required="no" default="">      
        
        
 		<cfquery name="signup" datasource="#application.dsn#">
			UPDATE t_members
			SET 
            	first_name = '#arguments.first_name#', 
                last_name = '#arguments.last_name#',
                username = '#arguments.username#',
                password = '#arguments.password#',
                email_address = '#arguments.email_address#',
                country = '#arguments.country#',
                zip_code = '#arguments.zip_code#',
                marital_status = '#arguments.marital_status#',
                cultural_heritage = '#arguments.cultural_heritage#',
                children = '#arguments.children#',
                 hobbies = '#arguments.hobbies#',
                profession = '#arguments.profession#',
                dob = '#arguments.birth_month#/#arguments.birth_day#/#arguments.birth_year#'
                
            WHERE id = #client.mid#            
         </cfquery>

 		<cfquery name="display" datasource="#application.dsn#">
			UPDATE t_profile_display
			SET 
            	d_first_name = #arguments.d_first_name#, 
                d_email_address = #arguments.d_email_address#,
                d_country = #arguments.d_country#,
                d_zip_code = #arguments.d_zip_code#,
                d_marital_status = #arguments.d_marital_status#,
                d_cultural_heritage = #arguments.d_cultural_heritage#,
                d_children = #arguments.d_children#,
                d_hobbies = #arguments.d_hobbies#,
                d_profession = #arguments.d_profession#,
                d_dob = #arguments.d_dob#
                
            WHERE mid = #client.mid#            
         </cfquery>                               
                
            <cfset client.email_address = arguments.email_address>
			<cfset client.username = arguments.username>
			<cfset client.name = arguments.first_name & " " & arguments.last_name>
			


		     <cfoutput>
        		<cflocation url="../index.cfm?fa=my_profile&updated=1">
            </cfoutput>          


	</cffunction>



<!--- Function to update Details of Member's Profile --->
	<cffunction name="updateDetails" returntype="string">
    
		<cfargument name="details" required="yes">	       		       	   
					       
            <cfquery name="details_update" datasource="#application.dsn#">
                Update t_members
                 	SET 
                        details = '#arguments.details#'
                WHERE id = #client.mid#
            </cfquery>	
            
 		    <cfoutput>
        		<cflocation url="../index.cfm?fa=my_profile&updated=1">
            </cfoutput>   
                       
	</cffunction>



	
	<!--- Function to display password and email password to client. --->
	<cffunction name="resendPassword" returnType="numeric" output="yes">
	
		<cfargument name="email_address" required="yes">
		
		
		<cfquery name="get_pass" datasource="#application.dsn#" maxrows="1">
			SELECT id, username, email_address, password, first_name, last_name
			FROM t_members
			WHERE email_address = '#trim(arguments.email_address)#'
		</cfquery>		 
	
	<cfif get_pass.recordcount neq 0>
	
     <cfmail from="info@MakeMyChoice.com" to="#get_pass.email_address#" subject="MakeMyChoice.com Password Request">
	
		Member Password request email:
		
		Username: #get_pass.username#
		Password: #get_pass.password#
		
		Login at:
		http://www.MakeMyChoice.com/index.cfm?fa=login
		
		Best Regards,
		
		
		The MakeMyChoice.com Team
		
	</cfmail>
	
		<cflocation url="../index.cfm?fa=get_pass&resent=1&resend=1">
		
	<cfelse>
		<cflocation url="../index.cfm?fa=get_pass&resend=1&denied=1">	
	</cfif>
	
	</cffunction>
	
	
	<!--- Function to CHANGE password. --->
	
	<cffunction name="changePassword" output="yes" returnType="string">
	
		<cfargument name="email_address" required="yes">
		<cfargument name="old_password" required="yes">
		<cfargument name="new_password" required="yes">
		<cfargument name="new_password2" required="yes">
		
		<cfif arguments.new_password neq arguments.new_password2>
			<cflocation url="index.cfm?fa=get_pass&change=1&np=1">
		</cfif>
	
		<cfquery name="get_pass" datasource="#application.dsn#">
			SELECT id, email_address, password, first_name, last_name
			FROM t_members
			WHERE email_address = '#trim(arguments.email_address)#'
		</cfquery>		
        
		<cfif trim(arguments.old_password) eq get_pass.password>
        
            <cfquery name="update_pass" datasource="#application.dsn#">
                UPDATE t_members
                SET password = '#trim(arguments.new_password)#'
                WHERE id = #get_pass.id#
            </cfquery>		
            
			<cfoutput>
                <cflocation url="../index.cfm?fa=get_pass&updated=1&change=1">
            </cfoutput>
            
        <cfelse>
       		<cflocation url="../index.cfm?fa=get_pass&change=1&op=1"> 
        </cfif>
	
	</cffunction>
	
	<!--- *** This is a deprecated function, no longer in use. *** --->
<!--- Function for adding an ORG --->
	<cffunction name="addOrg" returntype="string">
	
		<cfargument name="org_name" required="yes">
		<cfargument name="poc_name" required="yes">
		<cfargument name="poc_email" required="yes">
		<cfargument name="group_name" required="yes">
		<cfargument name="address1" required="no" default="">
		<cfargument name="address2" required="no" default="">
		<cfargument name="city" required="no" default="">
		<cfargument name="state" required="no" default="">
		<cfargument name="zip_code" required="no" default="">
		<cfargument name="phone" required="no" default="">

		   <!--- Get new org ID   --->  	
        <cfquery name="max" datasource="#application.dsn#">
        	SELECT (MAX(orgid) + 1) AS new_orgid
			FROM t_groups
        </cfquery>	 
		   
		<cfquery name="insOrg" datasource="#application.dsn#">
			INSERT INTO t_orgs
			(orgid, org_name, mid, poc_name, poc_email, address1, address2, city, state, zip_code, phone)
			VALUES
			('#max.new_orgid#','#arguments.org_name#', '#client.mid#', '#arguments.poc_name#', '#arguments.poc_email#', '#arguments.address1#', '#arguments.address2#', '#arguments.city#', '#arguments.state#', '#arguments.zip_code#', '#arguments.phone#')
	
		</cfquery>	
   
                 <!--- Adds org designation if this is a pro account.   --->  	
        <cfquery name="insGroup" datasource="#application.dsn#">
        	INSERT INTO t_groups
            	(group_name, date_created, pro, orgid)
            VALUES
            	('#arguments.group_name#', CURRENT_TIMESTAMP, 1, #max.new_orgid#)
        </cfquery>		

<cfif arguments.poc_email CONTAINS "@" AND arguments.poc_email CONTAINS ".">

     <cfmail from="info@MakeMyChoice.com" to="#arguments.poc_email#" subject="MakeMyChoice.com Organization Set Up" server="mail.makemychoice.com">
	
		Welcome #arguments.org_name# to MakeMyChoice.com
		
		MakeMyChoice.com Organization Info:
		
		Organization name: #arguments.org_name# 
		Org ID: #max.new_orgid#
		Group name: #arguments.group_name#
		
		You may administer your Organization and create new groups at:
		http://www.MakeMyChoice.com/index.cfm?fa=my_profile
		
		Now you can give all the people in your organization your Org ID: #max.new_orgid# 
       	to enter when they sign up for MakeMyChoice.com.
        
		They will enter your Org ID upon sign up, or login, 
        and also choose your group: #arguments.group_name# when requesting feedback.
		
		If you have any questions or concerns please do not hesitate to contact us at:
		info@makemychoice.com
		
		Thank you!
		
		
		www.MakeMyChoice.com
		
	</cfmail>	
	
    
   	<cfmail from="info@MakeMyChoice.com" to="dtkelly72@yahoo.com,hortonjont@yahoo.com" subject="MakeMyChoice.com Organization Set Up" server="mail.makemychoice.com">
	
		Welcome #arguments.org_name# to MakeMyChoice.com
		
		MakeMyChoice.com Organization Info:
		
		Organization name: #arguments.org_name# 
		Org ID: #max.new_orgid#
		Group name: #arguments.group_name#
		
		You may administer your Organization and create new groups at:
		http://www.MakeMyChoice.com/index.cfm?fa=my_profile
		
		Now you can give all the people in your organization your Org ID: #max.new_orgid# 
        to enter when they sign up for MakeMyChoice.com.
        
		They will enter your Org ID upon sign up, or login, and also choose your group: #arguments.group_name# 
        when requesting feedback.
		
		If you have any questions or concerns please do not hesitate to contact us at:
		info@makemychoice.com
		
		Thank you!
		
		
		www.MakeMyChoice.com
		
	</cfmail>	
	
</cfif>
		<cfoutput>
            	<cfset client.orgid = max.new_orgid>
                <cfset client.org_name = arguments.org_name> 
                <cflocation url="../index.cfm?fa=my_choices&newOrg=1"> 
        </cfoutput>

	
	</cffunction>	
	
	<!--- *** The ABOVE is a deprecated function, no longer in use. *** --->
	
</cfcomponent>




<cfcomponent hint="Component for Choices functions">

	<cffunction name="init" output="false">
    	<cfreturn this />
	</cffunction>

	<!--- Function to ADD a Choice. --->
	<cffunction name="addChoice" returnType="string" output="yes">
	
		<cfargument name="short_desc" required="yes">
		<cfargument name="details" required="yes">
		<cfargument name="num_of_answers" required="yes">
        <cfargument name="anon" required="yes">
        <cfargument name="type" required="yes">
        <cfargument name="date_end" required="no" default="#DateAdd('D', 1, DateFormat(Now(),'mm/dd/yyyy'))#">
        <cfargument name="email_me" required="no" default="0">
        <cfargument name="catList" required="yes" default="">
		<cfargument name="gid" required="no" default="0">
         

		<cfquery name="add_c" datasource="#application.dsn#">
			INSERT INTO t_choices
			(mid, username, short_desc, details, date_created, anon, type, date_end, email_me, num_of_answers, gid)
			VALUES
			('#client.mid#',<cfif arguments.anon eq 1>'Anonymous'<cfelse>'#client.username#'</cfif>,'#arguments.short_desc#', '#arguments.details#', CURRENT_TIMESTAMP, 
            '#arguments.anon#', '#arguments.type#', '#DateFormat(arguments.date_end,"mm/dd/yyyy")#', '#arguments.email_me#', '#arguments.num_of_answers#', #arguments.gid#)
	
			SELECT @@IDENTITY  AS cid
		</cfquery>	
        
      	<cfloop list="#catList#" index="i">
            <cfquery name="add_cats" datasource="#application.dsn#">
                INSERT INTO t_choice_cats
                    (mid, cid, cat_id)
                  VALUES(#client.mid#, #add_c.cid#, #i#)
            </cfquery>   
        </cfloop>
	
		<cfif arguments.type eq "multiple">
			<cfoutput>
                <cflocation url="../index.cfm?fa=add_answers&cid=#add_c.cid#&num_of_answers=#arguments.num_of_answers#&added=1&gid=#arguments.gid#">
            </cfoutput>
        <cfelseif arguments.type eq "yesno">
        
        	 <cfquery name="answersIn1" datasource="#application.dsn#">
                INSERT INTO t_answers
                (cid, mid, answer_text, type, order_num)
                VALUES
                ('#add_c.cid#', '#client.mid#', 'yes', 'text', 1)
            </cfquery>	
            <cfquery name="answersIn1" datasource="#application.dsn#">
                INSERT INTO t_answers
                (cid, mid, answer_text, type, order_num)
                VALUES
                ('#add_c.cid#', '#client.mid#', 'no', 'text', 2)
            </cfquery>	
        
 			<cfoutput>
                <cflocation url="../index.cfm?fa=request_feedback&cid=#add_c.cid#&type=yesno&gid=#arguments.gid#">
            </cfoutput>       
        </cfif>

	
	</cffunction>

	<!--- Function to EDIT a Choice. --->
	<cffunction name="editChoice" returnType="string" output="yes">
    
		<cfargument name="cid" required="yes">
		<cfargument name="short_desc" required="yes">
		<cfargument name="details" required="yes">
        <cfargument name="anon" required="yes">
        <cfargument name="type" required="yes">
        <cfargument name="date_end" required="no" default="#DateAdd('D', 1, DateFormat(Now(),'mm/dd/yyyy'))#">
		<cfargument name="catList" required="yes" default="">


		<cfquery name="up_c" datasource="#application.dsn#">
			UPDATE t_choices
			SET
            	short_desc = '#arguments.short_desc#', 
                details = '#arguments.details#', 
                anon = '#arguments.anon#', 
                type = '#arguments.type#', 
                date_end = '#DateFormat(arguments.date_end,"mm/dd/yyyy")#'
			WHERE id = #arguments.cid# 
            	AND mid = #client.mid#
		</cfquery>	

          <cfquery name="del_c" datasource="#application.dsn#">
              DELETE t_choice_cats 
              WHERE mid = #client.mid#
              		AND cid = #arguments.cid# 
          </cfquery>	

			<cfloop list="#arguments.catList#" index="i">
				<cfquery name="add_cats" datasource="#application.dsn#">
					INSERT INTO t_choice_cats
						(mid, cid, cat_id)
					  VALUES(#client.mid#, #arguments.cid#, #i#)
				</cfquery>   
			</cfloop>			            
            
		<cfif arguments.type eq "multiple">
			<cfoutput>
                <cflocation url="../index.cfm?fa=add_answers&cid=#arguments.cid#&cu=1">
            </cfoutput>
        <cfelseif arguments.type eq "yesno">
        
        	 <cfquery name="answersIn1" datasource="#application.dsn#">
                INSERT INTO t_answers
                (cid, mid, answer_text, type, order_num)
                VALUES
                ('#add_c.cid#', '#client.mid#', 'yes', 'text', 1)
            </cfquery>	
            <cfquery name="answersIn1" datasource="#application.dsn#">
                INSERT INTO t_answers
                (cid, mid, answer_text, type, order_num)
                VALUES
                ('#add_c.cid#', '#client.mid#', 'no', 'text', 2)
            </cfquery>	
        
 			<cfoutput>
                <cflocation url="../index.cfm?fa=request_feedback&cid=#arguments.cid#&type=yesno">
            </cfoutput>       
        </cfif>

	
	</cffunction>
    
    	<!--- Function for Requesting Feedback. --->
	<cffunction name="requestFeedback" returntype="string">
      
		<cfargument name="cid" required="yes">
		<cfargument name="request_type" required="yes">
        <cfargument name="gid" required="no" default=0>
        <cfargument name="gender" required="no" default="">
        <cfargument name="marital_status" required="no" default="">
        <cfargument name="children" required="no" default=0>
        <cfargument name="hobbies" required="no" default="">
        <cfargument name="profession" required="no" default="">
        <cfargument name="country" required="no" default="">
        <cfargument name="zip_code" required="no" default="">
        <cfargument name="cultural_heritage" required="no" default="">
        <cfargument name="min_age" required="no" default="">
        <cfargument name="max_age" required="no" default="">
        
        
        
                 <!--- Insert Requests to the t_requests table --->
            <cfquery name="add_r" datasource="#application.dsn#">
                INSERT INTO t_requests
                (mid, cid, gid, gender, marital_status, children, hobbies, profession, 
                		country, zip_code, cultural_heritage, min_age, max_age, date_created, request_type)
                VALUES
                ('#client.mid#', '#arguments.cid#', '#arguments.gid#', '#arguments.gender#', '#arguments.marital_status#', '#arguments.children#', '#arguments.hobbies#', '#arguments.profession#', 
                		'#arguments.country#', '#arguments.zip_code#', '#arguments.cultural_heritage#', '#arguments.min_age#', '#arguments.max_age#', CURRENT_TIMESTAMP, '#arguments.request_type#')
            </cfquery>	 
            
            
  		<cfquery name="choice" datasource="#application.dsn#">
			SELECT id, username, short_desc, anon
            FROM t_choices
            WHERE id = #arguments.cid#
		</cfquery>	

        <cfif arguments.request_type eq "group">
        
            <cfquery name="members" datasource="#application.dsn#">
                SELECT id, username, first_name, last_name, email_address
                FROM t_members 
                WHERE id IN 
                	(SELECT mid FROM t_group_members 
                    	WHERE gid = #arguments.gid#
						AND confirmed = 1)
                   AND email_requests_g = 1
                   <!--- AND id IN (8,4) --->
            </cfquery>	
			
            <cfquery name="g" datasource="#application.dsn#">
                SELECT id, mid, group_name
                FROM t_groups 
                	WHERE id = #arguments.gid#
            </cfquery>	
            
        <cfelseif arguments.request_type eq "advanced">
           	
        
            <cfquery name="members" datasource="#application.dsn#">
                SELECT id, username, first_name, last_name, email_address 
                FROM t_members 
                WHERE 1=1  AND email_requests_t = 1
                <cfif arguments.gender neq "">
                	AND gender = '#trim(arguments.gender)#'   
                </cfif>
                <cfif arguments.marital_status neq "">
                	AND marital_status = '#trim(arguments.marital_status)#'   
                </cfif>               
                 <cfif arguments.children neq 0>
                	AND children = '#trim(arguments.children)#'   
                </cfif>  
                <cfif arguments.hobbies neq "">
                	AND hobbies LIKE '%#trim(arguments.hobbies)#%'   
                </cfif>  
                <cfif arguments.profession neq "">
                	AND profession LIKE '%#trim(arguments.profession)#%'   
                </cfif>  
                <cfif arguments.country neq "">
                	AND country = '#trim(arguments.country)#'   
                </cfif>  
                <cfif arguments.zip_code neq "">
                	AND zip_code = '#trim(arguments.zip_code)#'   
                </cfif>  
                <cfif arguments.cultural_heritage neq "">
                	AND cultural_heritage = '#trim(arguments.cultural_heritage)#'   
                </cfif>  
                 <cfif arguments.min_age neq "" AND arguments.max_age neq "">
                	AND DATEDIFF(YEAR,DOB,GETDATE()) BETWEEN #trim(arguments.min_age)# AND #trim(arguments.max_age)#
                </cfif> 
                 <cfif arguments.min_age neq "" AND arguments.max_age eq "">
                	AND DATEDIFF(YEAR,DOB,GETDATE()) BETWEEN #trim(arguments.min_age)# AND 110
                </cfif>    
                 <cfif arguments.min_age eq "" AND arguments.max_age neq "">
                	AND DATEDIFF(YEAR,DOB,GETDATE()) BETWEEN 1 AND #trim(arguments.max_age)#
                </cfif>   
                <!--- AND id IN (8,4)    --->            
            </cfquery>	

         <cfelseif arguments.request_type eq "everyone">

				<cfinclude template="../udfs/arrayFind.cfm">
				
				<!--- Get categories for the choice --->
 				<cfquery name="cats_e" datasource="#application.dsn#">
 					SELECT id, mid, cid, cat_id
					FROM  t_choice_cats
					WHERE  cid = #arguments.cid#
				</cfquery>
				<cfset catListChoice = ValueList(cats_e.cat_id)>
				
				<!--- Get all members that have email_requests = 1 --->
            <cfquery name="members" datasource="#application.dsn#">
                SELECT id, username, first_name, last_name, email_address
                FROM t_members 
                WHERE email_requests = 1 
                <!--- AND id IN (8,4,82)  --->
            </cfquery>     
			
<!--- 			<cfoutput>
				#catListChoice#
			</cfoutput>
			<cfabort> --->
			
			<cfset eMemberList = "0">
			
			<cfloop query="members">
				<!--- Get the category list for each member --->
 				<cfquery name="cats_m" datasource="#application.dsn#">
 					SELECT id, mid, cat_id
					FROM  t_member_cats
					WHERE  mid = #members.id#
				</cfquery>		
					<!--- Create an array of the member cats --->	
				<cfset catList = ValueList(cats_m.cat_id)>
				<cfset catArrayList = ListToArray(catList)>
					
					<!--- Loop through the categories for the choice --->
					<cfloop list="#catListChoice#" index="i">
						<!--- If the member categories contain one of the choice categories then add that member to the eMemberList. --->
						<cfif arrayFind(catArrayList, i) neq 0>
							<cfset eMemberList = ListAppend(eMemberList,members.id)>
						</cfif>
					</cfloop>
			</cfloop>
			
<!--- 			<cfoutput>
				#ememberList#
			</cfoutput>
			<cfabort> --->
							
				<!--- Get all members that are in the eMemberList --->
            <cfquery name="members" datasource="#application.dsn#">
                SELECT id, username, first_name, last_name, email_address
                FROM t_members 
                WHERE id IN (#eMemberList#)
            </cfquery>  				         
    

            
         </cfif>
         
            
<cfoutput query="members">
	
	<cfif members.email_address CONTAINS "@" AND members.email_address CONTAINS ".">
       
	   <!--- email feedback request --->     
 <cfmail from="info@MakeMyChoice.com" to="#members.email_address#" subject="Please Help Make this Choice! - #DateFormat(Now(),'mmmm d, yyyy')#" 
 			server = "localhost"
 			username = "dom@makemychoice.com"
 			password = "Woody101"  
            type="html">

	
	<cfinclude template="../email_feedback.cfm">

    
</cfmail>	           
 	
	</cfif>

</cfoutput>
            


<cfif client.email_address CONTAINS "@" AND client.email_address CONTAINS ".">
        
		<!--- email request sent verification email to the member who sent it out.---> 
     <cfmail from="info@MakeMyChoice.com" to="#client.email_address#" subject="Your Recent Choice - #DateFormat(Now(),'mmmm d, yyyy')#"  type="html">
    
		
		<cfinclude template="../email_request_sent.cfm">
	
        
    </cfmail>	

</cfif>
			<cfoutput>
				<cfif arguments.gid eq 0>
                	<cflocation url="../index.cfm?fa=view_choice&cid=#arguments.cid#&mid=#client.mid#&added=1">
				<cfelse>
					<cflocation url="../groups/index.cfm?fa=view_choice&cid=#arguments.cid#&mid=#client.mid#&gid=#arguments.gid#&added=1">
				</cfif>
            </cfoutput>
	
	</cffunction>
	

    	<!--- Function for Providing Feedback. --->
	<cffunction name="provideFeedback" returntype="string">
      
     	<cfargument name="mid" required="yes">
		<cfargument name="cid" required="yes">
		<cfargument name="answer_choice" required="yes">
        <cfargument name="type" required="yes">
        <cfargument name="comments" required="no" default="">
		<cfargument name="gid" required="no" default=0>
        
		<cfquery name="member" datasource="#application.dsn#">
			SELECT id, username, email_address 
            FROM t_members
            WHERE id = #arguments.mid#
		</cfquery>	
		<cfquery name="comment" datasource="#application.dsn#">
			SELECT id, username, email_address 
            FROM t_members
            WHERE id = #client.mid#
		</cfquery>       
		<cfquery name="choice" datasource="#application.dsn#">
			SELECT id, short_desc, email_me 
            FROM t_choices
            WHERE id = #arguments.cid#
		</cfquery>   
 
 			<cfquery name="check" datasource="#application.dsn#">
            	SELECT id
                FROM t_feedback
                WHERE mid = #arguments.mid#
                		AND feedback_mid = #client.mid#
                        AND cid = #arguments.cid#
            </cfquery>
            
            <cfif check.recordcount neq 0>
				<cfoutput>
                    <cflocation url="../index.cfm?fa=choice_feedback&repeat=1&cid=#arguments.cid#&mid=#arguments.mid#">
                </cfoutput>            	
            </cfif>
        
            <cfquery name="add_feedback" datasource="#application.dsn#">
                INSERT INTO t_feedback
                (mid, cid, aid, feedback_mid, date_created)
                VALUES
                ('#arguments.mid#','#arguments.cid#', '#arguments.answer_choice#', '#client.mid#',
                	CURRENT_TIMESTAMP)
            </cfquery>	
         
         <cfif arguments.comments neq "">
            <cfquery name="add_comments" datasource="#application.dsn#">
                INSERT INTO t_comments
                (mid, username, cid, comment_text, s_mid, s_username, date_created)
                VALUES
                ('#arguments.mid#', '#member.username#', '#arguments.cid#', '#arguments.comments#', '#client.mid#', 
                	'#comment.username#', CURRENT_TIMESTAMP)
            </cfquery>	 
         </cfif>
		 
<cfif choice.email_me eq 1>
	<cfif member.email_address CONTAINS "@" AND member.email_address CONTAINS ".">
	
		<!--- sent response notification to member member that created choice. --->
 	<cfmail from="info@MakeMyChoice.com" to="#member.email_address#" subject="You have received feedback - #DateFormat(Now(),'mmmm d, yyyy')#"  
			server = "localhost"
 			username = "dom@makemychoice.com"
 			password = "Woody101"      
    		type="html">

    	<cfinclude template="../email_response.cfm">
    
	</cfmail>	
	</cfif>
</cfif>	      	

<!--- 	<cfoutput>
    	#arguments.gid# test
    </cfoutput>
    <cfabort> --->
			<cfoutput>
				<cfif arguments.gid eq 0>
                	<cflocation url="../index.cfm?fa=view_choice&cid=#arguments.cid#&mid=#arguments.mid#&feedback=1" addtoken="no">
				<cfelse>
					<cflocation url="../groups/index.cfm?fa=view_choice&cid=#arguments.cid#&mid=#arguments.mid#&gid=#arguments.gid#&feedback=1" addtoken="no">
				</cfif>
            </cfoutput>
	
	</cffunction>

</cfcomponent>
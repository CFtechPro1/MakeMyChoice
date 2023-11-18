
<cfparam name="form.gid" default=0>	

		<cfquery name="comment" datasource="#application.dsn#">
			SELECT id, username 
            FROM t_members
            WHERE id = #form.mid#
		</cfquery>   
		<cfquery name="choice" datasource="#application.dsn#">
			SELECT id, mid, short_desc, email_me 
            FROM t_choices
            WHERE id = #form.cid#
		</cfquery>  
            <cfquery name="member" datasource="#application.dsn#">
                SELECT id, username, email_address 
                FROM t_members
                WHERE id = #choice.mid#
            </cfquery>	
            
                   
            <cfquery name="add_comments" datasource="#application.dsn#">
                INSERT INTO t_comments
                (mid, username, cid, comment_text, s_mid, s_username, date_created)
                VALUES
                ('#form.mid#', '#comment.username#', '#form.cid#', '#form.comments#', '#client.mid#', 
                	'#client.username#', CURRENT_TIMESTAMP)
            </cfquery>	
  
<cfif choice.email_me eq 1>

 	<cfmail from="info@MakeMyChoice.com" to="#member.email_address#" subject="You have received feedback - #DateFormat(Now(),'mmmm d, yyyy')#">

    Dear #member.username#,
    
    Someone has provided feedback on one of your choices.
    
    Choice title: "#choice.short_desc#"

    You may view the results as they come in at:
    
    http://www.MakeMyChoice.com/index.cfm?fa=view_choice&mid=#choice.mid#&cid=#form.cid#
    
     note: you can refresh your browser to make sure you are seeing the latest results.
	  
    The link for people to provide feedback on this choice is at:
    
    http://www.MakeMyChoice.com/index.cfm?fa=choice_feedback&mid=#choice.mid#&cid=#form.cid#  
	       
    Thank you for being a part of the MMC community!
    
    
    www.MakeMyChoice.com
    
	</cfmail>	

</cfif>	
            
     		<cfoutput>
				<cfif form.gid eq 0>
                	<cflocation url="../index.cfm?fa=view_choice&cid=#form.cid#&mid=#form.mid#&comment=1" addtoken="no">
				<cfelse>
					<cflocation url="../groups/index.cfm?fa=view_choice&cid=#form.cid#&mid=#form.mid#&gid=#form.gid#&comment=1" addtoken="no">
				</cfif>
            </cfoutput>       
            
     
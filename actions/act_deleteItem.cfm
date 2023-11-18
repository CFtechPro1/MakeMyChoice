<cfparam name="url.comment_id" default="0">
<cfparam name="url.cid" default="0">
<cfparam name="url.gid" default="0">
<cfparam name="url.message_id" default="0">
<cfparam name="url.item" default="0">

	<cfif url.item eq "comment">
    
            <cfquery name="del" datasource="#application.dsn#">
                DELETE t_comments 
                WHERE cid = #trim(url.cid)# AND id = #url.comment_id#
            </cfquery>	
      
       		<cfoutput>
            	<cfif url.gid eq 0>
               		<cflocation url="../index.cfm?fa=view_choice&mid=#url.mid#&cid=#url.cid#&cd=1">
                <cfelse>
                	<cflocation url="../groups/index.cfm?fa=view_choice&mid=#url.mid#&cid=#url.cid#&cd=1&gid=#url.gid#">
                </cfif>
            </cfoutput>
  
            
   <cfelseif url.item eq "message">        

            <cfquery name="del" datasource="#application.dsn#">
                DELETE t_messages 
                WHERE r_mid = #client.mid# AND id = #url.message_id#
            </cfquery>	
       
       		<cfoutput>
                <cflocation url="../index.cfm?fa=my_messages&cid=#url.cid#&md=1">
            </cfoutput>       


   <cfelseif url.item eq "group">        

            <cfquery name="del" datasource="#application.dsn#">
                DELETE t_groups 
                WHERE mid = #client.mid# AND id = #url.gid#
            </cfquery>	
       
       		<cfoutput>
                <cflocation url="../index.cfm?fa=my_groups&gid=#url.gid#&gd=1">
            </cfoutput>    
			
   <cfelseif url.item eq "groupLink">        

            <cfquery name="del" datasource="#application.dsn#">
                DELETE t_group_links 
                WHERE id = #url.link_id#
            </cfquery>	
       
       		<cfoutput>
                <cflocation url="../groups/index.cfm?fa=links&gid=#url.gid#&deleted=1" addtoken="no">
            </cfoutput>  
            
   <cfelseif url.item eq "g_member">        

            <cfquery name="del" datasource="#application.dsn#">
                DELETE t_group_members 
                WHERE mid = #url.mid# 
                AND gid = #url.gid#
                AND ab_mid = #client.mid#
            </cfquery>	
       
       		<cfoutput>
                <cflocation url="../index.cfm?fa=group_members&member=1&gid=#url.gid#&md=1&members=1">
            </cfoutput>   
            
   <cfelseif url.item eq "choice">        

            <cfquery name="del" datasource="#application.dsn#">
                DELETE t_choices 
                WHERE mid = #client.mid# 
                	AND id = #url.cid#
            </cfquery>	
             <cfquery name="delc" datasource="#application.dsn#">
                DELETE t_comments
                WHERE cid = #url.cid#
            </cfquery>	
             <cfquery name="delf" datasource="#application.dsn#">
                DELETE t_feedback
                WHERE cid = #url.cid#
            </cfquery>	       
       		<cfoutput>
                <cflocation url="../index.cfm?fa=my_choices&cd=1">
            </cfoutput>  
            
   <cfelseif url.item eq "suggestion">        

            <cfquery name="del" datasource="#application.dsn#">
                UPDATE t_suggestions 
                	SET deleted = 1
                WHERE mid = #client.mid# 
                	AND id = #url.sid#
            </cfquery>	
       
       		<cfoutput>
                <cflocation url="../index.cfm?fa=suggestion_report&sd=1">
            </cfoutput>  
                   
	</cfif>
	



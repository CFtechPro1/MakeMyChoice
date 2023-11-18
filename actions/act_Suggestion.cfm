


<cfparam name="form.s_subject" default=0>
<cfparam name="form.s_text" default=0>
<cfparam name="form.topic" default=0>
<cfparam name="form.function" default=0>


<cfif form.function eq "addSuggestion">

	<cfif form.botcatcher neq "">
        <cflocation url="index.cfm?fa=suggestion&bot=1">
    </cfif>
    
	<cfinclude template="../udfs/removeAppos.cfm">


    
          <!--- Insert Suggestion to the t_suggestions table --->
            <cfquery name="add_m" datasource="#application.dsn#">
                INSERT INTO t_suggestions
                (mid, username, s_subject, s_text, topic, status, date_created)
                VALUES
                ('#client.mid#','#client.username#',
                	'#form.s_subject#','#form.s_text#','#form.topic#','unread',CURRENT_TIMESTAMP)
            </cfquery>	 
            
     <cfmail from="#trim(client.email_address)#" to="dtkelly72@yahoo.com,hortonjont@yahoo.com" subject="MakeMyChoice.com Suggestion Made">
	
  An MMC member has added a suggestion to the Suggestion Box:
  
  #client.username#  
  #client.name#
  #client.email_address#
  
  Subject: #form.s_subject#
  
  Topic: #form.topic#
  
  Suggestion: 
  #form.s_text#

  The suggestion will be viewable in the suggestion report area on MMC.
  You can alter the status of the suggestion there, once it has been addressed.
  
  Thank you.
		
	</cfmail>	
            
            <cfoutput>
                <cflocation url="../index.cfm?fa=suggestion&sent=1">
            </cfoutput>
            
<cfelseif form.function eq "updateStatus">

          <!--- Update suggestion status --->
            <cfquery name="add_m" datasource="#application.dsn#">
                UPDATE t_suggestions
                SET status = '#form.status#'
                WHERE id = #form.sid#
            </cfquery>	
            
            <cfoutput>
                <cflocation url="../index.cfm?fa=suggestion_report&status=1">
            </cfoutput>
</cfif>
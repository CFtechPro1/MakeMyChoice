
<cfif form.botcatcher neq "">
	<cflocation url="index.cfm?fa=contact&bot=1">
</cfif>

<cfparam name="form.email_address" default=0>
<cfparam name="form.m_subject" default=0>
<cfparam name="form.m_text" default=0>

<cfinclude template="../udfs/removeAppos.cfm">


    
          <!--- Insert message to the t_messages table --->
            <cfquery name="add_m" datasource="#application.dsn#">
                INSERT INTO t_contact
                (<cfif client.mid neq 0>mid, username,</cfif> email_address, m_subject, m_text, date_created)
                VALUES
                (<cfif client.mid neq 0>'#client.mid#','#client.username#',</cfif> '#form.email_address#',
                	'#form.m_subject#','#form.m_text#', CURRENT_TIMESTAMP)
            </cfquery>	 
            
     <cfmail from="#trim(form.email_address)#" to="dtkelly72@yahoo.com,dom@makemychoice.com" subject="MakeMyChoice.com Contact Message">
	
  An MMC contact email message has been sent from:
  
  <cfif client.mid neq 0>
  #client.username#  
  #client.name#
  </cfif>
  #form.email_address#
  
  Subject: #form.m_subject#
  
  Message: 
  #form.m_text#

  Please respond ASAP.
  Thank you
		
	</cfmail>	
            
            <cfoutput>
                <cflocation url="../index.cfm?fa=contact&sent=1">
            </cfoutput>
            

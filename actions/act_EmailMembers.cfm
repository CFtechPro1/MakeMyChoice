
<cfif form.botcatcher neq "">
	<cflocation url="index.cfm?fa=email_members&bot=1">
</cfif>

<cfparam name="form.m_subject" default=0>
<cfparam name="form.m_text" default=0>

    
	<cfquery name="members" datasource="#application.dsn#">
		SELECT DISTINCT email_address, id
		FROM t_members
		<!--- WHERE id IN (585, 606) --->
	</cfquery>
 
 <cfoutput query="members">           
     <cfmail from="info@makemychoice.com" to="#members.email_address#" subject="#form.m_subject#" type="html">
	 
<cfinclude template="../email_template.cfm">
		
	</cfmail>	
</cfoutput>
            
            <cfoutput>
                <cflocation url="../index.cfm?fa=email_members&sent=1">
            </cfoutput>
            

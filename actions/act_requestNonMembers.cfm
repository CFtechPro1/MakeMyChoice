
<cfparam name="url.mid" default=0>
<cfparam name="url.cid" default=0>

<cfinclude template="../udfs/removeAppos.cfm">

<cfquery name="a" datasource="#application.dsn#">
	SELECT anon 
    FROM t_choices 
    WHERE id = #url.cid#
</cfquery>

<cfquery name="request" datasource="#application.dsn#">
	SELECT id
    FROM t_requests 
    WHERE cid = #url.cid#
    AND mid = #client.mid#
</cfquery>

<cfoutput>
    <cfloop from="1" to="10" index="i">
        
        <cfif evaluate('form.name_' & i) neq "" AND evaluate('form.email_' & i) neq "">
        
             <cfmail from="#client.email_address#" to="#evaluate('form.email_' & i)#" subject="Re: Help Making a Choice">
            
                Hello #evaluate('form.name_' & i)#,
                
                <cfif a.anon neq 1>#client.name#<cfelse>An anonymous member</cfif> has to make a choice or decision, and is requesting your feedback.
                
                Please go to the link below and you can very quickly sign up give your feedback.
               
                http://www.MakeMyChoice.com/index.cfm?fa=sign_up&mid=#url.mid#&cid=#url.cid#
                
                
               	Your participation is much appreciated!
                
                Best Regards,
                
                
                www.MakeMyChoice.com
                
            </cfmail>	
        
        </cfif> 
     
     </cfloop>
 </cfoutput>        
 
    <cfif request.recordcount eq 0>
            <cfoutput>
                <cflocation url="../index.cfm?fa=request_feedback&cid=#url.cid#&emails=1">
            </cfoutput>
    <cfelse>
             <cfoutput>
                <cflocation url="../index.cfm?fa=view_choice&mid=#client.mid#&cid=#url.cid#&emails=1">
            </cfoutput>      
    </cfif>
          

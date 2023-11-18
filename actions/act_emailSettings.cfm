<cfparam name="form.email_requests" default="0">
<cfparam name="form.email_requests_g" default="0">
<cfparam name="form.email_requests_t" default="0">
	

    
        <cfquery name="email" datasource="#application.dsn#">
           UPDATE t_members
            SET email_requests = '#form.email_requests#',
				email_requests_g = '#form.email_requests_g#',
           		email_requests_t = '#form.email_requests_t#'
                WHERE id = #client.mid#
        </cfquery>	



        <cfoutput>
            <cflocation url="../index.cfm?fa=my_profile&eSettings=1">
        </cfoutput>
		

 
	



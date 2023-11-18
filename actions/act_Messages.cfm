
<cfparam name="form.function" default=0>
<cfparam name="form.r_mid" default=0>
<cfparam name="form.r_email" default=0>
<cfparam name="form.m_subject" default=0>
<cfparam name="form.m_text" default=0>


	<cfif form.function eq "sendMessage">
    
          <!--- Insert message to the t_messages table --->
            <cfquery name="add_m" datasource="#application.dsn#">
                INSERT INTO t_messages
                (s_mid, s_email, r_mid, r_email, m_subject, m_text, date_created, personal)
                VALUES
                ('#client.mid#','#client.email_address#', '#form.r_mid#', '#form.r_email#',
                	'#form.m_subject#','#form.m_text#', CURRENT_TIMESTAMP, 1)
            </cfquery>	 
            
            <cfoutput>
                <cflocation url="../index.cfm?fa=my_messages&sent=1">
            </cfoutput>
            
    </cfif>
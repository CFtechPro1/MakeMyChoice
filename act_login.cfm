


	<cfquery name="login" datasource="#application.dsn#">
		SELECT client_email, password, first_name, last_name
		FROM dom_clients
			WHERE client_email = '#trim(form.email)#'
				AND password = '#trim(form.password)#'
	</cfquery>
	
	<cfif login.recordcount eq 0>
	
		<cflocation url="index.cfm?fa=login&denied=1">
		
	<cfelse>
	
		<cfset client.email = login.client_email>
		<cfset client.name = login.first_name & login.last_name>
				
		<cflocation url="index.cfm?fa=search_music">
		
	</cfif>
	
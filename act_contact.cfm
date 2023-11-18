	<cfmail from="#form.given_email#" to="dtkelly72@yahoo.com,dom@dommusic.com,jonathan@dommusic.com" subject="#form.subject#">
	
	Support email:
	
	From: #form.name# 
	Given Email: #form.given_email#
	
	#form.description#
	
	</cfmail>



<cfoutput>
	<cflocation url="index.cfm?fa=contact&sent=1">
</cfoutput>
<CFAPPLICATION name="makemychoice" sessionmanagement="Yes" sessiontimeout="#CreateTimeSpan(0,0,10,0)#" 
clientmanagement="yes" clientstorage="MakeMyChoice">

<CFSET application.dsn = "MakeMyChoice">
<CFSET application.filepath = "C:\Websites\204552kh3\">
<CFSET application.urlpath = "http://www.makemychoice.com/">

<cfparam name="client.name" default=0>
<cfparam name="client.email" default=0>
<cfparam name="client.mid" default=0>
<cfparam name="client.email_address" default=0>
<cfparam name="client.username" default=0>
<cfparam name="client.orgid" default=0>
<cfparam name="client.org_name" default=0>
<cfparam name="client.gid" default=0>

<!--- <cfif not isDefined('application.choicesCFC')>
	<cfset application.choicesCFC = createObject('component', 'components.ChoicesCFC').init() />
</cfif> 
 --->


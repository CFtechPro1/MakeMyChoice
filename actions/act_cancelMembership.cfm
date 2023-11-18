
<cftransaction>

<cfdirectory action="delete" directory="#application.filepath#media\#client.mid#" recurse="yes">

<cfquery name="del_1" datasource="#application.dsn#">
	DELETE FROM t_members WHERE id = #client.mid#
</cfquery>

<cfquery name="del_2" datasource="#application.dsn#">
	DELETE FROM t_choices WHERE mid = #client.mid#
</cfquery>

<cfquery name="del_3" datasource="#application.dsn#">
	DELETE FROM t_feedback WHERE feedback_mid = #client.mid#
</cfquery>

<cfquery name="del_4" datasource="#application.dsn#">
	DELETE FROM t_answers WHERE mid = #client.mid#
</cfquery>

<cfquery name="del_5" datasource="#application.dsn#">
	DELETE FROM t_messages WHERE r_mid = #client.mid#
</cfquery>

<cfquery name="del_6" datasource="#application.dsn#">
	DELETE FROM t_messages WHERE s_mid = #client.mid#
</cfquery>

<cfquery name="del_7" datasource="#application.dsn#">
	DELETE FROM t_comments WHERE s_mid = #client.mid#
</cfquery>

<cfquery name="del_8" datasource="#application.dsn#">
	DELETE FROM t_comments WHERE mid = #client.mid#
</cfquery>

<cfquery name="del_9" datasource="#application.dsn#">
	DELETE FROM t_group_members WHERE mid = #client.mid#
</cfquery>

<cfquery name="del_10" datasource="#application.dsn#">
	DELETE FROM t_group_members WHERE ab_mid = #client.mid#
</cfquery>

<cfquery name="del_11" datasource="#application.dsn#">
	DELETE FROM t_groups WHERE mid = #client.mid#
</cfquery>

<cfquery name="del_12" datasource="#application.dsn#">
	DELETE FROM t_profile_display WHERE mid = #client.mid#
</cfquery>

<cfquery name="del_13" datasource="#application.dsn#">
	DELETE FROM t_requests WHERE mid = #client.mid#
</cfquery>

			<!--- Set client vars --->
			<cfset client.mid = 0>
			<cfset client.email_address = 0>
			<cfset client.username = 0>
			<cfset client.name = 0>

</cftransaction>

<cflocation url="../index.cfm?fa=contact&best_wishes=1">



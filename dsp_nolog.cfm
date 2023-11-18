<cfparam name="url.cid" default=0>
<cfparam name="url.mid" default=0>
<cfparam name="url.nolog" default=0>
<cfparam name="url.new_choice" default=0>
<cfparam name="url.help_someone" default=0>
<cfparam name="url.search" default=0>
<cfparam name="url.gid" default=0>
<cfparam name="url.nog" default=0>
<cfparam name="url.new_group" default=0>
	
    <cfoutput>		
		<table width="100%" border="0" cellspacing="1" cellpadding="5" class="site_text">
 		<cfif url.nolog eq 1>
			<tr> 
				<td class="alert_text" colspan="2">
                <br><br>
					<span class="red_stars">***</span> You must be a member of MakeMyChoice.com in order to give feedback. <span class="red_stars">***</span>
					<br><br>
					<span class="stars">***</span> You can easily sign up, or login below.  <span class="stars">***</span>
					<br><br>
                </td>
			</tr>
		</cfif>
 		<cfif url.new_choice eq 1>
			<tr> 
				<td class="alert_text" colspan="2">
                <br><br>
					<span class="red_stars">***</span> You must be a member of MakeMyChoice.com in order to create a new choice. <span class="red_stars">***</span>
					<br><br>
					<span class="stars">***</span> You can easily sign up, or login below.  <span class="stars">***</span>
					<br><br>
                </td>
			</tr>
		</cfif>
 		<cfif url.new_group eq 1>
			<tr> 
				<td class="alert_text" colspan="2">
                <br><br>
					<span class="red_stars">***</span> You must be a member of MakeMyChoice.com in order to create a new Group. <span class="red_stars">***</span>
					<br><br>
					<span class="stars">***</span> You can easily sign up, or login below.  <span class="stars">***</span>
					<br><br>
                </td>
			</tr>
		</cfif>
 		<cfif url.help_someone eq 1>
			<tr> 
				<td class="alert_text" colspan="2">
                <br><br>
					<span class="red_stars">***</span> You must be a member of MakeMyChoice.com in order to help make choices. <span class="red_stars">***</span>
					<br><br>
					<span class="stars">***</span> You can easily sign up, or login below.  <span class="stars">***</span>
					<br><br>
                </td>
			</tr>
		</cfif>
 		<cfif url.search eq 1>
			<tr> 
				<td class="alert_text" colspan="2">
                <br><br>
					<span class="red_stars">***</span> You must be a member of MakeMyChoice.com in order to use the advanced Choice & Member search. <span class="red_stars">***</span>
					<br><br>
					<span class="stars">***</span> You can easily sign up, or login below.  <span class="stars">***</span>
					<br><br>
                </td>
			</tr>
		</cfif>
 		<cfif url.gid neq 0 AND url.nolog eq 0>
			<tr> 
				<td class="alert_text" colspan="2">
                <br><br>
					<span class="red_stars">***</span> You must be a member of MakeMyChoice.com to join a Group. <span class="red_stars">***</span>
					<br><br>
					<span class="stars">***</span> You can easily sign up, or login below.  <span class="stars">***</span>
					<br><br>
                </td>
			</tr>
		</cfif>
 		<cfif url.nog neq 0>
			<tr> 
				<td class="alert_text" colspan="2">
                <br><br>
					<span class="red_stars">***</span> You must be a member of MakeMyChoice.com to view a Group homepage. <span class="red_stars">***</span>
					<br><br>
					<span class="stars">***</span> You can easily sign up, or login below.  <span class="stars">***</span>
					<br><br>
                </td>
			</tr>
		</cfif>

			<tr> 
				<td bgcolor="FFFFFF"  valign="top" align="center" style="width:50%">		
					<br /><br /><br />
					<a href="index.cfm?fa=legal&mid=#url.mid#&cid=#url.cid#&gid=#url.gid#" class="bodylink"><b>Sign Up</b> for free to get started.</a>
					<br /><Br />
                    Only takes a couple minutes.
                    <br /><Br />
                    <br /><Br />
                    <br /><Br />
				</td>
				<td bgcolor="FFFFFF"  valign="top" align="center" style="width:50%">		
				<br /><br /><br />
					<a href="index.cfm?fa=login&mid=#url.mid#&cid=#url.cid#&gid=#url.gid#" class="bodylink"><b>Login</b> if you are already a member.</a>
                    <br /><Br />
                    <br /><Br />
                    <br /><Br />
				</td>
			</tr>
		</table>
	</cfoutput>
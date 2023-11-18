<meta name="robots" content="noindex" />
<meta name="googlebot" content="index" />



<cfparam name="url.updated" default=0>
<cfparam name="url.added" default=0>
<cfparam name="url.gd" default=0>
<cfparam name="url.md" default=0>
<cfparam name="url.edit" default=0>
<cfparam name="url.gid" default=0>
<cfparam name="url.optOut" default=0>
<cfparam name="url.notSure" default=0>
<cfparam name="url.add_gid" default=0>
<cfparam name="url.confirmed" default=0>
<cfparam name="url.status" default=0>
<cfparam name="url.i_deleted" default=0>
<cfparam name="url.added" default=0>


		
			<cfquery name="g2" datasource="#application.dsn#">
				SELECT DISTINCT g.gid, g.mid, g.ab_mid, g.confirmed, gr.private, gr.group_name, m.username
				FROM  t_group_members AS g INNER JOIN
							   t_groups AS gr ON g.gid = gr.id
							   INNER JOIN t_members m ON m.id = g.ab_mid
				WHERE g.mid = #client.mid#  
				AND g.ab_mid != #client.mid#	
            </cfquery>	
		

		
		<cfif url.optOut eq 1 OR url.notSure eq 1 OR url.status eq 1 OR url.confirmed eq 1 OR url.added eq 1>
			<cfquery name="gr" datasource="#application.dsn#">
				SELECT group_name FROM t_groups
				WHERE id = #url.add_gid#
			</cfquery>
		</cfif>

<script Language="JavaScript"><!--
function formValidator(theForm)
{

  if (theForm.new_group.value == "")
  										{
    alert("Please enter a value for the \" New Group\" field.");
    theForm.new_group.focus();
    return (false);
  }



return (true);

}
//--></script>



<cfoutput>


		<table width="100%" border="0" cellspacing="1" cellpadding="6" class="body_text" bgcolor="577DB1"> 
 		<cfif url.confirmed eq 1>
			<tr> 
				<td class="alert_text" colspan="4">
                <br><br>
					<span class="red_stars">***</span> You have been confirmed as a member of the group: <cfoutput><strong>#gr.group_name#</strong></cfoutput> <span class="red_stars">***</span>
					<br><br>
					<a href="groups/index.cfm?fa=home&gid=#url.add_gid#" class="bodylink">Go to <cfoutput><strong>#gr.group_name#</strong> group homepage</cfoutput></a>
                </td>
			</tr>
		</cfif>
 		<cfif url.added eq 1>
			<tr> 
				<td class="alert_text" colspan="4">
                <br><br>
					<span class="red_stars">***</span> You have been added to the group: <cfoutput><strong>#gr.group_name#</strong></cfoutput> <span class="red_stars">***</span>
					<br><br>
					<a href="##" class="bodylink">Go to <cfoutput><strong>#gr.group_name#</strong> group homepage</cfoutput></a>
                </td>
			</tr>
		</cfif>
		  <cfif url.optOut eq 1>
			  <tr> 
				  <td class="alert_text" colspan="4">
					  <span class="red_stars">***</span> You have decided not to join the group: <cfoutput><strong>#gr.group_name#</strong></cfoutput> <span class="red_stars">***</span>
				  </td>
			  </tr> 
		  </cfif>   
		  <cfif url.notSure eq 1>
			  <tr> 
				  <td class="alert_text" colspan="4">
					  <span class="red_stars">***</span> You have set your status to 'Not Sure' for the group: <cfoutput><strong>#gr.group_name#</strong></cfoutput>. <span class="red_stars">***</span>
					  <br /><br />
					  	You can change your status for this group at any time below.
				  </td>
			  </tr> 
		  </cfif> 
		  <cfif url.status eq 1>
			  <tr> 
				  <td class="alert_text" colspan="4">
					  <span class="red_stars">***</span> You have changed your status for the group: <cfoutput><strong>#gr.group_name#</strong></cfoutput>. <span class="red_stars">***</span>
					  <br /><br />
					  	You can change your status for this group at any time below.
				  </td>
			  </tr> 
		  </cfif> 
		  <cfif url.i_deleted eq 1>
			  <tr> 
				  <td class="alert_text" colspan="4">
					  <span class="red_stars">***</span> You have deleted the group: <cfoutput><strong>#gr.group_name#</strong></cfoutput> from your 'invited to join' list. <span class="red_stars">***</span>
				  </td>
			  </tr> 
		  </cfif> 		
     </table>	
   </cfoutput>   

	
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="site_text">
			<tr> 
				<td class="header" colspan="6">
					<span class="header_orange">My</span> Group Memberships
				</td>
			</tr>  			 
			<tr> 
				<td colspan="6" class="page_desc">
					Here is where you manage the different Groups that you have joined, or have been ivited to join.<br />
                    You can change your status in a group or delete a group altogether.       
				</td>            
			</tr>
			<tr>
				<td colspan="6" align="left" class="sub_menu">
					<cfinclude template="includes/group_submenu.cfm">
				</td>
			</tr>
 
            <tr>
                <td class="column_header">
                    Group Homepage
                </td>    
                <td class="column_header">
                    Created By
                </td>                   	
                <td class="column_header">
                    Your Status
                </td>
                <td class="column_header">
                    Group Type
                </td>
                <td class="column_header">
                    Members
                </td>
                <td class="column_header">
                    Delete
                </td>
             </tr>	
              
              <cfif g2.recordcount neq 0>
			  
			  <cfoutput query="g2">
			  
              		<cfquery name="gm2" datasource="#application.dsn#">
                        SELECT id, mid, gid, ab_mid, date_created
                        FROM t_group_members 
                            WHERE gid = #g2.gid#
							AND confirmed = 1
                    </cfquery>					              
				<form action="actions/act_Groups.cfm" method="post"> 					   
						<input type="hidden" name="gid" value="#g2.gid#" />
				  		<input type="hidden" name="function" value="change_status" />	
                  <tr>
                      <td class="column_data" style="width:25%">
                          <a href="groups/index.cfm?fa=home&gid=#g2.gid#" class="bodylink">#g2.group_name#</a>
                      </td>
                      <td class="column_data" style="width:15%">
                          <a href="index.cfm?fa=profile&mid=#g2.ab_mid#" class="bodylink">#g2.username#</a>
                      </td>
                      <td class="column_data" style="width:25%" nowrap="nowrap">
							 <select name="member_status" style="width:100px">
								<cfif g2.confirmed eq 0>
									<option value=0 selected="selected">pending</option>
									<option value=1>confirm</option>
									<option value=2>not sure</option>
									<option value="-1">opt out</option>
								<cfelseif g2.confirmed eq -1>
									<option value="-1" selected="selected">opted out</option>
									<option value=1>confirm</option>
									<option value=2>not sure</option>
								<cfelseif g2.confirmed eq 1>
									<option value=1 selected="selected">confirmed</option>
									<option value="-1">opt out</option>
									<option value=2>not sure</option>
								<cfelseif g2.confirmed eq 2>
									<option value=2 selected="selected">not sure</option>
									<option value=1>confirm</option>
									<option value="-1">opt out</option>
								</cfif> 
							</select>

							<input type="submit" value="update" />
                      </td>
                      <td class="column_data" style="width:15%">
                          	<cfif g2.private eq 1>
						  		Private
							<cfelse>
								Public
							</cfif>
                      </td>
                      <td class="column_data" style="width:15%">
                          #gm2.recordcount#
                      </td>
                      <td class="column_data" style="width:5%">
                          <a href="actions/act_groups.cfm?function=del_invited&gid=#g2.gid#" class="tinylink" onclick="return confirm('Are you sure you want to delete this Group Membership?')")>delete</a>
                      </td>
                   </tr>

                 </form>
              </cfoutput>
             
             <cfelse>
             	<tr>
                	<td colspan="6" class="basic_td">
                    		<br /><br />
                    		You have not yet joined any other groups.
                        	<br /><br />
							<a href="index.cfm?fa=search_groups" class="bodylink">Search public groups</a> to find a group you are interested in joining, or <a href="index.cfm?fa=new_group" class="bodylink">start a new group</a>.
                    </td>
                </tr>
             </cfif>
              
            <tr>
            	<td colspan="6">&nbsp;
                	
                </td>
            </tr>
	</table>
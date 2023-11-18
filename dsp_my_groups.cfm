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
<cfparam name="url.nog" default=0>


            <cfquery name="g" datasource="#application.dsn#">
                SELECT id, mid, group_name
                FROM t_groups 
                	WHERE mid = #client.mid#
                	ORDER BY group_name
            </cfquery>	
		
			<cfquery name="g2" datasource="#application.dsn#">
				SELECT DISTINCT g.gid, g.mid, g.ab_mid, g.confirmed, gr.group_name, m.username
				FROM  t_group_members AS g INNER JOIN
							   t_groups AS gr ON g.gid = gr.id
							   INNER JOIN t_members m ON m.id = g.mid
				WHERE g.mid = #client.mid#  
				AND g.ab_mid != #client.mid#	
            </cfquery>	
		
        <cfif url.edit eq 1>
            <cfquery name="g_edit" datasource="#application.dsn#">
                SELECT id, mid, group_name
                FROM t_groups 
                	WHERE mid = #client.mid#
                    	AND id = #url.gid#
            </cfquery>
        </cfif>
		
		<cfif url.optOut eq 1 OR url.notSure eq 1 OR url.status eq 1>
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

		<table width="100%" border="0" cellspacing="1" cellpadding="6" class="site_text">
         <cfif url.added eq 1>
			<tr> 
				<td class="alert_text" colspan="4">
                	<br>
					<span class="stars">***</span> Your new Group has been added.<span class="stars">***</span>
                    <br /><br />
                    	 <a href="index.cfm?fa=group_members_add&gid=#url.gid#" class="bodylink">Add Group Members</a>
					<br /><br />
                </td>
			</tr>
		</cfif>
 		<cfif url.gd eq 1>
			<tr> 
				<td class="alert_text" colspan="4">
                <br><br>
					<span class="stars">***</span> Your group has been deleted. <span class="stars">***</span>
					<br><br>
                </td>
			</tr>
		</cfif>
 		<cfif url.updated eq 1>
			<tr> 
				<td class="alert_text" colspan="4">
                <br><br>
					<span class="stars">***</span> Your group has been updated. <span class="stars">***</span>
					<br><br>
                </td>
			</tr>
		</cfif>	
 		<cfif url.nog eq 1>
			<tr> 
				<td class="alert_text" colspan="4">
                <br><br>
					<span class="stars">***</span> You must be a group member to view a group homepage. <span class="stars">***</span>
					<br><br>
					You can search for, and <a href="index.cfm?fa=search_groups" class="bodylink">join public groups</a>. Or create your own <a href="index.cfm?fa=new_group" class="bodylink">public or private group</a> and invite other members to join.
                </td>
			</tr>
		</cfif>	
     </table>	
	 
   </cfoutput>   
     
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="site_text">
			<tr> 
				<td  class="header" colspan="5">
					<span class="header_orange">My</span> Groups
				</td>
			</tr>  			 
			<tr> 
				<td colspan="5" class="page_desc">
					Here is where you manage the different Groups that you have created.<br />
                    You can click on "edit group members" to manage the members of your groups.<br />   
				</td>            
			</tr> 	
			<tr>
				<td colspan="5" align="left" class="sub_menu">
					<cfinclude template="includes/group_submenu.cfm">
				</td>
			</tr>
            <tr>
                <td class="column_header">
                    Group Homepage
                </td>    
                <td class="column_header">
                    Manage Members
                </td>                   	
                <td class="column_header">
                    Edit Group Info
                </td>
                <td class="column_header">
                    Delete Group
                </td>
                <td class="column_header">
                    Member Count
                </td>
             </tr>	
			  
              
              <cfif g.recordcount neq 0>
			  
			  <cfoutput query="g">
              
              		<cfquery name="gm" datasource="#application.dsn#">
                        SELECT id, mid, gid, ab_mid, date_created
                        FROM t_group_members 
                            WHERE ab_mid = #client.mid# 
                            AND gid = #g.id#
							AND confirmed = 1
                    </cfquery>	
                  <tr>
                      <td class="column_data" style="width:30%">
                          <a href="groups/index.cfm?gid=#g.id#" class="bodylink">#g.group_name#</a>
                      </td>
                      <td class="column_data" style="width:20%">
                          <a href="index.cfm?fa=group_members_add&gid=#g.id#&members=1" class="bodylink">edit group members</a>
                      </td>
                      <td class="column_data" style="width:15%" nowrap="nowrap">
                          <a href="index.cfm?fa=new_group&gid=#g.id#&edit=1" class="tinylink">edit group info</a> 
                      </td>
                      <td class="column_data" style="width:15%" nowrap="nowrap">
                          <a href="actions/act_deleteItem.cfm?gid=#g.id#&item=group" class="tinylink" onclick="return confirm('Are you sure you want to delete this Group?')">delete</a> 
                      </td>
                      <td style="width:20%" align="center">
                          #gm.recordcount#
                      </td>
                   </tr>
                   
              </cfoutput>
             
             <cfelse>
             	<tr>
                	<td colspan="4" class="basic_td">
                    		<br /><br />
                    	You do not have any groups created yet. &nbsp; <a href="index.cfm?fa=new_group" class="bodylink">create new group</a>
                        	<br /><br />
                    </td>
                </tr>
             </cfif>
              
            <tr>
            	<td colspan="4">&nbsp;
                	
                </td>
            </tr>
	</table>
	

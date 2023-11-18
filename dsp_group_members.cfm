<meta name="robots" content="noindex" />
<meta name="googlebot" content="index" />


<cfparam name="url.members" default=0>
<cfparam name="url.addMember" default=0>
<cfparam name="url.gid" default=0>
<cfparam name="url.md" default=0>
<cfparam name="url.mid" default=0>
<cfparam name="url.added" default=0>
<cfparam name="url.existed" default=0>

		
            <cfquery name="g" datasource="#application.dsn#">
                SELECT id, mid, group_name
                FROM t_groups 
                	WHERE mid = #client.mid#
            </cfquery>
            
		<cfif url.addMember eq 1>	
            <cfquery name="m" datasource="#application.dsn#">
                SELECT id, username
                FROM t_members 
                	WHERE id = #url.mid#
            </cfquery>	
		</cfif>

		<cfif url.members eq 1>
            <cfquery name="gn" datasource="#application.dsn#">
                SELECT id, mid, group_name
                FROM t_groups 
                	WHERE id = #url.gid#
            </cfquery>
            <cfquery name="gm" datasource="#application.dsn#">
                SELECT gm.id, gm.mid, gm.gid, gm.ab_mid, gm.date_created, m.username
                FROM t_group_members gm 
                		INNER JOIN t_members m ON gm.mid = m.id
                	WHERE gm.ab_mid = #client.mid#
                    	AND gm.gid = #url.gid#
            </cfquery>
		</cfif>



<cfif url.members eq 1>

	<table width="100%" border="0" cellspacing="1" cellpadding="5" class="dkblue12" bgcolor="CCCCCC">
			<tr> 
				<td  class="header" colspan="2">
          			<cfoutput>#gn.group_name#</cfoutput> - Group Members 
				</td>
			</tr>
          	<tr> 
				<td  align="left" colspan="2" bgcolor="e9e9e9">
					<a href="index.cfm?fa=my_groups" class="bodylink">My Groups</a> &nbsp; | &nbsp;<span style="text-align:right"><a href="index.cfm?fa=search_engine&m=1&groups=1" class="bodylink">Add Members</a></span>
				</td>
			</tr>	
			  <cfif url.added eq 1>
                  <tr> 
                      <td class="alert_text" colspan="4">
                      <br><br>
                          <span class="stars">***</span> The specified Member has been added to your group. <span class="stars">***</span>
                          <br><br>
                          <a href="index.cfm?fa=search_engine&m=1&groups=1" class="bodylink">Add Members</a>
                          <br /><br />
                      </td>
                  </tr>
              </cfif>
			  <cfif url.existed eq 1>
                  <tr> 
                      <td class="alert_text" colspan="4">
                      <br><br>
                          <span class="red_stars">***</span> The specified Member is already in that group. <span class="red_stars">***</span>
                          <br><br>
                          <li><a href="index.cfm?fa=search_engine&m=1&groups=1" class="bodylink">Add Members</a></li>
                          <br /><br />
                      </td>
                  </tr>
              </cfif>
            <tr>
                <td class="header_small">
                    Member Username
                </td>                      	
                <td class="header_small">
                    Delete
                </td>
             </tr>	
			  <cfif url.md eq 1>
                  <tr> 
                      <td class="alert_text" colspan="4">
                      <br><br>
                          <span class="stars">***</span> The specified Member has been deleted from your group. <span class="stars">***</span>
                          <br><br>
                          <a href="index.cfm?fa=my_groups" class="bodylink">My Groups</a>
                          <br /><br />
                      </td>
                  </tr>
              </cfif>			  
              
              <cfif gm.recordcount neq 0>
			  
			  <cfoutput query="gm">
                  <tr>
                      <td class="body_text" style="width:65%" align="center" bgcolor="FFFFFF">
                          <a href="index.cfm?fa=profile&mid=#gm.mid#" class="bodylink">#gm.username#</a>
                      </td>
                      <td bgcolor="FFFFFF" style="width:10%">
                          <a href="actions/act_deleteItem.cfm?gid=#gn.id#&mid=#gm.mid#&item=g_member" class="tinylink" onclick="return confirm('Are you sure you want to delete this Member?')">delete</a> 
                      </td>
                   </tr>
              </cfoutput>
             
             <cfelse>
             	<tr>
                	<td colspan="3" class="basic_td">
                    		<br /><br />
                    	This group has no members yet. You must be on a Member's profile page in order to add them to a group.
                        <br /><br />
                    	<a href="index.cfm?fa=search_engine&m=1&groups=1" class="bodylink">Add Members</a>
                        <br /><br />
                    </td>
                </tr>
             </cfif>
              
            <tr>
            	<td colspan="3" class="submit">&nbsp;
                	
                </td>
            </tr>
	</table>
    
<cfelseif url.addMember eq 1>     
    
    
   	<table width="100%" border="0" cellspacing="1" cellpadding="6" class="body_text" bgcolor="577DB1">
  			 <tr> 
				<td colspan="2" class="alert_text">
					Add this Member to one of your Groups
				</td>            
			</tr> 
       <form action="actions/act_groups.cfm"  onSubmit="return formValidator(this)" method="post">     	
            <tr>
                  <td class="form_instruct" valign="middle" nowrap="nowrap">
                  		<br />
                    	Add Member: <cfoutput>#m.username#</cfoutput>
                   </td>
                  <td class="form_input">
                  	<br />
                  	<select name="gid" size="1">
                    	<option value="0">Select Group...</option>
                        <cfoutput query="g">
                        	<option value="#g.id#">#g.group_name#</option>
                        </cfoutput>
                    </select>
                    <br /><br />
                  </td>
          	</tr> 	
			<tr> 
				<td colspan="2" class="submit">

                		<input type="hidden" name="function" value="addMember" />
                        <cfoutput>
                        	<input type="hidden" name="mid" value="#m.id#" />
                        </cfoutput>
                        <input type="Submit" value="Add Member to your Group">
					
				</td>
			</tr>	            
       </form>			
     </table>


</cfif>

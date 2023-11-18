

		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="bodytext" bgcolor="FFFFFF">			
        	<tr> 
				<!--- Sub menu for feedback --->
				<cfif fa eq "my_groups">
					<td align="left" width="16px" class="sub_menu">
						<img src="images/arrow_orange.gif"/>
					</td>
					<td align="left" width="23%" class="sub_menu" nowrap="nowrap">
						<a href="index.cfm?fa=my_groups" class="orange_text_big">Manage My Groups</a>
					</td>
				<cfelse>
					<td align="left" width="16px" class="sub_menu">&nbsp;
						
					</td>
					<td align="left" width="23%" class="sub_menu" nowrap="nowrap">
						<a href="index.cfm?fa=my_groups" class="sub_menu_link">Manage My Groups</a>
					</td>
				</cfif>				
				<cfif fa eq "my_groups_invited">
					<td align="left" width="16px" class="sub_menu">
						<img src="images/arrow_orange.gif"/>
					</td>
					<td align="left" width="23%" class="sub_menu" nowrap="nowrap">
						<a href="index.cfm?fa=my_groups_invited" class="orange_text_big">Group Memberships</a>
					</td>
				<cfelse>
					<td align="left" width="16px" class="sub_menu">&nbsp;
						
					</td>
					<td align="left" width="23%" class="sub_menu" nowrap="nowrap">
						<a href="index.cfm?fa=my_groups_invited" class="sub_menu_link">Group Memberships</a>
					</td>
				</cfif>
				<cfif fa eq "new_group">
					<td align="left" width="16px" class="sub_menu">
						<img src="images/arrow_orange.gif"/>
					</td>
					<td align="left" width="23%" class="sub_menu" nowrap="nowrap">
						<a href="index.cfm?fa=new_group" class="orange_text_big">Create New Group</a>
					</td>
				<cfelse>
					<td align="left" width="16px" class="sub_menu">&nbsp;
						
					</td>
					<td align="left" width="23%" class="sub_menu" nowrap="nowrap">
						<a href="index.cfm?fa=new_group" class="sub_menu_link">Create New Group</a>
					</td>
				</cfif>

				<cfif fa eq "search_groups">
					<td align="left" width="16px" class="sub_menu">
						<img src="images/arrow_orange.gif"/>
					</td>
					<td align="left" width="23%" class="sub_menu" nowrap="nowrap">
						<a href="index.cfm?fa=search_groups" class="orange_text_big">Search Groups</a>
					</td>
				<cfelse>
					<td align="left" width="16px" class="sub_menu">&nbsp;
						
					</td>
					<td align="left" width="23%" class="sub_menu" nowrap="nowrap">
					<a href="index.cfm?fa=search_groups" class="sub_menu_link">Search Groups</a>
					</td>
				</cfif>
			</tr>	
		</table>
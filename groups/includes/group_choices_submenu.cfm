 		<table width="100%" border="0">	
			<tr> 
					<!--- Sub menu for Group Choices --->
					<cfif fa eq "group_choices" AND url.type eq "r"> 
						<td align="left" class="sub_menu">
				  			<img src="../images/arrow_orange.gif"/>
						</td>
						<td align="left" width="23%" class="sub_menu" nowrap="nowrap">
							<a href="index.cfm?fa=group_choices&type=r" class="orange_text_big">Recent Choices</a>
						</td>
					<cfelse>
						<td align="left" width="2%" class="sub_menu">
				  			<img src="../images/spr_submenu.gif">
						</td>
						<td align="left" width="25%" class="sub_menu" nowrap="nowrap">
							<a href="index.cfm?fa=group_choices&type=r" class="sub_menu_link">Recent Choices</a>
						</td>
					</cfif>						
						<td align="left" width="2%" class="sub_menu">
				  			<img src="../images/spr_submenu.gif">
						</td>
						<td align="left" width="25%" class="sub_menu" nowrap="nowrap">
							<cfoutput>
								<a href="../index.cfm?fa=new_choice&gid=#client.gid#" class="sub_menu_link">New Group Choice</a>
							</cfoutput>
						</td>
					<cfif fa eq "search_choices"> 
						<td align="left" class="sub_menu">
				  			<img src="../images/arrow_orange.gif"/>
						</td>
						<td align="left" width="23%" class="sub_menu" nowrap="nowrap">
							<a href="index.cfm?fa=search_choices" class="orange_text_big">Search Choices</a>
						</td>
					<cfelse>
						<td align="left" width="2%" class="sub_menu">
				  			<img src="../images/spr_submenu.gif">
						</td>
						<td align="left" width="25%" class="sub_menu" nowrap="nowrap">
							<a href="index.cfm?fa=search_choices" class="sub_menu_link">Search Choices</a>
						</td>
					</cfif>					
					<cfif fa eq "group_choices" AND url.type eq "e"> 
						<td align="left" class="sub_menu">
				  			<img src="../images/arrow_orange.gif"/>
						</td>
						<td align="left" width="23%" class="sub_menu" nowrap="nowrap">
							<a href="index.cfm?fa=group_choices&type=e" class="orange_text_big">Date Expired Choices</a>
						</td>
					<cfelse>
						<td align="left" width="2%" class="sub_menu">
				  			<img src="../images/spr_submenu.gif">
						</td>
						<td align="left" width="25%" class="sub_menu" nowrap="nowrap">
							<a href="index.cfm?fa=group_choices&type=e" class="sub_menu_link">Date Expired Choices</a>
						</td>
					</cfif>

			</tr>
		</table>	

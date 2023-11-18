 		<table width="70%" border="0">	
			<tr> 
					<!--- Sub menu for feedback --->
					<cfif fa eq "my_choices" AND url.c eq 0> 
						<td align="left" class="sub_menu">
				  			<img src="images/arrow_orange.gif"/>
						</td>
						<td align="left" width="23%" class="sub_menu" nowrap="nowrap">
							<a href="index.cfm?fa=my_choices&c=0" class="orange_text_big">My Choices</a>
						</td>
					<cfelse>
						<td align="left" width="2%" class="sub_menu">
				  			<img src="images/spr_submenu.gif">
						</td>
						<td align="left" width="25%" class="sub_menu" nowrap="nowrap">
							<a href="index.cfm?fa=my_choices&c=0" class="sub_menu_link">My Choices</a>
						</td>
					</cfif>
					<cfif fa eq "new_choice">
						<td align="left" class="sub_menu">
				  			<img src="images/arrow_orange.gif"/>
						</td>
						<td align="left" width="40%" class="sub_menu" nowrap="nowrap">
							<a href="index.cfm?fa=new_choice" class="orange_text_big">Create New Choice</a>
						</td>
					<cfelse>
						<td align="left" style="width:16px;" class="sub_menu">
				  			<img src="images/spr_submenu.gif">
						</td>
						<td align="left" width="40%" class="sub_menu" nowrap="nowrap">
							<a href="index.cfm?fa=new_choice" class="sub_menu_link">Create New Choice</a>
						</td>
					</cfif>
					<cfif fa eq "my_choices" AND url.c eq 1> 
						<td align="left" class="sub_menu">
				  			<img src="images/arrow_orange.gif"/>
						</td>
						<td align="left" width="35%" class="sub_menu" nowrap="nowrap">
							<a href="index.cfm?fa=my_choices&c=1" class="orange_text_big">Unfinished Choices</a>
						</td>
					<cfelse>
						<td align="left" style="width:16px;">
				  			<img src="images/spr_submenu.gif">
						</td>
						<td align="left" width="35%" class="sub_menu" nowrap="nowrap">
							<a href="index.cfm?fa=my_choices&c=1" class="sub_menu_link">Unfinished Choices</a>
						</td>
					</cfif>
			</tr>
		</table>	

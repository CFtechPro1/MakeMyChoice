					<table width="70%" border="0">	
						<tr> 
								<!--- Sub menu for Search--->	
								<cfif fa eq "search_cats"> 
									<td align="left" class="sub_menu">
										<img src="images/arrow_orange.gif"/>
									</td>
									<td align="left" width="47%" class="sub_menu" nowrap="nowrap">
										<a href="index.cfm?fa=search_cats" class="orange_text_big">Choice Categories</a>
									</td>
								<cfelse>
									<td align="left" width="3%" class="sub_menu">
										<img src="images/spr_submenu.gif">
									</td>
									<td align="left" width="47%" class="sub_menu" nowrap="nowrap">
										<a href="index.cfm?fa=search_cats" class="sub_menu_link">Choice Categories</a>
									</td>
								</cfif>							
								<cfif url.m eq 0> 
									<td align="left" class="sub_menu">
										<img src="images/arrow_orange.gif"/>
									</td>
									<td align="left" width="47%" class="sub_menu" nowrap="nowrap">
										<a href="index.cfm?fa=search_engine&m=0" class="orange_text_big">Search Choices</a>
									</td>
								<cfelse>
									<td align="left" width="3%" class="sub_menu">
										<img src="images/spr_submenu.gif">
									</td>
									<td align="left" width="47%" class="sub_menu" nowrap="nowrap">
										<a href="index.cfm?fa=search_engine&m=0" class="sub_menu_link">Search Choices</a>
									</td>
								</cfif>
								<cfif url.m eq 1> 
									<td align="left" class="sub_menu">
										<img src="images/arrow_orange.gif"/>
									</td>
									<td align="left" width="47%" class="sub_menu" nowrap="nowrap">
										<a href="index.cfm?fa=search_engine&m=1" class="orange_text_big">Search Members</a>
									</td>
								<cfelse>
									<td align="left" width="3%" class="sub_menu">
										<img src="images/spr_submenu.gif">
									</td>
									<td align="left" width="47%" class="sub_menu" nowrap="nowrap">
										<a href="index.cfm?fa=search_engine&m=1" class="sub_menu_link">Search Members</a>
									</td>
								</cfif>

						</tr>
					</table>
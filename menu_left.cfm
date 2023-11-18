


		
		
		<table width="100%" border="0" cellspacing="0" cellpadding="5">
        
			<tr>
				<td nowrap class="small_text">
				<cfif client.name neq 0>
                	Logged in:<br />
                    <b><cfoutput>#client.username#</b></cfoutput>
                    <br /><br />
                    <a href="index.cfm?fa=my_choices" class="leftmenu">My Choices</a>
                    	<table cellpadding="1" border="0">
                        	<tr>
                            	<td>
                                	 <img src="images/bullet.jpg" border="0" align="middle">
                                </td>
                               	<td valign="top" nowrap="nowrap">
                                	<a href="index.cfm?fa=new_choice" class="leftmenu_sub">New Question</a>
                                </td>
                            </tr><tr>
                            	<td>
                                	 <img src="images/bullet.jpg" border="0" align="middle">
                                </td>
                               	<td valign="top" nowrap="nowrap">
                                	<a href="index.cfm?fa=my_choices" class="leftmenu_sub">View Results</a>
                                </td>
                            </tr>
                        </table> 
                    <br>  
                    <a href="index.cfm?fa=my_feedback" class="leftmenu">My Feedback</a>
                    	<table cellpadding="1" border="0">
                        	<tr>
                            	<td>
                                	 <img src="images/bullet.jpg" border="0" align="middle">
                                </td>
                               	<td valign="middle" nowrap>
                                	<a href="index.cfm?fa=my_feedback&f=4" class="leftmenu_sub">I Have Given</a>
                                </td>
                            </tr>
                            <tr>
                            	<td> 
                                	 <img src="images/bullet.jpg" border="0" align="middle">
                                </td>
                               	<td valign="middle" nowrap>
                                	<a href="index.cfm?fa=my_feedback&f=1" class="leftmenu_sub">Give Feedback</a>
                                </td>
                            </tr>
                        </table> 
                    <br> 
                    <a href="index.cfm?fa=my_messages" class="leftmenu">My Messages</a>
                    <br><br>
                    <a href="index.cfm?fa=my_profile" class="leftmenu">My Profile</a>
                    <br><br>
                    <a href="index.cfm?fa=my_groups" class="leftmenu">My Groups</a>
                    <br><br>
                    <a href="index.cfm?fa=suggestion" class="leftmenu">Suggestions</a>
                    <br><br>
					<br><br>
                 </cfif>  				
                	<a href="index.cfm?fa=about" class="leftmenu">About</a>
                    <br><br>
                    <a href="index.cfm?fa=login" class="leftmenu">Login</a>
                    <br><br>
                    <a href="index.cfm?fa=legal" class="leftmenu">Sign Up</a>
                    <br><br>					
                    <a href="index.cfm?fa=contact" class="leftmenu">Contact</a>
                    <br><br>					
					<cfif client.username eq "JHorton" OR client.username eq "dtkelly72">
                    	<br><br>
                        <a href="index.cfm?fa=suggestion_report" class="leftmenu">Suggestion<br />Report</a>
                        <br><br>
                    </cfif>
				</td>
			</tr>	<!--- </cfif> --->
		</table>
		
		

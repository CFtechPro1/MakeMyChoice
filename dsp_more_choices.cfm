   		<!--- Get the next 50 most recent choices the member is eligible for providing feedback on from the public. --->
		<cfquery name="recent_everyone" datasource="#application.dsn#" maxrows="100" >
			SELECT c.id, c.mid, c.username, c.short_desc, c.date_created, c.anon, r.request_type
			FROM t_choices c INNER JOIN
            	t_requests r ON c.id = r.cid
                	WHERE r.request_type = 'everyone'
                            AND c.date_end > GETDATE()
			ORDER BY c.id DESC
		</cfquery>		
   
   
			<table style="width:100%;" cellpadding="0" cellspacing="0" class="bodytext_new" border="0">
					<tr class="header">
						<td align="left">
							<span class="header_orange">More</span> Choices
						</td>
					</tr>
					<tr class="grey_line">
						<td height="8px">
							<p class="small-spacer">&nbsp;</p>
						</td>
					</tr>
					 <cfloop query="recent_everyone" startrow="13" endrow="34">
					 	<cfoutput>
						<cfif currentRow MOD 2>  
							<cfset rowClass = "blue_row" />  
						<cfelse>  
							<cfset rowClass = "white_row" />  
						</cfif> 
					 <tr>
						<td class="#rowClass#" align="left" style="padding-bottom:5px;">
							<a href="index.cfm?fa=choice_feedback&cid=#recent_everyone.id#&mid=#recent_everyone.mid#" class="choice_link_m">#left(recent_everyone.short_desc,72)#<cfif len(recent_everyone.short_desc) gt 72>....</cfif></a>
							<br />
							Created By
							<cfif recent_everyone.anon eq 0>
								<a href="index.cfm?fa=profile&mid=#recent_everyone.mid#" class="orange_link">#recent_everyone.username#</a>  
							<cfelse>
								<span class="member_text">Anonymous Member</span>
							</cfif> 
							&nbsp; Date Created: #DateFormat(recent_everyone.date_created, "mm/dd/yyyy")#           
						</td>
					</tr>
					</cfoutput>
					</cfloop>
					<tr>
						<td>
							<p class="small-spacer">&nbsp;</p>
						</td>
					</tr>								
				</table>
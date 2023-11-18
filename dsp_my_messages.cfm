<meta name="robots" content="noindex" />
<meta name="googlebot" content="index" />

		<cfparam name="url.sent" default=0>
        <cfparam name="url.md" default=0>
        <cfparam name="url.sort" default=0>
        <cfparam name="url.asc_1" default=0> 
 
        
 		<!--- Get the Member's messages that are feddback requests from a Groups --->
		<cfquery name="messages" datasource="#application.dsn#">
			SELECT m.id, m.s_mid, m.m_subject, m.m_text, m.date_created, m.anon, m.request_type, m.personal, mem.username
			FROM t_messages m INNER JOIN
            	t_members mem ON mem.id = m.s_mid
			WHERE m.r_mid = '#client.mid#'
            	AND m.personal = 1
 			<cfif url.sort eq 0 OR url.sort eq 3>									
                ORDER BY m.id <cfif url.asc_1 eq 0>DESC <cfset url.sw = 1><cfelse>ASC <cfset url.sw = 0></cfif> 
            <cfelseif url.sort eq 1>
            	ORDER BY m.m_subject <cfif url.asc_1 eq 0>ASC <cfset url.sw = 1><cfelse>DESC <cfset url.sw = 0></cfif> 
            <cfelseif url.sort eq 2>
            	ORDER BY mem.username <cfif url.asc_1 eq 0>ASC <cfset url.sw = 1><cfelse>DESC <cfset url.sw = 0></cfif>            
            </cfif>
		</cfquery>	   
	

		
        <!--- paginate vars --->
        <cfparam name="url.page" default="1" />
		<cfparam name="rowCount" default="1" />
		<cfparam name="rowStart" default="1" />
        <cfset variables.page_number = max(val(url.page), 1) />
        <cfset variables.items_per_page = 10 />
		<cfif url.page neq 1>		
        	<cfloop from="2" to="10" index="i">
				<cfset rowCount = rowCount + variables.items_per_page>
				<cfif url.page eq i>
					<cfset rowStart = rowCount>
				</cfif>
			</cfloop>
		</cfif>

                       <!--- Sorting vars set --->
							<cfif url.sw eq 1>
                                <cfset url.asc_1 = 1>
                            <cfelseif url.sw eq 0>
                            	<cfset url.asc_1 = 0>
                            <cfelse>
                            	<cfset url.asc_1 = 0>
                            </cfif>
  
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="site_text">
			<tr> 
				<td  class="header" colspan="4">
					<span class="header_orange">My</span> Messages
				</td>
			</tr>	
            <tr> 
                <td class="page_desc" colspan="4">
                     Here is where messages from other members will be displayed.  &nbsp; &nbsp; &nbsp; &nbsp; <a href="index.cfm?fa=search_engine&m=1&message=1" class="bodylink">New Message</a>
                </td>
            </tr>
 		<cfif url.sent eq 1>
			<tr> 
				<td class="alert_text" colspan="4">
                <br><br>
					<span class="stars">***</span> Your Message has been sent. <span class="stars">***</span>
					<br><br>
                </td>
			</tr>
		</cfif>
 		<cfif url.md eq 1>
			<tr> 
				<td class="alert_text" colspan="4">
                <br><br>
					<span class="stars">***</span> Your Message has been deleted. <span class="stars">***</span>
					<br><br>
                </td>
			</tr>
		</cfif>
                <cfif messages.recordcount neq 0>
						<tr>
                        	<td colspan="4">
                            	<p class="small-spacer">&nbsp;</p>
                            </td>
                        </tr>
                     <cfoutput>
                    	<tr>
                        	<td class="column_header">
                            	<a href="index.cfm?fa=my_messages&page=#url.page#&sort=1&asc_1=#url.asc_1#" class="columnlink">Message Subject</a>
								<cfif url.sort eq 1>
									<cfif url.asc_1 eq 0>
										<img src="images/arrow_sort_down.gif" />
									<cfelse>
										<img src="images/arrow_sort_up.gif" />
									</cfif>
								</cfif>
                            </td>
                         	<td class="column_header">
                            	<a href="index.cfm?fa=my_messages&page=#url.page#&sort=2&asc_1=#url.asc_1#" class="columnlink">From</a>
								<cfif url.sort eq 2>
									<cfif url.asc_1 eq 0>
										<img src="images/arrow_sort_down.gif" />
									<cfelse>
										<img src="images/arrow_sort_up.gif" />
									</cfif>
								</cfif>
                            </td>                        	
                            <td class="column_header">
                            	<a href="index.cfm?fa=my_messages&page=#url.page#&sort=3&asc_1=#url.asc_1#" class="columnlink">Date/Time</a>
								<cfif url.sort eq 3>
									<cfif url.asc_1 eq 0>
										<img src="images/arrow_sort_down.gif" />
									<cfelse>
										<img src="images/arrow_sort_up.gif" />
									</cfif>
								</cfif>
                            </td>
                        	<td class="column_header">
                            	Delete
                            </td>
                         </tr>
                     </cfoutput>
						<cfoutput query="messages" startrow="#rowStart#" maxrows="#variables.items_per_page#">
                        	<tr>
                            	<td class="column_data" style="width:65%">
                             		<a href="index.cfm?fa=view_message&mesid=#messages.id#" class="bodylink">#messages.m_subject#</a>
                                </td>
                            	<td class="column_data" style="width:10%">
                                	<cfif messages.anon eq 0>
                             			<a href="index.cfm?fa=profile&mid=#messages.s_mid#" class="bodylink">#messages.username#</a>
                                    <cfelseif messages.anon eq 1>
                                    	Anonymous
                                    </cfif>
                                </td>
                                <td class="column_data" style="width:15%" align="center" nowrap="nowrap">
    								#DateFormat(messages.date_created, "mm/dd/yyyy  hh:mm")#
                                </td>
                                <td bgcolor="FFFFFF" style="width:10%" align="center">
                            		<a href="actions/act_deleteItem.cfm?message_id=#messages.id#&item=message" class="tinylink" onclick="return confirm('Are you sure you want to delete this message?')">delete</a>  
                            	</td>
                             </tr>
                        </cfoutput>
                <cfelse>
                	<tr>
                    	<td bgcolor="FFFFFF" colspan="4" align="left">
						<br /><br />
                        	You do not have any Messages yet.
                        </td>
                    </tr>
                	
                </cfif>
                
                  <cfset variables.last_page = ceiling(messages.recordCount / variables.items_per_page) />
						<cfif variables.last_page gt 1>
							<cfif url.asc_1 eq 0>
								<cfset sort_asc = 1>
							<cfelse>
								<cfset sort_asc = 0>
							</cfif>
                        <cfoutput>
						<table width="100%" align="center" cellspacing="0" cellpadding="0" border="0">
						<tr><td align="center">
						<table cellspacing="0" cellpadding="0" border="0">
						<tr class="page_navigation">
							<cfset variables.query_string = reReplaceNoCase(cgi.query_string, '[?&]?page=[0-9]+$', '') />
							<td class="previous_page"><cfif variables.page_number gt 1><a href="index.cfm?fa=my_messages&sort=#url.sort#&page=#variables.page_number - 1#&asc_1=#sort_asc#" class="bodylink">Previous</a>&nbsp;</cfif></td>
							<td class="page_range" colspan="3">
								<cfset variables.start_page = 1 />
								<cfset variables.page_numbers_to_show = 9 - variables.start_page />
								<cfset variables.end_page = variables.last_page />
								<cfloop index="i" from="#variables.start_page#" to="#variables.end_page#">
									<a href="index.cfm?fa=my_messages&sort=#url.sort#&page=#i#&asc_1=#sort_asc#" class="bodylink"><cfif i eq variables.page_number><strong>#i#</strong><cfelse>#i#</cfif></a>
								</cfloop>
							</td>
							<td class="next_page"><cfif variables.page_number lt variables.last_page>&nbsp;<a href="index.cfm?fa=my_messages&sort=#url.sort#&page=#variables.page_number + 1#&asc_1=#sort_asc#" class="bodylink">Next</a></cfif></td>
						</tr>
						</table>
						</td></tr></table>
                        </cfoutput>
						</cfif>               
                
				</td>
			</tr>	
	</table>

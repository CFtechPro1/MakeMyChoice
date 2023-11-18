<meta name="robots" content="noindex" />
<meta name="googlebot" content="index" />

        <cfparam name="url.firstName" default="">
        <cfparam name="url.lastName" default="">
        <cfparam name="url.username" default="">
        <cfparam name="url.emailAddress" default="">

		<cfparam name="url.cd" default=0>
        <cfparam name="url.sort" default=0>
        <cfparam name="url.asc_1" default=0>
        <cfparam name="url.sw" default=-1>
        <cfparam name="url.c" default=0>
        <cfparam name="url.newOrg" default=0>
		<cfparam name="url.type" default=0>
        
        <!--- paginate vars --->
        <cfparam name="url.page" default="1" />
		<cfparam name="rowCount" default="1" />
		<cfparam name="rowStart" default="1" />
		<cfparam name="maxRows" default="20" />
		<cfparam name="maxRecords" default="100" />
		
        <cfset variables.page_number = max(val(url.page), 1) />
        <cfset variables.items_per_page = 20 />
		<cfif url.page neq 1>		
        	<cfloop from="2" to="20" index="i">
				<cfset rowCount = rowCount + variables.items_per_page>
				<cfif url.page eq i>
					<cfset rowStart = rowCount>
				</cfif>
			</cfloop>
		</cfif>
    

 		<!--- Get all the members that meet the criteria selected. --->
            <cfquery name="gm" datasource="#application.dsn#" maxrows="#maxRecords#">
                SELECT gm.id, gm.gid, gm.mid, gm.emailAddress, gm.firstName, gm.lastName,
                	gm.confirmed, m.username, m.first_name, m.last_name, m.email_address AS member_email
                FROM t_group_members gm LEFT OUTER JOIN
                	t_members m ON m.id = gm.mid
                	WHERE gm.gid = #client.gid#
				   <cfif url.sort eq 0>									
						ORDER BY gm.id <cfif url.asc_1 eq 0>DESC <cfset url.sw = 1><cfelse>ASC <cfset url.sw = 0></cfif>
					<cfelseif url.sort eq 1>
						ORDER BY m.username <cfif url.asc_1 eq 0>ASC <cfset url.sw = 1><cfelse>DESC <cfset url.sw = 0></cfif> 
					<cfelseif url.sort eq 2>
						ORDER BY m.email_address <cfif url.asc_1 eq 0>ASC <cfset url.sw = 1><cfelse>DESC <cfset url.sw = 0></cfif>     
					<cfelseif url.sort eq 3>
						ORDER BY m.first_name <cfif url.asc_1 eq 0>ASC <cfset url.sw = 1><cfelse>DESC <cfset url.sw = 0></cfif>      
					<cfelseif url.sort eq 4>
						ORDER BY m.last_name <cfif url.asc_1 eq 0>ASC <cfset url.sw = 1><cfelse>DESC <cfset url.sw = 0></cfif>   
					<cfelseif url.sort eq 5>
						ORDER BY gm.confirmed <cfif url.asc_1 eq 0>ASC <cfset url.sw = 1><cfelse>DESC <cfset url.sw = 0></cfif>             
					</cfif>
            </cfquery>
   
  			<cfset variables.query_name = "gm">

			<cfquery name="dp" datasource="#application.dsn#" maxrows="1">
				SELECT id, mid, d_first_name, d_last_name, d_username, d_email_address
				FROM t_profile_display
				WHERE mid = #g.mid#
			</cfquery>  	

		<table border="0" cellspacing="0" cellpadding="0" width="100%" class="site_text">
			<cfoutput>
			<tr> 
				<td  class="header" colspan="5">
						<span class="header_orange">#g.group_name#</span> Group Members 
				</td>
			</tr>
			<cfif g.mid eq client.mid>
			<tr>
				<td class="page_desc">
				<a href="../index.cfm?fa=group_members_add&gid=#g.id#" class="bodylink">Manage Group Members</a>
				</td>
			</tr>
			</cfif>			
			</cfoutput>
						<!--- Sorting vars set --->
						<cfif url.sw eq 1>
							<cfset url.asc_1 = 1>
						<cfelseif url.sw eq 0>
							<cfset url.asc_1 = 0>
						<cfelse>
							<cfset url.asc_1 = 0>
						</cfif>
			
                <cfif gm.recordcount neq 0>
					<cfoutput>
                    	<tr>
                        	<td class="column_header">
                            	<a href="index.cfm?fa=group_members&page=#url.page#&sort=1&asc_1=#url.asc_1#" class="columnlink">Username</a>
								<cfif url.sort eq 1>
									<cfif url.asc_1 eq 0>
										<img src="../images/arrow_sort_down.gif" />
									<cfelse>
										<img src="../images/arrow_sort_up.gif" />
									</cfif>
								</cfif>
                            </td>
                        	<td class="column_header">
                            	<a href="index.cfm?fa=group_members&page=#url.page#&sort=2&asc_1=#url.asc_1#" class="columnlink">Email Address</a>
								<cfif url.sort eq 2>
									<cfif url.asc_1 eq 0>
										<img src="../images/arrow_sort_down.gif" />
									<cfelse>
										<img src="../images/arrow_sort_up.gif" />
									</cfif>
								</cfif>
                            </td>
                        	<td class="column_header">
                            	<a href="index.cfm?fa=group_members&page=#url.page#&sort=3&asc_1=#url.asc_1#" class="columnlink">First Name</a>
								<cfif url.sort eq 3>
									<cfif url.asc_1 eq 0>
										<img src="../images/arrow_sort_down.gif" />
									<cfelse>
										<img src="../images/arrow_sort_up.gif" />
									</cfif>
								</cfif>
                            </td>
                        	<td class="column_header">
                            	<a href="index.cfm?fa=group_members&page=#url.page#&sort=4&asc_1=#url.asc_1#" class="columnlink">Last Name</a>
								<cfif url.sort eq 4>
									<cfif url.asc_1 eq 0>
										<img src="../images/arrow_sort_down.gif" />
									<cfelse>
										<img src="../images/arrow_sort_up.gif" />
									</cfif>
								</cfif>
                            </td>
                        	<td class="column_header">
                            	<a href="index.cfm?fa=group_members&page=#url.page#&sort=5&asc_1=#url.asc_1#" class="columnlink">Status</a>
								<cfif url.sort eq 5>
									<cfif url.asc_1 eq 0>
										<img src="../images/arrow_sort_down.gif" />
									<cfelse>
										<img src="../images/arrow_sort_up.gif" />
									</cfif>
								</cfif>
                            </td>
                         </tr>
					</cfoutput>
						<cfoutput query="gm">
                        	<tr id="#gm.id#">
                            	<td class="column_data">
                                	<cfif gm.username neq "">
                             			<a href="../index.cfm?fa=profile&amp;mid=#gm.mid#" class="bodylink">#gm.username#</a>
                                    <cfelse>
                                    	&nbsp;
                                    </cfif>
                                </td>
                                <td class="column_data">
								<!--- <cfif dp.d_email_address eq 1> --->
									<cfif gm.member_email neq "">
                                        <a href="../index.cfm?fa=new_message&amp;mid=#gm.mid#" class="bodylink">#gm.member_email#</a>
                                    <cfelse>
                                    	<cfif gm.mid neq "">
                                        	<a href="../index.cfm?fa=new_message&amp;mid=#gm.mid#" class="bodylink">#gm.emailAddress#</a>
                                        <cfelse>
                                        	#gm.emailAddress#
                                        </cfif>
                                    </cfif>
								<!--- <cfelse>
									<a href="../index.cfm?fa=new_message&amp;mid=#gm.mid#" class="bodylink">Send Message</a>
								</cfif> --->
                                </td>   
                                <td class="column_data">
								<!--- <cfif dp.d_first_name eq 1> --->
                               		<cfif gm.firstName neq "">
                                    	#gm.firstName#
                                    <cfelse>
                                    	N/A
                                    </cfif>
								<!--- <cfelse>
									N/A
								</cfif> --->
                                </td>   
                                <td class="column_data">
								<!--- <cfif dp.d_last_name eq 1> --->
                               		<cfif gm.lastName neq "">
                                    	#gm.lastName#
                                    <cfelse>
                                    	#gm.lastName#
                                    </cfif>
								<!--- <cfelse>
									N/A
								</cfif> --->
                                </td> 
                                <td class="column_data">
									<cfif gm.confirmed eq 0>
                                        pending
                                    <cfelseif gm.confirmed eq -1>
                                        opted out
                                    <cfelseif gm.confirmed eq 1>
                                        confirmed
									<cfelseif gm.confirmed eq 2>
										not sure
                                    </cfif>
                                </td> 
                             </tr>
                             
                        </cfoutput>
                <cfelse>
                	<tr>
                    	<td class="alert_text" nowrap="nowrap">
                        	<br /><br />
                        	<span class="red_stars">***</span> There are no Members for this Group yet. <span class="red_stars">***</span>
                            <br /><br />
                        </td>
                    </tr>
                	
                </cfif>
				
				
			<!--- PAGINATION --->
       	<cfset variables.last_page = ceiling(evaluate(variables.query_name & '.recordCount') / variables.items_per_page) />	
		<cfif variables.last_page gt 1>
            <tr>
                <td class="pagination" colspan="8" align="right">
					<cfif url.asc_1 eq 0>
						<cfset sort_asc = 1>
					<cfelse>
						<cfset sort_asc = 0>
					</cfif>
					<cfoutput>
					<table cellspacing="0" cellpadding="0" border="0">
						<tr>
							<td class="previous_page"><cfif variables.page_number gt 1><a href="index.cfm?fa=group_members&sort=#url.sort#&page=#variables.page_number - 1#&type=#url.type#&asc_1=#sort_asc#" class="columnlink">Previous</a>&nbsp;</cfif></td>
							<td class="page_range" colspan="3">
								<cfset variables.start_page = 1 />
								<cfset variables.page_numbers_to_show = 9 - variables.start_page />
								<cfset variables.end_page = variables.last_page />
								<cfloop index="i" from="#variables.start_page#" to="#variables.end_page#">
									<a href="index.cfm?fa=group_membersk&sort=#url.sort#&page=#i#&type=#url.type#&asc_1=#sort_asc#" class="columnlink"><cfif i eq variables.page_number><strong>#i#</strong><cfelse>#i#</cfif></a>
								</cfloop>
							</td>
							<td class="next_page"><cfif variables.page_number lt variables.last_page>&nbsp;<a href="index.cfm?fa=group_members&sort=#url.sort#&page=#variables.page_number - 1#&type=#url.type#&asc_1=#sort_asc#" class="columnlink">Next</a></cfif></td>
						</tr>
					</table>
					</cfoutput>	                    
                </td>
            </tr>
           </cfif>  
		</table>

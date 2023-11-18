<meta name="robots" content="noindex" />
<meta name="googlebot" content="index" />


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
		<cfparam name="maxRows" default="10" />
		<cfparam name="maxRecords" default="100" />
		
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
        


    	<!--- Get the top ten most recent choices for THIS GROUP. --->
		<cfquery name="group_choices" datasource="#application.dsn#" maxrows="#maxRecords#">
			SELECT c.id, c.mid, c.username, c.short_desc, c.date_created, c.num_of_answers, c.anon, r.gid, r.request_type,
            	(SELECT COUNT(id) AS Expr1 FROM t_feedback WHERE cid = c.id) AS response_count
			FROM t_choices c INNER JOIN
            	t_requests r ON c.id = r.cid
			WHERE r.gid = #client.gid#
				AND r.request_type = 'group'
            	AND (c.id IN (SELECT cid FROM t_answers) OR c.num_of_answers = 0)
				<cfif url.type eq "r">
					AND c.date_end > GETDATE()
				<cfelseif url.type eq "e">
					AND c.date_end < GETDATE()
				</cfif>
           <cfif url.sort eq 0 OR url.sort eq 2>									
                ORDER BY c.id <cfif url.asc_1 eq 0>DESC <cfset url.sw = 1><cfelse>ASC <cfset url.sw = 0></cfif>
            <cfelseif url.sort eq 1>
            	ORDER BY c.short_desc <cfif url.asc_1 eq 0>ASC <cfset url.sw = 1><cfelse>DESC <cfset url.sw = 0></cfif>        
            </cfif>
		</cfquery>	
		
		<cfset variables.query_name = "group_choices">
        	



		


		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="dkblue12" bgcolor="FFFFFF">
			<tr> 
				<td  class="header" colspan="2">
					<cfif url.type eq "r">
						<span class="header_orange">Recent</span> Choices
					<cfelseif url.type eq "e">
						<span class="header_orange">Date</span> Expired Choices
					</cfif>
				</td>
			</tr>	
			<cfif url.cd eq 1>
                <tr> 
                    <td class="alert_text" colspan="4">
                    <br><br>
                        <span class="stars">***</span> Your Choice has been deleted. <span class="stars">***</span>
                        <br><br>
                    </td>
                </tr>
            </cfif>
                <tr> 
                    <td class="page_desc" colspan="4">       
                        Here is where all the <cfif url.type eq "r">Recent<cfelse>Date Expired</cfif> Choices for this Group will be listed.
                    </td>
                </tr>   
				
				<tr>
					<td colspan="4" align="left">
						<cfinclude template="includes/group_choices_submenu.cfm">      
					</td>
				</tr>
				 
  
      
			<tr>
				<td class="site_text">
                <cfif group_choices.recordcount neq 0>
                	<table cellspacing="0" cellpadding="0" class="site_text" style="width:100%">
                    		<!--- Sorting vars set --->
							<cfif url.sw eq 1>
                                <cfset url.asc_1 = 1>
                            <cfelseif url.sw eq 0>
                            	<cfset url.asc_1 = 0>
                            <cfelse>
                            	<cfset url.asc_1 = 0>
                            </cfif>
                    	<cfoutput>
                    	<tr>
                        	<td class="column_header">
                            	<a href="index.cfm?fa=group_choices&type=#url.type#&page=#url.page#&sort=1&asc_1=#url.asc_1#" class="columnlink">Choice Description</a>
								<cfif url.sort eq 1>
									<cfif url.asc_1 eq 0>
										<img src="../images/arrow_sort_down.gif" />
									<cfelse>
										<img src="../images/arrow_sort_up.gif" />
									</cfif>
								</cfif>
                            </td>
                        	<td class="column_header">
                            	<a href="index.cfm?fa=group_choices&type=#url.type#&page=#url.page#&sort=2&asc_1=#url.asc_1#" class="columnlink">Date Created</a>
								<cfif url.sort eq 2>
									<cfif url.asc_1 eq 0>
										<img src="../images/arrow_sort_down.gif" />
									<cfelse>
										<img src="../images/arrow_sort_up.gif" />
									</cfif>
								</cfif>
                            </td>
                            <td class="column_header">
                            	Responses
                            </td>
							<cfif client.mid eq group_choices.mid OR g.mid eq client.mid>
								<td class="column_header">
									Delete
								</td>
							</cfif>
                         </tr>
                       </cfoutput>
						<cfoutput query="group_choices" startrow="#rowStart#" maxrows="#maxRows#">
                            <tr>
                            	<td class="column_data" style="width:70%">
                             		<a href="../index.cfm?fa=choice_feedback&cid=#group_choices.id#&mid=#group_choices.mid#&gid=#client.gid#" class="bodylink">#group_choices.short_desc#</a>
                                </td>
                                <td class="column_data" style="width:20%" nowrap="nowrap">
    								#DateFormat(group_choices.date_created, "mm/dd/yyyy")# #TimeFormat(group_choices.date_created, "h:mm tt")#
                                </td>
                                <td style="width:5%" align="center">                            	
                                	#group_choices.response_count#
                                </td>
								<cfif client.mid eq group_choices.mid OR g.mid eq client.mid>
									<td class="column_data" style="width:5%">								
										<a href="../actions/act_deleteItem.cfm?cid=#group_choices.id#&item=choice&group=1" class="tinylink" onclick="return confirm('Are you sure you want to delete this Choice?')">delete</a> 	
									</td>
								</cfif>
                             </tr>
                        </cfoutput>
                      </table>
                <cfelse>
					<br /><br />
					<cfif url.type eq "r">
                		This group does not have any choices created yet.
					<cfelse>
						This group does not have any date expired choices yet.
					</cfif>
                </cfif>
                
                
                
				</td>
			</tr>	
   
          
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
							<td class="previous_page"><cfif variables.page_number gt 1><a href="index.cfm?fa=group_choices&sort=#url.sort#&page=#variables.page_number - 1#&type=#url.type#&asc_1=#sort_asc#" class="columnlink">Previous</a>&nbsp;</cfif></td>
							<td class="page_range" colspan="3">
								<cfset variables.start_page = 1 />
								<cfset variables.page_numbers_to_show = 9 - variables.start_page />
								<cfset variables.end_page = variables.last_page />
								<cfloop index="i" from="#variables.start_page#" to="#variables.end_page#">
									<a href="index.cfm?fa=group_choices&sort=#url.sort#&page=#i#&type=#url.type#&asc_1=#sort_asc#" class="columnlink"><cfif i eq variables.page_number><strong>#i#</strong><cfelse>#i#</cfif></a>
								</cfloop>
							</td>
							<td class="next_page"><cfif variables.page_number lt variables.last_page>&nbsp;<a href="index.cfm?fa=group_choices&sort=#url.sort#&page=#variables.page_number - 1#&type=#url.type#&asc_1=#sort_asc#" class="columnlink">Next</a></cfif></td>
						</tr>
					</table>
					</cfoutput>	                    
                </td>
            </tr>
           </cfif>    
		</table>

<meta name="robots" content="noindex" />
<meta name="googlebot" content="index" />


		<cfparam name="url.cd" default=0>
        <cfparam name="url.sort" default=0>
        <cfparam name="url.asc_1" default=0>
        <cfparam name="url.sw" default=-1>
        <cfparam name="url.c" default=0>
        <cfparam name="url.newOrg" default=0>
        
        <!--- paginate vars --->
        <cfparam name="url.page" default="1" />
        <cfset variables.page_number = max(val(url.page), 1) />
        <cfset variables.items_per_page = 30 />
        
        <cfparam name="url.page2" default="1" />
        <cfset variables.page_number2 = max(val(url.page2), 1) />
        <cfset variables.items_per_page2 = 30 />
        
	<cfif url.c eq 0>     

    	<!--- Get the top ten most recent choices the member has created. --->
		<cfquery name="recent_choices" datasource="#application.dsn#" >
			SELECT c.id, c.short_desc, date_created, c.num_of_answers,
            	(SELECT COUNT(id) AS Expr1 FROM t_feedback WHERE cid = c.id AND mid = #client.mid#) AS response_count
			FROM t_choices c
			WHERE c.mid = '#client.mid#'
            	AND (id IN (SELECT cid FROM t_answers) OR c.num_of_answers = 0)
           <cfif url.sort eq 0 OR url.sort eq 2>									
                ORDER BY c.id <cfif url.asc_1 eq 0>DESC <cfset url.sw = 1><cfelse>ASC <cfset url.sw = 0></cfif>
            <cfelseif url.sort eq 1>
            	ORDER BY c.short_desc <cfif url.asc_1 eq 0>ASC <cfset url.sw = 1><cfelse>DESC <cfset url.sw = 0></cfif>        
            </cfif>
		</cfquery>	
		
		<cfset variables.query_name = "recent_choices">
        	
    <cfelseif url.c eq 1> 		
		
		<!--- Get the top ten most recent choices the member has created. --->
		<cfquery name="unfinished" datasource="#application.dsn#">
			SELECT c.id, c.short_desc, c.date_created, c.num_of_answers
			FROM t_choices c
			WHERE c.mid = '#client.mid#'
            	AND c.num_of_answers != 0 AND c.num_of_answers IS NOT NULL
            	AND id NOT IN (SELECT cid FROM t_answers)
           <cfif url.sort eq 0 OR url.sort eq 2>	         										
                ORDER BY c.id <cfif url.asc_1 eq 0>DESC <cfset url.asc_1 = 1><cfelse>ASC <cfset url.asc_1 = 0></cfif>
            <cfelseif url.sort eq 1>
            	ORDER BY c.short_desc <cfif url.asc_1 eq 0>ASC <cfset url.asc_1 = 1><cfelse>DESC <cfset url.asc_1 = 0></cfif>         
            </cfif>        
		</cfquery>	
        
       	<cfset variables.query_name = "unfinished">
            
     </cfif>	


		


		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="dkblue12" bgcolor="FFFFFF">
			<tr> 
				<td  class="header" colspan="2">
					<span class="header_orange">My</span> Choices
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
			 <cfif url.newOrg eq 1>
             	<cfoutput>
                  <tr> 
                      <td class="alert_text" colspan="2">
                          <span class="stars">***</span> Congratualtions, you have added the new Organization <strong>#client.org_name#</strong>! <span class="stars">***</span>
                          <br><br>
                          Now you can send people your Org ID: <strong>#client.orgID#</strong> which they will enter when logging in or signing up.
                         <br><br>
                      </td>
                  </tr>
                </cfoutput>
            </cfif> 
                <tr> 
                    <td class="page_desc" colspan="4">       
                        Here is where all the Choices you have created will be listed. You can view the results of your choices by click on the links below.
                    </td>
                </tr>   
				
				<tr>
					<td colspan="4" align="left">
						<cfinclude template="includes/choices_submenu.cfm">      
					</td>
				</tr>
				 
    <cfif url.c eq 0>      
      
			<tr>
				<td class="site_text">
                <cfif recent_choices.recordcount neq 0>
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
                            	<a href="index.cfm?fa=my_choices&page=#url.page#&sort=1&asc_1=#url.asc_1#" class="columnlink">Choice Description</a>
								<cfif url.sort eq 1>
									<cfif url.asc_1 eq 0>
										<img src="images/arrow_sort_down.gif" />
									<cfelse>
										<img src="images/arrow_sort_up.gif" />
									</cfif>
								</cfif>
                            </td>
                        	<td class="column_header">
                            	<a href="index.cfm?fa=my_choices&page=#url.page#&sort=2&asc_1=#url.asc_1#" class="columnlink">Date Created</a>
								<cfif url.sort eq 2>
									<cfif url.asc_1 eq 0>
										<img src="images/arrow_sort_down.gif" />
									<cfelse>
										<img src="images/arrow_sort_up.gif" />
									</cfif>
								</cfif>
                            </td>
                            <td class="column_header">
                            	Responses
                            </td>
                        	<td class="column_header">
                            	Edit
                            </td>
                        	<td class="column_header">
                            	Delete
                            </td>
                         </tr>
                       </cfoutput>
						<cfloop query="recent_choices" startrow="#((variables.page_number - 1) * variables.items_per_page) + 1#" endrow="#((variables.page_number - 1) * variables.items_per_page) + variables.items_per_page#">
                        	<cfoutput>
                            <tr>
                            	<td class="column_data" style="width:70%">
                             		<a href="index.cfm?fa=view_choice&cid=#recent_choices.id#&mid=#client.mid#" class="bodylink">#recent_choices.short_desc#</a>
                                </td>
                                <td class="column_data" style="width:20%" nowrap="nowrap">
    								#DateFormat(recent_choices.date_created, "mm/dd/yyyy")# #TimeFormat(recent_choices.date_created, "h:mm tt")#
                                </td>
                                <td style="width:5%" align="center">                            	
                                	#recent_choices.response_count#
                                </td>
                            	<td class="column_data" style="width:5%">
                             		<a href="index.cfm?fa=new_choice&edit=1&cid=#recent_choices.id#" class="bodylink">edit</a>
                                </td>
                                <td class="column_data" style="width:5%">
                            		<a href="actions/act_deleteItem.cfm?cid=#recent_choices.id#&item=choice" class="tinylink" onclick="return confirm('Are you sure you want to delete this Choice?')">delete</a> 
                            	</td>
                             </tr>
                             </cfoutput>
                        </cfloop>
                      </table>
                <cfelse>
					<br /><br />
                	You do not have any choices created yet.
                </cfif>
                
                
                
				</td>
			</tr>	
	
    <cfelseif url.c eq 1>
    
			<tr>
				<td class="body_text">
                <cfif unfinished.recordcount neq 0>
                	<table cellspacing="0" cellpadding="0" class="site_text" style="width:100%">
                    	<cfoutput>
                    	<tr>
                        	<td class="column_header">
                            	<a href="index.cfm?fa=my_choices&page2=#url.page2#&sort=1##u" class="columnlink">Choice Description</a>
                            </td>
                        	<td class="column_header">
                            	<a href="index.cfm?fa=my_choices&page2=#url.page2#&sort=2##u" class="columnlink">Date Created</a>
                            </td>
                        	<td class="column_header">
                            	Edit/Delete
                            </td>
                         </tr>
                       </cfoutput>
						<cfloop query="unfinished" startrow="#((variables.page_number2 - 1) * variables.items_per_page2) + 1#" endrow="#((variables.page_number2 - 1) * variables.items_per_page2) + variables.items_per_page2#">
                        	<cfoutput>
                        	<tr>
                            	<td class="column_data" style="width:65%">
                             		<a href="index.cfm?fa=add_answers&cid=#unfinished.id#&mid=#client.mid#&num_of_answers=#unfinished.num_of_answers#" class="bodylink">#unfinished.short_desc#</a>
                                </td>
                                <td class="column_data" style="width:25%" nowrap="nowrap">
    								#DateFormat(unfinished.date_created, "mm/dd/yyyy")# #TimeFormat(unfinished.date_created, "h:mm tt")#
                                </td>
                                <td class="column_data" style="width:10%" nowrap>
                            		<a href="index.cfm?fa=new_choice&cid=#unfinished.id#&edit=1" class="tinylink">edit</a> | <a href="actions/act_deleteItem.cfm?cid=#unfinished.id#&item=choice" class="tinylink" onclick="return confirm('Are you sure you want to delete this Choice?')">delete</a>   
                            	</td>
                             </tr>
                             </cfoutput>
                        </cfloop>
                      </table>
                <cfelse>
					<br /><br />
                	You do not have any unfinished choices.
                </cfif>
                
                
				</td>
			</tr>
            
        </cfif>       
          
        	<tr>
            	<td>
                
                </td>
                <td>    

                   <cfset variables.last_page = ceiling(evaluate(variables.query_name & '.recordCount') / variables.items_per_page) />
						<cfif variables.last_page gt 1>
                        <cfoutput>
						<table width="100%" align="center" cellspacing="0" cellpadding="0" border="0">
						<tr><td align="center">
						<table cellspacing="0" cellpadding="0" border="0">
						<tr class="page_navigation">
							<td class="previous_page"><cfif variables.page_number gt 1><a href="index.cfm?fa=my_choices&sort=#url.sort#&page=#variables.page_number - 1#&c=#url.c#" class="bodylink">Previous</a>&nbsp;</cfif></td>
							<td class="page_range" colspan="3">
								<cfset variables.start_page = 1 />
								<cfset variables.page_numbers_to_show = 9 - variables.start_page />
								<cfset variables.end_page = variables.last_page />
								<cfloop index="i" from="#variables.start_page#" to="#variables.end_page#">
									<a href="index.cfm?fa=my_choices&sort=#url.sort#&page=#i#&c=#url.c#" class="bodylink"><cfif i eq variables.page_number><strong>#i#</strong><cfelse>#i#</cfif></a>
								</cfloop>
							</td>
							<td class="next_page"><cfif variables.page_number lt variables.last_page>&nbsp;<a href="index.cfm?fa=my_choices&sort=#url.sort#&page=#variables.page_number + 1#&c=#url.c#" class="bodylink">Next</a></cfif></td>
						</tr>
						</table>
						</td></tr></table>
                        </cfoutput>
						</cfif>     
                 </td>
             </tr> 	
		</table>

<meta name="robots" content="noindex" />
<meta name="googlebot" content="index" />



		
		<cfif client.mid eq 0>
			<cflocation url="index.cfm?fa=nolog&help_someone=1">
		</cfif>

		<!--- Get request from ColdFusion page contenxt. --->
        <cfset objRequest = GetPageContext().GetRequest() />
         
        
        <!--- Get requested URL from request object. --->
        <cfset strUrl = objRequest.GetRequestUrl().Append(
        "?" & objRequest.GetQueryString()
        ).ToString()/>

		
        <cfparam name="url.sort" default="0" />
        <cfparam name="url.f" default="1" />
        <cfparam name="url.asc_1" default=0>
        <cfparam name="url.sw" default=-1>
        
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
        
  <cfif url.f eq 1>
  
		<!--- Get the top ten most recent choices the member is eligible for providing feedback on from the public. --->
		<cfquery name="recent_everyone" datasource="#application.dsn#" maxrows="#maxRecords#">
			SELECT c.id, c.mid, c.username, c.short_desc, c.date_created,  c.anon,
			r.request_type
			FROM t_choices c INNER JOIN
            	t_requests r ON c.id = r.cid
                	WHERE r.request_type = 'everyone'
                    		AND '#client.mid#' NOT IN (SELECT feedback_mid FROM t_feedback WHERE cid = c.id)
                            AND c.date_end > GETDATE()
			<cfif url.sort eq 0 OR url.sort eq 2>									
                ORDER BY c.id <cfif url.asc_1 eq 0>DESC <cfset url.sw = 1><cfelse>ASC <cfset url.sw = 0></cfif>
            <cfelseif url.sort eq 1>
            	ORDER BY c.short_desc <cfif url.asc_1 eq 0>ASC <cfset url.sw = 1><cfelse>DESC <cfset url.sw = 0></cfif>
            <cfelseif url.sort eq 3>
            	ORDER BY c.username <cfif url.asc_1 eq 0>ASC <cfset url.sw = 1><cfelse>DESC <cfset url.sw = 0></cfif>           
            </cfif>
		</cfquery>		
        
    	<cfset variables.query_name = "recent_everyone">  
        
  
	
   <cfelseif url.f eq 2>
      	
		<!--- Get the top ten most recent choices the member is eligible for providing feedback on 
				from ADVANCED FEEDBACK Requests. --->        
        <cfquery name="member" datasource="#application.dsn#" maxrows="1">
			SELECT id, first_name, last_name, username, email_address, country, zip_code, dob, gender, marital_status, cultural_heritage,
            			children, hobbies, profession, DATEDIFF(YEAR,DOB,GETDATE()) as age
			FROM t_members
			WHERE id = #client.mid#
		</cfquery>	
		
		<cfquery name="recent_adv" datasource="#application.dsn#" maxrows="#maxRecords#">
			SELECT c.id, c.mid, c.username, c.short_desc, c.date_created, c.anon, r.mid, r.cid, r.gid, r.username, r.gender, r.country, r.zip_code, r.marital_status, r.cultural_heritage,
            			r.children, r.hobbies, r.profession, r.min_age, r.max_age, r.date_created, r.request_type
			FROM t_choices c INNER JOIN
            	t_requests r ON c.id = r.cid
                	WHERE r.request_type = 'advanced'
                    		AND '#client.mid#' NOT IN (SELECT feedback_mid FROM t_feedback WHERE cid = c.id)
                            AND c.date_end > GETDATE()

							AND  
                          	r.gender = 
                            	CASE 
                            	WHEN r.gender <> '' 
                              	THEN '#member.gender#'
                                ELSE ''
                                END                           
 							AND  
                          	r.marital_status LIKE 
                            	CASE 
                            	WHEN r.marital_status <> '' 
                              	THEN '%#member.marital_status#%'
                                ELSE ''
                                END 
							AND  
                          	r.country = 
                            	CASE 
                            	WHEN r.country <> '' 
                              	THEN '#member.country#'
                                ELSE ''
                                END  
							AND  
                          	r.zip_code = 
                            	CASE 
                            	WHEN r.zip_code <> '' 
                              	THEN '#member.zip_code#'
                                ELSE ''
                                END  
							AND  
                          	r.cultural_heritage = 
                            	CASE 
                            	WHEN r.cultural_heritage <> '' 
                              	THEN '#member.cultural_heritage#'
                                ELSE ''
                                END  
							AND  
                          	r.children = 
                            	CASE 
                            	WHEN r.children <> 0 
                              	THEN '#member.children#'
                                ELSE 0
                                END  
							AND  
                          	r.hobbies LIKE 
                            	CASE 
                            	WHEN r.hobbies <> '' 
                              	THEN '#member.hobbies#'
                                ELSE ''
                                END  
							AND  
                          	r.profession LIKE 
                            	CASE 
                            	WHEN r.profession <> '' 
                              	THEN '#member.profession#'
                                ELSE ''
                                END  	
							AND  
                          	r.min_age >= 
                            	CASE 
                            	WHEN r.min_age <> 1 
                              	THEN '#member.age#'
                                ELSE 1
                                END 
							AND  
                          	r.max_age <= 
                            	CASE 
                            	WHEN r.max_age <> 110 
                              	THEN '#member.age#'
                                ELSE 110
                                END 			
		
			<cfif url.sort eq 0 OR url.sort eq 2>									
                ORDER BY c.id <cfif url.asc_1 eq 0>DESC <cfset url.sw = 1><cfelse>ASC <cfset url.sw = 0></cfif>
            <cfelseif url.sort eq 1>
            	ORDER BY c.short_desc <cfif url.asc_1 eq 0>ASC <cfset url.sw = 1><cfelse>DESC <cfset url.sw = 0></cfif>
            <cfelseif url.sort eq 3>
            	ORDER BY c.username  <cfif url.asc_1 eq 0>ASC <cfset url.sw = 1><cfelse>DESC <cfset url.sw = 0></cfif>           
            </cfif>
		</cfquery>	
        
        <cfset variables.query_name = "recent_adv">      
        
   <cfelseif url.f eq 3>
     
		<!--- Get the top ten most recent choices the member is eligible for providing feedback on from members in THEIR Groups. --->
		<cfquery name="recent_groups" datasource="#application.dsn#" maxrows="#maxRecords#">
			SELECT c.id, c.username, c.short_desc, c.date_created, c.anon, r.request_type, r.mid, r.gid, g.group_name
			FROM t_choices c INNER JOIN
            	t_requests r ON c.id = r.cid
                			INNER JOIN
            	t_groups g ON r.gid = g.id
                	WHERE r.request_type = 'group'
                    	AND '#client.mid#' IN 
                        	(SELECT mid FROM t_group_members WHERE gid = r.gid)
                            AND c.date_end > GETDATE()
			<cfif url.sort eq 0 OR url.sort eq 2>									
                ORDER BY c.id <cfif url.asc_1 eq 0>DESC <cfset url.sw = 1><cfelse>ASC <cfset url.sw = 0></cfif>
            <cfelseif url.sort eq 1>
            	ORDER BY c.short_desc <cfif url.asc_1 eq 0>ASC <cfset url.sw = 1><cfelse>DESC <cfset url.sw = 0></cfif>
            <cfelseif url.sort eq 3>
            	ORDER BY c.username <cfif url.asc_1 eq 0>ASC <cfset url.sw = 1><cfelse>DESC <cfset url.sw = 0></cfif>            
            </cfif>
		</cfquery>	
	
    	<cfset variables.query_name = "recent_groups">  
        
	<cfelseif url.f eq 4>
    
       
		<!--- Get the top ten most recent choices where the member has already provided feedback. --->
		<cfquery name="recent_feedback" datasource="#application.dsn#" maxrows="#maxRecords#">
			SELECT c.id, c.mid, c.username, c.short_desc, c.date_created, c.anon, f.feedback_mid
			FROM t_choices c INNER JOIN
            	t_feedback f ON c.id = f.cid
                	WHERE f.feedback_mid = #client.mid# 
			<cfif url.sort eq 0 OR url.sort eq 2>									
                ORDER BY c.id <cfif url.asc_1 eq 0>DESC <cfset url.sw = 1><cfelse>ASC <cfset url.sw = 0></cfif>
            <cfelseif url.sort eq 1>
            	ORDER BY c.short_desc <cfif url.asc_1 eq 0>ASC <cfset url.sw = 1><cfelse>DESC <cfset url.sw = 0></cfif>    
            <cfelseif url.sort eq 3>
            	ORDER BY c.username <cfif url.asc_1 eq 0>ASC <cfset url.sw = 1><cfelse>DESC <cfset url.sw = 0></cfif>              
            </cfif>
		</cfquery>		
        
        <cfset variables.query_name = "recent_feedback">          
        
   </cfif>
        
                       <!--- Sorting vars set --->
							<cfif url.sw eq 1>
                                <cfset url.asc_1 = 1>
                            <cfelseif url.sw eq 0>
                            	<cfset url.asc_1 = 0>
                            <cfelse>
                            	<cfset url.asc_1 = 0>
                            </cfif>

                        
                                
		<table width="100%" border="0" cellspacing="5" cellpadding="0" class="site_text" bgcolor="FFFFFF">            
			<tr> 
				<td  class="header" colspan="8">
					<span class="header_orange">My</span> Feedback
				</td>
			</tr>        	
            <tr> 
                <td colspan="8" class="page_desc">       
                    Choices that you have already given feedback on, 
                    and choices that you are eligible to give feedback on, will be listed here.
                </td>
            </tr>   	
            <tr> 
					<!--- Sub menu for feedback --->
					<cfif url.f eq 1>
						<td align="left" width="2%" class="sub_menu">
				  			<img src="images/arrow_orange.gif"/>
						</td>
						<td align="left" width="23%" class="sub_menu">
							<a href="index.cfm?fa=my_feedback&f=1" class="orange_text_big">General Requests</a>
						</td>
					<cfelse>
						<td align="left" width="2%" class="sub_menu">&nbsp;
				  			
						</td>
						<td align="left" width="23%" class="sub_menu">
							<a href="index.cfm?fa=my_feedback&f=1" class="sub_menu_link">General Requests</a>
						</td>
					</cfif>
				</td>
					<cfif url.f eq 2>
						<td align="left" width="2%" class="sub_menu">
				  			<img src="images/arrow_orange.gif"/>
						</td>
						<td align="left" width="23%" class="sub_menu">
							<a href="index.cfm?fa=my_feedback&f=2" class="orange_text_big">Targeted Requests</a>
						</td>
					<cfelse>
						<td align="left" width="2%" class="sub_menu">&nbsp;
				  			
						</td>
						<td align="left" width="23%" class="sub_menu">
							<a href="index.cfm?fa=my_feedback&f=2" class="sub_menu_link">Targeted Requests</a>
						</td>
					</cfif>
					<cfif url.f eq 3>
						<td align="left" width="2%" class="sub_menu">
				  			<img src="images/arrow_orange.gif"/>
						</td>
						<td align="left" width="23%" class="sub_menu">
							<a href="index.cfm?fa=my_feedback&f=3" class="orange_text_big">Group Requests</a>
						</td>
					<cfelse>
						<td align="left" width="2%" class="sub_menu">&nbsp;
				  			
						</td>
						<td align="left" width="20%" class="sub_menu">
							<a href="index.cfm?fa=my_feedback&f=3" class="sub_menu_link">Group Requests</a>
						</td>
					</cfif>
					<cfif url.f eq 4>
						<td align="left" width="2%" class="sub_menu">
				  			<img src="images/arrow_orange.gif"/>
						</td>
						<td align="left" width="23%" class="sub_menu" nowrap="nowrap">
							<a href="index.cfm?fa=my_feedback&f=4" class="orange_text_big">Feedback I have Given</a>
						</td>
					<cfelse>
						<td align="left" width="2%" class="sub_menu">&nbsp;
				  			
						</td>
						<td align="left" width="26%" class="sub_menu" nowrap="nowrap">
						<a href="index.cfm?fa=my_feedback&f=4" class="sub_menu_link">Feedback I Have Given</a>
						</td>
					</cfif>
			</tr>	
      <cfif url.f eq 1>
			<tr>
				<td class="site_text" valign="top" colspan="8" align="left" valign="top">
                <cfif recent_everyone.recordcount neq 0>
                	<table cellpadding="0" cellspacing="0" class="site_text" style="width:100%">
                    	<cfoutput>
						
							<cfinclude template="includes/feedback_columns.cfm">
						
                       </cfoutput>
						<cfoutput query="recent_everyone" startrow="#rowStart#" maxrows="#maxRows#">
                        	<tr>
                            	<td class="column_data" style="width:70%">
                             		<a href="index.cfm?fa=choice_feedback&cid=#recent_everyone.id#&mid=#recent_everyone.mid#" class="bodylink">#recent_everyone.short_desc#</a>
                                </td>
                                <td class="column_data"  style="width:20%" nowrap="nowrap">
    								#DateFormat(recent_everyone.date_created, "mm/dd/yyyy  h:mm")#
                                </td>
                                <td class="column_data"  style="width:10%">
                            	 	<cfif recent_everyone.anon eq 0>
                                    	<a href="index.cfm?fa=profile&mid=#recent_everyone.mid#" class="bodylink">#recent_everyone.username#</a>  
                            		<cfelse>
                                    	Anonymous
                                    </cfif> 
                            	</td>
                             </tr>
                        </cfoutput>
                    </table>
                        <cfelse>
                            There are not choices created by the MMC community for you to give feedback on.
                        </cfif>
 
                	
				</td>
			</tr>	
     
     
     <cfelseif url.f eq 2>      
                    
                    
			<tr>
				<td class="site_text" valign="top" colspan="8" align="left" valign="top">
                <cfif recent_adv.recordcount neq 0>
                	<table cellspacing="0" cellpadding="0" class="site_text" style="width:100%">
                    	<cfoutput>
						
							<cfinclude template="includes/feedback_columns.cfm">
						
                       </cfoutput>
						<cfoutput query="recent_adv" startrow="#rowStart#" maxrows="#maxRows#">
                        	
                        	<tr>
                            	<td class="column_data" style="width:70%">
                             		<a href="index.cfm?fa=choice_feedback&cid=#recent_adv.id#&mid=#recent_adv.mid#" class="bodylink">#recent_adv.short_desc#</a>
                                </td>
                                <td class="column_data" style="width:20%" nowrap="nowrap">
    								#DateFormat(recent_adv.date_created, "mm/dd/yyyy  h:mm")#
                                </td>
                                <td class="column_data" style="width:10%">
                            	 	<cfif recent_adv.anon eq 0>
                                    	<a href="index.cfm?fa=profile&mid=#recent_adv.mid#" class="bodylink">#recent_adv.username#</a>  
                            		<cfelse>
                                    	Anonymous
                                    </cfif> 
                            	</td>
                             </tr>
                        </cfoutput>
                    </table>
                 <cfelse>
                    If another Member sends out a Targeted Feedback Request, and you meet the criteria of their request, then that choice will show up here for you to provide feedback.
                    <br /><br />
                    <strong>Example:</strong> If a member wants feedback from only people who are married, and your profile indicates that you are married, then their choice will show up here
                    for you to provide feedback on.
                 </cfif>
 
                	
				</td>
			</tr>	
             	
                
    <cfelseif url.f eq 3>
 
 
			<tr>
				<td class="site_text" valign="top" colspan="8" align="left" valign="top">
                <cfif recent_groups.recordcount neq 0>
                	<table cellspacing="0" cellpadding="0" class="site_text"  style="width:100%">
                    	<cfoutput>
						
							<cfinclude template="includes/feedback_columns.cfm">
						
                        </cfoutput>
						<cfoutput query="recent_groups" startrow="#rowStart#" maxrows="#maxRows#">
                        	<tr>
                            	<td class="column_data" style="width:70%">
                             		<a href="index.cfm?fa=choice_feedback&cid=#recent_groups.id#&mid=#client.mid#" class="bodylink">#recent_groups.short_desc#</a>
                                </td>
                                <td class="column_data" style="width:20%" nowrap="nowrap">
    								#DateFormat(recent_groups.date_created, "mm/dd/yyyy  h:mm")#
                                </td>
                                <td class="column_data" style="width:10%" nowrap="nowarp">
                            		<cfif recent_groups.anon eq 0>
                                    	<a href="index.cfm?fa=profile&mid=#recent_groups.mid#" class="bodylink">#recent_groups.username#</a>  
                            		<cfelse>
                                    	Anonymous
                                    </cfif>
                                </td>
                             </tr>
                        </cfoutput>
                     </table>
                        <cfelse>
                           This is where all your group choices and decisions will be listed. 
						   This will include groups that you are a member of, and groups that you have created.
                        </cfif>
                                     	
				</td>
			</tr>	
    
            
     <cfelseif url.f eq 4>       


			<tr>
				<td class="site_text" valign="top" colspan="8" align="left" valign="top">
                <cfif recent_feedback.recordcount neq 0>
                	<table cellspacing="0" cellpadding="0" class="site_text" style="width:100%">
                    	<cfoutput>
						
							<cfinclude template="includes/feedback_columns.cfm">
						
                        </cfoutput>
						<cfoutput query="recent_feedback" startrow="#rowStart#" maxrows="#maxRows#">
                        	<tr>
                            	<td class="column_data" style="width:70%">
                             		<a href="index.cfm?fa=view_choice&cid=#recent_feedback.id#&mid=#recent_feedback.mid#" class="bodylink">#recent_feedback.short_desc#</a>
                                </td>
                                <td class="column_data" style="width:20%" nowrap="nowrap">
    								#DateFormat(recent_feedback.date_created, "mm/dd/yyyy  h:mm")#
                                </td>
                                <td class="column_data" style="width:10%">
                            	 	<cfif recent_feedback.anon eq 0>
                                    	<a href="index.cfm?fa=profile&mid=#recent_feedback.mid#" class="bodylink">#recent_feedback.username#</a>  
                            		<cfelse>
                                    	Anonymous
                                    </cfif> 
                            	</td>
                             </tr>
                        </cfoutput>   
                    </table>
                            <cfelse>
                                There are currently no choices that you have already given feedback on.
                                <br /><br />
                                Click on the links above to find choices to provide feedback on.
                            </cfif>
				</td>
			</tr>
                        
      </cfif>
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
							<td class="previous_page"><cfif variables.page_number gt 1><a href="index.cfm?fa=my_feedback&sort=#url.sort#&page=#variables.page_number - 1#&f=#url.f#&asc_1=#sort_asc#" class="columnlink">Previous</a>&nbsp;</cfif></td>
							<td class="page_range" colspan="3">
								<cfset variables.start_page = 1 />
								<cfset variables.page_numbers_to_show = 9 - variables.start_page />
								<cfset variables.end_page = variables.last_page />
								<cfloop index="i" from="#variables.start_page#" to="#variables.end_page#">
									<a href="index.cfm?fa=my_feedback&sort=#url.sort#&page=#i#&f=#url.f#&asc_1=#sort_asc#" class="columnlink"><cfif i eq variables.page_number><strong>#i#</strong><cfelse>#i#</cfif></a>
								</cfloop>
							</td>
							<td class="next_page"><cfif variables.page_number lt variables.last_page>&nbsp;<a href="index.cfm?fa=my_feedback&sort=#url.sort#&page=#variables.page_number + 1#&f=#url.f#&asc_1=#sort_asc#" class="columnlink">Next</a></cfif></td>
						</tr>
					</table>
					</cfoutput>	                    
                </td>
            </tr>
           </cfif>      
	</table>

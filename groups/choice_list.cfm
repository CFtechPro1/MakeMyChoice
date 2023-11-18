<meta name="robots" content="noindex" />
<meta name="googlebot" content="index" />

        <cfparam name="url.keywords" default="">
        <cfparam name="url.categories" default="">

        <cfparam name="url.sort" default=0>
        <cfparam name="url.asc_1" default=0>
        <cfparam name="url.sw" default=-1>        


    	<!--- Get the top ten most recent choices for THIS GROUP. --->
		<cfquery name="group_choices" datasource="#application.dsn#">
			SELECT c.id, c.mid, c.username, c.short_desc, c.date_created, c.num_of_answers, c.anon, r.gid, r.request_type,
            	(SELECT COUNT(id) AS Expr1 FROM t_feedback WHERE cid = c.id) AS response_count
			FROM t_choices c INNER JOIN
            	t_requests r ON c.id = r.cid
			WHERE r.gid = #client.gid#
				AND r.request_type = 'group'
            	AND (c.id IN (SELECT cid FROM t_answers) OR c.num_of_answers = 0)
				<cfif url.keywords neq "">
					AND c.short_desc LIKE '%#url.keywords#%'
				</cfif>
				<cfif url.categories neq "">
					AND c.id IN (SELECT cid FROM t_choice_cats WHERE cat_id IN (#url.categories#))
				</cfif>
           <cfif url.sort eq 0 OR url.sort eq 2>									
                ORDER BY c.id <cfif url.asc_1 eq 0>DESC <cfset url.sw = 1><cfelse>ASC <cfset url.sw = 0></cfif>
            <cfelseif url.sort eq 1>
            	ORDER BY c.short_desc <cfif url.asc_1 eq 0>ASC <cfset url.sw = 1><cfelse>DESC <cfset url.sw = 0></cfif>        
            </cfif>
		</cfquery>	
		
		<cfset variables.query_name = "group_choices">
        	
            <cfquery name="g" datasource="#application.dsn#">
                SELECT id, mid, group_name, group_desc, private, group_pic
                FROM t_groups 
                	WHERE id = #client.gid#
            </cfquery>


		


		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="dkblue12" bgcolor="FFFFFF">
			<tr> 
				<td  class="header" colspan="2">
					<span class="header_orange">Choice</span> Results
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
                            	<a href="javascript:ColdFusion.navigate('choice_list.cfm?keywords=#url.keywords#&categories=#url.categories#&sort=1&asc_1=#url.asc_1#','SearchResult');" class="columnlink">Choice Description</a>
								<cfif url.sort eq 1>
									<cfif url.asc_1 eq 0>
										<img src="../images/arrow_sort_down.gif" />
									<cfelse>
										<img src="../images/arrow_sort_up.gif" />
									</cfif>
								</cfif>
                            </td>
                        	<td class="column_header">
                            	<a href="javascript:ColdFusion.navigate('choice_list.cfm?keywords=#url.keywords#&categories=#url.categories#&sort=2&asc_1=#url.asc_1#','SearchResult');" class="columnlink">Date Created</a>
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
						<cfoutput query="group_choices">
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

						No Choices were returned for your search. Plase expand your search criteria.

                </cfif>
                
                
                
				</td>
			</tr>	    
		</table>

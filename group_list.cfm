
        <cfparam name="url.keywords" default="">
        <cfparam name="url.categories" default="">

<!--- <cfoutput>
	#url.keywords#
	#url.categories#
</cfoutput>
<cfabort> --->
    

 		<!--- Get all the Groups that meet the criteria selected. --->
            <cfquery name="g" datasource="#application.dsn#">
                SELECT g.id, g.mid, g.group_name, g.group_desc, g.private, m.username
                FROM t_groups g INNER JOIN 
					t_members m ON g.mid = m.id
                	WHERE g.private = 0
						<cfif url.keywords neq "">
							AND g.group_name LIKE '%#url.keywords#%'
						</cfif>
						<cfif url.categories neq "">
							AND g.id IN (SELECT gid FROM t_group_cats WHERE cat_id IN (#url.categories#))
						</cfif>
                	ORDER BY group_name
            </cfquery>	
   

		<table border="0" cellspacing="0" cellpadding="0" class="site_text" width="100%">
                <cfif g.recordcount neq 0>
                    	<tr>
                        	<td class="column_header" style="width:20%">
                            	Group Name
                            </td>
                        	<td class="column_header" style="width:30%">
                            	Group Description
                            </td>
                        	<td class="column_header" style="width:15%">
                            	Created By
                            </td>
                        	<td class="column_header" style="width:15%">
                            	Member Count
                            </td>
                        	<td class="column_header" style="width:20%">
                            	Join Group
                            </td>
                         </tr>
						<cfoutput query="g">
						
								<cfquery name="gm" datasource="#application.dsn#">
									SELECT id, mid, gid, ab_mid, date_created
									FROM t_group_members 
										WHERE gid = #g.id#
								</cfquery>	
                        	<tr>
                            	<td class="column_data">
                             		<a href="groups/index.cfm?fa=home&gid=#g.id#" class="bodylink">#g.group_name#</a>
                                </td>
                            	<td class="column_data">
                             		#left(g.group_desc,150)#<cfif g.group_desc gt 150>....</cfif>
                                </td>
                                <td class="column_data">
									<a href="index.cfm?fa=profile&mid=#g.mid#" class="bodylink">#g.username#</a>
                                </td>   
                                <td bgcolor="FFFFFF" align="center">
                               		#gm.recordcount#
                                </td>   
                                <td class="column_data">
									<a href="actions/act_Groups.cfm?gid=#g.id#&function=joinGroup" class="bodylink">Join Group</a>
                                </td> 
                             </tr>
                             
                        </cfoutput>
                <cfelse>
                	<tr>
                    	<td class="alert_text" nowrap="nowrap">
                        	<br /><br />
                        	<span class="red_stars">***</span> No groups matched your search criteria. Please broaden your search. <span class="red_stars">***</span>
                            <br /><br />
                        </td>
                    </tr>
                	
                </cfif>
		</table>

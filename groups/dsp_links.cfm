<meta name="robots" content="noindex" />
<meta name="googlebot" content="index" />


		<cfparam name="url.cd" default=0>
        <cfparam name="url.sort" default=0>
        <cfparam name="url.asc_1" default=0>
        <cfparam name="url.sw" default=-1>
        <cfparam name="url.c" default=0>
        <cfparam name="url.newOrg" default=0>
		<cfparam name="url.type" default=0>
        <cfparam name="url.sort" default=0>
		<cfparam name="url.updated" default=0>
		<cfparam name="url.added" default=0>
		<cfparam name="url.deleted" default=0>


    	<!--- Get all the links for this group. --->
		<cfquery name="links" datasource="#application.dsn#">
			SELECT id, mid, gid, url, url_text, url_desc, date_created
			FROM t_group_links
			WHERE gid = #client.gid#
           <cfif url.sort eq 0 OR url.sort eq 2>									
                ORDER BY id <cfif url.asc_1 eq 0>DESC <cfset url.sw = 1><cfelse>ASC <cfset url.sw = 0></cfif>
            <cfelseif url.sort eq 1>
            	ORDER BY url_text <cfif url.asc_1 eq 0>ASC <cfset url.sw = 1><cfelse>DESC <cfset url.sw = 0></cfif>        
            </cfif>
		</cfquery>	

            <cfquery name="g" datasource="#application.dsn#">
                SELECT id, mid, group_name, group_desc, private, group_pic
                FROM t_groups 
                	WHERE id = #client.gid#
            </cfquery>

		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="site_text">
			<tr> 
				<td  class="header" colspan="2">
					<span class="header_orange">Group</span> Links
				</td>
			</tr>	
			<cfif url.added eq 1>
                <tr> 
                    <td class="alert_text" colspan="4">
                        <span class="stars">***</span> Your link has been added. <span class="stars">***</span>
                    </td>
                </tr>
            </cfif>
			<cfif url.updated eq 1>
                <tr> 
                    <td class="alert_text" colspan="4">
                        <span class="stars">***</span> Your link has been updated. <span class="stars">***</span>
                    </td>
                </tr>
            </cfif>
			<cfif url.deleted eq 1>
                <tr> 
                    <td class="alert_text" colspan="4">
                        <span class="stars">***</span> Your link has been deleted. <span class="stars">***</span>
                    </td>
                </tr>
            </cfif>
                <tr> 
                    <td class="page_desc" colspan="4">       
                        Here is where all the links for this Group will be listed.
                    </td>
                </tr>   
				
			<tr>
				<td class="site_text" align="left">
                <cfif links.recordcount neq 0>
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
                            	<a href="index.cfm?fa=links&sort=1&asc_1=#url.asc_1#" class="columnlink">Link Subject</a>
								<cfif url.sort eq 1>
									<cfif url.asc_1 eq 0>
										<img src="../images/arrow_sort_down.gif" />
									<cfelse>
										<img src="../images/arrow_sort_up.gif" />
									</cfif>
								</cfif>
                            </td>
							<td class="column_header">
								Link Description
							</td>
                        	<td class="column_header">
                            	<a href="index.cfm?fa=links&sort=2&asc_1=#url.asc_1#" class="columnlink">Date Created</a>
								<cfif url.sort eq 2>
									<cfif url.asc_1 eq 0>
										<img src="../images/arrow_sort_down.gif" />
									<cfelse>
										<img src="../images/arrow_sort_up.gif" />
									</cfif>
								</cfif>
                            </td>
							<cfif client.mid eq links.mid OR g.mid eq client.mid>
								<td class="column_header">
									Edit/Delete
								</td>
							</cfif>
                         </tr>
                       </cfoutput>
						<cfoutput query="links">
								<cfif links.url CONTAINS "http://">
									<cfset links.url = replace(links.url,"http://","")>
								</cfif>
                            <tr>
                            	<td class="column_data" style="width:40%">
                             		<a href="http://#trim(links.url)#" target="_new" class="bodylink">#links.url_text#</a>
                                </td>                                
								<td class="column_data" style="width:40%" align="center">                            	
                                	#links.url_desc#
                                </td>
                                <td class="column_data" style="width:10%" nowrap="nowrap">
    								#DateFormat(links.date_created, "mm/dd/yyyy")# #TimeFormat(links.date_created, "h:mm tt")#
                                </td>

								<cfif client.mid eq links.mid OR g.mid eq client.mid>
									<td class="column_data" style="width:10%" nowrap="nowrap">								
										<a href="index.cfm?fa=new_link&link_id=#links.id#&edit=1" class="tinylink">EDIT</a> | <a href="../actions/act_deleteItem.cfm?link_id=#links.id#&gid=#client.gid#&item=groupLink" class="tinylink" onclick="return confirm('Are you sure you want to delete this Choice?')">delete</a> 	
									</td>
								</cfif>
                             </tr>
                        </cfoutput>
                      </table>
                <cfelse>
					<br /><br />

						This group does not have any links yet. &nbsp; <a href="index.cfm?fa=new_link" class="bodylink">Add New Link</a>

                </cfif>
                
                
                
				</td>
			</tr>	   
		</table>

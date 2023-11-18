
        <cfparam name="url.firstName" default="">
        <cfparam name="url.lastName" default="">
        <cfparam name="url.username" default="">
        <cfparam name="url.emailAddress" default="">

        <cfparam name="url.sSortColumn" default="last_name" />
        <cfparam name="url.bSortDESC"   default="0" />
        <cfparam name="url.nRowsPerPage" default="50" />
        <cfparam name="url.nPageToReturn" default="1" />

	
    <cfif url.bSortDESC eq 0>
    	<cfset url.desc_link = 1>
    <cfelse>
    	<cfset url.desc_link = 0>
    </cfif>
	
 	<cfset variables.startRow = ((url.nPageToReturn - 1) * url.nRowsPerPage) + 1>
    

 		<!--- Get all the members that meet the criteria selected. --->
            <cfquery name="gm" datasource="#application.dsn#">
                SELECT gm.id, gm.gid, gm.mid, gm.emailAddress, gm.firstName, gm.lastName,
                	gm.confirmed, m.username, m.first_name, m.last_name, m.email_address AS member_email
                FROM t_group_members gm LEFT OUTER JOIN
                	t_members m ON m.id = gm.mid
                	WHERE gm.ab_mid = #client.mid#
					AND gm.gid = #url.gid#
            </cfquery>
   
  
	

		<table border="0" cellspacing="1" cellpadding="5" class="dkblue12" bgcolor="577DB1">
                <cfif gm.recordcount neq 0>
                    	<tr>
                        	<td class="header_small" style="width:5%">
                            	Remove
                            </td>
                        	<td class="header_small" style="width:25%">
                            	Username
                            </td>
                        	<td class="header_small" style="width:25%">
                            	Email Address
                            </td>
                        	<td class="header_small" style="width:25%">
                            	First Name 
                            </td>
                        	<td class="header_small" style="width:25%">
                            	Last Name
                            </td>
                        	<td class="header_small" style="width:10%">
                            	Status
                            </td>
                         </tr>
						<cfoutput query="gm" startrow="#variables.startRow#">
                        	<tr id="#gm.id#">
                            	<td bgcolor="FFFFFF" align="center">
                                	<a href="javascript:;" onclick="depopulateDiv(#gm.id#)"><img src="images/subtract_icon.jpg" border="0" /></a>
                                </td>
                            	<td bgcolor="FFFFFF">
                                	<cfif gm.username neq "">
                             			<a href="index.cfm?fa=profile&mid=#gm.mid#" class="bodylink">#gm.username#</a>
                                    <cfelse>
                                    	&nbsp;
                                    </cfif>
                                </td>
                                <td bgcolor="FFFFFF">
									<cfif gm.member_email neq "">
                                        <a href="index.cfm?fa=new_message&mid=#gm.mid#" class="bodylink">#gm.member_email#</a>
                                    <cfelse>
                                        #gm.emailAddress#
                                    </cfif>
                                </td>   
                                <td bgcolor="FFFFFF">
                               		<cfif gm.first_name neq "">
                                    	#gm.first_name#
                                    <cfelse>
                                    	#gm.firstName#
                                    </cfif>
                                </td>   
                                <td bgcolor="FFFFFF">
                               		<cfif gm.last_name neq "">
                                    	#gm.last_name#
                                    <cfelse>
                                    	#gm.lastName#
                                    </cfif>
                                </td> 
                                <td bgcolor="FFFFFF">
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
                                <input type="hidden" name="#gm.id#" value="#gm.id#" />
                             </tr>
                             
                        </cfoutput>
                <cfelse>
                	<tr>
                    	<td class="alert_text" nowrap="nowrap">
                        	<br /><br />
                        	<span class="red_stars">***</span> You have no members for this group yet. Please add members above. <span class="red_stars">***</span>
                            <br /><br />
							<input type="hidden" name="0" value="0" />
                        </td>
                    </tr>
                	
                </cfif>
		</table>

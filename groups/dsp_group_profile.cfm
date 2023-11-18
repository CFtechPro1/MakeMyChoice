


<cfparam name="url.eSettings" default=0>


            <cfquery name="g" datasource="#application.dsn#">
                SELECT g.id, g.mid, g.group_name, g.group_desc, g.private, g.group_pic, m.username, m.first_name, m.last_name, m.email_address,
							p.d_first_name, p.d_last_name, p.d_email_address 
                FROM t_groups g INNER JOIN
					t_members m ON g.mid = m.id
						INNER JOIN t_profile_display p
							ON g.mid = p.mid
                	WHERE g.id = #client.gid#
            </cfquery>
			
            <cfquery name="gm" datasource="#application.dsn#">
                SELECT id, mid, gid
                FROM t_group_members 
                	WHERE gid = #client.gid#
					AND confirmed = 1
            </cfquery>			


		<!--- Upload image and personal details --->
 <cfoutput>	
		<table width="100%" border="0" cellspacing="10" cellpadding="0" class="site_text">
			<tr> 
				<td class="header" colspan="2">
					<span class="header_orange">Group</span> Profile
				</td>
			</tr>
           <tr> 
              <td class="form_instruct" width="25%">
                  Group Image                 
              </td>
              <td class="form_input">
			 	<cfif g.group_pic neq "">
					<a href="#application.urlpath#media/#g.mid#/#client.gid#/#g.group_pic#" target="_new" class="bodylink">
					 <img src="#application.urlpath#media/#g.mid#/#client.gid#/#g.group_pic#" width="150" height="150" border="01">
					</a>
				<cfelse>
					No image uploaded.
				</cfif>
              </td>
          </tr>
           <tr> 
              <td class="form_instruct" width="25%">
                  Group Description    
              </td>
              <td class="form_input"> 
				 #g.group_desc#
              </td>
          </tr>  
           <tr> 
              <td class="form_instruct" width="25%">
                  Group Members   
              </td>
              <td class="form_input"> 
			  	<cfif gm.recordcount eq 0>
					0 members
				<cfelse>
					<a href="index.cfm?fa=group_members" class="bodylink">
						#gm.recordcount# members
					</a>				
				</cfif>
              </td>
          </tr>   
           <tr> 
              <td class="form_instruct" width="25%">
                  Group Administrator    
              </td>
              <td class="form_input"> 
			  		<table cellpadding="5">
						<tr>
							<td class="column_header">
					 		First Name:
							</td>
							<td class="column_data">
								<cfif g.first_name neq "" AND g.d_first_name eq 1>
								 #g.first_name# 
								 <cfelse>
								 N/A
								 </cfif>
							 </td>
						</tr>
						<tr>
							<td class="column_header">
					 		Last Name:
							</td>
							<td class="column_data">
								<cfif g.last_name neq "" AND g.d_last_name eq 1>
								 #g.last_name# 
								 <cfelse>
								 N/A
								 </cfif>
							 </td>
						</tr>
						<tr>
							<td class="column_header">
					 		Username:
							</td>
							<td class="column_data">
							 #g.username#
							 </td>
						</tr>
						<tr>
							<td class="column_header">
					 		Send Message:
							</td>
							<td class="column_data">
								<cfif g.email_address neq "" AND g.d_email_address eq 1>
									<a href="../index.cfm?fa=new_message&mid=#g.mid#" class="bodylink">#g.email_address#</a>
								 <cfelse>
									<a href="../index.cfm?fa=new_message&mid=#g.mid#" class="bodylink">Send Message</a>
								 </cfif>
							 </td>
						</tr>
					</table>
					 
              </td>
          </tr> 
        </table>
</cfoutput>	
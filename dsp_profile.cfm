
<cfparam name="form.gender" default="">
<cfparam name="form.marital_status" default="">
<cfparam name="url.mid" default=0>
<cfparam name="url.added" default=0>
<cfparam name="url.existed" default=0>
<cfparam name="url.gid" default=0>

<script Language="JavaScript"><!--
function Valid(theForm)
{

  if (theForm.gid.value == 0)
  {
    alert("Please choose one of your Groups to invite this member to.");
    theForm.gid.focus();
    return (false);
  }

  return (true);
}
//--></script>

<cfinclude template="udfs/feedbackPercent.cfm">




		<cfquery name="profile" datasource="#application.dsn#" maxrows="1">
			SELECT id, first_name, last_name, username, email_address, password, country, zip_code, dob, gender, marital_status, cultural_heritage,
            			children, hobbies, profession, image, quote, details, DATEDIFF(YEAR,DOB,GETDATE()) as age
			FROM t_members
			WHERE id = #url.mid#
		</cfquery>	
        
		<cfquery name="dp" datasource="#application.dsn#" maxrows="1">
			SELECT id, mid, d_first_name, d_last_name, d_username, d_email_address, d_country, d_zip_code, d_dob, d_gender, d_marital_status, d_cultural_heritage,
            			d_children, d_hobbies, d_profession, d_image, d_quote, d_details
			FROM t_profile_display
			WHERE mid = #url.mid#
		</cfquery>       
         
		  <!--- Get all feedback results for this member. the choices they have provided feedback on, and what asnwers they chose, for only closed choices. --->
          <cfquery name="f" datasource="#application.dsn#">
              SELECT id, cid, mid, aid, feedback_mid, date_created
              FROM t_feedback
              WHERE feedback_mid = #url.mid#
                  AND cid IN 
                  (SELECT id FROM t_choices
                      WHERE date_end < GETDATE())
          </cfquery>
    
            <cfquery name="g" datasource="#application.dsn#">
                SELECT id, mid, group_name
                FROM t_groups 
                	WHERE mid = #client.mid#
                	ORDER BY group_name
            </cfquery>		
	
<body>			

<cfoutput>


		
		<table width="100%" border="0" cellspacing="1" cellpadding="5" class="site_text">
			<tr> 
				<td class="header" colspan="2">
					<span class="header_orange">#profile.username#'s</span> Profile
				</td>
			</tr>
			  <cfif url.existed eq 1>
                  <tr> 
                      <td class="alert_text" colspan="2">
                          <span class="red_stars">***</span> This member is already a member of the specified group.<span class="red_stars">***</span>
                      </td>
                  </tr> 
              </cfif>  
			  <cfif url.added eq 1>
                  <tr> 
                      <td class="alert_text" colspan="2">
                          <span class="red_stars">***</span> An group invitation email has been sent to this member. <span class="red_stars">***</span>
						  <br><br>
						  You can check the status of memberships in the <a href="index.cfm?fa=group_members_add&gid=#url.gid#" class="bodylink">edit group members</a> section.
                      </td>
                  </tr> 
              </cfif>  
            <tr> 
				<td class="basic_td" style="width:75%">			
                
                        <table width="100%" border="0" cellspacing="5" cellpadding="5" class="site_text">
                          <tr>
                              <td class="form_instruct" style="width:25%">
                                  Username:
                              </td>
                              <td bgcolor="FFFFFF">
                                  <strong>#profile.username#</strong>
                                  
                                  <cfif profile.image neq "">
                                  		<br><br>
                                      <img src="media/#url.mid#/#profile.image#" width="75" height="75">
                                      <br>
                                  </cfif>
                                  <cfif profile.quote neq "">
                                      <br>
                                      <span class="dkblue12"><em>#profile.quote#</em></span><br>
                                  </cfif>
                              </td>
                          </tr>	
                      <cfif dp.d_first_name eq 1>  
                          <tr>
                              <td class="form_instruct">
                                  First Name:
                              </td>
                              <td bgcolor="FFFFFF">
                                  #profile.first_name#
                              </td>
                          </tr>	  
                      </cfif>     
                      <cfif dp.d_last_name eq 1>  
                          <tr>
                              <td class="form_instruct">
                                  Last Name:
                              </td>
                              <td bgcolor="FFFFFF">
                                  #profile.last_name#
                              </td>
                          </tr>	  
                      </cfif>       
                      <cfif dp.d_email_address eq 1>  
                          <tr>
                              <td class="form_instruct">
                                  Email Address:
                              </td>
                              <td bgcolor="FFFFFF">
                                  #profile.email_address#
                              </td>
                          </tr>	  
                      </cfif>                   
                      <cfif profile.details neq "">
                          <tr>
                              <td class="form_instruct">
                                  Details:
                              </td>
                              <td bgcolor="FFFFFF">
                                  #profile.details#
                              </td>
                          </tr>	  
                      </cfif>     
                     
                      <cfif dp.d_country eq 1>    
                          <tr>
                              <td class="form_instruct">
                                  Country:
                              </td>
                              <td bgcolor="FFFFFF">
                                  #profile.country#
                              </td>
                          </tr>	
                      </cfif>
                      <cfif dp.d_zip_code eq 1>   
                          <tr>
                              <td class="form_instruct">
                                  Postal/Zip Code:
                              </td>
                              <td bgcolor="FFFFFF">
                                  #profile.zip_code#
                              </td>
                          </tr> 
                      </cfif>
                      <cfif dp.d_gender eq 1>   
                          <tr>
                              <td class="form_instruct">
                                  Gender:
                              </td>
                              <td bgcolor="FFFFFF">
                                  #profile.gender#
                              </td>
                          </tr>	
                      </cfif>
                      <cfif dp.d_marital_status eq 1>   			
                          <tr>				
                              <td class="form_instruct" nowrap>
                                  Marital Status:
                              </td>
                              <td bgcolor="FFFFFF">
                                  #profile.marital_status#
                              </td>
                          </tr>	
                      </cfif>
              		  <cfif dp.d_cultural_heritage eq 1>   
                          <tr>
                              <td class="form_instruct" nowrap>
                                  Cultural Heritage:
                              </td>
                              <td bgcolor="FFFFFF">
                                  #profile.cultural_heritage#
                              </td>
                          </tr>	
                      </cfif>
                      <cfif dp.d_children eq 1>   
                          <tr>
                              <td class="form_instruct" nowrap>
                                  Number of Children:
                              </td>
                              <td bgcolor="FFFFFF">
                                  #profile.children#
                              </td>
                          </tr>		
                      </cfif>
                      <cfif dp.d_hobbies eq 1>   
                          <tr>
                              <td class="form_instruct" nowrap>
                                  Hobbies:
                              </td>
                              <td bgcolor="FFFFFF">
                                  #profile.hobbies#
                              </td>
                          </tr>	
                      </cfif>
                      <cfif dp.d_profession eq 1>   
                          <tr>
                              <td class="form_instruct" nowrap>
                                  Business or Profession:
                              </td>
                              <td bgcolor="FFFFFF">
                                  #profile.profession#
                              </td>
                          </tr>	
                      </cfif>
                      <cfif dp.d_dob eq 1>      
                          <tr>
                              <td class="form_instruct">
                                  Date of Birth:
                              </td>
                              <td bgcolor="FFFFFF">
                                  #profile.dob#
                              </td>
                          </tr>	
                      </cfif>
                       </table>
                       
 				                      
                       
             	</td>
                
             	<td  style="width:25%" valign="top" bgcolor="FFFFFF">
                	<li><a href="index.cfm?fa=new_message&mid=#url.mid#" class="bodylink">Send Message</a></li> 
                    <br /><br />	
					<cfif g.recordcount neq 0 AND client.mid neq url.mid>
						<table class="site_text">
							<tr>
								<td class="alert_text">	
									Send this member an invitation to join one of your groups.
									<br><br>
										<form name="groupInvite" action="components/act_Groups.cfm" method="post">
											<select name="gid" size="1">
												<option vlue="0">Select Group...</option>
													<cfloop query="g">
														<option value="#g.id#">#g.group_name#</option>
													</cfloop>
											</select>
											<input type="hidden" name="mid" value="#url.mid#">
											<input type="hidden" name="function" value="addMember">
											<br><br>
											<input type="submit" value="Send Invite">
										 </form>
								</td>
							</tr>
						</table>
					</cfif>
                    <br /><br />	
                   	<cfif mid eq client.mid>
                        <li><a href="index.cfm?fa=my_profile" class="bodylink">Edit My Profile</a></li> 
                        <br /><br />	                   	
                    </cfif>
               	<cfif f.recordcount neq 0> 
                    <strong>#profile.username#</strong> has chosen the most popular answer for other members choices
                    <br>
                    <strong>#NumberFormat((feedbackPercent(profile.id) / f.recordcount * 100),"99.9")#%</strong> of the time 
                    <br>
                     <strong>#f.recordcount#</strong> total responses
                 </cfif>    
		     </td>   
             </tr>
      		
			<tr>
				<td colspan="2" >&nbsp;
					
				</td>
			</tr>				
		</table>
	


   </cfoutput>
</body>
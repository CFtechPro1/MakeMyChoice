
        <cfparam name="url.firstName" default="">
        <cfparam name="url.lastName" default="">
        <cfparam name="url.username" default="">
        <cfparam name="url.emailAddress" default="">

        <cfparam name="url.sSortColumn" default="username" />
        <cfparam name="url.bSortDESC"   default="0" />
        <cfparam name="url.nRowsPerPage" default="10" />
        <cfparam name="url.nPageToReturn" default=1 />

	
    <cfif url.bSortDESC eq 0>
    	<cfset url.desc_link = 1>
    <cfelse>
    	<cfset url.desc_link = 0>
    </cfif>
	
 	 <cfset variables.startRow = ((url.nPageToReturn - 1) * url.nRowsPerPage) + 1> 
    
  
<!---   <cfoutput>
  	#url.username# - #url.firstName# - #url.lastName# - #url.emailAddress#
  </cfoutput>
  <cfabort> --->
  
    <cfoutput>
 		<!--- Get all the members that meet the criteria selected. --->
		<cfquery name="members" datasource="#application.dsn#"  maxrows="#url.nRowsPerPage#">
			SELECT     id, first_name, last_name, username, password, email_address, country, zip_code, dob, gender, marital_status, cultural_heritage, children, hobbies, 
                      profession, date_created, remote_addr, remote_ident
			FROM         t_members
			WHERE     (1 = 1)    
				 <cfif url.username neq ""> 
                	AND (username LIKE '%#url.username#%') 
                 </cfif> 
				 <cfif url.firstName neq ""> 
                	AND (first_name LIKE '%#url.firstName#%') 
                 </cfif> 
				 <cfif url.lastName neq ""> 
                	AND (last_name LIKE '%#url.lastName#%') 
                 </cfif> 
                 <cfif url.emailAddress neq ""> 
                	AND (email_address LIKE '%#url.emailAddress#%') 
                 </cfif> 
			ORDER BY #url.sSortColumn# <cfif url.bSortDESC eq 0> ASC <cfelse> DESC </cfif>
		</cfquery>	
		
	</cfoutput>     
  
	

		<table border="0" cellspacing="1" cellpadding="5" class="dkblue12" bgcolor="577DB1">
                <cfif members.recordcount neq 0>
                    	<tr>
                        	<td class="header_small" style="width:10%">
                            	Add
                            </td>
                        	<td class="header_small" style="width:25%">
                            	Username
                            </td>
                        	<td class="header_small" style="width:25%">
                            	First Name 
                            </td>
                        	<td class="header_small" style="width:25%">
                            	Last Name
                            </td>                        	
                            <td class="header_small" style="width:25%">
                            	Email Address
                            </td>
                         </tr>
						<cfoutput query="members" startrow="#variables.startRow#">
                        	<tr>
                            	<td bgcolor="FFFFFF" align="center">
                                	<a href="javascript:;" onclick="populateDiv(#members.id#,'#members.username#','#members.first_name#','#members.last_name#','#members.email_address#')"><img src="images/plus_icon.jpg" border="0" /></a>
                                </td>
                            	<td bgcolor="FFFFFF">
                             		<a href="index.cfm?fa=profile&mid=#members.id#" class="bodylink">#members.username#</a>
                                </td>                                
                                <td bgcolor="FFFFFF">
                                    <a href="index.cfm?fa=new_message&mid=#members.id#" class="bodylink">#members.email_address#</a>
                                </td>   
                                <td bgcolor="FFFFFF">
                                    #members.first_name#
                                </td>   
                                <td bgcolor="FFFFFF">
                                    #members.last_name#
                                </td>                                
                             </tr>
                        </cfoutput>
                <cfelse>
                	<tr>
                    	<td class="alert_text" nowrap="nowrap">
                        	<br /><br />
                        	<span class="red_stars">***</span> Your Member search did not return any results. Please try again. <span class="red_stars">***</span>
                            <br /><br />
                        </td>
                    </tr>
                	
                </cfif>
		</table>

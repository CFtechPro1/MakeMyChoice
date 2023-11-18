
<cfparam name="url.sub" default=0>
<cfparam name="url.email" default=0>
<cfparam name="url.experts" default=0>
<cfparam name="url.feedback" default=0>
<cfparam name="url.be" default=0>
<cfparam name="url.uc" default=0>
<cfparam name="url.big" default=0>
<cfparam name="url.update" default=0>
<cfparam name="url.delete" default=0>
<cfparam name="url.review" default=0>
<cfparam name="url.nojpg" default=0>
<cfparam name="url.resize" default=0><head>	
	<title>
		PowerMarketer Assignments
	</title>
</head>










<link href="styles/style1.css" rel="stylesheet" type="text/css">



<cfquery name="business" datasource="#application.dsn#">
	SELECT id, cid, business_desc, generic_descriptor
	FROM t_business
	WHERE cid = #client.cid#
</cfquery>


	<cfquery name="names" datasource="#application.dsn#">
		SELECT id, element_text, business_element, legal_clearance, date_submitted, rating, gd_n
		FROM         t_bake_off
		WHERE     (cid = #client.cid#)
			AND business_element = '#url.be#'
		ORDER BY id DESC
	</cfquery>

	<cfset url.uc = names.recordcount + 1>
	


		
		<table width="100%" border="0" cellspacing="1" cellpadding="3" class="black14" class="print">
	<cfif url.sub eq 0>
			
<cfoutput>	
			<tr> 
				<td>
				<cfif names.recordcount lte 5>
				<font color="green">

					Please locate your #replace(ucase(url.be),"_"," ")# below and click "Upload" 
					<br><br>
					
				</font>
				</cfif>
				</td>
			</tr>		
<!--- 			<tr> 
				<td>
					<b>Key Graphics:</b> 
				</td>
			</tr> --->
<cfif url.big eq 1>
			<tr> 
				<td bgcolor="FFFFCC">
					<font color="red"><b>Your #replace(ucase(url.be),"_"," ")# is too large in file size. Please resize to be under 200k.</b></font>
				</td>
			</tr>
</cfif>
<cfif url.update eq 1>
			<tr> 
				<td bgcolor="FFFFCC">
					<font color="red"><b>Your #replace(ucase(url.be),"_"," ")# number <cfoutput>#(url.uc - 1)#</cfoutput> has been uploaded.</b></font>
				</td>
			</tr>
</cfif>
<cfif url.delete eq 1>
			<tr> 
				<td bgcolor="FFFFCC">
					<font color="red"><b>Your #replace(ucase(url.be),"_"," ")# has been deleted.</b></font>
				</td>
			</tr>
</cfif>
<cfif url.nojpg eq 1>
			<tr> 
				<td bgcolor="FFFFCC">
					<font color="red"><b>Your #replace(ucase(url.be),"_"," ")# has to be in the .jpg format. Please save it as a .jpg.</b></font>
				</td>
			</tr>
</cfif>
<cfif url.resize eq 1>
			<tr> 
				<td bgcolor="FFFFCC">
					<font color="red"><b>Your #replace(ucase(url.be),"_"," ")# needs to be less than or equal to <cfif url.be eq "key_graphic">600<cfelse>400</cfif> pixels width & less than or equal to <cfif url.be eq "key_graphic">600<cfelse>200</cfif> pixels height. Please resize it and try again.</b></font>
				</td>
			</tr>
</cfif>
</cfoutput>	
	<!--- If there are 6 graphics, then have them review and submit --->
	<cfif names.recordcount lte 5>
	
	<cfoutput>
	
			<tr> 
				<td>
				<font color="green">Please upload #replace(ucase(url.be),"_"," ")# number <cfoutput>#url.uc#</cfoutput>.</font>
				<br><br>
		


		<cfinclude template="includes/upload_instructions.cfm">
		
					
		
		<form action="act_key_graphic_upload.cfm?be=#url.be#&uc=#url.uc#<cfif url.email eq 1>&email=1</cfif><cfif url.experts eq 1>&experts=1</cfif>" method="post" enctype="multipart/form-data">

		<strong>#replace(ucase(url.be),"_"," ")#:</strong> <input type="file" name="upload_image"> <br><br>
		<input type="submit" value="  Upload  ">
		</form>
		
					<br><br>
				</td>
			</tr>	
		</cfoutput>	
	<cfelse>
		<cfoutput>
			<tr> 
				<td>
					<font color="green"><b>Please review your 6 #replace(ucase(url.be),"_"," ")#s below.</b></font>
					<cfif url.experts eq 1>
					<br><br>
						<font color="green">***</font> The Connectics Experts will be automatically contacted, and will provide the required feedback for this excercise. 
					</cfif>
					<cfif url.email eq 1>
					<br><br>
						<font color="green">***</font> Please enter email addresses and contact names below, that this excercise will be sent to. <font color="green">***</font>
					</cfif>
				</td>
			</tr>	
		</cfoutput>
	</cfif>		
	
		<cfif names.recordcount gt 0>
			<cfoutput query="names">
				<tr>
					<td align="center">
					<hr>
					<br>

							<img src="images/#url.be#/#client.cid#/#names.element_text#" border="0"> 
						
					
					<br><br>
					<a href="act_key_graphic_upload.cfm?be=#url.be#&delete=1&bid=#names.id#<cfif url.email eq 1>&email=1</cfif><cfif url.experts eq 1>&experts=1</cfif>" class="bodylink3">delete this graphic</a>
					<br>
					
					<hr>					
					</td>
				</tr>
				<tr>
					<td bgcolor="Gray">
					<br>
					</td>
				</tr>	
			</cfoutput>
		</cfif>		

	
	
	
	
	
	
	
			<cfif url.uc eq 7>		
			<cfoutput>	
	<form name="business" action="act_key_graphic_names.cfm?be=#url.be#&uc=#url.uc#<cfif url.email eq 1>&email=1</cfif><cfif url.experts eq 1>&experts=1</cfif>" method="post">
		<cfif names.recordcount gte 6 AND url.email neq 0>
			<tr> 
				<td>
				
				
					
					
						<!--- Include the text fields and select lists of Email address to send exercise to. --->
					<cfinclude template="functions/chooseEmails_bakeoff.cfm">
					
					
				
				
				
				</td>
			</tr>
		</cfif>
			<tr> 
				<td bgcolor="3969A4" align="center">
				
					<input type="submit" value="Submit"> 
					
				</td>
			</tr>
			</form>	
			
				</cfoutput>
			</cfif>	
			
			
			<!--- Old section for paper connectics. --->
			
	<cfelse>
			<tr> 
				<td>
					<b>My Buisness Description:</b>
				</td>
			</tr>
			<tr> 
				<td>
					<cfoutput>#business.business_desc#</cfoutput>
				</td>
			</tr>	
			<tr> 
				<td>
					<br>
					<font color="green">***</font> 
					Please review all of the key graphics one-by-one and circle the number at the bottom of the page that most expresses your judgment. 
					<br><br>
					Evaluate it as if you were going to purchase this product or service. 
					<br><br>
					<b>Rate it a 1 if it has no bearing on your decision or a 7 if you are significantly influenced by its presence. </b>
					<br><br>
					You may also rate it anywhere in between as appropriate. 
 					
				</td>
			</tr>		
			<cfif names.recordcount eq 0>
				<tr>
					<td>
						<strong>There are currently no Key Graphics.</strong>
					</td>
				</tr>
			<cfelse>
			
			<cfoutput query="names">
				<tr>
					<td align="center">
					<hr>
					<br>

							<img src="images/key_graphic/#client.cid#/#names.element_text#" border="0"> 
						
					
					<br>
					<br>
					Rate 1 to 7, 7 if you are significantly influenced by its presence.
					<br><br>
					<br>
					<table class="black14" border="0">
						<tr>
							<td nowrap="nowrap" align="center">
								&nbsp;
								<font size="+3">1</font>
								 &nbsp;
							</td>
							<td nowrap="nowrap" align="center">
								&nbsp;
								<font size="+3">2</font>
								 &nbsp;
							</td>
							<td nowrap="nowrap" align="center">
								&nbsp;
								<font size="+3">3</font>
								 &nbsp;
							</td>
							<td nowrap="nowrap" align="center">
								&nbsp;
								<font size="+3">4</font>
								 &nbsp;
							</td>
							<td nowrap="nowrap" align="center">
								&nbsp;
								<font size="+3">5</font>
								 &nbsp;
							</td>
							<td nowrap="nowrap" align="center">
								&nbsp;
								<font size="+3">6</font>
								 &nbsp;
							</td>
							<td nowrap="nowrap" align="center">
								&nbsp;
								<font size="+3">7</font>
								 &nbsp;
							</td>
						</tr>
						<tr>
							<td align="center" nowrap="nowrap" colspan="7">
								<img src="images/spectrum_bg.jpg">
							</td>
						</tr>
						<tr>
							<td nowrap="nowrap" align="center">
								<font size="1">Rejected</font>
							</td>
							<td nowrap="nowrap" align="center">
								<font size="1">Poor</font>
							</td>
							<td nowrap="nowrap" align="center">
								<font size="1">Weak</font>
							</td>
							<td nowrap="nowrap" align="center">
								<font size="1">Average</font>
							</td>
							<td nowrap="nowrap" align="center">
								<font size="1">Preferred</font>
							</td>
							<td nowrap="nowrap" align="center">
								<font size="1">Strong</font>
							</td>
							<td nowrap="nowrap" align="center">
								<font size="1">Remarkable</font>
							</td>
						</tr>
					</table>
					<br>
					<hr>					
					</td>
				</tr>
				<tr>
					<td bgcolor="Gray">
					<br><br>
					</td>
				</tr>	
			</cfoutput>				
				
			</cfif>	
</cfif>
	  	</table>
		<br><br>
	<cfif url.sub eq 1>	
		<table width="100%" border="0" cellspacing="1" cellpadding="3" class="black14" class="noprint">
			<tr> 
				<td>
					<form>
						<input type="button" value=" Print this page "  onclick="window.print();return false;" / >
					</form> 
				</td>
			</tr>
		</table>	
	</cfif>		

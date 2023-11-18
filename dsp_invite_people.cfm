

<cfparam name="url.cid" default=0>
<cfparam name="url.mid" default=0>
<cfparam name="url.sent" default=0>



<cfoutput>

		<table width="100%" border="0" cellspacing="1" cellpadding="5" class="dkblue12" bgcolor="577DB1">			
       		<tr> 
				<td class="header" colspan="2">
					Invite People to Join MakeMyChoice.com
				</td>
			</tr> 
       	<cfif url.sent eq 1>
			<tr> 
				<td class="alert_text" colspan="2">
                	<br><br>
					<span class="stars">***</span> Your invitation has been sent to the email addresses you provided. <span class="stars">***</span>
					<br><br>
                </td>
			</tr>
		</cfif>
        <form action="actions/act_invitePeople.cfm?mid=#url.mid#" method="post" onSubmit="return formValidator(this)">	
			<tr> 
				<td class="form_instruct" style="width:25%">
                	<p class="med-spacer">&nbsp;</p>
                    <p class="med-spacer">&nbsp;</p>
                    <p class="med-spacer">&nbsp;</p>
					Names & Email Addresses:
                    <br />
                    <span class="body_text">
                    	(enter the names and email addresses of the people you want to invite to join MakeMyChoice.com)
                    </span>
                    <p class="med-spacer">&nbsp;</p>
                </td>
				<td class="form_input" style="width:75%" nowrap="nowrap"> 
                	<strong>Message:</strong><br />
                	<textarea name="m_text" cols="60" rows="6"> </textarea>
                	<br /><br />
                	Name: <input type="text" name="name_1" size="30" maxlength="150" /> &nbsp; &nbsp; Email: <input type="text" name="email_1" size="30" maxlength="150" />
                 		<br /><br />
                    Name: <input type="text" name="name_2" size="30" maxlength="150" /> &nbsp; &nbsp; Email: <input type="text" name="email_2" size="30" maxlength="150" />
                    	<br /><br />
                    Name: <input type="text" name="name_3" size="30" maxlength="150" /> &nbsp; &nbsp; Email: <input type="text" name="email_3" size="30" maxlength="150" />
                  	 	<br /><br />
                    Name: <input type="text" name="name_4" size="30" maxlength="150" /> &nbsp; &nbsp; Email: <input type="text" name="email_4" size="30" maxlength="150" />
                    	<br /><br />
                    Name: <input type="text" name="name_5" size="30" maxlength="150" /> &nbsp; &nbsp; Email: <input type="text" name="email_5" size="30" maxlength="150" />
                    	<br /><br />
                    Name: <input type="text" name="name_6" size="30" maxlength="150" /> &nbsp; &nbsp; Email: <input type="text" name="email_6" size="30" maxlength="150" />
                    	<br /><br />
                    Name: <input type="text" name="name_7" size="30" maxlength="150" /> &nbsp; &nbsp; Email: <input type="text" name="email_7" size="30" maxlength="150" />
                    	<br /><br />
                    Name: <input type="text" name="name_8" size="30" maxlength="150" /> &nbsp; &nbsp; Email: <input type="text" name="email_8" size="30" maxlength="150" />
                    	<br /><br />
                    Name: <input type="text" name="name_9" size="30" maxlength="150" /> &nbsp; &nbsp; Email: <input type="text" name="email_9" size="30" maxlength="150" />
                    	<br /><br />
                    Name: <input type="text" name="name_10" size="30" maxlength="150" /> &nbsp; &nbsp; Email: <input type="text" name="email_10" size="30" maxlength="150" />
				</td>
			</tr>

            <tr> 
				<td colspan="2" class="submit">
					<input type="Submit" value="  Send Invitations  ">
				</td>
			</tr>	
		</form>
        </table>
        
    </cfoutput>

 
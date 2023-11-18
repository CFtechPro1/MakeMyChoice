


<cfparam name="url.bot" default=0>
<cfparam name="url.sent" default=0>
<cfparam name="url.best_wishes" default=0>

		<cfif client.mid neq 0>
            <cfquery name="member" datasource="#application.dsn#">
                SELECT id, username, first_name, last_name, email_address 
                FROM t_members 
                	WHERE id = #client.mid#
            </cfquery>	
        </cfif>

<style type="text/css">
   .fstyle
   {
       display: none;
    }
</style> 

<cfoutput>
<script Language="JavaScript"><!--
function formValidator(theForm)
{

  if (theForm.email_address.value == "")
  										{
    alert("Please enter a value for the \" Email Address\" field.");
    theForm.email_address.focus();
    return (false);
  }

  if (theForm.m_subject.value == "")
  										{
    alert("Please enter a value for the \" Subject\" field.");
    theForm.m_subject.focus();
    return (false);
  }

  if (theForm.m_text.value == "")
  										{
    alert("Please enter a value for the \" Message Text\" field.");
    theForm.m_text.focus();
    return (false);
  }


return (true);

}
//--></script>
</cfoutput>


<cfoutput>

<form action="actions/act_Contact.cfm" name="FrontPage_Form1" onSubmit="return formValidator(this)" method="post">
		<table width="100%" border="0" cellspacing="5" cellpadding="6" class="body_text">
			<tr> 
				<td class="header" colspan="2">
					<span class="header_orange">Contact</span> Us
				</td>
			</tr>  
         <cfif url.sent eq 1>
			<tr> 
				<td class="alert_text" colspan="4">
                	<br><br>
					<span class="stars">***</span> Your Contact Message has been sent. We will respond promptly. <span class="stars">***</span>
					<br><br>
                </td>
			</tr>
		</cfif>
 		<cfif url.bot eq 1>
			<tr> 
				<td class="alert_text" colspan="4">
                <br><br>
					<span class="red_stars">***</span> You have been identified as a robot...Bad Robot! <span class="red_stars">***</span>
					<br><br>
                </td>
			</tr>
		</cfif>
 		<cfif url.best_wishes eq 1>
			<tr> 
				<td class="alert_text" colspan="4">
                	<br>
					<span class="red_stars">***</span>Thank you for trying MakeMyChoice.com your account has been cancelled.<span class="red_stars">***</span>
					<br><br>
					<span class="stars">***</span> Best wishes to you in all your endeavors. Feel free give us feedback below.<span class="stars">***</span>
					<br><br>
                </td>
			</tr>
		</cfif>
  			 <tr> 
				<td colspan="2" class="alert_text">
					Contact us below, and we will respond promptly.<br />
                    Thank you for your interest in MakeMyChoice.com	
				</td>            
			</tr>      	
            <tr>
                  <td class="form_instruct" valign="middle"> 
                        Send message to:	
                   </td>
                  <td class="form_input">
                        <strong>MakeMyChoice.com</strong>
                  </td>
          	</tr> 			
            <tr>
				<td class="form_instruct">
					Your Email Address:
				</td>
				<td class="form_input">
					<input type="text" name="email_address" size="20" maxlength="150" <cfif client.mid neq 0>value="#client.email_address#"</cfif>>
				</td>
			</tr>	
 			<tr>
				<td class="form_instruct">
					Subject:
				</td>
				<td class="form_input">
					<input type="text" name="m_subject" size="70" maxlength="150">
					<br>
					(message subject line)
				</td>
			</tr>

			<tr>
				<td class="form_instruct">
					Message Text:
				</td>
				<td class="form_input">
					<textarea name="m_text" cols="60" rows="8"></textarea>
                    <p class="fstyle"><input name="botcatcher" type="text" value=""/>  </p> 
				</td>
			</tr>           
			<tr> 
				<td colspan="2" class="submit">
					<a href="javascript:;" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('submitBtnC','','images/btn_submit_hover.gif',1)"><input type="image" src="images/btn_submit.gif" alt="Submit" name="submitBtnC" width="187" height="45" border="0" id="submitBtnC" /></a>
				</td>
			</tr>	 
		</table>
	</form>	
 </cfoutput>
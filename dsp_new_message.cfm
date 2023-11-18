<meta name="robots" content="noindex" />
<meta name="googlebot" content="index" />


<cfparam name="url.mid" default=0>
<cfparam name="url.subject" default=0>
<cfparam name="url.cid" default=0>


            <cfquery name="member" datasource="#application.dsn#">
                SELECT id, username, first_name, last_name, email_address
                FROM t_members 
                	WHERE id = #url.mid#
            </cfquery>	
		
        <cfif url.cid neq 0>
            <cfquery name="choice" datasource="#application.dsn#">
                SELECT short_desc, details, type, date_end, anon
                FROM t_choices
                WHERE id = #url.cid#
            </cfquery>				
		</cfif>
        
        
<cfoutput>
<script Language="JavaScript"><!--
function formValidator(theForm)
{

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

<form action="actions/act_Messages.cfm" name="FrontPage_Form1" onSubmit="return formValidator(this)" method="post">
		<table width="100%" border="0" cellspacing="1" cellpadding="6" class="body_text" bgcolor="577DB1">
			<tr> 
				<td class="header" colspan="2">
					New Message
				</td>
			</tr>        	
            <tr>
                  <td class="form_instruct" valign="middle"> 
                        Sending message to:	
                   </td>
                  <td class="form_input">
                  	<cfif url.cid neq 0>	
                        <cfif choice.anon eq 0><strong>#member.username#</strong><cfelse>Anonymous Member</cfif>
                    <cfelse>
                    	<strong>#member.username#</strong>
                    </cfif>
                  </td>
          	</tr>	
 			<tr>
				<td class="form_instruct">
					Subject:
				</td>
				<td class="form_input">
					<input type="text" name="m_subject" size="70" maxlength="150" <cfif url.subject neq 0>value="Re: #url.subject#"</cfif>>
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
				</td>
			</tr>           
			<tr> 
				<td colspan="2" class="submit">
					<input type="hidden" name="function" value="sendMessage">
                    <input type="hidden" name="r_mid" value="#url.mid#">
                    <input type="hidden" name="r_email" value="#member.email_address#">
					<input type="Submit" value="  Send Message  ">
				</td>
			</tr>	 
		</table>
	</form>	
 </cfoutput>
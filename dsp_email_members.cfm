


<cfparam name="url.bot" default=0>
<cfparam name="url.sent" default=0>



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

<cfform action="actions/act_EmailMembers.cfm" name="FrontPage_Form1" onSubmit="return formValidator(this)" method="post">
		<table width="100%" border="0" cellspacing="5" cellpadding="6" class="body_text">
			<tr> 
				<td class="header" colspan="2">
					<span class="header_orange">Email</span> Members
				</td>
			</tr>  
         <cfif url.sent eq 1>
			<tr> 
				<td class="alert_text" colspan="4">
                	<br><br>
					<span class="stars">***</span> Your Message has been sent to the members of MakeMyChoice.com. <span class="stars">***</span>
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
  			 <tr> 
				<td colspan="2" class="alert_text">
					Please enter the body text and subject line you would like to email to the MMC Members.
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
					<cftextarea name="m_text" cols="60" rows="8" richtext="true" toolbar="Basic"></cftextarea>
					
					
					
                    <p class="fstyle"><input name="botcatcher" type="text" value=""/>  </p> 
				</td>
			</tr>           
			<tr> 
				<td colspan="2" class="submit">
					<a href="javascript:;" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('submitBtnC','','images/btn_submit_hover.gif',1)"><input type="image" src="images/btn_submit.gif" alt="Submit" name="submitBtnC" width="187" height="45" border="0" id="submitBtnC" /></a>
				</td>
			</tr>	 
		</table>
	</cfform>	
 </cfoutput>
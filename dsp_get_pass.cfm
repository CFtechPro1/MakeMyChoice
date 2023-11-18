<meta name="robots" content="noindex" />
<meta name="googlebot" content="index" />


<script Language="JavaScript"><!--
function Valid(theForm)
{

  if (theForm.email.value == "")
  {
    alert("Please enter a value for the \" Email\" field.");
    theForm.email.focus();
    return (false);
  }

  return (true);
}
//--></script>

	
	<cfparam name="url.denied" default=0>
	<cfparam name="url.change" default=0>
	<cfparam name="url.np" default=0>
    <cfparam name="url.op" default=0>
    <cfparam name="url.resend" default=0>
    <cfparam name="url.resent" default=0>
    <cfparam name="url.updated" default=0>

	
		<table width="100%" border="0" cellspacing="1" cellpadding="5" class="dkblue12" bgcolor="577DB1">
		
	<form action="components/act_Members.cfm" method="post" onsubmit="return Valid(this)">  
			<tr> 
				<td  class="header" colspan="2">
					<span class="header_orange">Password</span> Management
				</td>
			</tr>		
	
	<cfif url.denied eq 1>
		  <tr>
			<td colspan="2" class="alert_text">
            		<br><br>
					<span class="red_stars">***</span> Your email address is not in our database. Please try again or click on the "Contact" link on the left menu.
					<br><br>			
            </td>
		 </tr>	
	</cfif>		
	<cfif url.np eq 1>
		  <tr>
			<td colspan="2" class="alert_text">
            	<br><br>
				<span class="red_stars">***</span> Your New Passwords do not match, please try again. <span class="red_stars">***</span>
                <br><br>
			</td>
		 </tr>	
	</cfif>	
	<cfif url.op eq 1>
		  <tr>
			<td colspan="2" class="alert_text">
            	<br><br>
				<span class="red_stars">***</span> Your "Old Password" entry does not match the password on file.  Please try again or click on the "Contact" link on the left menu.
                <br><br>
			</td>
		 </tr>	
	</cfif>			
	<cfif url.updated eq 1>
		  <tr>
			<td colspan="2" class="alert_text">
            	<br><br>
				<span class="stars">***</span> Your Password has been changed. <span class="stars">***</span>
                <br><br>
			</td>
		 </tr>	
	</cfif>	 
	<cfif url.resent eq 1>
		  <tr>
			<td colspan="2" class="alert_text">
            	<br><br>
				<span class="stars">***</span> Your Password has been resent to your email address. <span class="stars">***</span>
                <br><br>
                You may have to check your spam folder if the email does not arrive in the next few minutes.
                <br><br>
			</td>
		 </tr>	
	</cfif>	   
    <cfif url.resend eq 1>	
		<tr>
			<td colspan="2">&nbsp;
				
			</td>
		</tr>
		 <tr>
			<td colspan="2" class="basic_td">	
				<br>
				<li>Enter your email address below to be emailed your password.</li> 
				<br><br>
				<li>You may need to check your spam folder for the email</li>	
				<br><br>
			</td>
		 </tr>	
		<tr>
			<td class="form_instruct">
				Email Address: 
			</td>
			<td width="60%">
				<input type="text" size="30" name="email_address" value="" maxlength="150">
                
			</td>
		 </tr>		
	</cfif>
	<cfif url.change eq 1>
		 <tr>
			<td colspan="2" class="basic_td">	
				<br><br>
				<li>Enter your email address & create your new password.</li> 
				<br><br>
			</td>
		 </tr>	
		<tr>
			<td class="form_instruct">
				Email Address: 
			</td>
			<td width="60%">
				<input type="text" size="30" name="email_address" value="" maxlength="150">
                
			</td>
		 </tr>	
		<tr>
			<td class="form_instruct">
				Old Password: 
			</td>
			<td width="60%">
				<input type="text" size="30" name="old_password" value="" maxlength="20">
			</td>
		 </tr>	
		<tr>
			<td class="form_instruct">
				New Password: 
			</td>
			<td width="60%">
				<input type="text" size="30" name="new_password" value="" maxlength="20">
			</td>
		 </tr>	
		<tr>
			<td class="form_instruct">
				Repeat New Password: 
			</td>
			<td width="60%">
				<input type="text" size="30" name="new_password2" value="" maxlength="20">
			</td>
		 </tr>	
	</cfif>	 
		 <tr>
			<td colspan="2" class="submit">
			<cfif url.change eq 1>
				<input type="hidden" name="function" value="changePassword">
				<input type="Submit" value=" Change My Password  ">
			<cfelseif url.resend eq 1>
				<input type="hidden" name="function" value="resendPassword">
				<input type="Submit" value=" Resend My Password  ">
			</cfif>
				
			</td>
		 </tr>			 
	 </form>
	  
	</table>
  <br><br>

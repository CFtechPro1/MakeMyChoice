<script Language="JavaScript"><!--
function Valid(theForm)
{

  if (theForm.username.value == "")
  {
    alert("Please enter a value for the \" Username\" field.");
    theForm.email.focus();
    return (false);
  }

  if (theForm.password.value == "")
  {
    alert("Please enter a value for the \" Password\" field.");
    theForm.password.focus();
    return (false);
  }

  return (true);
}
//--></script>

	
	<cfparam name="url.denied" default=0>
	<cfparam name="url.mid" default=0>
    <cfparam name="url.cid" default=0>
	<cfparam name="url.status" default=0>
    <cfparam name="url.p" default=0>
	<cfparam name="url.gid" default=0>
	
	<cfif url.mid neq 0>
		<cfquery name="get_pass" datasource="#application.dsn#">
			SELECT id, email_address, password
			FROM t_members
			WHERE id = #url.mid#
		</cfquery>	
	</cfif>
	<script type="text/javascript">
			function MM_swapImgRestore() { //v3.0
			  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
			}
			function MM_preloadImages() { //v3.0
			  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
				var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
				if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
			}
			
			function MM_findObj(n, d) { //v4.01
			  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
				d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
			  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
			  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
			  if(!x && d.getElementById) x=d.getElementById(n); return x;
			}
			
			function MM_swapImage() { //v3.0
			  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
			   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
			}
	</script>
<body onLoad="MM_preloadImages('images/btn_login2_hover.gif')">
	

	
		<table width="100%" border="0" cellspacing="5" cellpadding="5" class="body_text">
		
	<form action="components/act_Members.cfm" method="post" onSubmit="return Valid(this)">  
	
	
	<cfif url.denied eq 1>
		  <tr>
			<td colspan="2" class="alert_text">
				<span class="red_stars">***</span>Your login attempt failed. Please try again, or click on the <a href="index.cfm?fa=contact" class="bodylink">Contact</a> link.<span class="red_stars">***</span>
					<br><br>
				To gain free access to MakeMyChoice.com and to become a member, <a href="index.cfm?fa=legal" class="bodylink">Sign up here</a> and you will create a username and password.	
			</td>
		 </tr>	
	</cfif>			
	<cfif url.status neq 0>
		  <tr>
			<td colspan="2" class="alert_text">
			<br>
				Your password has been changed.
				<br><br>
				Please login below.
					<br>
			</td>
		 </tr>	
	</cfif>		
	<cfif url.p eq 1>
        <tr> 
            <td class="alert_text" colspan="2">
            <br><br>
                <span class="red_stars">***</span> You must <strong>Login first</strong> before changing your <strong>Profile settings</strong>  <span class="red_stars">***</span>
                <br><br>
                <span class="stars">***</span> <strong>Please login below.  Then click on the "My Profile" link on the left menu.</strong><span class="stars">***</span>
                <br><br>
            </td>
        </tr>
    </cfif>
			<tr> 
				<td class="header" colspan="2">
					<span class="header_orange">Login</span> To MakeMyChoice.com
				</td>
			</tr>
	
		 <tr>
			<td class="alert_text" colspan="2">	
				<br>
				Login below to access MakeMyChoice.com
				<br><br>
				If you forgot your password:
				<a href="index.cfm?fa=get_pass&resend=1" class="bodylink">Get my password</a> | OR | <a href="index.cfm?fa=get_pass&change=1" class="bodylink">Change My Password</a>
				
				
				<br><br>		
				If you do not have a username and password, <a href="index.cfm?fa=sign_up" class="bodylink">Sign Up for free</a>.	
				<br><br>
			</td>
		 </tr>	
		<tr>
			<td class="form_instruct">
            	
				<strong>Username:</strong>
			</td>
			<td class="form_input">
				
				<input type="text" size="30" name="username" value="" maxlength="150">
			</td>
		 </tr>		
		<tr>
			<td class="form_instruct">
				<strong>Password:</strong>
			</td>
			<td class="form_input">
				<input type="password" size="15" name="password" value="" maxlength="20">
			</td>
		 </tr>		 
		 <tr>
			<td colspan="2" class="submit">
            	<cfoutput>
                	<input type="hidden" name="mid" value="#url.mid#">
                    <input type="hidden" name="cid" value="#url.cid#">
					<input type="hidden" name="gid" value="#url.gid#">
                </cfoutput>
				<input type="hidden" name="function" value="login">
			 
		 	 <a href="javascript:;" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('loginBtn','','images/btn_login2_hover.gif',1)"><input type="image" src="images/btn_login2.gif" alt="Login" name="loginBtn" id="loginBtn" width="187" height="45" border="0"></a></td>
		 </tr>			 
	 </form>
	  <tr>
      	<td colspan="2">
			<!--- <cfinclude template="login_facebook.cfm"> --->
        </td>
      </tr>
      
	</table>
  <br><br>

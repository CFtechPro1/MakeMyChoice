<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Wecome to www.MakeMyChoice.com</title>
</head>




<cfparam name="url.mid" default=0>
<cfparam name="urlPath" default="http://www.makemychoice.com">

<cfoutput>
	<link href="#urlPath#/css/site_layout.css" rel="stylesheet" type="text/css">
</cfoutput>

<style>
.bodylink {
	FONT-SIZE: 14px; COLOR: #498db1; FONT-FAMILY: Arial, Helvetica, sans-serif; TEXT-DECORATION: underline
}
A.bodylink:hover {
	FONT-SIZE: 14px; COLOR: #fcb026; FONT-FAMILY: Arial, Helvetica, sans-serif; TEXT-DECORATION: underline
}
.site_text_email {
	FONT-SIZE: 14px; COLOR: #5b5c5e; FONT-FAMILY: Helvetica, Arial, sans-serif; TEXT-DECORATION: none;
	text-align:left;
	padding:10px;
}

.header_email {
	FONT-SIZE: 14pt; 
	COLOR: #818285; 
	FONT-FAMILY: Helvetica, Arial, sans-serif; 
	background-color:#FFFFFF; 
	text-align:left; 
	padding-top:10px;
	padding-bottom:10px;
	padding-left:10px;
	border-top: solid 1px #e1e2e2;
	border-bottom: solid 1px #e1e2e2;  
}

.header_email_orange {
	FONT-SIZE: 14pt; 
	COLOR: #fcb026; 
	FONT-FAMILY: Helvetica, Arial, sans-serif; 
}

.header_email_top {
	FONT-SIZE: 14pt; 
	font-weight:bold;
	COLOR: #818285; 
	FONT-FAMILY: Helvetica, Arial, sans-serif; 
	background-color:#FFFFFF; 
	text-align:left; 
	padding-top:10px;
	padding-bottom:10px;
	padding-left:10px;
}

.header_email_top_orange {
	FONT-SIZE: 14pt; 
	font-weight:bold;
	COLOR: #fcb026; 
	FONT-FAMILY: Helvetica, Arial, sans-serif; 
}

.email_welcome {
	background: url(http://www.makemychoice.com/images/bg_email_welcome.gif) repeat-x;
	height: 204px;
}	

.email_great {
	FONT-SIZE: 16px; COLOR: #858889; FONT-FAMILY: Helvetica, Arial, sans-serif; TEXT-DECORATION: none; font-weight:bold;
}
.email_great_orange {
	FONT-SIZE: 16px; COLOR: #fcb026; FONT-FAMILY: Helvetica, Arial, sans-serif; TEXT-DECORATION: none; font-weight:bold;
}
</style>

<cfquery datasource="#application.dsn#" name="m">
	SELECT id, first_name, last_name, username, password 
	FROM t_members
	WHERE id = #url.mid#
</cfquery>

<body leftmargin=0 topmargin=0 rightmargin=0 bottommargin=0 marginwidth=0 marginheight=0>
<table style="width:100%;" margintop="0" marginLeft="0" width="100%" cellpadding="0" cellspacing="0" border="0">
	<cfoutput>
	<tr>
		<td align="center" valign="top" class="email_welcome">
			<table style="width:733px;" cellpadding="0" cellspacing="0" border="0" class="email_welcome">
				<tr>
					<td class="email_welcome" valign="top">
						<a href="#urlPath#"><img src="#urlPath#/images/email_logo_welcome.gif" border="0" /></a>
						<table cellpadding="0" cellspacing="0" width="100%">
							<tr>
								<td class="header_email_top" valign="top">
									Welcome #m.first_name# #m.last_name# to <br />
									<span class="header_email_top_orange">MakeMyChoice.com</span>
								</td>					
							</tr>
						</table>
					</td>
					<td class="email_welcome" valign="top">
						<a href="#urlPath#/index.cfm?fa=login"><img src="#urlPath#/images/email_fish_welcome.gif" border="0" /></a>
					</td>
				</tr>
				<tr>
					<td colspan="2" class="site_text_email">
						Now you can get the feedback you need, and help others, to make the best choices and decisions possible. 
						<br /><br />
						Try creating a group for any organization, business, friends or family, and make great choices together!
						<br /><br />
						Your <a href="#urlPath#/index.cfm?fa=login" target="_new" class="bodylink">MakeMyChoice.com</a> Member login info is:
					</td>
				</tr>			
				<tr>
					<td class="header_email">
						<span class="header_email_orange">
							Username:
						</span>
						#m.username#
						<br />
						<span class="header_email_orange">
							Password:
						</span>
						#m.password#
						<br />						
					</td>
					<td	class="site_text_email">&nbsp;
						
					</td>
				</tr>
				<tr>
					<td colspan="2" class="site_text_email">
						<table>
							<tr>	
								<td align="left">
									<a href="#urlPath#/index.cfm?fa=login"><img src="#urlPath#/images/email_login.gif" border="0" /></a>
								</td>
								<td valign="middle" align="left" class="site_text_email">
									<span class="email_great">& MAKE</span> <span class="email_great_orange">GREAT</span> <span class="email_great">CHOICES!</span>
									<br />
									Ask anything, Get answers... Get & give feedback.
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="2" class="site_text_email">
						Best Regards,
						<br /><br />
						The MakeMyChoice.com Team
						<br />
					</td>
				</tr>
				<tr>
					<td colspan="2" class="site_text_email">
						<a href="http://www.facebook.com/sharer.php?u=http://www.makemychoice.com&t=MakeMyChoice.com"><img src="#urlPath#/images/email_facebook.gif" border="0"/></a>
						&nbsp;
						<a href="http://twitter.com/share/?url=http://www.makemychoice.com"><img src="#urlPath#/images/email_twitter.gif" border="0"/></a>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	</cfoutput>
</table>


</body>
</html>

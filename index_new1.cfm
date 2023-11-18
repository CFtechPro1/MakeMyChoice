<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
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
</head>

<link href="css/site_layout.css" rel="stylesheet" type="text/css">

		<!--- Get the top ten most recent choices from the public. --->
		<cfquery name="recent_everyone" datasource="#application.dsn#" maxrows="11">
			SELECT c.id, c.mid, c.username, c.short_desc, c.date_created, c.anon, r.request_type
			FROM t_choices c INNER JOIN
            	t_requests r ON c.id = r.cid
                	WHERE r.request_type = 'everyone'
                            AND c.date_end > GETDATE()
			ORDER BY c.id DESC
		</cfquery>	

<body leftmargin=0 topmargin=0 rightmargin=0 bottommargin=0 marginwidth=0 marginheight=0 onload="MM_preloadImages('images/btn_signup_hover.gif','images/btn_login_hover.gif','images/btn_create_new_hover.gif','images/btn_give_feedback_hover.gif','images/btn_search_choices_hover.gif','images/btn_more_choices_hover.gif')">

<table style="width:100%;" margintop="0" marginLeft="0" width="100%" cellpadding="0" cellspacing="0" border="0">
	<cfoutput>
	<tr>
		<td align="center" valign="top" class="eyebrow">
			<table style="width:980px;" cellpadding="0" cellspacing="0">
				<tr>
					<td class="eyebrow">
						<img src="images/make_great_choices.gif" />
					</td>
					<td style="width:142px" width="142" class="eyebrow">&nbsp;
						
					</td>
					<td class="eyebrow">
						<a href="http://www.facebook.com/sharer.php?u=http://www.makemychoice.com#cgi.script_name#?#cgi.query_string#&t=http://www.MakeMyChoice.com"><img src="images/facebook.gif" border="0"/></a>
					</td>
					<td class="eyebrow">
						<a href="http://twitter.com/share"><img src="images/twitter.gif" border="0"/></a>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	</cfoutput>
	<tr>
		<td align="center" valign="top" bgcolor="FFFFFF">
			<table style="width:980px;" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td bgcolor="FFFFFF">
						<a href="index.cfm"><img src="images/makemychoice.com_logo.gif" border="0" /></a>
					</td>
					<td bgcolor="FFFFFF" valign="top">
						<table style="width:430px" width="430" border="0">
							<tr>
								<td style="height:34px;">
									<p class="med-spacer">&nbsp;</p>
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<a href="index.cfm?fa=new_group" alt="MakeMyChoice.com Groups">
										<img src="images/news_temp.gif" border="0" />	
									</a>
								</td>
							</tr>
							<tr>
								<td style="width:35px" width="35">
									<img src="images/spr_after_logo.gif" />	
								</td>
								<td>
									<a href="index.cfm?fa=legal" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('signUp','','images/btn_signup_hover.gif',1)"><img src="images/btn_signup.gif" alt="Sign Up" name="signUp" width="183" height="50" border="0" id="signUp" /></a>
								</td>
								<td style="width:35px" width="35">
									<img src="images/spr_login.gif" />	
								</td>
								<td>
									<a href="index.cfm?fa=login" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Login','','images/btn_login_hover.gif',1)"><img src="images/btn_login.gif" alt="Login" name="Login" width="183" height="49" border="0" id="Login" /></a>
								</td>								
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="center" valign="top" class="aquarium">
			<table style="width:980px;" cellpadding="0" cellspacing="0">
				<tr>
					<td class="aquarium">
						<a href="index.cfm?fa=new_choice" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('createNew','','images/btn_create_new_hover.gif',1)"><img src="images/btn_create_new.gif" alt="Create New Choice" name="createNew" width="351" height="238" border="0" id="createNew" /></a>
					</td>
					<td class="aquarium">
						<a href="index.cfm?fa=my_feedback" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('giveFeedback','','images/btn_give_feedback_hover.gif',1)"><img src="images/btn_give_feedback.gif" alt="Give Feedback" name="giveFeedback" width="279" height="238" border="0" id="giveFeedback" /></a>
					</td>
					<td class="aquarium">
						<a href="index.cfm?fa=search_cats" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('searchChoices','','images/btn_search_choices_hover.gif',1)"><img src="images/btn_search_choices.gif" alt="Search Choices" name="searchChoices" width="285" height="238" border="0" id="searchChoices" /></a>
					</td>
					<td class="aquarium">&nbsp;
							
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="center" valign="top" bgcolor="FFFFFF">
			<table style="width:980px;" cellpadding="0" class="site_text" cellspacing="0" border="0">
				<tr>
					<td valign="top" bgcolor="FFFFFF">
						<!--- <img src="images/spr_after_menu.gif" /> --->
						&nbsp;
					</td>
					<td valign="top" bgcolor="FFFFFF">
						<table border="0">
							<tr>
								<td>
									<p class="med-spacer">&nbsp;</p>
								</td>
							</tr>
							<tr>
								<td align="left">
									<a href="index.cfm?fa=about" class="leftmenu_link">ABOUT</a>
								</td>
							</tr>
							<tr>
								<td>
									<p class="small-spacer">&nbsp;</p>
								</td>
							</tr>
							<tr>
								<td align="left">
									<a href="index.cfm?fa=instructions" class="leftmenu_link">INSTRUCTIONS</a>
								</td>
							</tr>
							<tr>
								<td>
									<p class="small-spacer">&nbsp;</p>
								</td>
							</tr>
							<tr>
								<td align="left">
									<a href="index.cfm?fa=contact" class="leftmenu_link">CONTACT</a>
								</td>
							</tr>
							<tr>
								<td>
									<p class="small-spacer">&nbsp;</p>
								</td>
							</tr>
							<tr>
								<td align="left">
									<a href="index.cfm?fa=login" class="leftmenu_link">LOGIN</a>
								</td>
							</tr>
							<tr>
								<td>
									<p class="small-spacer">&nbsp;</p>
								</td>
							</tr>
							<tr>
								<td align="left">
									<a href="index.cfm?fa=legal" class="leftmenu_link">SIGN UP</a>
								</td>
							</tr>
							<tr>
								<td>
									<p class="small-spacer">&nbsp;</p>
								</td>
							</tr>
							<tr>
								<td>
									<p class="med-spacer">&nbsp;</p>
								</td>
							</tr>
						</table>
									<a href="http://947thewave.radio.com/2010/12/08/pat-kims-website-of-the-week-make-my-choice" class="bodylink" target="_new">
										<img src="images/press_theWave.gif" border="0" />
									</a> 
					</td>
					<td valign="top" bgcolor="FFFFFF">
						 <img src="images/spr_after_menu2.gif" /> 
						
					</td>
					<td valign="top" bgcolor="FFFFFF">
						<img src="images/hdr_answer_questions.gif" /><br />
						<table style="width:100%;" cellpadding="0" cellspacing="0" class="home_text" border="0">
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
								<td class="#rowClass#" align="left">
									<a href="index.cfm?fa=choice_feedback&cid=#recent_everyone.id#&mid=#recent_everyone.mid#" class="choice_link">#left(recent_everyone.short_desc,80)#<cfif len(recent_everyone.short_desc) gt 80>....</cfif></a>
									<br />
									Created By
									<cfif recent_everyone.anon eq 0>
										<a href="index.cfm?fa=profile&mid=#recent_everyone.mid#" class="member_link">#recent_everyone.username#</a>  
									<cfelse>
										<span class="member_text">Anonymous Member</span>
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

</body>
</html>

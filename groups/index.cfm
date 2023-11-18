<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<html>




<cfparam name="client.gid" default=0>
<cfparam name="url.gid" default=0>
<cfparam name="fa" default="home">
<cfparam name="url.imid" default=0>

	<cfif url.imid neq 0>
		<!--- Log in users automatically if are already members, and request comes from an email sent to them. --->
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

<cfif url.gid neq 0>
	<cfset client.gid = url.gid>
</cfif>
<cfif client.mid eq 0>
	<cfoutput>
		<cflocation url="../index.cfm?fa=nolog&gid=#client.gid#&nolog=1" addtoken="no">
    </cfoutput>
</cfif>
            <cfquery name="g" datasource="#application.dsn#">
                SELECT id, mid, group_name, group_desc, private, group_pic
                FROM t_groups 
                	WHERE id = #client.gid#
            </cfquery>
			
            <cfquery name="gm" datasource="#application.dsn#">
                SELECT id, mid, gid, ab_mid
                FROM t_group_members 
                	WHERE mid = #client.mid#
                    	AND gid = #client.gid#
            </cfquery>			
<cfif gm.recordcount eq 0>
	<cfoutput>
		<cflocation url="../index.cfm?fa=my_groups&gid=#client.gid#&nog=1" addtoken="no">
    </cfoutput>
</cfif>			


			
					<!--- Get the top ten most recent active choices for this group. --->
		<cfquery name="recent_group" datasource="#application.dsn#">
			SELECT c.id, c.mid, c.username, c.short_desc, c.date_created, c.anon, r.gid, r.request_type
			FROM t_choices c INNER JOIN
            	t_requests r ON c.id = r.cid
                	WHERE r.request_type = 'group'
					AND r.gid = #client.gid#
                            AND c.date_end > GETDATE()
			ORDER BY c.id DESC
		</cfquery>	

<head>
<title>MakeMyChoice.com - Make Better Group Choices & Decisions! Ask Questions Get Answers</title>
<META NAME="DESCRIPTION" CONTENT="Make Great Choices with MakeMyChoice.com, create surveys instantly, ask questions, get answers, question and answer, help making choices, make great choices, making choices, decision making, help making choices, decision maker">
<META NAME="KEYWORDS" CONTENT="Make My choice, ask, ask questions, answers, making great choices, make choices, making choices, decision making, help making choices, decision maker">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../css/site_layout.css" rel="stylesheet" type="text/css">
<link rel="shortcut icon" type="image/x-icon" href="../images/faviconCAB010KZ.ico">
<meta property="og:title" content="MakeMyChoice.com - Make Great Choices!" /> 
<meta property="og:description" content="Create surveys, Get feedback on all the choices and decisions you need to make." /> 
<meta property="og:image" content="http://www.makemychoice.com/images/MakeMyChoice_Logo_sm.jpg" />

			<!--- Import jQuery library & plugins --->
			<script src="../js/jquery-latest.js" type="text/javascript"></script>
			<script src="../js/jquery.tablesorter.min.js" type="text/javascript"></script>
            <script src="../js/ui.datepicker.js" type="text/javascript"></script>
            <script src="../js/jquery.validate.js" type="text/javascript"></script>
            <script src="../js/jquery.jqModal.min.js" type="text/javascript"></script>



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

<link rel="stylesheet" type="text/css" href="../css/anylinkcssmenu.css" />

<script type="text/javascript" src="../js/anylinkcssmenu.js">

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



<link href="../css/site_layout.css" rel="stylesheet" type="text/css">
<link href="../css/calendar.css" rel="stylesheet" type="text/css">



<body leftmargin=0 topmargin=0 rightmargin=0 bottommargin=0 marginwidth=0 marginheight=0 onload="MM_preloadImages('../images/btn_signup_hover.gif','../images/btn_login_hover.gif','../images/btn_create_new_hover.gif','../images/btn_give_feedback_hover.gif','../images/btn_search_choices_hover.gif','../images/btn_more_choices_hover.gif','../images/btn_logout_m_hover.gif','../images/btn_create_new_m_hover.gif','../images/btn_give_feedback_hover_m.gif','../images/btn_search_choices_m_hover.gif','../images/btn_my_choices_hover.gif','../images/btn_my_feedback_hover.gif','../images/btn_my_messages_hover.gif','../images/btn_my_profile_hover.gif','../images/btn_links_resources_hover.gif','../images/btn_downloads_hover.gif','../images/btn_group_choices_hover.gif','../images/btn_suggestions_hover.gif','../images/btn_my_groups_g_hover.gif','../images/btn_chat_hover.gif')">

<table style="width:100%;" margintop="0" marginLeft="0" width="100%" cellpadding="0" cellspacing="0" border="0">
	<cfoutput>
	<tr>
		<td align="center" valign="top" class="eyebrow_g">
			<table style="width:980px;" cellpadding="0" cellspacing="0" border="0" class="eyebrow_g">
				<tr>
					<td class="eyebrow_g">
						<img src="../images/make_group_choices.gif" />
					</td>
					<td style="width:137px" width="137" class="eyebrow_g">&nbsp;
						
					</td>
					<td class="eyebrow_g">
						<a href="http://www.facebook.com/sharer.php?u=#cgi.script_name#?#cgi.query_string#&t=MakeMyChoice.com"><img src="../images/facebook_g.gif" border="0"/></a>
					</td>
					<td class="eyebrow_g">
						<a href="http://twitter.com/share"><img src="../images/twitter_g.gif" border="0"/></a>
					</td>
				</tr>
			</table>
		</td>
	</tr>

	<tr>
		<td align="center" valign="top"  class="aquarium_g" >
			<table style="width:980px;" cellpadding="0" cellspacing="0" border="0" class="site_text">
				<tr>
					<td class="group_logo" width="204">
                    	
							<cfif g.group_pic eq "">
								<div style="padding:30px;">
						 			Organization logo or picture goes here.
										<cfif client.mid eq g.mid>
											<br /><br />
											<a href="index.cfm?fa=group_profile_edit##groupPic" class="bodylink">add picture</a>
										</cfif>
								</div>
							<cfelse>
								<div>
									<a href="index.cfm?fa=home"><img src="#application.urlpath#media/#g.mid#/#client.gid#/#g.group_pic#" height="150" width="150" alt="#g.group_name#" border="0" /></a>
								</div>
							</cfif>
                        </div>
					</td>
					<td class="group_desc">
                    <div style="padding:25px;">
						<table width="100%">
							<tr>
								<td align="left" style="padding-bottom:10px;padding-top:5px;">
									<span class="site_hdr">GROUP:</span> &nbsp; <span class="grp_name">#g.group_name#</span>
								</td>
							</tr>
							<tr>
								<td class="group_desc_text">
										<cfif g.group_desc neq "">
											#g.group_desc#
										<cfelse> 
											<br /><br />
											Help make better choices and decisions for <strong>#g.group_name#</strong> below.
											<br /><br />
											<a href="index.cfm?fa=group_profile_edit##groupDesc" class="bodylink">add group description</a>
										</cfif>
								</td>	
							</tr>
							<tr>				
								<td class="group_url">
									homepage: <a href="#application.urlpath#groups/?gid=#client.gid#" class="bodylink">#application.urlpath#groups/?gid=#client.gid#</a>
								</td>
							</tr>
						</table>
                    </div>

					</td><td class="group_mmc_logo"><a href="../index.cfm?fa=home" alt="MakeMyChoice.com"><img src="../images/mmc_logo_group.gif" border="0" vspace="0" align="top" /></a></td>
				</tr>
			</table>
		</td>
	</tr>
	</cfoutput>
	<tr>
		<td align="center" valign="top" bgcolor="FFFFFF">
			<table style="width:980px;" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td valign="top" bgcolor="FFFFFF" style="width:15px;">&nbsp;
						
					</td>
					<td valign="top" bgcolor="FFFFFF" style="width:220px;">
                    <br />
						<cfif client.mid neq 0>
						<table border="0">
							<tr>
								<td align="left">
									<a href="index.cfm?fa=group_choices&amp;type=r" class="anchorclass someotherclass" rel="submenu2" rev="lr" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('groupChoices','','../images/btn_group_choices_hover.gif',1)"><img src="../images/btn_group_choices.gif" alt="Group Choices" name="groupChoices" width="189" height="47" border="0" id="groupChoices" /></a> 
									<div id="submenu2" class="anylinkcss" style="width: 150px; background-color:#E9FECB">
										<ul>
											<li><a href="index.cfm?fa=group_choices&type=r">Recent Choices</a></li>
											<cfoutput>
											<li><a href="../index.cfm?fa=new_choice&gid=#client.gid#">New Choice or Decision</a></li>
											</cfoutput>
											<li><a href="index.cfm?fa=search_choices">Search Choices</a></li>											
											<li><a href="index.cfm?fa=group_choices&type=e">Date Expired Choices</a></li>	
											<li><a href="index.cfm">Group Homepage</a></li>
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
									<a href="index.cfm?fa=links" class="anchorclass someotherclass" rel="submenu2" rev="lr" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image21','','../images/btn_group_links_hover.gif',1)"><img src="../images/btn_group_links.gif" alt="Downloads" name="Image21" width="189" height="46" border="0" id="Image21" /></a> 
									<div id="submenu2" class="anylinkcss" style="width: 150px; background-color:#E9FECB">
										<ul>
											<li><a href="index.cfm?fa=links">View Links</a></li>
											<li><a href="index.cfm?fa=new_link">Add New Link</a></li>
			  						  </ul>
								  </div>
							  </td>
							</tr>								
							<tr>
								<td>
									<p class="small-spacer">&nbsp;</p>
								</td>
							</tr>	
<!--- 							<tr>
								<td align="left">
									<a href="index.cfm?fa=downloads" class="anchorclass someotherclass" rel="submenu2" rev="lr" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('downloads','','../images/btn_downloads_hover.gif',1)"><img src="../images/btn_downloads.gif" alt="Downloads" name="downloads" width="189" height="47" border="0" id="downloads" /></a>
									<div id="submenu2" class="anylinkcss" style="width: 150px; background-color:#E9FECB">
										<ul>
											<li><a href="index.cfm?fa=downloads">View Downloads</a></li>
											<li><a href="index.cfm?fa=new_download">Upload New Item</a></li>
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
									<a href="index.cfm?fa=suggestions" class="anchorclass someotherclass" rel="submenu2" rev="lr" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('suggestions','','../images/btn_suggestions_hover.gif',1)"><img src="../images/btn_suggestions.gif" alt="Suggestions" name="suggestions" width="189" height="46" border="0" id="suggestions" /></a>
									<div id="submenu2" class="anylinkcss" style="width: 150px; background-color:#E9FECB">
										<ul>
											<li><a href="index.cfm?fa=suggestions">Recent Suggestions</a></li>
											<li><a href="index.cfm?fa=new_suggestion">Make a Suggestion</a></li>
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
									<a href="index.cfm?fa=chat" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Chat','','../images/btn_chat_hover.gif',1)"><img src="../images/btn_chat.gif" alt="Chat" name="Chat" width="189" height="47" border="0" id="Chat" /></a>
								</td>	
							</tr>	
							<tr>
								<td>
									<p class="small-spacer">&nbsp;</p>
								</td>
							</tr>	--->					
							<tr>
								<td align="left">
									<a href="../index.cfm?fa=my_groups" class="anchorclass someotherclass" rel="submenu2" rev="lr" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('myGroups','','../images/btn_my_groups_g_hover.gif',1)"><img src="../images/btn_my_groups_g.gif" alt="My Groups" name="myGroups" width="189" height="47" border="0" id="myGroups" /></a>
									<div id="submenu2" class="anylinkcss" style="width: 150px; background-color:#E9FECB">
										<ul>
											<li><a href="../index.cfm?fa=new_group">Create New Group</a></li>
											<li><a href="../index.cfm?fa=my_groups">My Groups</a></li>
											<li><a href="../index.cfm?fa=my_groups_invited">Group Memberships</a></li>
											<li><a href="../index.cfm?fa=search_groups">Search Groups</a></li>
										</ul>
									</div>
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
								  <a href="index.cfm?fa=group_profile" class="leftmenu_link">GROUP PROFILE</a>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<p class="small-spacer">&nbsp;</p>
								</td>
							</tr>
						<cfif client.mid eq g.mid>
							<tr>
								<td style="width:25px;">&nbsp;
									
								</td>
								<td align="left">
								  <a href="index.cfm?fa=group_profile_edit" class="leftmenu_link">EDIT PROFILE</a>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<p class="small-spacer">&nbsp;</p>
								</td>
							</tr>
						</cfif>
							<tr>
								<td style="width:25px;">&nbsp;
									
								</td>
								<td align="left">
								  <a href="index.cfm?fa=group_members" class="leftmenu_link">GROUP MEMBERS</a>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<p class="small-spacer">&nbsp;</p>
								</td>
							</tr>
						<cfif client.mid eq g.mid>
							<tr>
								<td style="width:25px;">&nbsp;
									
								</td>
								<td align="left">
									<cfoutput>
									  <a href="../index.cfm?fa=group_members_add&gid=#g.id#" class="leftmenu_link">EDIT MEMBERS</a>
									</cfoutput>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<p class="small-spacer">&nbsp;</p>
								</td>
							</tr>
						</cfif>
							<tr>
								<td>&nbsp;
									
								</td>
								<td align="left">
									<a href="../index.cfm?fa=instructions" class="leftmenu_link">INSTRUCTIONS</a>
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
									<a href="../index.cfm" class="leftmenu_link">HOME</a>
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
                    
                    <br />
                    
					<cfswitch expression="#fa#">
						 <cfcase value="home">
							<table style="width:100%;" cellpadding="0" cellspacing="0" class="bodytext_new" border="0">
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
							<cfif recent_group.recordcount neq 0> 
								 <cfoutput query="recent_group" maxrows="11">
									<cfif currentRow MOD 2>  
										<cfset rowClass = "blue_row" />  
									<cfelse>  
										<cfset rowClass = "white_row" />  
									</cfif> 
								 <tr>
									<td class="#rowClass#" align="left" style="padding-bottom:5px;">
										<a href="../index.cfm?fa=choice_feedback&amp;cid=#recent_group.id#&amp;mid=#recent_group.mid#&gid=#client.gid#" class="choice_link_m">#left(recent_group.short_desc,72)#<cfif len(recent_group.short_desc) gt 72>....</cfif></a>
										<br />
										Created By
										<cfif recent_group.anon eq 0>
											<a href="../index.cfm?fa=profile&amp;mid=#recent_group.mid#" class="orange_link">#recent_group.username#</a>  
										<cfelse>
											<span class="member_text">Anonymous Member</span>
										</cfif> 
										&nbsp; Date Created: #DateFormat(recent_group.date_created, "mm/dd/yyyy")#           
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
										<cfif recent_group.recordcount gt 11>
											<a href="index.cfm?fa=group_choices" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('moreChoices','','../images/btn_more_choices_hover.gif',1)"><img src="../images/btn_more_choices.gif" name="moreChoices" width="160" height="39" border="0" id="moreChoices" /></a>
										</cfif>
									</td>
								</tr>	
							<cfelse>
								<tr>
									<td align="left">
									<cfoutput>
										<p class="small-spacer">&nbsp;</p>
										There have not been and choices or decisions created for this group yet.
										<br /><br />
										Be the first member of <strong>#g.group_name#</strong> to <a href="../index.cfm?fa=new_choice&gc=1" class="bodylink">create a new choice or decision</a> 
									</cfoutput>
									</td>
								</tr>	
							</cfif>														
							</table>
						 </cfcase>	
						 <cfcase value="more_choices">
							<cfinclude template="dsp_more_choices.cfm">
						 </cfcase>
						 <cfcase value="group_choices">
							<cfinclude template="dsp_group_choices.cfm">
						 </cfcase> 	
						 <cfcase value="search_choices">
							<cfinclude template="dsp_search_choices.cfm">
						 </cfcase> 	 
						 <cfcase value="view_choice">
							<cfinclude template="dsp_view_choice_g.cfm">
						 </cfcase>
						 <cfcase value="group_members">
							<cfinclude template="dsp_group_members.cfm">
						 </cfcase> 	
						 <cfcase value="links">
							<cfinclude template="dsp_links.cfm">
						 </cfcase> 
						 <cfcase value="new_link">
							<cfinclude template="dsp_new_link.cfm">
						 </cfcase>
						 <cfcase value="downloads">
							<cfinclude template="dsp_downloads.cfm">
						 </cfcase>
						 <cfcase value="new_download">
							<cfinclude template="dsp_new_download.cfm">
						 </cfcase>
						 <cfcase value="group_profile">
							<cfinclude template="dsp_group_profile.cfm">
						 </cfcase>
						 <cfcase value="group_profile_edit">
							<cfinclude template="dsp_group_profile_edit.cfm">
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
						<img src="../images/footer_logo.gif" /> &nbsp;
					</td>
					<td>
						<cfoutput>
							MakeMyChoice.com &copy; #DateFormat(Now(),"mm/dd/yyyy")#. Proprietary patent pending technology.
						</cfoutput>
					</td>
					<td>
						&nbsp; &nbsp;
						<a href="../index.cfm?fa=about" class="footer_link">About MakeMyChoice.com &trade;</a> | <a href="../index.cfm?fa=legal" class="footer_link">Terms & Conditions</a>
					</td>
				</tr>
			</table>	
		</td>
	</tr>						
</table>

</body>
</html>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>MakeMyChoice.com - Make Great Choices! Ask Questions Get Answers</title>
<META NAME="DESCRIPTION" CONTENT="Make My choice, ask, ask questions, answers, ask the jeeves, question and answerhelp making choices, make great choices, making choices, decision making, help making choices, decision maker">
<META NAME="KEYWORDS" CONTENT="Make My choice, ask, ask questions, answers, ask the jeeves, making great choices, make choices, making choices, decision making, help making choices, decision maker">
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

</head>

<cfparam name="fa" default="home">
<cfset variables.urlString = replace((cgi.script_name & '?' & cgi.query_string),"&","&amp;")>

<body leftmargin="0" topmargin="0" bgcolor="FFFFFF">

<table border="0" bgcolor="FFFFFF" width="100%" height="100%" cellpadding="0" cellspacing="0"><tr><td align="center">		
<table border="0" cellspacing="0" cellpadding="0" width="800" height="100%" bgcolor="FFFFFF">
  <tr>
    <td  height="66" align="right" colspan="2" nowrap="nowrap">				
		<a href="index.cfm?fa=home"><img src="images/header_main.jpg" alt="MakeMyChoice.com Make Great Choices" border="0"></a><a href="index.cfm?fa=login"><img src="images/header_login.jpg" alt="Login" border="0"></a><a href="index.cfm?fa=legal"><img src="images/header_signup.jpg" alt="Sign Up Free" border="0"></a>
	</td>
  </tr>
  <tr>
    <td  height="15" align="right" colspan="2" nowrap="nowrap">		
    	<cfoutput>	
        	<table cellpadding="0" cellspacing="0" border="0">
            	<tr>					           
                	<td style="padding-right:10px">	
						<a name="fb_share" type="button" href="http://www.facebook.com/sharer.php?u=#cgi.script_name#?#cgi.query_string#&t=MakeMyChoice.com">Share</a><script src="http://static.ak.fbcdn.net/connect.php/js/FB.Share" type="text/javascript"></script> 
                	</td>                	
                    <td <cfif client.mid eq 0>style="padding-top:6px;padding-right:75px"<cfelse>style="padding-top:6px;padding-right:28px"</cfif>>
                        <a href="http://twitter.com/share" class="twitter-share-button" data-count="none">Tweet</a><script type="text/javascript" src="http://platform.twitter.com/widgets.js"></script>
                    </td>
                </tr>
           </table>
      	</cfoutput>
	</td>
  </tr><!--- 
  <tr>
    <td width="90" valign="top">
    	
    </td>
	<td bgcolor="FFFFFF" width="670" height="20" nowrap="nowrap" align="center">	
		<cfinclude template="menu_top.cfm">
	</td> 
  </tr> --->
  <tr>
  	<td width="90" valign="top">
    	<cfinclude template="menu_left.cfm">
    </td>
    <td width="670"  valign="top" align="center">
<cfswitch expression="#fa#">
	 <cfcase value="home">
        <cfinclude template="dsp_home.cfm">
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
	 <cfcase value="search_engine">
        <cfinclude template="dsp_search_engine.cfm">
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
     <cfcase value="group_members">
        <cfinclude template="dsp_group_members.cfm">
     </cfcase>
     <cfcase value="group_members_add">
        <cfinclude template="dsp_group_members_add.cfm">
     </cfcase>
     <cfcase value="group_confirm">
        <cfinclude template="dsp_group_confirm.cfm">
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
 </cfswitch>
	</td>	
  </tr>
<tr>
	<td align="center" colspan="2" bgcolor="FFFFFF">
      	<cfif fa neq "home">
            <a href="index.cfm?fa=invite_people" class="bodylink">Invite people to join MakeMyChoice.com</a>
  		</cfif>
    <br><br>
		<a href="index.cfm?fa=about" class="toplink">About MakeMyChoice.com &trade;</a> | <a href="index.cfm?fa=legal" class="toplink">Terms & Conditions</a> | <a href="actions/act_logout.cfm" class="toplink">Logout</a> 
<br>
<span class="dkblue10">The MakeMyChoice.com application is proprietary patent pending technology.</span>
	</td>
</tr>


</table>

		</td>
                
	</tr>
</table>


</body>
</html>

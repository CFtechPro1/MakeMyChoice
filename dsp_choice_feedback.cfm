<script type="text/javascript" src="http://mediaplayer.yahoo.com/js"></script>

<cfparam name="url.cid" default=0>
<cfparam name="url.mid" default=0>
<cfparam name="url.added" default=0>
<cfparam name="url.repeat" default=0>
<cfparam name="url.loggedin" default=0>
<cfparam name="url.gid" default=0>
<cfparam name="url.imid" default=0>

<style type="text/css">
	input.radio { width: 1em; height: 1em; background-color:#ddf1fe;}
	input.submit { width: 10em; height: 3em; }
</style>

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


<cfif client.mid eq 0>
	<cfoutput>
		<cflocation url="index.cfm?fa=nolog&mid=#url.mid#&cid=#url.cid#&gid=#url.gid#&nolog=1">
    </cfoutput>
</cfif>

		<!--- If this member has already given feedback, redirect them to the results page. --->
 			<cfquery name="check" datasource="#application.dsn#">
            	SELECT id
                FROM t_feedback
                WHERE mid = #url.mid#
                		AND feedback_mid = #client.mid#
                        AND cid = #url.cid#
            </cfquery>
            
            <cfif check.recordcount neq 0>
				<cfoutput>
					<cfif url.gid eq 0>
                    	<cflocation url="index.cfm?fa=view_choice&mid=#url.mid#&cid=#url.cid#">
					<cfelse>
						<cflocation url="groups/index.cfm?fa=view_choice&mid=#url.mid#&cid=#url.cid#&gid=#url.gid#">
					</cfif>
                </cfoutput>            	
            </cfif>

<script Language="JavaScript">
<!--
function formValidator(theForm)
{

  if (theForm.answer_choice.value == "")
  										{
    alert("Please choose one answer below, then submit.");
    theForm.answer_choice.focus();
    return (false);
  }

return (true);

}
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
//-->
</script>

		<cfquery name="choice" datasource="#application.dsn#">
			SELECT short_desc, details, type, date_end, anon
            FROM t_choices
            WHERE id = #url.cid#
		</cfquery>	
		
		<cfquery name="answers" datasource="#application.dsn#">
			SELECT id, answer_text, answer_filename,  answer_caption, link_title, type, order_num  
            FROM t_answers
            WHERE cid = #url.cid#
            		AND mid = #url.mid#  
		</cfquery>	
	
		<cfquery name="member" datasource="#application.dsn#">
			SELECT id, username, first_name, last_name, email_address 
            FROM t_members
            WHERE id = #url.mid#
		</cfquery>	
        
        <cfquery name="feedback_total" datasource="#application.dsn#">
			SELECT aid 
            FROM t_feedback
            WHERE cid = #url.cid#
            	AND mid = #url.mid#
		</cfquery>	

<cfoutput><body onLoad="MM_preloadImages('images/btn_submit_hover.gif')">
		<table width="100%" border="0" cellspacing="5" cellpadding="5" class="site_text">			 
            <tr> 
				<td class="header" colspan="4">
					What is the best answer for <cfif choice.anon eq 0>#member.username#<cfelse>Anonymous Member</cfif>'s choice described below?
                    <cfif choice.date_end lt now()>
                    <br /><br />
                    <span class="stars">***</span> The date for <strong><cfif choice.anon eq 0>#member.username#<cfelse>Anonymous Member</cfif></strong>'s choice has passed. No more feedback is being accepted.
					<br />
                    <a href="index.cfm?fa=view_choice&mid=#url.mid#&cid=#url.cid#" class="bodylink">View Results Here</a>
                    
                    </cfif>
                </td>
			</tr>
        <cfif url.repeat eq 1>
			<tr> 
				<td class="alert_text" colspan="4">
               		 <br><br>
					<span class="red_stars">***</span> You have already provided feedback on this choice. <span class="red_stars">***</span>
					<br><br>
                    <li><a href="index.cfm?fa=view_choice&mid=#url.mid#&cid=#url.cid#" class="bodylink">View Results Here</a></li>
                </td>
			</tr>
		</cfif>
		<cfif url.loggedin eq 1>
			<tr> 
				<td class="alert_text" colspan="4">
					<span class="stars">***</span> Welcome #client.name#! <span class="stars">***</span>
					<br><br>
					<span class="stars">***</span>You may now provide feedback on the choice below. <span class="stars">***</span>
                    <br><br>
                </td>
			</tr>
		</cfif>
            <tr> 
				<td class="choice_instruct">
					Choice or Desicion:
				</td>
 				<td class="choice_short_desc" colspan="2">
					#choice.short_desc#
				</td>               
			</tr>
            <tr> 
				<td class="choice_instruct">
					More Info:
				</td>
 				<td class="basic_td" colspan="2">
					#choice.details#
				</td>               
			</tr>
            
        <cfif answers.recordcount neq 0>
            <tr> 
				<td class="column_header" width="100">
					Answer No.
				</td>
				<td class="column_header" width="550">
					Answer Option
				</td> 
                <td class="column_header" width="100">
					Select Answer
				</td>             
			</tr>
        </cfif>
            
<cfform action="components/act_Choices.cfm" method="post" onSubmit="return formValidator(this)">
        
	<cfif answers.recordcount neq 0>

        <cfloop query="answers">	        	
            
                <tr> 
                    <td class="choice_instruct">
                        <p class="med-spacer">&nbsp;</p>
                            Answer #answers.order_num#
                        <p class="med-spacer">&nbsp;</p>
                    </td>
					<cfif answers.type eq "text">
                    	<cfif choice.type eq "multiple">
                            <td class="choice_text" width"400"> 
                                <p class="med-spacer">&nbsp;</p>
                                    #answers.answer_text#
                                <p class="med-spacer">&nbsp;</p> 
                            </td> 
                         <cfelseif choice.type eq "yesno">
                            <td class="yesno_text" width"400"> 
                                <p class="med-spacer">&nbsp;</p>
                                    #answers.answer_text#
                                <p class="med-spacer">&nbsp;</p> 
                            </td>                          
                         </cfif>                       
					<cfelseif answers.type eq "image">
                    	<td width"400" class="image_td"> 
							<img src="#application.urlpath#media/#member.id#/#answers.answer_filename#" />  
                        </td>   
                    <cfelseif answers.type eq "mp3">
                     	<td width"400" class="image_td"> 	
							<a href="#application.urlpath#media/#member.id#/#trim(answers.answer_filename)#" target="new" class="bodylink" ></a><strong>#answers.link_title#</strong><br />
                            <span class="dkblue10">(To preview, click on little play button above)</span> 
                        </td>     
                  	<cfelseif answers.type eq "document">
                     	<td width"400" class="image_td"> 	
							<a href="#application.urlpath#media/#member.id#/#trim(answers.answer_filename)#" target="new" class="bodylink" ></a><strong>#answers.link_title#</strong><br />
                            <span class="dkblue10">(To preview, Click on link above)</span> 
                        </td>               
                    </cfif>  
                    <td class="choice_text"> 
                        
                            <font size="+3"><input type="radio" name="answer_choice" value="#answers.id#" class="radio"/></font>
                                                 
                    </td>                
                </tr>
                
		</cfloop>   
        
     <cfelse>
     
     	<tr>
        	<td class="column_header" colspan="3">
            	<span class="stars">***</span> This member did not provide any Answer Options for this Choice. <span class="stars">***</span>
                <br /><br />
                Please provide feedback regarding their choice or decision below.
            </td>
        </tr>
     
     </cfif>
        
 		 <cfif choice.date_end gt now()>
            <tr> 
				<td class="choice_instruct">
					Additional Comments:
				</td>
 				<td bgcolor="FFFFFF" colspan="2">
					<cftextarea name="comments" width="500" height="150" richtext="true" toolbar="Basic" skin="silver"></cftextarea> 
                    <br />
                    (Abusive posts will not be tolerated, and may result in membership revocation)
				</td>               
			</tr>
         </cfif>
		<tr>
			<td class="basic_td" colspan="3">
				<cfif choice.date_end gt now()>
					<strong><cfif choice.anon eq 0>#member.username#<cfelse>Anonymous Member</cfif></strong>'s choice must be made by <strong>#choice.date_end#</strong>. 
				<cfelse>
				<span class="stars">***</span> The date for <strong><cfif choice.anon eq 0>#member.username#<cfelse>Anonymous Member</cfif></strong>'s choice has passed. No more feedback is being accepted.
				</cfif>
			</td>
		</tr>
			<tr> 
				<td colspan="4" class="submit" align="right">
                	<input type="hidden" name="function" value="provideFeedback">
                    <input type="hidden" name="type" value="#choice.type#">
                    <input type="hidden" name="cid" value="#url.cid#">
                    <input type="hidden" name="mid" value="#url.mid#">
					<input type="hidden" name="gid" value="#url.gid#">
                    <cfif choice.date_end gt now()>
					  	<a href="javascript:;" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('smtButton','','images/btn_submit_hover.gif',1)"><input type="image" src="images/btn_submit.gif" alt="Submit Feedback" name="smtButton" width="187" height="45" border="0" id="smtButton" /></a>
					<cfelse>
                    	<a href="index.cfm?fa=view_choice&mid=#url.mid#&cid=#url.cid#" class="bodylink">View Winning Choice</a>
                    </cfif>
                </td>            
			</tr>	
</cfform>

	<cfif client.mid neq url.mid>
			 <tr> 
				<td colspan="4" class="form_input" align="right">
					<a href="index.cfm?fa=new_message&mid=#url.mid#&cid=#url.cid#&subject=#choice.short_desc#" class="bodylink">Send this Member a Private Message.</a><br />	
				</td>            
			</tr>    
    </cfif>		
    	<tr>
        	<td>
            	<p class="med-spacer">&nbsp;</p>
            </td>
        </tr>
      </table>


</cfoutput>
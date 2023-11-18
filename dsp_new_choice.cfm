<meta name="robots" content="noindex" />
<meta name="googlebot" content="index" />

<cfparam name="url.signedup" default=0>
<cfparam name="url.loggedin" default=0>
<cfparam name="url.edit" default=0>
<cfparam name="url.cid" default=0>
<cfparam name="url.c" default=0>
<cfparam name="url.gid" default=0>



<cfset CurrentDate = DateFormat(Now(),"yyyy-mm-dd")>

		<cfif client.mid eq 0>
			<cflocation url="index.cfm?fa=nolog&new_choice=1">
		</cfif>

		<cfif url.edit eq 1>
          <cfquery name="choice" datasource="#application.dsn#">
              SELECT short_desc, details, type, date_end, anon, num_of_answers
              FROM t_choices
              WHERE id = #url.cid#
          </cfquery>
        </cfif>
		

                <cfquery name="cats" datasource="#application.dsn#">
                    SELECT c.id, c.cat_name
                    FROM t_categories c 
                </cfquery>	
			
			<cfif url.edit eq 1>
				<cfinclude template="udfs/arrayFind.cfm">
				
 				<cfquery name="cats_e" datasource="#application.dsn#">
 					SELECT id, mid, cid, cat_id
					FROM  t_choice_cats
					WHERE (cid = #url.cid#)
				</cfquery>
				
				<cfset catList = ValueList(cats_e.cat_id)>
				<cfset catArrayList = ListToArray(catList)>
			</cfif>

<link href="css/calendar.css" rel="stylesheet" type="text/css">
 <script type="text/javascript" src="js/calendar.js"></script>

<cfoutput>
<script Language="JavaScript"><!--
function formValidator(theForm)
{

  if (theForm.short_desc.value == "")
  										{
    alert("Please enter a value for the \"What is the Choice or Decision you need to make?\" field.");
    theForm.short_desc.focus();
    return false;
  }

<!---   if (theForm.details.value == "")
  										{
    alert("Please enter a value for the \"Choice Details text box\" field.");
    theForm.details.focus();
    return (false);
  } --->

   if (theForm.num_of_answers.value == "")
  										{
    alert("Please enter a value for the \"Number of Possible Options\" field.");
	return false;
    theForm.num_of_options.focus();
    
  } 
 
   if (theForm.date_end.value == "")
  										{
    alert("Please enter a value for the \"By what date does this Choice need to be made?\" field.");
    theForm.date_end.focus();
    return false;
  } 
 
 <cfif url.edit eq 0> 	
   if (theForm.date_end.value <= '#CurrentDate#')
  										{
    alert("Please enter a date a date after today's date.");
    theForm.date_end.focus();
    return false;
  } 
</cfif>

	count = 0;
	for (var i = 0; i < theForm.elements.length; i++ ) {
        if (theForm.elements[i].type == 'checkbox' &&  theForm.elements[i].name != 'email_me'){	
            if (theForm.elements[i].checked == true) {
                count++;
            }
        }
	}
	
	if(count==0){
		alert("You must choose at least 1 Category.");
		 return false;
	}
	else if(count>20){
		alert("You can only choose up to 20 Categories");
		return false;
	}


return (true);

}
//--></script>
</cfoutput>

	<script language="javascript"> 
		function toggle() {
		var ele = document.getElementById("toggleText");
		var text = document.getElementById("displayText");
		if(ele.style.display == "block") {
    		ele.style.display = "none";
		text.innerHTML = "Show Instructions";
  		}
		else {
		ele.style.display = "block";
		text.innerHTML = "Hide Instructions";
			}
		} 
		function submitForm() {
			$("#theForm").submit();
		}
	</script>

<script language="javascript">
function checkDate()	{
   if (theForm.date_end.value <= '#CurrentDate#')
  										{
    alert("Please enter a date a date after today's date.");
    theForm.date_end.focus();
    return false;
  } 
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
</script>

<cfoutput><body onLoad="MM_preloadImages('images/btn_hide_ins_hover.gif','images/btn_continue_hover.gif')">

<form action="components/act_Choices.cfm" name="theForm" id="theForm" onSubmit="return formValidator(this)" method="post">
		<table width="100%" border="0" cellspacing="10" cellpadding="0" class="body_text" bgcolor="FFFFFF">

		<cfif url.signedup eq 1>
			<tr> 
				<td class="alert_text" colspan="2">
					<span class="site_hdr3"> Thank you for signing up!</span>
					<br><br>
					Now you can describe a choice or decision you need to make in the form below.  <br />
                    Or you can go to <a href="index.cfm?fa=my_feedback" class="bodylink">My Feedback</a> to help others make choices, or <a href="index.cfm?fa=search_cats" class="bodylink">Search Choices</a> .
                    
					<br><br>
                </td>
			</tr>
		</cfif>        

		<cfif url.loggedin eq 1>
			<tr> 
				<td class="alert_text" colspan="2">
					<span class="site_hdr3"> <span style="color:##fcb026">Welcome</span> #client.name#!</span>
					<br><br>
					Please describe a choice or decision you need to make in the form below. 
					<br><br>
                    Or you can visit the <a href="index.cfm?fa=my_feedback" class="bodylink">My Feedback</a> or <a href="index.cfm?fa=search_engine&m=0" class="bodylink">Search Choices</a> to help others make choices.
                   <br><br>
                </td>
			</tr>
		</cfif>    
		<cfif url.gid neq 0>
			<tr> 
				<td class="alert_text" colspan="2">
					<span class="stars">***</span> To create a <strong>Group choice or decision</strong>,  Please describe a choice or decision you need to make in the form below. 
					<br><br>
                    You will have the option to <strong>request feedback only from the Group of your choice</strong> in the final step of the process below.
                   <br><br>
                </td>
			</tr>
		</cfif>       
			<tr> 
				<td class="alert_text" colspan="2">
				<table width="100%">
					<tr>
						<td align="left" valign="top">				
						<div id="toggleText" style="display: block">
							<span class="site_hdr2">Please Read Instructions Below</span>
								<br><br>
							<strong>This is how MakeMyChoice.com works:</strong>
								<br>   
								- You describe a choice or decision you need to make 
								<br />
								- You provide options for people to choose from to help you make your choice 
								<br />   
								<br /> 
							  <strong>Very much like you are creating a poll or survey</strong>
								<br><br>
								<strong>Example:</strong> <br> 
								<strong>Choice</strong> = What kind of dog should I get?<br />
								<strong>Details</strong> = I want a small dog that is friendly.<br />	
								<strong>Options</strong> = (3 options) Pug, Beagle, Dachshund		
								<br>     	
						 </div>	
						 </td>
						 <td align="right" valign="top">	
						 	<a id="displayText" href="javascript:toggle();" class="bodylink">Hide Instructions</a>
						 </td>
						</tr>
				</table>
                </td>
			</tr>       
			<tr> 
				<td class="header" colspan="2">
					<span style="color:##fcb026">STEP 1)</span> &nbsp; Describe Your Choice or Decision 
				</td>
			</tr>	
 			<tr>
				<td class="form_instruct" width="25%">
					What is the Choice or Decision you need to make?
				</td>
				<td class="form_input">
					<input type="text" name="short_desc" size="70" maxlength="150" <cfif url.edit eq 1>value="#choice.short_desc#"</cfif>>
					<br>
					<b>example</b>: Which elementary school in los angeles should I send my child to?
				</td>
			</tr>
			<tr>
				<td class="form_instruct">
					More details about the Choice or Decision you need to make.

				</td>
				<td class="form_input">
					<textarea name="details" cols="60" rows="6"><cfif url.edit eq 1>#choice.details#</cfif></textarea>
					<br>
					(<b>example</b>: My child is entering elementary school, and what is most important to us is having small class sizes and dedicated teachers.)
				</td>
			</tr>           
            <tr>
               <td class="form_instruct" valign="middle"> 
					Number of possilbe options for people to choose from?
               </td>
              <td class="form_input">

					<select name="num_of_answers" size="1" class="site_text">
                    	<cfif url.edit eq 1>
                    		<option value="#choice.num_of_answers#"> #choice.num_of_answers# </option>
                       	<cfelse>
                        	<option value="">Select number of options</option>
                        </cfif>
                        <option value=2> two </option>
                        <option value=3> three </option>
                        <option value=4> four </option>
                        <option value=5> five </option>
                        <option value=6> six </option>
                        <option value=7> seven </option>
                        <option value=8> eight </option>
                        <option value=9> nine </option>
                        <option value=0> - no options -</option>
                    </select>
					<br><br>
					<b>example</b>: If you have four schools you are considering, you would choose "four" above.

                    <br>
                 <b>NOTE:</b> You will enter the options on the following page.
		  			<br>
                    "no options" means you do not want to provide answer options.
              <!--- 	<cfif url.edit eq 0>
					<input type="radio" name="type" value="multiple" checked="checked" /> Yes, I want to add the possible answers. 				<br>	<br>	
(<b>example</b>: For the above example, you would would have two possible answers - "public" or "private")
                    <br />  <br /> 
                    <input type="radio" name="type" value="yesno" /> No, it is a "Yes or No" decision. 
                <cfelse>
 					<input type="radio" name="type" value="multiple" <cfif choice.type eq "multiple">checked="checked"</cfif> /> Yes, I want to add the possible answers. 
                    <br /> 
                    <input type="radio" name="type" value="yesno" <cfif choice.type eq "yesno">checked="checked"</cfif> /> No, it is a "Yes or No" decision.                
                </cfif> --->
             </td>
          </tr>
			<tr>
				<td class="form_instruct">
					Display Username?
				</td>
				<td class="form_input">
                <cfif url.edit eq 0>
					<input type="radio" name="anon" value=0 checked="checked" /> Yes, it's OK to allow other members to see who is making this choice.
                    <br /> 
                    <input type="radio" name="anon" value=1 /> No, remain anonymous. Do not allow members to see who is making this choice.
				 <cfelse>
					<input type="radio" name="anon" value=0 <cfif choice.anon eq 0> checked="checked" </cfif> /> Yes, it's OK to allow other members to see who is making this choice.
                    <br /> 
                    <input type="radio" name="anon" value=1 <cfif choice.anon eq 1> checked="checked" </cfif> /> No, remain anonymous. Do not allow members to see who is making this choice.                 
                 </cfif>
                </td>
			</tr>
           <tr>
				<td class="form_instruct">
					By what date does this Choice need to be made?
				</td>
				<td class="form_input">
					<input type="text" size="15" name="date_end" <cfif url.edit eq 0>onChange="checkDate();"</cfif> maxlength="15" id="date_end" <cfif url.edit eq 1>value="#DateFormat(choice.date_end,'yyyy-mm-dd')#"<cfelse>value=""</cfif>>
 					<script type="text/javascript">
 						calendar.set("date_end");
					</script>
				</td>
			</tr>
           <tr>
				<td class="form_instruct">
					Email me when people respond.
				</td>
				<td class="form_input">
					<input type="checkbox" name="email_me" value="1" checked="checked" /> Yes, Email me when people provide feedback about my choice.
				</td>
			</tr>
           <tr>
				<td colspan="2">
                    <table width="100%" border="0" cellspacing="1" cellpadding="5" class="site_text_sm">
                        <tr> 
                            <td colspan="4" align="left" class="header2">
                                Choose Categories
                            </td>
                        </tr>    
                        <tr>
                            <td  class="form_instruct" nowrap colspan="4">
                                Plese check the category or categories for your Choice or Decision below.
                            </td>
                        </tr>
                            <td align="left" valign="top">
                                <cfloop query="cats" startrow="1" endrow="10">
                                   <input type="checkbox" name="cat_#cats.id#" value="#cats.id#" <cfif url.edit eq 1><cfif arrayFind(catArrayList,cats.id) neq 0>CHECKED</cfif></cfif>> &nbsp; #cats.cat_name#<br>
                                </cfloop>
                            </td>
                            <td align="left">
                                <cfloop query="cats" startrow="11" endrow="20">
                                   <input type="checkbox" name="cat_#cats.id#" value="#cats.id#" <cfif url.edit eq 1><cfif arrayFind(catArrayList,cats.id) neq 0>CHECKED</cfif></cfif>> &nbsp; #cats.cat_name#<br>
                                </cfloop>
                            </td> 
                            <td align="left">
                                <cfloop query="cats" startrow="21" endrow="30">
                                   <input type="checkbox" name="cat_#cats.id#" value="#cats.id#" <cfif url.edit eq 1><cfif arrayFind(catArrayList,cats.id) neq 0>CHECKED</cfif></cfif>> &nbsp; #cats.cat_name#<br>
                                </cfloop>
                            </td>       
                            <td align="left">
                                <cfloop query="cats" startrow="31" endrow="40">
                                   <input type="checkbox" name="cat_#cats.id#" value="#cats.id#" <cfif url.edit eq 1><cfif arrayFind(catArrayList,cats.id) neq 0>CHECKED</cfif></cfif>> &nbsp; #cats.cat_name#<br>
                                </cfloop>
                            </td>    
                        </tr>
                    </table>
				</td>
			</tr>
			<tr> 
				<td colspan="2" class="submit">
                	<cfif url.edit eq 0>
                        <input type="hidden" name="function" value="addChoice">
						<input type="hidden" name="gid" value="#url.gid#">
                    <cfelse>
                    	<input type="hidden" name="cid" value="#url.cid#">
                    	<input type="hidden" name="function" value="editChoice">
                    </cfif>
					<input type="hidden" name="type" value="multiple">
				<a href="javascript:;"  onmouseout="MM_swapImgRestore()" onMouseOver="MM_swapImage('continue','','images/btn_continue_hover.gif',1)"><input type="image" src="images/btn_continue.gif" alt="Continue" name="continue" width="189" height="46" border="0" id="continue" /></a></td>
			</tr>	 
            <tr>
            	<td colspan="2">&nbsp;
                	
                </td>
           </tr>
		</table>
	</form>	
 </cfoutput>
 <br /><Br />
 
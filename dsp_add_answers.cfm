<meta name="robots" content="noindex" />
<meta name="googlebot" content="index" />


<cfparam name="form.format" default=0>
<cfparam name="url.format" default=0>
<cfparam name="url.cid" default=0>
<cfparam name="url.added" default=0>
<cfparam name="url.extension" default=0>
<cfparam name="url.dimensions" default=0>
<cfparam name="url.filesize" default=0>
<cfparam name="url.na" default=0>
<cfparam name="url.mp3c" default=1>
<cfparam name="url.cu" default=0>
<cfparam name="url.empty" default=0>
<cfparam name="url.num_of_answers" default="">


<cfif url.format neq 0>
	<cfset form.format = url.format>
    <cfset form.num_of_answers = url.na>
</cfif>

<cfif form.format eq "mp3" AND url.mp3c eq 1>
    <cfset url.na = form.num_of_answers>
</cfif>

<cfif url.cid neq 0>
	<cfset form.cid = url.cid>
</cfif>

<cfif url.num_of_answers eq 0>
	<cfoutput>
        <cflocation url="index.cfm?fa=request_feedback&cid=#url.cid#&added_0=1">
    </cfoutput>
</cfif>

<script Language="JavaScript"><!--
function formValidator(theForm)
{

  if (theForm.format.value == "")
  {
    alert("Please enter a value for the \"Answer Format\" field.");
    theForm.format.focus();
    return (false);
  }
  
  if (theForm.num_of_answers.value == "")
  {
    alert("Please enter a value for the \"How Many possible Answers\" field.");
    theForm.num_of_answers.focus();
    return (false);
  }

  return (true);
}
//--></script>

<script Language="JavaScript"><!--
function answerValidator(theForm)
{

  if (theForm.answer_1.value == "")
  {
    alert("Please enter a value for the \"Answer 1\" field.");
    theForm.answer_1.focus();
    return (false);
  }
  
  if (theForm.answer_2.value == "")
  {
    alert("Please enter a value for the \"Answer 2\" field.");
    theForm.answer_2.focus();
    return (false);
  }

  return (true);
}
//--></script>



	<script language="javascript"> 
		function toggle() {
		var ele = document.getElementById("toggleText");
		var text = document.getElementById("displayText");
		if(ele.style.display == "block") {
    		ele.style.display = "none";
		text.innerHTML = "Show Example";
  		}
		else {
		ele.style.display = "block";
		text.innerHTML = "Hide Example";
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

<cfoutput>

<cfif form.format eq 0>
		<table width="100%" border="0" cellspacing="1" cellpadding="5" class="dkblue12">			
       		<tr> 
				<td class="header" colspan="2">
					<span style="color:##FFF">STEP 2)</span> &nbsp; Choose a Format for your Answer Options
				</td>
			</tr> 
       	<cfif url.added eq 1>
			<tr> 
				<td class="alert_text" colspan="2">
				<br>
					<span class="stars">***</span> <strong>Now add the possible answers</strong> for your choice below. <span class="stars">***</span>
					<br><br>
                </td>
			</tr>
		</cfif>
       	<cfif url.cu eq 1>
			<tr> 
				<td class="alert_text" colspan="2">
					<span class="stars">***</span> Your Choice has been updated. <span class="stars">***</span>
					<br><br>
					<span class="stars">***</span> Now add the possible answer options for your choice below. <span class="stars">***</span>
					<br><br>
                </td>
			</tr>
		</cfif>
       	<cfif url.empty eq 1>
			<tr> 
				<td class="alert_text" colspan="2">
					<span class="red_stars">***</span> You need at least two possible answer options to your choice. <span class="red_stars">***</span>
					<br><br>
					<span class="stars">***</span> Please add possible answer options to your choice below. <span class="stars">***</span>
					<br><br>
                </td>
			</tr>
		</cfif>
        <form action="index.cfm?fa=add_answers&cid=#url.cid#" method="post" onSubmit="return formValidator(this)">	
			<tr> 
				<td class="form_instruct">
                	<p class="small-spacer">&nbsp;</p>
                    <span class="body_text">
                    	How would you like to provide your answer options? <br>
						 In writing? (text) <br>
						 By photo? (images) <br>
						 By sound? (mp3s) <br>
						 different documents? (documents)    
                    </span>
                    <p class="small-spacer">&nbsp;</p>
                </td>
				<td class="form_input"> 
                	
					<select name="format" size="1" class="site_text">
                    	<option value="">Select Format....</option>
                    	<option value="text">TEXT - Type in my answers</option>
                        <option value="image">IMAGES - Upload images for my answers</option> 
                        <option value="mp3">MP3s - Upload mp3s for my answers</option>
                        <option value="document">DOCUMENTS - Upload documents for my answers</option>
                    </select>
                 
				</td>
			</tr>           
           	<tr>
                <td colspan="2" align="left">
                | <a id="displayText" href="javascript:toggle();" class="bodylink">Show Example</a> |
                </td>
            </tr>
			<tr> 
				<td class="alert_text" colspan="2">
                    <div id="toggleText" style="display: none">
                        <span class="stars">***</span> EXAMPLE<span class="stars">***</span>
                        <br><br>
                        If your choice is "What kind of dog should I get?"</strong><br /><br />
                           Then you would choose <strong>TEXT</strong> as your <strong>Format</strong> above.<br /><br />
                          
                          <strong>On the next page, you would type in:</strong> <br />
                           "Pug" as Answer Option ##1<br /> 
                           "Beagle" as Answer Option ##2<br />
                           "Dachshund" as Answer Option ##3 		
                        <br><br>
                    </div>
                </td>
			</tr>

<!--- 			<tr> 
				<td class="form_instruct" nowrap="nowrap">
                	<p class="med-spacer">&nbsp;</p>
						How Many possible Answers do want to add for your choice?
                    <p class="med-spacer">&nbsp;</p>
                </td>
				<td class="form_input"> 
                	
					<select name="num_of_answers" size="1">
                    	<option value="">Select....</option>
                        <option value=2> two </option>
                        <option value=3> three </option>
                        <option value=4> four </option>
                        <option value=5> five </option>
                        <option value=6> six </option>
                        <option value=7> seven </option>
                        <option value=8> eight </option>
                        <option value=9> nine </option>
                    </select>
                 
				 (<b>example</b>: If your choice was, "Should I send my child to public or private elementary school in los angeles?" then you would have <b>two possible answers</b> - "public" and "private")
				 
				</td>
			</tr> --->
            <tr>
            	<td colspan="2">&nbsp;
                	
                </td>
            </tr>
            <tr> 
				<td colspan="2" class="submit">
				
					<input type="hidden" name="num_of_answers" value="#url.num_of_answers#">
					<a href="javascript:;"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('continue','','images/btn_continue_hover.gif',1)"><input type="image" src="images/btn_continue.gif" alt="Continue" name="continue" width="189" height="46" border="0" id="continue" /></a>
				</td>
			</tr>	
		</form>
        </table>
</cfif>


<cfif form.format neq 0>
		<table width="100%" border="0" cellspacing="10" cellpadding="5" class="dkblue12">			
       		<tr> 
				<td class="header" colspan="2">
					<span class="header_orange">Add</span> Your Answer Options
				</td>
			</tr> 
    <cfif form.format eq "image">
			<cfif url.extension eq 1>
                <tr> 
                    <td class="alert_text" colspan="2">
                        <span class="red_stars">***</span> The images need to be .jpg, .gif, or a .png files.<span class="red_stars">***</span>
                    </td>
                </tr> 
            </cfif>   
            <cfif url.dimensions eq 1>
                <tr> 
                    <td class="alert_text" colspan="2">
                        <span class="red_stars">***</span> The images cannot be more than 800 pixels width and 1200 pixels height <span class="red_stars">***</span>
                    </td>
                </tr> 
            </cfif>   
            <cfif url.filesize eq 1>
                <tr> 
                    <td class="alert_text" colspan="2">
                        <span class="red_stars">***</span> The image has to be under 300k. Please resize the image, or save with lower resolution. <span class="red_stars">***</span>
                    </td>
                </tr> 
            </cfif>   
     <cfelseif form.format eq "mp3">
			 <cfif url.extension eq 1>
                <tr> 
                    <td class="alert_text" colspan="2">
                        <span class="red_stars">***</span> The music files need to be .mp3 files.<span class="red_stars">***</span>
                    </td>
                </tr> 
            </cfif>   
            <cfif url.filesize eq 1>
                <tr> 
                    <td class="alert_text" colspan="2">
                        <span class="red_stars">***</span> The mp3s have to be under 10mb each. Please save the mp3s with lower quality settings to reduce size. <span class="red_stars">***</span>
                    </td>
                </tr> 
            </cfif>      
     <cfelseif form.format eq "document">
			 <cfif url.extension eq 1>
                <tr> 
                    <td class="alert_text" colspan="2">
                        <span class="red_stars">***</span> That kind of file is not allowed to be uploaded. <span class="red_stars">***</span>
                    </td>
                </tr> 
            </cfif>   
            <cfif url.filesize eq 1>
                <tr> 
                    <td class="alert_text" colspan="2">
                        <span class="red_stars">***</span> The documents have to be under 5mb each. Please upload documents of a smaller file size. <span class="red_stars">***</span>
                    </td>
                </tr> 
            </cfif>  
     </cfif>   
     
      
     
			 <cfif form.format eq "text">
                
                <form action="actions/act_addAnswers.cfm" method="post" name="answers" onSubmit="return answerValidator(this)">
                	<cfloop from="1" to="#form.num_of_answers#" index="i">
                    <tr> 
                        <td class="form_instruct" nowrap="nowrap">

                               Answer Option ###i#)                        
                        </td>
                        <td class="form_input"> 
                            <input type="text" name="answer_#i#" size="60" maxlength="150" />
                        </td>
                    </tr>  
                    </cfloop>
               
               
                    <tr> 
                        <td colspan="2" class="submit">
                            <input type="hidden" name="function" value="addAnswers">
                            <input type="hidden" name="type" value="#form.format#">
                            <input type="hidden" name="num_of_answers" value="#form.num_of_answers#">
                            <input type="hidden" name="cid" value="#url.cid#">
                            <input type="Submit" value="Add Your Answer Options">
                        </td>
                    </tr>	
               </form>
               
            <cfelseif form.format eq "image" OR form.format eq "document">
            
             <form action="actions/act_upload.cfm" method="post" enctype="multipart/form-data">
            
                	<cfloop from="1" to="#form.num_of_answers#" index="i">
                    <tr> 
                        <td class="form_instruct" nowrap="nowrap">

                               #ucase(form.format)# ###i#)                        

                        </td>
                        <td class="form_input"> 
                            
                            <input type="file" name="upload_#form.format#_#i#" /><br />
                            browse for #form.format#
                            <br /><br />
                            <cfif form.format eq "image">
                            	<input type="text" name="image_caption_#i#" /><br />
                            	optional image caption
                            <cfelseif form.format eq "document">
                             	<input type="text" name="link_title_#i#" /><br />
                            	<strong>Name of Document</strong><br />
                                (the link that people will see)
                            </cfif>
                         
                        </td>
                    </tr>  
                    </cfloop>
               
               
                    <tr> 
                        <td colspan="2" class="submit">
                        	<cfif form.format eq "image">
                            	<input type="hidden" name="function" value="newImageAnswers">
                            <cfelseif form.format eq "document">
                            	<input type="hidden" name="function" value="newDocumentAnswers">
                            <cfelse>
                            	<input type="hidden" name="function" value="newImageAnswers">
                            </cfif>
                            <input type="hidden" name="num_of_answers" value="#form.num_of_answers#">
                            <input type="hidden" name="cid" value="#url.cid#">
                            <a href="javascript:;"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('continue2','','images/btn_continue_hover.gif',1)"><input type="image" src="images/btn_continue.gif" alt="Continue" name="continue2" width="189" height="46" border="0" id="continue2" /></a>
                            <br />
                          <span class="stars">***</span> Click once....May take some time to upload. <span class="stars">***</span>
                        </td>
                    </tr>	 
                    
                </form>           
            
           <cfelseif form.format eq "mp3">
            
             <form action="actions/act_upload.cfm?mp3c=#url.mp3c#&na=#url.na#" method="post" enctype="multipart/form-data">
            
    				<tr>
                    	<td colspan="2" class="submit">
                        	<span class="stars">***</span> You will upload your MP3 Answers one at a time. <span class="stars">***</span>
                        </td>      
                    <tr> 
                 <cfif url.added neq 0>
                	<tr>
                    	<td colspan="2" class="alert_text">
                        	<span class="stars">***</span> Your MP3 has been added, continue below. <span class="stars">***</span>
                        </td>      
                    <tr> 
                 </cfif>
                        <td class="form_instruct" nowrap="nowrap">
                            <p class="med-spacer">&nbsp;</p>
                               MP3 ###url.mp3c#)                        
                            <p class="med-spacer">&nbsp;</p>
                        </td>
                        <td class="form_input"> 
                            
                            <input type="file" name="upload_mp3_#url.mp3c#" /><br />
                            browse for MP3
                            <br /><br />

                            	<input type="text" name="link_title_#url.mp3c#" /><br />
                            	<strong>Name of Mp3</strong><br />
                                (the link that people will see)
                         
                        </td>
                    </tr>  
               
               
                    <tr> 
                        <td colspan="2" class="submit">

                            <input type="hidden" name="function" value="newMp3Answers">
                            <input type="hidden" name="cid" value="#url.cid#">
                            <a href="javascript:;"  onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('continue3','','images/btn_continue_hover.gif',1)"><input type="image" src="images/btn_continue.gif" alt="Continue" name="continue3" width="189" height="46" border="0" id="continue3" /></a>
                            <br />
                          <span class="stars">***</span> Click once....May take some time to upload. <span class="stars">***</span>
                        </td>
                    </tr>	 
                    
                </form>           
            
            </cfif>           
		
        
       
       
      </table>
</cfif>

</cfoutput>
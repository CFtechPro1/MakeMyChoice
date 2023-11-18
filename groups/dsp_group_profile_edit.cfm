

<cfparam name="url.updated" default=0>
<cfparam name="url.extension" default=0>
<cfparam name="url.dimensions" default=0>
<cfparam name="url.filesize" default=0>
<cfparam name="url.eSettings" default=0>


            <cfquery name="g" datasource="#application.dsn#">
                SELECT id, mid, group_name, group_desc, private, group_pic
                FROM t_groups 
                	WHERE id = #client.gid#
            </cfquery>
			
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript">

function textCounter(field,cntfield,maxlimit) {
	if (field.value.length > maxlimit) // if too long...trim it!
	field.value = field.value.substring(0, maxlimit);
	// otherwise, update 'characters left' counter
	else
	cntfield.value = maxlimit - field.value.length;
}

//<![CDATA[        
						bkLib.onDomLoaded(function() { nicEditors.allTextAreas() });  
						//]]>
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

</SCRIPT>

		<!--- Upload image and personal details --->
 <cfoutput>	
		<table width="100%" border="0" cellspacing="0" cellpadding="5" class="site_text">
			<tr> 
				<td class="header" colspan="2">
					Edit Group Profile Picture & Description
				</td>
			</tr>
              	<cfif url.updated eq 1>
                    <tr> 
                        <td class="alert_text" colspan="3">
                       		<br>
                            <span class="stars">***</span> Your profile has been updated! <span class="stars">***</span>
                            <br><br>
                        </td>
                    </tr>
                </cfif>		
			  <cfif url.extension eq 1>
                  <tr> 
                      <td class="alert_text" colspan="3">
                          <span class="red_stars">***</span> The images need to be .jpg, .gif, or a .png files.<span class="red_stars">***</span>
                      </td>
                  </tr> 
              </cfif>   
              <cfif url.dimensions eq 1>
                  <tr> 
                      <td class="alert_text" colspan="3">
                          <span class="red_stars">***</span> The image cannot be more than 800 pixels width and 800 pixels height. It will be re-sized to 150px by 150px when displayed.<span class="red_stars">***</span>
                      </td>
                  </tr> 
              </cfif>   
              <cfif url.filesize eq 1>
                  <tr> 
                      <td class="alert_text" colspan="3">
                          <span class="red_stars">***</span> The image has to be under 200k. Please resize the image, or save with lower resolution. <span class="red_stars">***</span>
                      </td>
                  </tr> 
              </cfif> 
               	<cfif url.eSettings eq 1>
                    <tr> 
                        <td class="alert_text" colspan="3">
                       		<br>
                            <span class="stars">***</span> Your Email Settings have been updated! <span class="stars">***</span>
                            <br><br>
                        </td>
                    </tr>
                </cfif>	
       <form action="../actions/act_upload.cfm" method="post" enctype="multipart/form-data">
           <tr> 
              <td class="form_instruct" width="25%">
                     <a name="groupPic">Upload Image</a>                   
                  	<br>
                 <span class="stars">***</span> <span class="dkblue12"> (Image will be displayed at <strong>150 pixels width</strong> by <strong>150 pixels height</strong>)</span>
              </td>
              <td class="form_input"> 
                  <table class="site_text">
                  	  <tr>
                    	<td align="left">
                          <input type="file" name="upload_image" size="40" /><br />
                          browse for image
                          <br /><br />
                       </td>
                     	<td align="center" style="padding-left:10px;">
                        	<cfif g.group_pic neq "">
                            	<img src="#application.urlpath#/media/#g.mid#/#client.gid#/#g.group_pic#" width="150" height="150"><br>
                                (current image)
                            </cfif>
                        </td>
                      </tr>
                  </table>
               
              </td>
          </tr>
			<tr> 
				<td colspan="2" class="submit">
                    
					<input type="hidden" name="function" value="groupPic">
					<input type="hidden" name="gid" value="#client.gid#">
					 <a href="javascript:;" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('saveChanges2','','../images/btn_save_changes_hover.gif',1)"><input type="image" src="../images/btn_save_changes.gif" alt="Save Changes" name="saveChanges2" id="saveChanges2" width="187" height="45" border="0"></a> 
				</td>
			</tr>
       </form>
	  	 <tr> 
	   		<td colspan="2">&nbsp;
				
		    </td>
		 </tr>
       <form action="../actions/act_Groups.cfm" method="post" name="updateGroup">
           <tr> 
              <td class="form_instruct" width="25%">
                  <p class="small-spacer">&nbsp;</p>
                    <a name="groupDesc"> Brief Group Description    
                     <br>                 
                  	<span class="dkblue10">
                    (To be dispayed on Group Homepage)
                    <br><br>
                    </span>
              
              </td>
              <td class="basic_td"> 
                    <textarea name="group_desc" wrap="physical" cols="50" rows="5"
						onKeyDown="textCounter(document.updateGroup.group_desc,document.updateGroup.remLen1,250)"
						onKeyUp="textCounter(document.updateGroup.group_desc,document.updateGroup.remLen1,250)"><cfif g.group_desc neq "">#g.group_desc#</cfif></textarea>
						<br>
						<input readonly type="text" name="remLen1" size="3" maxlength="3" value="150">
						characters left
						<br>
              </td>
          </tr>    
			<tr> 
				<td colspan="2" class="submit">                    
					<input type="hidden" name="function" value="groupDesc">
					<input type="hidden" name="gid" value="#client.gid#">
					
				<a href="javascript:;" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('saveChanges1','','../images/btn_save_changes_hover.gif',1)"><input type="image" src="../images/btn_save_changes.gif" alt="Save Changes" name="saveChanges1" id="saveChanges1" width="187" height="45" border="0"></a>
				</td>
			</tr>
         </form>
        </table>
</cfoutput>	
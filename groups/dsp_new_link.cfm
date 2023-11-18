

<cfparam name="url.edit" default=0>
<cfparam name="url.link_id" default=0>


<cfif url.edit eq 1>
	<cfquery name="link" datasource="#application.dsn#">
		SELECT id, mid, gid, url, url_text, url_desc, date_created
		FROM t_group_links
		WHERE id = #url.link_id#
	</cfquery>
</cfif>


		<!--- Upload image and personal details --->
 <cfoutput>	
		<table width="100%" border="0" cellspacing="10" cellpadding="0" class="site_text">
			<tr> 
				<td class="header" colspan="2">
					<span class="header_orange"><cfif url.edit eq 0>New<cfelse>Edit</cfif></span> Link
				</td>
			</tr>	
			<tr> 
				<td class="page_desc" colspan="2">
					Please enter the link information below, and click submit.
				</td>
			</tr>
				
       <form action="../actions/act_Groups.cfm" method="post">
           <tr> 
              <td class="form_instruct" width="25%">
                Web Address (URL)            
				
              </td>
              <td class="form_input"> 
                  http://<input type="text" name="url" size="60" <cfif url.edit eq 1>value="#link.url#"</cfif> />
              </td>
          </tr>
           <tr> 
              <td class="form_instruct" width="25%">
                Link Text             
              </td>
              <td class="form_input"> 
                  <input type="text" name="url_text" size="65" <cfif url.edit eq 1>value="#link.url_text#"</cfif> />
				  <br />
				  (The text that users will click on)
              </td>
          </tr>
           <tr> 
              <td class="form_instruct" width="25%">
                Link Description             
              </td>
              <td class="form_input"> 
                  <textarea name="url_desc" cols="50" rows="3"><cfif url.edit eq 1>#link.url_desc#</cfif> </textarea>
				  <br />
				  (optional brief description of the content you are linkiing to.)
              </td>
          </tr>
			<tr> 
				<td colspan="2" class="submit">
                    
					<input type="hidden" name="function" value="groupLink">
					<input type="hidden" name="gid" value="#client.gid#">
					<input type="hidden" name="edit" value="#url.edit#">
					<cfif url.edit eq 1>
						<input type="hidden" name="link_id" value="#link.id#">
					</cfif>
					
					<a href="javascript:;" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('submitBtnL','','../images/btn_submit_hover.gif',1)"><input type="image" src="../images/btn_submit.gif" alt="Submit" name="submitBtnL" width="187" height="45" border="0" id="submitBtnL" /></a>
					
				</td>
			</tr>
	  	 <tr> 
	   		<td colspan="2">&nbsp;
				
		    </td>
		 </tr>
		 </form>
        </table>
</cfoutput>		
        <br>
<meta name="robots" content="noindex" />
<meta name="googlebot" content="index" />



<cfparam name="url.updated" default=0>
<cfparam name="url.added" default=0>
<cfparam name="url.gd" default=0>
<cfparam name="url.md" default=0>
<cfparam name="url.edit" default=0>
<cfparam name="url.gid" default=0>
<cfparam name="url.optOut" default=0>
<cfparam name="url.notSure" default=0>
<cfparam name="url.add_gid" default=0>
<cfparam name="url.confirmed" default=0>
<cfparam name="url.status" default=0>
<cfparam name="url.i_deleted" default=0>

		<cfif client.mid eq 0>
			<cflocation url="index.cfm?fa=nolog&new_group=1">
		</cfif>

            <cfquery name="g" datasource="#application.dsn#">
                SELECT id, mid, group_name
                FROM t_groups 
                	WHERE mid = #client.mid#
                	ORDER BY group_name
            </cfquery>	
		
		
        <cfif url.edit eq 1>
            <cfquery name="g_edit" datasource="#application.dsn#">
                SELECT id, mid, group_name, group_desc, private
                FROM t_groups 
                	WHERE mid = #client.mid#
                    	AND id = #url.gid#
            </cfquery>
        </cfif>

                <cfquery name="cats" datasource="#application.dsn#">
                    SELECT  id, cat_name
                    FROM t_categories 
                </cfquery>	  		


        <cfif url.edit eq 1>
            <cfquery name="cat_edit" datasource="#application.dsn#">
                SELECT cat_id
                FROM t_group_cats 
                	WHERE gid = #url.gid#
            </cfquery>
			<cfset catList = "">
			<cfloop query="cat_edit">
				<cfset catList = ListAppend(catList, cat_edit.cat_id)>
			</cfloop>	
			<cfset catList = catList & ",">
        </cfif>
		
<cfif url.edit eq 1>
	<cfif g_edit.private eq 1>
		<cfset privateVar = 1>
		<cfset publicVar = 0>
	<cfelseif g_edit.private eq 0>
		<cfset privateVar = 0>
		<cfset publicVar = 1>	
	</cfif>	
<cfelse>
	<cfset privateVar = 1>
	<cfset publicVar = 0>	
</cfif>

<script Language="JavaScript">
function textCounter(field,cntfield,maxlimit) {
	if (field.value.length > maxlimit) // if too long...trim it!
	field.value = field.value.substring(0, maxlimit);
	// otherwise, update 'characters left' counter
	else
	cntfield.value = maxlimit - field.value.length;
}



<!--
function formValidator(theForm)
{

  if (theForm.new_group.value == "")
  										{
    alert("Please enter a value for the \" New Group\" field.");
    theForm.new_group.focus();
    return (false);
  }

	count = 0;
	for (var i = 0; i < theForm.elements.length; i++ ) {
        if (theForm.elements[i].type == 'checkbox'){	
            if (theForm.elements[i].checked == true) {
                count++;
            }
        }
	}
	
	if(count==0){
		alert("You must choose at least 1 Category.");
		 return false;
	}
	else if(count>30){
		alert("You can only choose up to 30 Categories");
		return false;
	}

return (true);

}
//-->
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



<cfoutput><body onLoad="MM_preloadImages('images/btn_add_new_group_hover.gif')">


		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="site_text">
			<tr> 
				<td class="header" colspan="2">
					<span class="header_orange">New</span> Group
				</td>
			</tr>  
  			 <tr> 
				<td colspan="2" class="page_desc">
					Create a group for any organization, business, or for friends or family below. 
					It's a great way to make choices and decisions together, create surveys, ask anonymous questions, and post important links and resources.
				</td>            
			</tr> 
			<tr>
				<td colspan="2" align="left" class="sub_menu">
					<cfinclude template="includes/group_submenu.cfm">
				</td>
			</tr>
		</table>
		<table width="100%" border="0" cellspacing="5" cellpadding="0" class="site_text">
       <form name="newGroup" id="newGroup" action="actions/act_groups.cfm"  onSubmit="return formValidator(this)" method="post">     	
            <tr>
                  <td class="form_instruct" valign="middle">
                  	<cfif url.edit eq 0>	 
                        Create New Group
                    <cfelseif url.edit eq 1>
                    	Edit Your Group
                    </cfif>	
                   </td>
                  <td class="form_input">
                  	<cfif url.edit eq 0>
                        <input type="text" name="new_group" size="50" maxlength="100"><br />      
                        (type name of new group above)  
                    <cfelse>
                        <input type="text" name="new_group" size="50" maxlength="100" value="#g_edit.group_name#"><br />      
                        (edit name of your group above)                      
                    </cfif>
                  </td>
          	</tr> 
			<tr>
                  <td class="form_instruct" valign="middle">
                  	<cfif url.edit eq 0>	 
                        Group Description
                    <cfelseif url.edit eq 1>
                    	Edit Group Description
                    </cfif>	
                   </td>
                  <td class="form_input">

                    <textarea name="group_desc" wrap="physical" cols="50" rows="5"
						onKeyDown="textCounter(document.newGroup.group_desc,document.newGroup.remLen1,250)"
						onKeyUp="textCounter(document.newGroup.group_desc,document.newGroup.remLen1,250)"><cfif url.edit eq 1>#g_edit.group_desc#</cfif></textarea>
						<br>
						<input readonly type="text" name="remLen1" size="3" maxlength="3" value="250">
						characters left
						<br>

                  </td>
			<tr>
                  <td class="form_instruct" valign="middle">
                  	<cfif url.edit eq 0>	 
                        Group Access
                    <cfelseif url.edit eq 1>
                    	Edit Group Access
                    </cfif>	
                   </td>
                  <td class="form_input">
				  		<cfif url.edit eq 0>
                        	<input type="radio" id="privateRadio" name="private" value="1" checked>  &nbsp; <strong>PRIVATE</strong>
						<cfelse>
							<input type="radio" id="privateRadio" name="private" value="1" <cfif g_edit.private eq 1>checked</cfif>>  &nbsp; <strong>PRIVATE</strong>
						</cfif>
						<ul>
							<li>Private groups are only viewable by those who are members of the group.</li>
						</ul>
						
						<cfif url.edit eq 0>
                        	<input type="radio" id="publicRadio" name="private" value="0"> &nbsp; <strong>PUBLIC</strong>
						<cfelse>
							<input type="radio" id="publicRadio" name="private" value="0" <cfif g_edit.private eq 0>checked</cfif>> &nbsp; <strong>PUBLIC</strong>
						</cfif>
						<ul>
						<li>Public groups are searchable by other members & the public.</li>
						<li>Any other MakeMyChoice members can join public groups.</li>
						</ul>
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
										Plese check the appropriate category or categories for your new Group.
									</td>
								</tr>
								  <td align="left">
									  <cfloop query="cats" startrow="1" endrow="10">
										 <input type="checkbox" name="cat_#cats.id#" value="1" <cfif url.edit eq 1><cfif catList CONTAINS (cats.id & ",")>CHECKED</cfif></cfif>> &nbsp; #cats.cat_name#<br>
									  </cfloop>
								  </td>
								  <td align="left">
									  <cfloop query="cats" startrow="11" endrow="20">
										 <input type="checkbox" name="cat_#cats.id#" value="1" <cfif url.edit eq 1><cfif catList CONTAINS (cats.id & ",")>CHECKED</cfif></cfif>> &nbsp; #cats.cat_name#<br>
									  </cfloop>
								  </td> 
								  <td align="left">
									  <cfloop query="cats" startrow="21" endrow="30">
										 <input type="checkbox" name="cat_#cats.id#" value="1" <cfif url.edit eq 1><cfif catList CONTAINS (cats.id & ",")>CHECKED</cfif></cfif>> &nbsp; #cats.cat_name#<br>
									  </cfloop>
								  </td>       
								  <td align="left">
									  <cfloop query="cats" startrow="31" endrow="40">
										 <input type="checkbox" name="cat_#cats.id#" value="1" <cfif url.edit eq 1><cfif catList CONTAINS (cats.id & ",")>CHECKED</cfif></cfif>> &nbsp; #cats.cat_name#<br>
									  </cfloop>
								  </td>    
							  </tr>	
						  </table>  
					</td>
				</tr>
			
			<tr> 
				<td colspan="2" class="submit">
                	<cfif url.edit eq 0>
                		<input type="hidden" name="function" value="addGroup" />
						<a href="javascript:;" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('addNewGroup','','images/btn_add_new_group_hover.gif',1)"><input type="image" src="images/btn_add_new_group.gif" alt="Add New Group" name="addNewGroup" width="187" height="45" border="0" id="addNewGroup" /></a>
					<cfelseif url.edit eq 1>
                     	<input type="hidden" name="function" value="editGroup" />
                        <input type="hidden" name="gid" value="#url.gid#" />
                        <input type="Submit" value="  Update Your Group  ">
                    </cfif>
					
				</td>
			</tr>	            
       </form>			
     </table>	
</cfoutput>   

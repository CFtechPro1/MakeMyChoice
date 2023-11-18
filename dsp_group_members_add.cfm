<meta name="robots" content="noindex" />
<meta name="googlebot" content="index" />


<cfparam name="url.members" default=0>
<cfparam name="url.addMember" default=0>
<cfparam name="url.gid" default=0>
<cfparam name="url.md" default=0>
<cfparam name="url.mid" default=0>
<cfparam name="url.updated" default=0>
<cfparam name="url.existed" default=0>
<cfparam name="url.sSortColumn" default="last_name" />
<cfparam name="url.bSortDESC"   default="0" />
<cfparam name="url.nRowsPerPage" default="10" />
<cfparam name="url.nPageToReturn" default="1" />

<script language="javascript">
$(document).ready(function() {
		$("#typedMem").keypress(function(event) {
			if (event.keyCode == '13') {
				event.preventDefault();
				populatetypedMem();
				return false;
			}
		});
		$("#typedMem input[type=text]").blur(function(){
			if ($.trim($(this).val()).length > 0){
				$("#hlpInfo").text('');
				return false;
			}
		});
		
		$("#txtSrchResult").hide();
			if ($('#adminList tr').length == 2){
			$(".readyToAdd").hide();
		}
	});
		
		 
		//Function to remove a Member from the list.
	depopulateDiv=function(id)	{
		$("#" + id).remove();
		if ($('#adminList tr').length == 2){
			$(".readyToAdd").hide();
		}
		if ($("#typedMembers").length){
			$("#f_" + id).remove();
		}
		return false;
	}
	
		//Function to populate member list from the Member search results.
	populateDiv=function(id,userName,firstName,lastName,emailAddress)	{
		if ($("#" + id).length > 0) { 
			$('#overlay_object').jqmShow();
		}else {
			$("#adminList tr:last").after("<tr id=\"" + id + "\"><td class=\"data\"> <a href=\"javascript:\;\" onclick=\"depopulateDiv(" + id + ")\; return false\;\"><img src=\"images/subtract_icon.jpg\" border=\"0\"/></a> </td><td class=\"data\">" + username + "</td><td class=\"data\">"  + firstName + "</td><td class=\"data\">"  + lastName + "</td><td class=\"data\">" + emailAddress  + "<input type=\"hidden\" name=\"" + id + "\" value=\"" + id + "\"></td></tr>");
		}
		$(".readyToAdd").show();
		goToByScroll('txtSrchResult');
	}
	
	//Function to populate People to the Ready to add section that are typed in by the user.
	populateTypedMem=function(firstName,lastName,emailAddress)	{
		var hasError = false;
		$("#typedMem input[type=text]").each(function () {
			//if ($(this).attr('title') !== "Last Name") {
			  if ($(this).val() == ""){
				  $("#hlpInfo").html('Please enter a value for the ' + $(this).attr("title") + ' field').css("color","red");
				  $(this).focus();
				  hasError = true;
				  return false;
			  }
			//}
		});
		if (hasError){
			return false;
		}
		
		//$("#memberTable:contains(emailAddress)").css("text-decoration", "underline"); 

		//alert("test"); 
	
		var firstName = $("#typedMem input[name=firstName]").val();
		var lastName = $("#typedMem input[name=lastName]").val();
		var emailAddress = $("#typedMem input[name=emailAddress]").val();
		
		var totalDiv = $('#typedMembers div').length + 1;
		var n_numDivs = 1;
		/*Look for an empty slot in case previously remove from the middle. */
		
		for (I = 1; I <= totalDiv; I++){
			if (!$("#f_g_" + I).length){
				n_numDivs = I;
				break;
			}
		}

		var uid = 'g_' + n_numDivs;
		$("#adminList tr:last").after("<tr id=\"" + uid + "\"><td class=\"data\"> <a href=\"javascript:\;\" onclick=\"depopulateDiv('" + uid + "')\; return false\;\"><img src=\"images/subtract_icon.jpg\" border=\"0\"/></a></td><td class=\"data\">"  + firstName + "</td><td class=\"data\">"  + lastName + "</td><td class=\"data\">"  + emailAddress + "</td><td bgcolor=\"FFFFFF\"></td></tr>");
		$("#typedMembers").append("<div id='f_" + uid + "'><input type='hidden' name='firstName_" + uid + "' value='" + firstName + "'><input type='hidden' name='lastName_" + uid + "' value='" + lastName + "'><input type='hidden' name='emailAddress_" + uid + "' value='" + emailAddress + "'><input type='hidden' name='uid' value='" + uid +"'></div>");
		$(".readyToAdd").show();
		//goToByScroll('txtSrchResult'); 
	}
	

<!--- 	function memberSubmit() {
		$("#memberForm").submit();
	} --->

 	function memberSubmit() {
		var form = $("#memberForm"); 
		var action = form.attr("action"); 
		var serialized_form = form.serialize(); 
		$("#spinWait").show();
		$.post(action, serialized_form, submit_first); 
	}
	function submit_first(val) { 
		$("#typedMembers").submit(); 
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

            <cfquery name="g" datasource="#application.dsn#">
                SELECT id, mid, group_name
                FROM t_groups 
                	WHERE id = #url.gid#
            </cfquery>



		<body onLoad="MM_preloadImages('images/btn_save_changes_hover.gif','images/btn_add_group_list_hover.gif')"><table width="100%" border="0" cellspacing="1" cellpadding="5" class="dkblue12">
			<tr> 
				<td  class="header" colspan="5">
          			<span class="header_orange">Group Name:</span> <cfoutput>#g.group_name#</cfoutput>
				</td>
			</tr>
			<tr>
				<td colspan="5" align="left" class="sub_menu">
					<cfinclude template="includes/group_submenu.cfm">
				</td>
			</tr>	
			  <cfif url.updated eq 1>
                  <tr> 
                      <td class="alert_text" colspan="5">
                          <span class="stars">***</span> Group Members have been updated. <span class="stars">***</span>
                           <br><br>
                          <span class="stars">***</span> Group invitation emails have been sent to any new people added. <span class="stars">***</span>
                      </td>
                  </tr>
              </cfif>
           </table>
					<!--- ===== add Typed In Member ===== --->
					<form name="typedMem" id="typedMem" action="" method="post">
					<table width="100%" border="0" cellspacing="1" cellpadding="5" class="site_text">         
						<tr>
							<td colspan="8" bgcolor="FFFFFF" align="left">
                            	<strong>1)</strong> Type in the name and email of a person you want to add to this group.
                                <br />
                            	<strong>2)</strong> Click <strong>Add to Group List</strong> to add person to temporary group list.
                                <br />
                            	<strong>3)</strong> Click <strong>Save Changes</strong> to save people to group, and send out invitation emails. 

							</td>
						</tr>
						<tr>
							<td class="admin_search_panel"><strong>First Name:</strong></td>
							<td><input name="firstName" title="First Name" type="text" size="20"/></td>
							<td class="admin_search_panel"><strong>Last Name:</strong></td>
							<td><input name="lastName" title="Last Name" type="text" size="20"/></td>
							<td class="admin_search_panel"><strong>Email:</strong></td>
							<td><input name="emailAddress" title="Email" type="text" size="20"/></td>
						</tr>
						<tr>
							<td colspan="8"  class="submit" align="center">
							<!--- <a href="javascript:;" onClick="populateTypedMem(); return false;" class="bodylink"><img src="images/plus_icon.jpg" border="0" /> Add Person to Group List</a> <span style="color:red">***</span> --->
							
							<a href="javascript:;" onClick="populateTypedMem(); return false;" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('addToList','','images/btn_add_group_list_hover.gif',1)"><img src="images/btn_add_group_list.gif" alt="Add to Group List" name="addToList" width="187" height="45" border="0"></a> 
							&nbsp; <label id="hlpInfo" class="error"><br /></label>
                           	</td>
						</tr>
					</table>
					</form> 
<cfoutput>
	<form name="typedMembers" id="typedMembers" action="components/act_Groups.cfm?gid=#url.gid#&ab_mid=#client.mid#" method="post">
		<div id="typedMemList"> </div>	
		<input type="hidden" name="function" value="typedMembers" />
	</form>
</cfoutput> 

<cfoutput>  
	<form name="memberForm" id="memberForm" action="components/act_Groups.cfm?gid=#url.gid#&ab_mid=#client.mid#&delMembers=1" method="post">         
	<table id="adminList" width="100%" bgcolor="##FFFFFF" border="0" cellspacing="0" cellpadding="5" class="readyToAdd">
    	<tr>
        	<td colspan="5" class="header">
            	Ready To Save
            </td>
        </tr>
		<tr>
			<td class="header_small">Remove</td>
			<td class="header_small">First Name</td>
			<td class="header_small">Last Name</td>       
            <td class="header_small">Email Address</td>      
            <td bgcolor="##FFFFFF" style="width:10%">                  
			<a href="javascript:;" onClick="memberSubmit();return false;" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('saveChanges2','','images/btn_save_changes_hover.gif',1)"><img src="images/btn_save_changes.gif" alt="Save Changes" name="saveChanges2" width="187" height="45" border="0" id="saveChanges2" /></a>
            </td>  
		</tr>
	</table>
		
		<!--- This is where the Group Members display. --->
     		<table width="100%" border="0" cellspacing="1" cellpadding="5" class="dkblue12">
                <tr> 
                    <td  class="header">
                    <strong>Group Members</strong>             
                    </td>
                </tr>	
			</table>
			
				<cfdiv id="memberResult" bind="url:member_list.cfm?gid=#url.gid#" bindonload="true">
			
      <table width="100%" border="0" class="dkblue12" bgcolor="FFFFFF">
          <tr>
              <td class="submit">
			    <a href="javascript:;" onClick="memberSubmit();return false;" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('saveChanges1','','images/btn_save_changes_hover.gif',1)"><img src="images/btn_save_changes.gif" alt="Save Changes" name="saveChanges1" width="187" height="45" border="0" id="saveChanges1" /></a>
			</td>
          </tr>
      </table>
	</form> 
    
    <div id="overlay_object" style="display:none">
    	<div id="overlay_header">
        	Duplicate Email Alert
        </div>
        <div id="overlay_text">
        	You have already added a person with this email adddress.
        </div>
        <div id="overlay_buttons">
        	 <a href="javascript:;" class="cancel_modal">Close</a>
        </div>
    </div>
    
</cfoutput>

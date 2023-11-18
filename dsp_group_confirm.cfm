
<cfparam name="url.gid" default=0>
<cfparam name="url.mid" default=0>
<cfparam name="url.confirmed" default=0>
<cfparam name="url.optout" default=0>
<cfparam name="url.unSure" default=0>
<cfparam name="url.i_mid" default=0>
<cfparam name="url.imid" default=0>

<cfif url.imid neq 0>
		<!--- Log in users automatically if they have been invited to join a group and they are already members. --->
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
		<!--- If they are not members, reroute them to have them sign up first. --->
	<cfoutput>
		<cflocation url="index.cfm?fa=nolog&gid=#url.gid#">
    </cfoutput>
</cfif>

            <cfquery name="group" datasource="#application.dsn#">
                SELECT g.id, g.mid, g.group_name, g.group_desc, m.first_name, m.last_name, m.username
                FROM t_groups g INNER JOIN t_members m
							ON g.mid = m.id
                	WHERE g.id = #url.gid#
            </cfquery>
            <script type="text/javascript">
<!--
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
            <body onLoad="MM_preloadImages('images/bg_btn_hover.gif','images/btn_accept_hover.gif','images/btn_notsure_hover.gif','images/btn_optout_hover.gif')">	



<cfoutput>

		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="site_text">
			<tr> 
				<td class="header" colspan="3">
					<span class="header_orange">Group</span> Membership
				</td>
			</tr>  
         <cfif url.confirmed eq 1>
			<tr> 
				<td class="alert_text" colspan="3">
                	<br><br>
					<span class="stars">***</span> You have CONFIRMED your membership in this group. <span class="stars">***</span>
					<br><br>
                </td>
			</tr>
		</cfif>
 		<cfif url.unSure eq 1>
			<tr> 
				<td class="alert_text" colspan="3">
                	<br><br>
					<span class="stars">***</span> You may decide to decide to become a member of this group at a later time. <span class="stars">***</span>
					<br><br>
                </td>
			</tr>
		</cfif>
         <cfif url.optout eq 1>
			<tr> 
				<td class="alert_text" colspan="3">
                	<br><br>
					<span class="stars">***</span> You have OPTED OUT of this group. <span class="stars">***</span>
					<br><br>
                </td>
			</tr>
		</cfif>
  			 <tr> 
				<td colspan="3" class="header3">
					Please Choose an option for the Group below.
				</td>            
			</tr>      	
            <tr>
                 <td class="form_instruct" colspan="3">
                  	You have been invited to become a member of the group:
					<br><br>
                       <span class="site_hdr">Group Name: &nbsp; <strong>#group.group_name#</strong></span> &nbsp; &nbsp; created by: 
					   <cfif group.first_name neq "" OR group.last_name neq "">
					   		<strong>#group.first_name# #group.last_name#</strong>
					   <cfelse>
					   		<strong>#group.username#</strong>
					   </cfif>
              	</td>
          	</tr> 
  			 <tr> 
				<td colspan="3" class="alert_text">
					<strong>Group Description:</strong><br>
					#group.group_desc#
				</td>            
			</tr> 			
            <tr>
				<td align="center"  style="width:33%;padding:10px;">
					<a href="actions/act_Groups.cfm?gid=#url.gid#&mid=#url.mid#&i_mid=#url.i_mid#&function=accept" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('accept','','images/btn_accept_hover.gif',1)"><img src="images/btn_accept.gif" alt="Accept Invitation" name="accept" width="187" height="45" border="0"></a>
				</td>
				<td align="center" style="width:33%;padding:10px;">
		      		<a href="actions/act_Groups.cfm?gid=#url.gid#&mid=#url.mid#&i_mid=#url.i_mid#&function=notSure" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('notSure','','images/btn_notsure_hover.gif',1)"><img src="images/btn_notsure.gif" alt="Not Sure" name="notSure" width="187" height="45" border="0"></a>	
				</td>
				<td align="center" style="width:33%;padding:10px;">
					<a href="actions/act_Groups.cfm?gid=#url.gid#&mid=#url.mid#&i_mid=#url.i_mid#&function=optOut" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('optOut','','images/btn_optout_hover.gif',1)"><img src="images/btn_optout.gif" alt="Opt Out" name="optOut" width="187" height="45" border="0"></a>
				</td>
			</tr>	
 			<tr>
				<td class="basic_td" colspan="3">
				<br><br>
				<!--- <li><a href="groups/index.cfm?fa=dsp_home" class="bodylink">More info about this Group.</a></li> --->
				</td>
			</tr> 
		</table>

 </cfoutput>
<head>
<script Language="JavaScript">
<!--
function FrontPage_Form1_Validator(theForm)
{
  if (theForm.terms.checked == false)
  {
    alert("Please READ & AGREE to the \"Terms and Conditions\".");
    theForm.terms.focus();
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
</head>

<cfparam name="url.remind" default=0>
<cfparam name="url.mid" default=0>
<cfparam name="url.cid" default=0>
<cfparam name="url.nolog" default=0>
<cfparam name="url.gid" default=0>


		<body onload="MM_preloadImages('images/btn_continue_hover.gif')"><table width="100%" border="0" cellspacing="1" cellpadding="3" class="site_text">
		
			<tr> 
				<td class="header" colspan="2">
					<span class="header_orange">Sign Up</span> for MakeMyChoice.com
				</td>
			</tr>
			<tr> 
				<td  colspan="2" class="alert_text">
					<span class="stars">***</span> Please begin the <strong>Sign Up</strong> process below <span class="stars">***</span>
				</td>
			</tr>	
 		<cfif url.nolog eq 1>
			<tr> 
				<td class="alert_text" colspan="4">
                <br><br>
					<span class="red_stars">***</span> You must be a member of MakeMyChoice.com in order to give feedback. <span class="red_stars">***</span>
					<br><br>
					<span class="stars">***</span> You can easily sign up below.  <span class="stars">***</span>
					<br><br>
                </td>
			</tr>
		</cfif>
		<cfif url.remind eq 1>
			<tr> 
				<td  class="alert_text">
					<font color="red">***</font> Please accept the terms below in order to proceed. <font color="red">***</font>
				</td>
			</tr>
		</cfif>	
   	<cfoutput>
			<form action="index.cfm?fa=username&cid=#url.cid#&mid=#url.mid#&gid=#url.gid#" name="FrontPage_Form1" onsubmit="return FrontPage_Form1_Validator(this)" method="post">
	</cfoutput>	
            <tr> 
				<td  align="left" valign="bottom">
               <br /><br />
               Please Read the Terms & Conditions below, then click on the checkbox, and click on the "Continue" button below.
               <br /><br />
          		<li><a href="mmc_terms.html" target="new" class="bodylink">Terms & Conditions</a></li>
                <br /><br />


<span class="stars">*</span> I accept the above terms and conditions <input type="checkbox" name="terms" value="yes">
				
				<br /><br />
				</td>
			</tr>

			<tr>
				<td class="submit">
					<a href="javascript:;" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('ContinueLegal','','images/btn_continue_hover.gif',1)"><input type="image" src="images/btn_continue.gif" alt="Continue" name="ContinueLegal" width="189" height="46" border="0" id="ContinueLegal" /></a>
				</td>
			</tr>	
			</form>
            <tr>
            	<td class="basic_td">&nbsp;
                	
                </td>
            </tr>
		</table>	
	
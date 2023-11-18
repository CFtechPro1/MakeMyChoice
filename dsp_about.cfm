<script type="text/javascript">

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

</script>

<cfparam name="url.text" default="0">
		
<body leftmargin=0 topmargin=0 rightmargin=0 bottommargin=0 marginwidth=0 marginheight=0 onload="MM_preloadImages('images/about_1.gif','images/about_2.gif','images/about_3.gif','images/about_4.gif','images/about_5.gif','images/about_6.gif')">		
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="site_text">
		
 			<tr> 
				<td  class="header">
					<span class="header_orange">About</span> MakeMyChoice.com
				</td>
			</tr> 
		<cfif url.text eq 0> 
			<tr>
				<td align="right">
                	<a href="index.cfm?fa=about&text=1" class="bodylink">plain text version</a>
				</td>
			</tr>			      	          
			<tr>
				<td valign="top" align="left">
                	<img src="images/about_1.gif" border="0" />
				</td>
			</tr>
			<tr>
				<td valign="top" align="left">
                	<img src="images/about_2.gif" border="0" />
				</td>
			</tr>
			<tr>
				<td valign="top" align="left">
                	<img src="images/about_3.gif" border="0" />
				</td>
			</tr>
			<tr>
				<td valign="top" align="left">
                	<img src="images/about_4.gif" border="0" />
				</td>
			</tr>
			<tr>
				<td valign="top" align="left">
                	<img src="images/about_5.gif" border="0" />
				</td>
			</tr>
			<tr>
				<td valign="top" align="left">
                	<img src="images/about_6.gif" border="0" />
				</td>
			</tr>
		<cfelse>
			<tr>
				<td class="page_desc">
                	We find ourselves faced with making so many challenging choices and decisions in our lives. Whether they have to do with relationships, career, workplace, family matters, or just day to day situations. Our lives really compromise a vast and unending series of choices big and small.
					<br /><br />
					We developed MakyMyChoice.com because we felt that, we as choice makers, needed better  and easier access to "social feedback networks" a term coined by our associate, Jonathan, when he was trying to describe what MakeMyChoice actually is.
					<br /><br />
					We have enjoyed the process of developing MakeMychoice.com into a platform for anyone to get and give unbiased feedback regarding any choices or decisions they need to make in their lives. Members can add "answer options" for their choice, much like they are creating a survey. This gives people the opportunity to really think about their decision, and what are some possible resolutions, before posting it. Members can also remain anonymous when posting a new question. This allows people to bring up topics they may not want to discuss with people they know.
					<br /><br />
					We have also added many new features to the "Groups" section. Members can now create a MakeMychoice Group for any organization, business, or for friends or family. Groups can be public or private, each group has a unique homepage, and groups provide a great way for people to get feedback about choices & decisions from only a specific cross-section of members.
					<br /><br />
					If you have any questions about how to use MakeMyChoice.com don't hesitate to contact us and well be happy to provide you with assistance as quickly as possible. 
					Thank you for signing up, and we sincerely hope our site aides in helping you make the best possible choices in your life!
					<br /><br />
					Sincerely,
					<br /><br />
					The MakeMyChoice Team
					<br /><br />
				</td>
			</tr>		
		</cfif>	
		</table>
</body>
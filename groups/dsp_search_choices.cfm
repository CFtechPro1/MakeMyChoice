<head>
 	   <script type="text/javascript">
<!--- 			fnSearch=function() {
				//alert("test");
         	ColdFusion.Ajax.submitForm("choiceSearch", "choice_list.cfm");
			} --->
			
		fnSearch=function() {
		ColdFusion.Ajax.submitForm("FormSearch", "choice_list.cfm", 
		function(data){
			$("#SearchResult").html(data);
			},'','GET');
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
	</head>

        <cfparam name="url.keywords" default="">
        <cfparam name="url.categories" default="">
	
	            <cfquery name="cats" datasource="#application.dsn#">
                    SELECT c.id, c.cat_name
                    FROM t_categories c
                </cfquery>	


           <body onLoad="MM_preloadImages('../images/btn_submit_hover.gif')">
		   <form id="choiceSearch" method="get">
		   <table width="100%" border="0" cellspacing="0" cellpadding="0" class="site_text">
              
                 <tr> 
                    <td class="header" colspan="4">
                        <span class="header_orange">Search</span> Group Choices
                    </td>
                  </tr>
				<tr> 
					<td colspan="4" class="page_desc">       
						You can search this group's choices and decisions below. Search using a keyword or by selecting different categories. 
					</td>
				</tr>  
			</table>
			<table width="100%" border="0" cellspacing="5" cellpadding="0" class="site_text">
				 <tr>
				  	<td colspan="1" class="form_instruct">
						Keywords:   
					</td>
					<td colspan="3" valign="middle">
						<input type="text" name="keywords" size="30">
					</td>
				 </tr> 
				 <tr>
  					 <td class="form_instruct" colspan="4">
                         Click on the checkbox next to the categories you want included in your search results.
                     </td>
				 </tr>
				<cfoutput>
					  <tr>
						  <td align="left" width="25%" class="site_text" nowrap="nowrap">
							  <cfloop query="cats" startrow="1" endrow="10">
								 <input type="checkbox" name="categories" value="#cats.id#"> &nbsp; #cats.cat_name#<br>
							  </cfloop>
						  </td>
						  <td align="left" width="25%" class="site_text" nowrap="nowrap">
							  <cfloop query="cats" startrow="11" endrow="20">
								 <input type="checkbox" name="categories" value="#cats.id#"> &nbsp; #cats.cat_name#<br>
							  </cfloop>
						  </td> 
						  <td align="left" width="25%" class="site_text" nowrap="nowrap">
							  <cfloop query="cats" startrow="21" endrow="30">
								 <input type="checkbox" name="categories" value="#cats.id#"> &nbsp; #cats.cat_name#<br>
							  </cfloop>
						  </td>       
						  <td align="left" width="25%" class="site_text" nowrap="nowrap">
							  <cfloop query="cats" startrow="31" endrow="40">
								 <input type="checkbox" name="categories" value="#cats.id#"> &nbsp; #cats.cat_name#<br>
							  </cfloop>
						  </td>    
					  </tr>	
					</cfoutput>	 

                  <tr> 
                      <td colspan="4" class="submit">                    
						<a href="javascript:;" onclick="fnSearch();return false;" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('submit','','../images/btn_search_hover.gif',1)"><img src="../images/btn_search.gif" alt="Submit" name="submit" width="187" height="45" border="0" id="submit" /></a>   
                      </td>
                  </tr>   
          	</table>  
		  </form>
		  
		  <cfif url.keywords neq "" AND url.categories neq "">
		  	<cfdiv id="SearchResult" bind="url:choice_list.cfm?keywords={#url.keywords#}&categories={#url.categories#}" bindonload="true">
		  <cfelseif url.keywords neq "" AND url.categories eq "">
		  	<cfdiv id="SearchResult" bind="url:choice_list.cfm?keywords={#url.keywords#}&categories={categories}" bindonload="true">
		  <cfelseif url.keywords eq "" AND url.categories neq "">
		  	<cfdiv id="SearchResult" bind="url:choice_list.cfm?keywords={keywords}&categories={#url.categories#}" bindonload="true">
		  <cfelse>
		  	<cfdiv id="SearchResult" bind="url:choice_list.cfm?keywords={keywords@blur}&categories={categories}" bindonload="false">
		  </cfif>
		  
		  
		  
		  
		  
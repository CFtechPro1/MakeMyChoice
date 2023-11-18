		<!--- Get the top ten most recent choices the member is eligible for providing feedback on from the public. --->
		<cfquery name="recent_everyone" datasource="#application.dsn#">
			SELECT c.id, c.mid, c.username, c.short_desc, c.date_created, c.anon, r.request_type
			FROM t_choices c INNER JOIN
            	t_requests r ON c.id = r.cid
                	WHERE r.request_type = 'everyone'
                            AND c.date_end > GETDATE()
			ORDER BY c.id DESC
		</cfquery>		
		<table width="100%" border="0" cellspacing="0" cellpadding="5" bgcolor="FFFFFF">
              <tr>
                <td bgcolor="e9f2fe" align="center" valign="top" nowrap width="100%" align="center">
    				<a href="index.cfm?fa=new_choice" class="menulink">Create New Choice</a>
                    &nbsp;|&nbsp;
                   <a href="index.cfm?fa=my_feedback" class="menulink">Give Feedback on Choices</a>
                    &nbsp;|&nbsp;
                    <a href="index.cfm?fa=search_engine&m=0" class="menulink">Search Members & Choices</a>
                </td>
            </tr>
  	
     		
		</table> 
        <table cellspacing="1" cellpadding="5" class="dkblue12" bgcolor="336699" width="670">
            <tr>
                <td bgcolor="CCCCCC">
                    Answer Questions, help make Choices & Decisions below
                </td>
                <td bgcolor="CCCCCC" nowrap>
                    Date Created
                </td>
                <td bgcolor="CCCCCC">
                    Created By
                </td>
             </tr>
            <cfoutput query="recent_everyone" maxrows="10">
					<script language="javascript">
                        function getUrl#recent_everyone.id#()  {
                            window.location="index.cfm?fa=choice_feedback&cid=#recent_everyone.id#&mid=#recent_everyone.mid#"; 
                        }
                    </script>  
                             
            	<cfif currentRow MOD 2>  
					<cfset rowClass = "rowOdd" />  
                <cfelse>  
                	<cfset rowClass = "rowEven" />  
                </cfif>  

                <tr class="#rowClass#" onmouseover="this.className='rowHighlight'" onmouseout="this.className='#rowClass#'" onclick="getUrl#recent_everyone.id#()">  

                    <td width="459">
                        <a href="index.cfm?fa=choice_feedback&cid=#recent_everyone.id#&mid=#recent_everyone.mid#" class="choicelink">#recent_everyone.short_desc#</a>
                    </td>
                    <td width="101">
                        #DateFormat(recent_everyone.date_created, "mm/dd/yyyy  hh:mm")#
                    </td>
                    <td width="101">
                        <cfif recent_everyone.anon eq 0>
                            <a href="index.cfm?fa=profile&mid=#recent_everyone.mid#" class="choicelink">#recent_everyone.username#</a>  
                        <cfelse>
                            Anonymous Member
                        </cfif> 
                    </td>
                 </tr>
            </cfoutput>
            <tr> 
				<td colspan="3" align="right" bgcolor="e9f2fe">
				<cfif recent_everyone.recordcount gt 10> » <a href="index.cfm?fa=more_choices" class="bodylink">More Choices & Decisions</a> &nbsp;	» <a href="index.cfm?fa=about" class="bodylink">How do I use MakeMyChoice.com?</a>  </cfif>  
				</td>
			</tr>
        </table>     
                    			


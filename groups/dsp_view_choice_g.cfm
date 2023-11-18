<script type="text/javascript" src="http://mediaplayer.yahoo.com/js"></script>

<cfparam name="url.cid" default=0>
<cfparam name="url.mid" default=0>
<cfparam name="url.added" default=0>
<cfparam name="url.feedback" default=0>
<cfparam name="url.cd" default=0>
<cfparam name="url.comment" default=0>
<cfparam name="url.emails" default=0>
<cfparam name="url.imid" default=0>
<cfparam name="url.gid" default=0>

	<cfif url.imid neq 0>
		<!--- Log in users automatically if are already members. --->
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


		<cfquery name="choice" datasource="#application.dsn#">
			SELECT short_desc, details, type, date_end, anon
            FROM t_choices
            WHERE id = #url.cid#
		</cfquery>	
        
        <cfquery name="comments" datasource="#application.dsn#">
			SELECT c.id, c.mid, c.username, c.cid, c.comment_text, c.s_mid, c.s_username, c.date_created, c.deleted,
            		m.image, m.quote
            FROM t_comments c INNER JOIN
            		t_members m ON c.s_mid = m.id
            WHERE c.cid = #url.cid#
            	AND c.deleted = 0
                ORDER BY c.date_created
		</cfquery>	
		
		<cfquery name="answers" datasource="#application.dsn#">
			SELECT id, answer_text, answer_filename, answer_caption, link_title, type, order_num  
            FROM t_answers
            WHERE cid = #url.cid#
		</cfquery>	
	
		<cfquery name="member" datasource="#application.dsn#">
			SELECT id, username, first_name, last_name, email_address
            FROM t_members
            WHERE id = #url.mid#
		</cfquery>	
        
        <cfquery name="feedback_total" datasource="#application.dsn#">
			SELECT aid 
            FROM t_feedback
            WHERE cid = #url.cid#
            	AND mid = #url.mid#
		</cfquery>	
        
       		 <cfif answers.recordcount eq 0>
                 <cfquery name="comment_members" datasource="#application.dsn#">
                    SELECT DISTINCT c.username
                    FROM t_comments c
                    WHERE c.cid = #url.cid#
                        AND c.deleted = 0
                </cfquery>
             </cfif>	   
			
            <!--- Get the highest number of votes for an answer for this choice. --->
            <cfoutput>
			<cfset MaxArray = ArrayNew(1)>     
            <cfset MaxArray[1] = "0">      
			<cfloop query="answers">
            	<cfquery name="fb" datasource="#application.dsn#">
                    SELECT aid 
                    FROM t_feedback
                    WHERE cid = #url.cid#
                        AND mid = #url.mid#
                        AND aid = #answers.id#
            	</cfquery>	               
                <cfset ArrayAppend(MaxArray, fb.recordcount)>    
            </cfloop>
            <cfset variables.max_chosen = ArrayMax(MaxArray)>
            </cfoutput>
            

<cfoutput>
		<table width="100%" border="0" cellspacing="5" cellpadding="5" class="site_text">			 
       	<cfif url.added eq 1>
			<tr> 
				<td class="alert_text" colspan="4">
					<span class="stars">***</span> Your new Choice has been sent out for Feedback! <span class="stars">***</span>
					<br><br>
					<span class="stars">***</span> Below is what <strong>people will see AFTER</strong> they provide feedback.<span class="stars">***</span>
					<br>
                    |  <a href="http://www.MakeMyChoice.com/index.cfm?fa=choice_feedback&mid=#url.mid#&cid=#url.cid#&gid=#url.gid#" class="bodylink">click here to see the feedback page</a> |
                </td>
			</tr>
		</cfif>
       	<cfif url.feedback eq 1>
			<tr> 
				<td class="alert_text" colspan="4">
					<span class="stars">***</span> Thank You! Your Feedback as been recorded. <span class="stars">***</span>
					<br><br>
					<span class="stars">***</span> Below you can see which answer is winning. <span class="stars">***</span>
					<br><br>
                </td>
			</tr>
		</cfif>
       	<cfif url.cd eq 1>
			<tr> 
				<td class="alert_text" colspan="4">
               		 <br><br>
					<span class="stars">***</span> The comment has been deleted. <span class="stars">***</span>
					<br><br>
                </td>
			</tr>
		</cfif>
       	<cfif url.comment eq 1>
			<tr> 
				<td class="alert_text" colspan="4">
               		 <br><br>
					<span class="stars">***</span> Your comment has been added below. <span class="stars">***</span>
					<br><br>
                </td>
			</tr>
		</cfif>
       	<cfif url.emails eq 1>
			<tr> 
				<td class="alert_text" colspan="4">
               		<br><br>
						<span class="stars">***</span> Your Choice has been emailed to the "non-member" people you entered. <span class="stars">***</span>
					<br><br>
                </td>
			</tr>
		</cfif>
            <tr> 
				<td class="header" colspan="4">
					Results for <cfif choice.anon eq 0>#member.username#<cfelse>Anonymous Member</cfif>'s Choice or Decision
				</td>
			</tr>
            <tr> 
				<td class="choice_instruct">
					Choice or Desicion:
				</td>
 				<td class="choice_short_desc" colspan="3">
					#choice.short_desc#
				</td>               
			</tr>
            <tr> 
				<td class="choice_instruct">
					More Info:
				</td>
 				<td class="basic_td" colspan="3">
					#choice.details#
				</td>               
			</tr>
       <cfif answers.recordcount neq 0>
            <tr> 
				<td class="column_header" width="100">
					Answer No.
				</td>
				<td class="column_header" width="550">
					Answer Option
				</td> 
                <td class="column_header" width="50">
					Times Chosen
				</td> 
                <td class="column_header" width="50">
					Percentage
				</td>             
			</tr>
        <cfelse>
             <tr> 
				<td width="100">
					<p class="med-spacer">&nbsp;</p>
				</td>
				<td  width="550">
					<p class="med-spacer">&nbsp;</p>
				</td> 
                <td  width="50">
					<p class="med-spacer">&nbsp;</p>
				</td> 
                <td  width="50">
					<p class="med-spacer">&nbsp;</p>
				</td>             
			</tr>       
		</cfif>

        <cfloop query="answers">
        
            <cfquery name="feedback" datasource="#application.dsn#">
                SELECT aid 
                FROM t_feedback
                WHERE cid = #url.cid#
                    AND mid = #url.mid#
                    AND aid = #answers.id#
            </cfquery>	        	
            
                <tr> 
                    <td class="choice_instruct">
                        <p class="med-spacer">&nbsp;</p>
                            Answer #answers.order_num#
                        <p class="med-spacer">&nbsp;</p>
                    </td>
					<cfif answers.type eq "text">
                    	<cfif choice.type eq "multiple">
                            <td class="choice_text" width"400"> 
                                <p class="med-spacer">&nbsp;</p>
                                    #answers.answer_text#
                                <p class="med-spacer">&nbsp;</p> 
                            </td> 
                         <cfelseif choice.type eq "yesno">
                            <td class="yesno_text" width"400"> 
                                <p class="med-spacer">&nbsp;</p>
                                    #answers.answer_text#
                                <p class="med-spacer">&nbsp;</p> 
                            </td>                          
                         </cfif>                          
					<cfelseif answers.type eq "image">
                    	<td width"400" class="image_td"> 
							<img src="../media/#member.id#/#answers.answer_filename#" />  
                        </td>
                    <cfelseif answers.type eq "mp3">
                     	<td width"400" class="image_td"> 	
							<a href="../media/#member.id#/#trim(answers.answer_filename)#" target="new" class="bodylink" ></a><strong>#answers.link_title#</strong><br />
                            <span class="dkblue10">(To preview, click on little play button above)</span> 
                        </td>  
                  	<cfelseif answers.type eq "document">
                     	<td width"400" class="image_td"> 	
							<a href="../media/#member.id#/#trim(answers.answer_filename)#" target="new" class="bodylink" ></a><strong>#answers.link_title#</strong><br />
                            <span class="dkblue10">(To preview, Click on link above)</span> 
                        </td>                                            	              
                    </cfif>   
                    <td class="choice_text">       	
						<cfif feedback.recordcount eq 0>
                            0 
                        <cfelse>
                            <cfif feedback.recordcount neq variables.max_chosen> 
                                #feedback.recordcount# 
                            <cfelse>
                                <span style="background-color:##99FFFF"> #feedback.recordcount#  </span>
                            </cfif>   
                        </cfif>    	    	 
                    </td>
                    <td class="choice_text"> 
                        <cfif feedback.recordcount eq 0>
                            0%
                        <cfelse>
                            <cfif feedback.recordcount neq variables.max_chosen> 
                                #NumberFormat((feedback.recordcount / feedback_total.recordcount) * 100, "99")#%
                            <cfelse>
                                <span style="background-color:##99FFFF">#NumberFormat((feedback.recordcount / feedback_total.recordcount) * 100, "99")#%  </span>   
                            </cfif>
                        </cfif>                                
                    </td>               
                </tr>
		</cfloop>   
                
			 <tr> 
				<td colspan="4" class="submit" align="right">
					<cfif answers.recordcount neq 0>
                        TOTAL FEEDBACK: <strong>#feedback_total.recordcount# Members</strong>  &nbsp;  &nbsp; Choice must be made by <strong>#choice.date_end#</strong>
                    <cfelse>
                    	TOTAL FEEDBACK: <strong>#comment_members.recordcount# Members</strong>  &nbsp;  &nbsp; Choice must be made by <strong>#choice.date_end#</strong>
                    </cfif>
                </td>            
			</tr>	
	<cfif client.mid eq url.mid>
			 <tr> 
				<td colspan="4" class="form_input" align="right">
					<li> <a href="../index.cfm?fa=request_nonmembers&amp;mid=#client.mid#&amp;cid=#url.cid#&gid=#url.gid#" class="bodylink">Request Feedback from people who are not yet Members.</a><br />
				</td>            
			</tr>    	
    </cfif>
		<tr>
        	<td>
            	<p class="small-spacer">&nbsp;</p>
            </td>
        </tr>
     <cfif comments.recordcount neq 0>
            <tr> 
				<td class="header" colspan="4">
					Comments about <cfif choice.anon eq 0>#member.username#<cfelse>Anonymous Member</cfif>'s Choice or Decision
				</td>
			</tr>
             <tr> 
				<td  class="header_small" nowrap="nowrap">
					Posted By
				</td>
                <td  class="header_small" colspan="3">
					Comment
				</td>
			</tr>	
        
         <cfloop query="comments">
             <tr> 
				<td class="comments_instruct">
					<span class="dkblue12"><a href="../index.cfm?fa=profile&amp;mid=#comments.s_mid#" class="bodylink">#comments.s_username#</a></span>
					<cfif comments.image neq "">
                    	<br>
                    	<a href="../index.cfm?fa=profile&amp;mid=#comments.s_mid#" class="bodylink"><img src="../media/#comments.s_mid#/#comments.image#" width="75" height="75" border="0"></a>
                    </cfif>                  
				</td>
 				<td class="basic_td_top" <cfif client.mid eq url.mid>colspan="2"<cfelse>colspan="3"</cfif>>
					#trim(comments.comment_text)#
				</td>
			<!--- <cfif client.mid eq url.mid>    --->         
                <td class="basic_td" valign="top" align="right">
                	<a href="../actions/act_deleteItem.cfm?comment_id=#comments.id#&amp;cid=#url.cid#&mid=#url.mid#&amp;item=comment&gid=#url.gid#" class="tinylink" onclick="return confirm('Are you sure you want to delete this comment?')">delete comment</a>
                </td>
            <!--- </cfif>  --->              
			</tr>  

        </cfloop>       
        
		<tr>
        	<td>
            	<p class="med-spacer">&nbsp;</p>
            </td>
        </tr> 
  	<cfif client.mid neq url.mid>
			 <tr> 
				<td colspan="4" class="form_input" align="right">
					<li> <a href="../index.cfm?fa=new_message&mid=#url.mid#&cid=#url.cid#&subject=#choice.short_desc#" class="bodylink">Send this Member a Private Message.</a><br />	
				</td>            
			</tr>  
            <tr>
        	<td>
            	<p class="med-spacer">&nbsp;</p>
            </td>
        </tr>
    </cfif>     
      </cfif>  
   
   <cfif client.mid  neq 0>
      <form action="../actions/act_Comment.cfm" method="post">
            <tr> 
				<td class="choice_instruct">
					Post Comment
				</td>
 				<td class="form_input" colspan="3">
					<textarea name="comments" cols="70" rows="4"></textarea>
                  	<br />
                    (Abusive posts will not be tolerated, and may result in membership revocation)
                            	
                    <input type="hidden" name="cid" value="#url.cid#">
                    <input type="hidden" name="mid" value="#url.mid#">
					<input type="hidden" name="gid" value="#client.gid#">
                    
                    <input type="submit" value="Post Comment" />
				</td>               
			</tr>  
      </form>   
  </cfif>
      	<tr>
        	<td>
            	<p class="med-spacer">&nbsp;</p>
            </td>
        </tr>         
   </table>


</cfoutput>
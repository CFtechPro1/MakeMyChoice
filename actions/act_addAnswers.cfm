<cfparam name="form.type" default="0">
	
	
<cfif form.type eq "text">
    
      <cfloop from="1" to="#form.num_of_answers#" index="i">
			
            <cfset formAnswer = evaluate("form.answer_" & i)>
         	<cfset counter = 0>
			
		 <cfif formAnswer neq "">
		    
            <cfquery name="answersIn" datasource="#application.dsn#">
                INSERT INTO t_answers
                (cid, mid, answer_text, type, order_num)
                VALUES
                ('#form.cid#', '#client.mid#', '#formAnswer#', '#form.type#', '#i#')
            </cfquery>	

        </cfif>
		
       </cfloop>

       		<cfoutput>
                <cflocation url="../index.cfm?fa=request_feedback&cid=#form.cid#&added=1">
            </cfoutput>
		

</cfif> 
	



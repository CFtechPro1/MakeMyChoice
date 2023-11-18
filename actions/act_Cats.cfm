


<cfparam name="form.function" default=0>


	<cfif form.function eq "chooseCats">
    
 
    	<!--- Delete previous choices for this member. --->
        <cfquery name="del" datasource="#application.dsn#">
            DELETE t_member_cats 
            WHERE mid = #client.mid#
        </cfquery>	    	
	
          
         <!--- If the checkbox form field exists for the category, add it for this member. --->                 
     	<cfloop list="#form.fieldnames#" index="i">
        	<cfif i does not contain "function" AND i does not contain "save">
                <cfquery name="ins_cat" datasource="#application.dsn#">
                    INSERT INTO t_member_cats
                    	(mid, cat_id)
                    VALUES (#client.mid#, #i#)
                </cfquery>	            	
            </cfif>
        </cfloop>   
           
            <cfoutput>
                <cflocation url="../index.cfm?fa=my_profile&updated=1">
            </cfoutput>
            
	</cfif>
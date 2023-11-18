<cfoutput>
<cfset dateNow = "03/24/1972">
#DateDiff("yyyy", dateNow, DateFormat(Now(),'mm/dd/yyy'))#

<cfset variables.dob = evaluate(dateNow & "/" & dateNow & "/" & dateNow)>



</cfoutput> 


		<cfquery name="members" datasource="#application.dsn#">
			SELECT     m.id as mid, DATEDIFF(YEAR,m.DOB,GETDATE()) as age, m.name
                      
			FROM         t_member_test m 
			WHERE     (1 = 1)  

                	 AND DATEDIFF(YEAR,m.DOB,GETDATE()) > 2 


           		ORDER BY m.id DESC

		</cfquery>
        
        
    <cfoutput query="members">    
        #members.age#  <br />
    </cfoutput>

<cfparam name="url.mid" default=0>


<cfoutput>
    <cfloop from="1" to="10" index="i">
        
        <cfif evaluate('form.name_' & i) neq "" AND evaluate('form.email_' & i) neq "">
        
        <cfif client.email neq 0>
             
<cfmail from="#client.email_address#" to="#evaluate('form.email_' & i)#" subject="Re: MakeMyChoice.com - Check this out!">
            
Hi #evaluate('form.name_' & i)#,
                
#form.m_text#
                
                
www.MakeMyChoice.com allows you to get feedback on all your choices and decisions.
                
Please go to the link below and you can very quickly sign up.
You will then be able to get feedback on all your choices and decisions as well as giving 
assistance to #client.name#.

http://www.MakeMyChoice.com/index.cfm?fa=sign_up


#client.name#
                    
</cfmail>	 
			
            <cfelse>
            
<cfmail from="info@MakeMyChoice.com" to="#evaluate('form.email_' & i)#" subject="Re: MakeMyChoice.com - Check this out!">
            
Hi #evaluate('form.name_' & i)#,
                
#form.m_text#
                
Someone that knows you has seggested that you check out this website:              
www.MakeMyChoice.com 
It allows you to get feedback on all your choices and decisions.
                
Please go to the link below and you can very quickly sign up.
You will then be able to get feedback on all your choices and decisions as well helpiing other people 
make choices and decisions.

http://www.MakeMyChoice.com/index.cfm?fa=sign_up


www.MakeMyChoice.com
Make Great Choices!
                    
</cfmail>	            
            
            </cfif>
        
        </cfif> 
     
     </cfloop>
 </cfoutput>           
            <cfoutput>
                <cflocation url="../index.cfm?fa=invite_people&sent=1">
            </cfoutput>
            

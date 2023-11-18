

<cfparam name="form.function" default=0>

	<!--- Call Component/function to ADD A MEMBER --->
<cfif form.function eq "addMember">

	<cfif form.botcatcher neq "">
		<cflocation url="../index.cfm?fa=username&bot=1">
	</cfif> 
	
    <cfparam name="form.referred_by" default="">
    <cfparam name="form.children" default=0>
    <cfparam name="form.profession" default="">
    <cfparam name="form.hobbies" default="">
    <cfparam name="form.cultural_heritage" default="">
    <cfparam name="form.other_heritage" default="">
	
	    <cfset catList = "">
    	<cfloop list="#form.fieldnames#" index="i">
        	<cfif i CONTAINS "cat_">
            	<cfset catList = ListAppend(catList, evaluate('form.' & i))>
            </cfif>
        </cfloop>

<!---  		<cfoutput>
			#catList#
		</cfoutput>
		<cfabort>  --->
	    
	<cfscript>
		objAddMember = createObject("component","MembersCFC");
		isAdded = objAddMember.addMember(form.first_name, form.last_name, form.username, form.password, form.email_address, 
				form.country, form.zip_code, form.birth_month, form.birth_day, form.birth_year, form.gender, form.marital_status, 
				form.cultural_heritage, form.other_heritage, form.children, form.hobbies, form.profession, form.referred_by, 
				form.cid, form.mid, form.remote_addr, form.remote_ident, catList, form.gid);
	</cfscript>
	
</cfif>

<cfif form.function eq "login">

    <cfparam name="form.mid" default=0>
    <cfparam name="form.cid" default=0>
	<cfparam name="form.gid" default=0>
    	<!--- these two vars are only if coming from a choice feedback page. --->    	
        
	<cfscript>
		objMemberLogin = createObject("component","MembersCFC");
		isLogged = objMemberLogin.memberLogin(form.username, form.password, form.mid, form.cid, form.gid); 
	</cfscript>
	
</cfif>

<cfif form.function eq "changePassword">

	<cfscript>
		objMemberChange = createObject("component","MembersCFC");
		isLogged = objMemberChange.changePassword(form.email_address, form.old_password, form.new_password, form.new_password2); 
	</cfscript>
	
</cfif>

<cfif form.function eq "resendPassword">

	<cfscript>
		objMemberResend = createObject("component","MembersCFC");
		isLogged = objMemberResend.resendPassword(form.email_address); 
	</cfscript>
	
</cfif>

	<!--- Call Component/function to UPDATE a MEMBER Profile --->
<cfif form.function eq "updateMember">
	
    <cfparam name="form.d_first_name" default=0>
    <cfparam name="form.d_email_address" default=0>
    <cfparam name="form.d_country" default=0>
    <cfparam name="form.d_zip_code" default=0>
    <cfparam name="form.d_gender" default=0>
    <cfparam name="form.d_marital_status" default=0>
    <cfparam name="form.d_cultural_heritage" default=0>
    <cfparam name="form.d_children" default=0>
    <cfparam name="form.d_hobbies" default=0>
    <cfparam name="form.d_profession" default=0>
    <cfparam name="form.d_dob" default=0>
    

	<cfscript>
		objUpdateMember = createObject("component","MembersCFC");
		isUpdated = objUpdateMember.updateMember(form.first_name, form.last_name, form.username, form.password, form.email_address, 
				form.country, form.zip_code, form.gender, form.marital_status, 
				form.cultural_heritage, form.children, form.hobbies, form.profession, form.birth_month, form.birth_day, form.birth_year,
				form.d_first_name, form.d_email_address, 
				form.d_country, form.d_zip_code, form.d_gender, form.d_marital_status, 
				form.d_cultural_heritage, form.d_children, form.d_hobbies, form.d_profession, form.d_dob);
	</cfscript>
	
</cfif>


<!--- Call Component/function to UPDATE a MEMBER's DETAILS on Profile --->
<cfif form.function eq "updateDetails">

	<cfscript>
		objUpdateDetails = createObject("component","MembersCFC");
		isUpdated = objUpdateDetails.updateDetails(form.details); 
	</cfscript>
	
</cfif>

	<!--- Call Component/function to ADD AN ORG --->
<cfif form.function eq "orgSignup">

	<cfif form.botcatcher neq "">
		<cflocation url="../index.cfm?fa=signup_org&bot=1">
	</cfif> 
	
    	<cfquery name="org" datasource="#application.dsn#">
			SELECT orgid, org_name
			FROM t_orgs
			WHERE org_name = '#trim(form.org_name)#'
		</cfquery>     

		<cfif org.recordcount gt 0>
        	<cfoutput>
            	<cflocation url="../index.cfm?fa=signup_org&existing=1">
            </cfoutput>
        </cfif>
    
	<cfscript>
		objAddOrg = createObject("component","MembersCFC");
		isAdded = objAddOrg.addOrg(form.org_name, form.poc_name, form.poc_email, 
				form.group_name, form.address1, form.address2, form.city, form.state, form.zip_code, form.phone);
	</cfscript>
	
</cfif>
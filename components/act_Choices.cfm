
<cfparam name="form.function" default=0>

	<!--- Call Component/function to add a Choice --->
<cfif form.function eq "addChoice">
                
	<cfparam name="form.email_me" default=0>

    	<cfset catList = "">
    	<cfloop list="#form.fieldnames#" index="i">
        	<cfif i CONTAINS "cat_">
            	<cfset catList = ListAppend(catList, evaluate('form.' & i))>
            </cfif>
        </cfloop>

<!--- <cfoutput>
	#catList#
</cfoutput>
<cfabort> --->

	<cfscript>
		objAddChoice = createObject("component","ChoicesCFC");
		isAdded = objAddChoice.addChoice(form.short_desc, form.details, form.num_of_answers, form.anon, form.type, form.date_end, form.email_me, catList, form.gid);
	</cfscript>
		
</cfif>

	<!--- Call Component/function to edit a Choice --->
<cfif form.function eq "editChoice">

    	<cfset catList = "">
    	<cfloop list="#form.fieldnames#" index="i">
        	<cfif i CONTAINS "cat_">
            	<cfset catList = ListAppend(catList, evaluate('form.' & i))>
            </cfif>
        </cfloop>

	<cfscript>
		objEditChoice = createObject("component","ChoicesCFC");
		isEdited = objEditChoice.editChoice(form.cid, form.short_desc, form.details, form.anon, form.type, date_end, catList);
	</cfscript>
	
</cfif>


	<!--- Call Component/function to Request Feedback on a Choice --->
<cfif form.function eq "requestFeedback">
	<cfparam name="form.request_type" default="everyone">
    <cfparam name="form.gid" default=0>
	<cfparam name="form.g2id" default=0>
	<cfparam name="variables.g_id" default=0>
		<cfif form.gid neq 0 AND form.gid neq "">
			<cfset variables.g_id = form.gid>
		<cfelseif form.g2id neq 0 AND form.g2id neq "">
			<cfset variables.g_id = form.g2id>
		</cfif>
		
    
	<cfscript>
		objrequestFeedback = createObject("component","ChoicesCFC");
		isRequested = objrequestFeedback.requestFeedback(form.cid, form.request_type, variables.g_id);
	</cfscript>
	
</cfif>


	<!--- Call Component/function to Request ADVANCED Feedback on a Choice --->
<cfif form.function eq "requestFeedbackAdv">
	<cfparam name="form.request_type" default="advanced">
    <cfparam name="form.gid" default=0>
    <cfparam name="form.gender" default="">
    <cfparam name="form.marital_status" default="">
    <cfparam name="form.children" default=0>
    <cfparam name="form.hobbies" default="">
    <cfparam name="form.profession" default="">
    <cfparam name="form.country" default="">
    <cfparam name="form.zip_code" default="">
    <cfparam name="form.cultural_heritage" default="">
    <cfparam name="form.min_age" default="">
    <cfparam name="form.max_age" default="">
 
    <cfif form.gender eq "male,female">
    	<cfset form.gender = "">
    </cfif>
    <cfif form.marital_status eq "single,in a relationship,married,separated">
    	<cfset form.marital_status = "">
    </cfif>
     
	<cfscript>
		objrequestFeedback = createObject("component","ChoicesCFC");
		isRequested = objrequestFeedback.requestFeedback(form.cid, form.request_type, form.gid, form.gender, form.marital_status, form.children,
			form.hobbies, form.profession, form.country, form.zip_code, form.cultural_heritage, form.min_age, form.max_age);
	</cfscript>
	
</cfif>


	<!--- Call Component/function to Provide Feedback on a Choice --->
<cfif form.function eq "provideFeedback">
	<cfparam name="form.answer_choice" default=0>
	<cfparam name="form.gid" default=0>
    
	<cfscript>
		objProvideFeedback = createObject("component","ChoicesCFC");
		isProvided = objProvideFeedback.provideFeedback(form.mid, form.cid, form.answer_choice, form.type, form.comments, form.gid);
	</cfscript>
	
</cfif>
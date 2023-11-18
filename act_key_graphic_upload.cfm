<cfparam name="url.delete" default=0>
<cfparam name="url.email" default=0>
<cfparam name="url.experts" default=0>
<cfparam name="url.bakeoff" default=0>
<cfparam name="url.be" default=0>
<cfparam name="width" default=0>
<cfparam name="height" default=0>




<cfif url.delete eq 1>

	<cfquery name="get" datasource="#application.dsn#"> 
		SELECT element_text 
		FROM t_bake_off 
		WHERE id = #url.bid#
	</cfquery>


	<cffile action="delete" file="#application.filepath#images\#url.be#\#client.cid#\#get.element_text#"> 
	
	<cfquery name="d" datasource="#application.dsn#"> 
		DELETE t_bake_off 
		WHERE id = #url.bid#
	</cfquery>
	
	<cfif url.email eq 1>	
		<cfoutput>
			<cflocation url="dsp_#url.be#_upload.cfm?delete=1&be=#url.be#&email=1">
		</cfoutput>
	<cfelseif url.experts eq 1>
		<cfoutput>
			<cflocation url="dsp_#url.be#_upload.cfm?delete=1&be=#url.be#&experts=1">
		</cfoutput>	
	<cfelse>
		<cfoutput>
			<cflocation url="dsp_#url.be#_upload.cfm?delete=1&be=#url.be#">
		</cfoutput>	
	</cfif>
	
</cfif>


<cffile action="upload" filefield="upload_image" destination="#application.filepath#images\#url.be#\#client.cid#\" nameconflict="overwrite"> 

 


<!--- <cfoutput>
#application.filepath#images\#url.be#\#client.cid#\#file.ServerFile#
</cfoutput>
<cfabort> --->

<!--- If the file is not a jpg, then delete it. --->
<cfif file.serverfileext neq "jpg">
	<cffile action="delete" file="#application.filepath#images\#url.be#\#client.cid#\#file.ServerFile#"> 
	
	<cfif url.email eq 1>	
		<cfoutput>
			<cflocation url="dsp_#url.be#_upload.cfm?nojpg=1&be=#url.be#&email=1">
		</cfoutput>
	<cfelseif url.experts eq 1>
		<cfoutput>
			<cflocation url="dsp_#url.be#_upload.cfm?nojpg=1&be=#url.be#&experts=1">
		</cfoutput>	
	<cfelse>
		<cfif url.bakeoff eq 1>
			<cfoutput>
				<cflocation url="index.cfm?fa=bake_off&be=#url.be#&edit=1&nojpg=1&added=1">
			</cfoutput>	
		<cfelse>
			<cfoutput>
				<cflocation url="dsp_#url.be#_upload.cfm?update=1&be=#url.be#&nojpg=1">
			</cfoutput>
		</cfif>	
	</cfif>
	
</cfif>

<cfoutput>
  <CF_imagesize file="#application.filepath#images\#url.be#\#client.cid#\#file.ServerFile#">
</cfoutput>    


<!--- If the image dimensions are too big then delete it. --->

<cfif url.be eq "brand_logo" OR url.be eq "sub_brand_logo">
	<cfset variables.max_width = 400>
	<cfset variables.max_height = 200>
<cfelse>
	<cfset variables.max_width = 600>
	<cfset variables.max_height = 600>	
</cfif>

<cfif width gt variables.max_width OR height gt variables.max_height>
	<cffile action="delete" file="#application.filepath#images\#url.be#\#client.cid#\#file.ServerFile#"> 
	
	<cfif url.email eq 1>	
		<cfoutput>
			<cflocation url="dsp_#url.be#_upload.cfm?resize=1&be=#url.be#&email=1">
		</cfoutput>
	<cfelseif url.experts eq 1>
		<cfoutput>
			<cflocation url="dsp_#url.be#_upload.cfm?resize=1&be=#url.be#&experts=1">
		</cfoutput>	
	<cfelse>
		<cfif url.bakeoff eq 1>
			<cfoutput>
				<cflocation url="index.cfm?fa=bake_off&be=#url.be#&edit=1&resize=1&added=1">
			</cfoutput>	
		<cfelse>
			<cfoutput>
				<cflocation url="dsp_#url.be#_upload.cfm?update=1&be=#url.be#&resize=1">
			</cfoutput>
		</cfif>	
	</cfif>
	
</cfif>


<!--- If the file size is greater that 200k, then delete it. --->
<cfif file.filesize gt 204800>
	<cffile action="delete" file="#application.filepath#images\#url.be#\#client.cid#\#file.ServerFile#"> 
	
	<cfif url.email eq 1>	
		<cfoutput>
			<cflocation url="dsp_#url.be#_upload.cfm?big=1&be=#url.be#&email=1">
		</cfoutput>
	<cfelseif url.experts eq 1>
		<cfoutput>
			<cflocation url="dsp_#url.be#_upload.cfm?big=1&be=#url.be#&experts=1">
		</cfoutput>	
	<cfelse>
		<cfif url.bakeoff eq 1>
			<cfoutput>
				<cflocation url="index.cfm?fa=bake_off&be=#url.be#&edit=1&big=1&added=1">
			</cfoutput>	
		<cfelse>
			<cfoutput>
				<cflocation url="dsp_#url.be#_upload.cfm?update=1&be=#url.be#&big=1">
			</cfoutput>
		</cfif>	
	</cfif>
	
</cfif>



	
	<cfquery name="c" datasource="#application.dsn#"> 
		SELECT email
		FROM t_clients 
		WHERE id = #client.cid#
	</cfquery>

		<cfquery name="business" datasource="#application.dsn#"> 
			INSERT INTO t_bake_off 
				(cid, c_name, element_text, business_element, sug_by_name, sug_by_email, date_submitted)
			VALUES
				(#client.cid#, '#client.name#', '#File.ServerFile#', '#ucase(url.be)#', '#client.name#', '#c.email#', '#DateFormat(Now(),"mm/dd/yyyy")# #TimeFormat(Now())#')							
		</cfquery>

<!--- Your image, <cfoutput><b>#File.ServerFile#</b></cfoutput>, has been uploaded and will now appear as your virtual band picture. --->

	<cfif url.email eq 1>	
		<cfoutput>
			<cflocation url="dsp_#url.be#_upload.cfm?update=1&be=#url.be#&email=1">
		</cfoutput>
	<cfelseif url.experts eq 1>
		<cfoutput>
			<cflocation url="dsp_#url.be#_upload.cfm?update=1&be=#url.be#&experts=1">
		</cfoutput>	
	<cfelse>
		<cfif url.bakeoff eq 1>
			<cfoutput>
				<cflocation url="index.cfm?fa=bake_off&be=#url.be#&edit=1&added=1">
			</cfoutput>	
		<cfelse>
			<cfoutput>
				<cflocation url="dsp_#url.be#_upload.cfm?update=1&be=#url.be#">
			</cfoutput>
		</cfif>	
	</cfif>
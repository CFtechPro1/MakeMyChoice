

<cfif form.function eq "newImageAnswers">

		<!--- Set local vars first --->
			<cfset max_width = 800>
			<cfset max_height = 1200>	
            <cfparam name="width" default=200>
            <cfparam name="height" default=200>


	<cfloop from="1" to="#form.num_of_answers#" index="i">

		<cfif evaluate("form.upload_image_" & i) neq "">

			<!--- Initially upload file in order to get information on it. --->
			<cffile action="upload" filefield="upload_image_#i#" destination="#application.filepath#media\#client.mid#\" nameconflict="overwrite"> 
			
			<!--- Get the image file dimensions with custom tag. --->
			<CF_ImageSize file="#application.filepath#media\#client.mid#\#file.ServerFile#">	
			
	<!---         <cfoutput>#file.serverfileext#</cfoutput>
			<cfabort> --->
			
			<!--- If the file is not a jpg, then delete it and return false --->
			<cfif file.serverfileext neq "jpg" AND file.serverfileext neq "gif" and file.serverfileext neq "png">
				<cffile action="delete" file="#application.filepath#media\#client.mid#\#file.ServerFile#"> 
				<cfoutput>
					<cflocation url="../index.cfm?fa=add_answers&cid=#form.cid#&extension=1&format=image&na=#form.num_of_answers#">
				</cfoutput>
			<!--- If the file width or height is too much, then delete it and return false --->
			<cfelseif width gt max_width OR height gt max_height>
				<cffile action="delete" file="#application.filepath#media\#client.mid#\#file.ServerFile#"> 
				<cfoutput>
					<cflocation url="../index.cfm?fa=add_answers&cid=#form.cid#&dimensions=1&format=image&na=#form.num_of_answers#">
				</cfoutput>
			<!--- If the file is too heavy, then delete it and return false --->
			<cfelseif file.filesize gt 307200>
				<cffile action="delete" file="#application.filepath#media\#client.mid#\#file.ServerFile#"> 
				<cfoutput>
					<cflocation url="../index.cfm?fa=add_answers&cid=#form.cid#&filesize=1&format=image&na=#form.num_of_answers#">
				</cfoutput>
			<cfelse>
	
			   <cfquery name="answersIn" datasource="#application.dsn#">
					INSERT INTO t_answers
					(cid, mid, answer_filename, answer_caption, type, order_num)
					VALUES
					('#form.cid#', '#client.mid#', '#trim(file.ServerFile)#', '#evaluate("form.image_caption_" & i)#', 'image', #i#)
				</cfquery>	
	
			</cfif>
			
        </cfif>	
		
	</cfloop>		

			 <cfoutput>
                <cflocation url="../index.cfm?fa=request_feedback&cid=#form.cid#&added=1">
            </cfoutput>

</cfif>



<cfif form.function eq "newMp3Answers">

            <cfparam name="url.na" default=0>
            <cfparam name="url.mp3c" default=1>
    
        
		<!--- Initially upload file in order to get information on it. --->
		<cffile action="upload" filefield="upload_mp3_#url.mp3c#" destination="#application.filepath#media\#client.mid#\" nameconflict="overwrite"> 
		
        
		<!--- If the file is not a mp3, then delete it and return false --->
		<cfif file.serverfileext neq "mp3">
			<cffile action="delete" file="#application.filepath#media\#client.mid#\#file.ServerFile#"> 
       		<cfoutput>
                <cflocation url="../index.cfm?fa=add_answers&cid=#form.cid#&extension=1&format=mp3&na=#url.na#&mp3c=#url.mp3c#">
            </cfoutput>
		<!--- If the file is too heavy, then delete it and return false --->
		<cfelseif file.filesize gt 102400000>
			<cffile action="delete" file="#application.filepath#media\#client.mid#\#file.ServerFile#"> 
       		<cfoutput>
                <cflocation url="../index.cfm?fa=add_answers&cid=#form.cid#&filesize=1&format=mp3&na=#url.na#&mp3c=#url.mp3c#">
            </cfoutput>
		<cfelse>

           <cfquery name="answersIn" datasource="#application.dsn#">
                INSERT INTO t_answers
                (cid, mid, answer_filename, link_title, type, order_num)
                VALUES
                ('#form.cid#', '#client.mid#', '#trim(file.ServerFile)#', '#evaluate("form.link_title_" & url.mp3c)#', 'mp3', #url.mp3c#)
            </cfquery>	

		</cfif>
        
	<cfset url.mp3c = url.mp3c + 1>
        <cfif url.mp3c gt url.na>
            <cfoutput>
                <cflocation url="../index.cfm?fa=request_feedback&cid=#form.cid#&added=1">
            </cfoutput>     
        <cfelse>
            <cfoutput>
                <cflocation url="../index.cfm?fa=add_answers&mp3c=#url.mp3c#&na=#url.na#&format=mp3&cid=#form.cid#&added=1">
            </cfoutput>    
         </cfif> 
    </cfif>


<cfif form.function eq "newDocumentAnswers">
        

	<cfloop from="1" to="#form.num_of_answers#" index="i">

		<cfif evaluate("form.upload_document_" & i) neq "">
		
			<!--- Initially upload file in order to get information on it. --->
			<cffile action="upload" filefield="upload_document_#i#" destination="#application.filepath#media\#client.mid#\" nameconflict="overwrite"> 
			
			<cfset bext = "cfm,cfml,ade,adp,app,asp,bas,bat,cer,chm,cmd,cnt,com,cpl,crt,csh,der,exe,fxp,gadget,hlp,hpj,hta,inf,ins,isp,its,js,jse,ksh,lnk,mad,maf,mag,mam,maq,mar,mas,mat,mau,mav,maw,mda,mdb,mde,mdt,mdw,mdz,msc,msh,msh1,msh2,mshxml,msh1xml,msh2xml,msi,msp,mst,ops,osd,pcd,pif,plg,prf,prg,pst,reg,scf,scr,sct,shb,shs,ps1,ps1xml,ps2,ps2xml,psc1,psc2,tmp,url,vb,vbe,vbp,vbs,vsmacros,vsw,ws,wsc,wsf,wsh,xnk">
			
			<!--- If the file is one of the banned file types, then delete it and return false --->
			<cfif ListContainsNoCase(bext, file.serverfileext) is not 0> 
				<cffile action="delete" file="#application.filepath#media\#client.mid#\#file.ServerFile#"> 
				<cfoutput>
					<cflocation url="../index.cfm?fa=add_answers&cid=#form.cid#&extension=1&format=document&na=#form.num_of_answers#">
				</cfoutput>
			<!--- If the file is too heavy, then delete it and return false --->
			<cfelseif file.filesize gt 5242880>
				<cffile action="delete" file="#application.filepath#media\#client.mid#\#file.ServerFile#"> 
				<cfoutput>
					<cflocation url="../index.cfm?fa=add_answers&cid=#form.cid#&filesize=1&format=document&na=#form.num_of_answers#">
				</cfoutput>
			<cfelse>
	
			   <cfquery name="answersIn" datasource="#application.dsn#">
					INSERT INTO t_answers
					(cid, mid, answer_filename, link_title, type, order_num)
					VALUES
					('#form.cid#', '#client.mid#', '#trim(file.ServerFile)#', '#evaluate("form.link_title_" & i)#', 'document', #i#)
				</cfquery>	
	
			</cfif>
		
		</cfif>
        	
	</cfloop>		

			 <cfoutput>
                <cflocation url="../index.cfm?fa=request_feedback&cid=#form.cid#&added=1">
            </cfoutput>

</cfif>


<cfif form.function eq "updateProfile">


		<!--- Set local vars first --->
			<cfset max_width = 600>
			<cfset max_height = 600>
            
            <cfparam name="width" default=75>
            <cfparam name="height" default=75>	

	<cfif form.upload_image neq "">
    
		<!--- Initially upload file in order to get information on it. --->
		<cffile action="upload" filefield="upload_image" destination="#application.filepath#media\#client.mid#\" nameconflict="overwrite"> 
		
		<!--- Get the image file dimensions with custom tag. --->
		<CF_ImageSize file="#application.filepath#media\#client.mid#\#file.ServerFile#">	
        
		
<!---         <cfoutput>#file.serverfileext#</cfoutput>
        <cfabort> --->
        

<cfimage source="#application.filepath#media\#client.mid#\#file.ServerFile#" action="resize" name="ResizedImage" height="75" width="75"> 
        
 		<!--- If the file is not a jpg, then delete it and return false --->
		<cfif file.serverfileext neq "jpg" AND file.serverfileext neq "gif" and file.serverfileext neq "png">
			<cffile action="delete" file="#application.filepath#media\#client.mid#\#file.ServerFile#"> 
       		<cfoutput>
                <cflocation url="../index.cfm?fa=my_profile&extension=1" addtoken="no">
            </cfoutput>
		<!--- If the file width or height is too much, then delete it and return false --->
		<cfelseif width gt max_width OR height gt max_height>
			<cffile action="delete" file="#application.filepath#media\#client.mid#\#file.ServerFile#"> 
       		<cfoutput>
                <cflocation url="../index.cfm?fa=my_profile&dimensions=1" addtoken="no">
            </cfoutput>
		<!--- If the file is too heavy, then delete it and return false --->
		<cfelseif file.filesize gt 207200>
			<cffile action="delete" file="#application.filepath#media\#client.mid#\#file.ServerFile#"> 
       		<cfoutput>
                <cflocation url="../index.cfm?fa=my_profile&filesize=1" addtoken="no">
            </cfoutput>
	
   		</cfif> 
    
           <cfquery name="answersIn" datasource="#application.dsn#">
                Update t_members
                 	SET                     
					<cfif form.quote neq "">
                    	quote = '#form.quote#',
                    </cfif>
                 	image = '#trim(file.ServerFile)#'
                	WHERE id = #client.mid#
            </cfquery>	

	</cfif>


			<cfoutput>
                <cflocation url="../index.cfm?fa=my_profile&updated=1" addtoken="no">
            </cfoutput>


</cfif>

<cfif form.function eq "groupPic">


		<!--- Set local vars first --->
			<cfset max_width = 800>
			<cfset max_height = 800>
            
            <cfparam name="width" default=150>
            <cfparam name="height" default=150>	
			

	<cfif form.upload_image neq "">
    
		<!--- Initially upload file in order to get information on it. --->
		<cffile action="upload" filefield="upload_image" destination="#application.filepath#media\#client.mid#\#form.gid#" nameconflict="overwrite"> 
		
		
		<!--- Get the image file dimensions with custom tag. --->
		<CF_ImageSize file="#application.filepath#media\#client.mid#\#form.gid#\#file.ServerFile#">	
        
		<cfimage source="#application.filepath#media\#client.mid#\#form.gid#\#file.ServerFile#" action="resize" name="ResizedImage" height="150" width="150"> 
        
 		<!--- If the file is not a jpg, then delete it and return false --->
		<cfif file.serverfileext neq "jpg" AND file.serverfileext neq "gif" and file.serverfileext neq "png">
			<cffile action="delete" file="#application.filepath#media\#client.mid#\#form.gid#\#file.ServerFile#"> 
       		<cfoutput>
                <cflocation url="../groups/index.cfm?fa=group_profile_edit&extension=1" addtoken="no">
            </cfoutput>
		<!--- If the file width or height is too much, then delete it and return false --->
		<cfelseif width gt max_width OR height gt max_height>
			<cffile action="delete" file="#application.filepath#media\#client.mid#\#form.gid#\#file.ServerFile#"> 
       		<cfoutput>
                <cflocation url="../groups/index.cfm?fa=group_profile_edit&dimensions=1" addtoken="no">
            </cfoutput>
		<!--- If the file is too heavy, then delete it and return false --->
		<cfelseif file.filesize gt 207200>
			<cffile action="delete" file="#application.filepath#media\#client.mid#\#form.gid#\#file.ServerFile#"> 
       		<cfoutput>
                <cflocation url="../groups/index.cfm?fa=group_profile_edit&filesize=1" addtoken="no">
            </cfoutput>
	
   		</cfif> 
    
           <cfquery name="answersIn" datasource="#application.dsn#">
                UPDATE t_groups
                 	SET                     
                 	group_pic = '#trim(file.ServerFile)#'
                	WHERE id = #form.gid#
            </cfquery>	

	</cfif>


			<cfoutput>
                <cflocation url="../groups/index.cfm?fa=group_profile_edit&updated=1" addtoken="no">
            </cfoutput>


</cfif>
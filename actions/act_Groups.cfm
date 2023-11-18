

<cfparam name="form.new_group" default=0>
<cfparam name="form.function" default=0>
<cfparam name="url.function" default=0>

<cfif url.function neq 0>
	<cfset form.function = url.function>
</cfif>

<cfinclude template="../udfs/removeAppos.cfm">

	<cfif form.function eq "addGroup">
    
          <!--- Insert Group to the t_groups table --->
            <cfquery name="add_g" datasource="#application.dsn#">
                INSERT INTO t_groups
                (mid, group_name, group_desc, date_created, private)
                VALUES
                ('#client.mid#','#form.new_group#','#form.group_desc#',CURRENT_TIMESTAMP, '#form.private#')
				
				SELECT @@IDENTITY  AS gid
            </cfquery>	 
			<!--- Create the ctegory list --->
  			<cfset catList = "">
			<cfloop list="#form.fieldnames#" index="i">
				<cfif i CONTAINS "cat_">
					<cfset catList = ListAppend(catList, i)>
				</cfif>
			</cfloop>
			
			<cfset catList = replaceNoCase(catList, "cat_", "", "ALL")>
			
			<!--- Insert categories for this group. --->
			<cfloop list="#catList#" index="i">
                <cfquery name="ins_cat" datasource="#application.dsn#">
                    INSERT INTO t_group_cats
                    	(gid, cat_id)
                    VALUES (#add_g.gid#, #i#)
                </cfquery>	  				
			</cfloop>
			
          <!--- Insert Creating Member to the t_group_members table --->
            <cfquery name="add_m" datasource="#application.dsn#">
                INSERT INTO t_group_members
                (mid, gid, ab_mid, date_created, confirmed)
                VALUES
                (#client.mid#, #add_g.gid#, #client.mid#, CURRENT_TIMESTAMP, 1)
            </cfquery>	 
			
			<cfdirectory action="create" directory="#application.filepath#media\#client.mid#\#add_g.gid#">
			
            <cfoutput>
                <cflocation url="../index.cfm?fa=my_groups&added=1&gid=#add_g.gid#">
            </cfoutput>
            
            
	<cfelseif form.function eq "editGroup">
    
          <!--- Insert Group to the t_groups table --->
            <cfquery name="up_g" datasource="#application.dsn#">
                UPDATE t_groups
                SET group_name = '#form.new_group#',
					group_desc = '#form.group_desc#',
					private = '#form.private#'
                WHERE mid = '#client.mid#' 
                	AND id = #form.gid#
            </cfquery>	 
			
				<!--- Delete existing group categories --->
			<cfquery name="del_c" datasource="#application.dsn#">
				DELETE t_group_cats
				WHERE gid = #form.gid#
			</cfquery>
			
			<!--- Create the ctegory list --->
  			<cfset catList = "">
			<cfloop list="#form.fieldnames#" index="i">
				<cfif i CONTAINS "cat_">
					<cfset catList = ListAppend(catList, i)>
				</cfif>
			</cfloop>
			
			<cfset catList = replaceNoCase(catList, "cat_", "", "ALL")>
			
			<!--- Insert categories for this group. --->
			<cfloop list="#catList#" index="i">
                <cfquery name="ins_cat" datasource="#application.dsn#">
                    INSERT INTO t_group_cats
                    	(gid, cat_id)
                    VALUES (#form.gid#, #i#)
                </cfquery>	  				
			</cfloop>
     
            <cfoutput>
                <cflocation url="../index.cfm?fa=my_groups&updated=1">
            </cfoutput>
 
 	<cfelseif form.function eq "addMember">
    
    	<cfquery name="check" datasource="#application.dsn#">
        	SELECT id FROM t_group_members
            WHERE mid = #form.mid#
            	AND gid = #form.gid#
                AND ab_mid = #client.mid#
        </cfquery>
        
        	<cfif check.recordcount neq 0>
				<cfoutput>
                    <cflocation url="../index.cfm?fa=group_members&members=1&existed=1&mid=#form.mid#&gid=#form.gid#">
                </cfoutput>            
            </cfif>
    
          <!--- Insert Member to the t_group_members table --->
            <cfquery name="add_m" datasource="#application.dsn#">
                INSERT INTO t_group_members
                (mid, gid, ab_mid, date_created)
                VALUES
                (#form.mid#, #form.gid#, #client.mid#, CURRENT_TIMESTAMP)
            </cfquery>	 
     
            <cfoutput>
                <cflocation url="../index.cfm?fa=group_members&members=1&added=1&mid=#form.mid#&gid=#form.gid#">
            </cfoutput>
			
	<cfelseif form.function eq "accept">
    
            <cfquery name="up_g" datasource="#application.dsn#">
                UPDATE t_group_members
                SET confirmed = 1
                WHERE mid = #client.mid#
                	AND gid = #url.gid#
            </cfquery>	 
     
            <cfoutput>
                <cflocation url="../groups/?gid=#url.gid#">
            </cfoutput>            
			
	<cfelseif form.function eq "optOut">
    
            <cfquery name="up_g" datasource="#application.dsn#">
                UPDATE t_group_members
                SET confirmed = -1
                WHERE mid = #client.mid#
                	AND gid = #url.gid#
            </cfquery>	 
     
            <cfoutput>
                <cflocation url="../index.cfm?fa=my_groups_invited&optOut=1&add_gid=#url.gid#">
            </cfoutput>    
			
	<cfelseif form.function eq "notSure">
    
            <cfquery name="up_g" datasource="#application.dsn#">
                UPDATE t_group_members
                SET confirmed = 2
                WHERE mid = #client.mid#
                	AND gid = #url.gid#
            </cfquery>	 
     
            <cfoutput>
                <cflocation url="../index.cfm?fa=my_groups_invited&notSure=1&add_gid=#url.gid#">
            </cfoutput>    
			
	<cfelseif form.function eq "change_status">
    
            <cfquery name="up_g" datasource="#application.dsn#">
                UPDATE t_group_members
                SET confirmed = #form.member_status#
                WHERE mid = #client.mid#
                	AND gid = #form.gid#
            </cfquery>	 
     
            <cfoutput>
                <cflocation url="../index.cfm?fa=my_groups_invited&status=1&add_gid=#form.gid#">
            </cfoutput>    

	<cfelseif form.function eq "del_invited">
    
            <cfquery name="del_g" datasource="#application.dsn#">
                DELETE t_group_members
                WHERE mid = #client.mid# 
                	AND gid = #url.gid#
            </cfquery>	 
     
            <cfoutput>
                <cflocation url="../index.cfm?fa=my_groups_invited&i_deleted=1&add_gid=#url.gid#">
            </cfoutput>   
			
	<cfelseif form.function eq "joinGroup">
			
            <cfquery name="gr" datasource="#application.dsn#">
               SELECT mid
                FROM t_groups
                WHERE id = #url.gid#
            </cfquery>	 			
			
          <!--- Insert Member to the t_group_members table --->
            <cfquery name="add_m" datasource="#application.dsn#">
                INSERT INTO t_group_members
                (mid, gid, ab_mid, date_created, confirmed)
                VALUES
                (#client.mid#, #url.gid#, #gr.mid#, CURRENT_TIMESTAMP, 1)
            </cfquery>	 
     
            <cfoutput>
                <cflocation url="../index.cfm?fa=my_groups_invited&added=1&add_gid=#url.gid#">
            </cfoutput>			

	<cfelseif form.function eq "groupDesc">
			
            <cfquery name="up_g" datasource="#application.dsn#">
                UPDATE t_groups
                SET group_desc = '#form.group_desc#'
                WHERE id = #form.gid#
            </cfquery>	 
     
            <cfoutput>
                <cflocation url="../groups/index.cfm?fa=group_profile_edit&updated=1">
            </cfoutput>			
	<cfelseif form.function eq "groupLink">
		
		<cfif form.edit eq 0>	
          <!--- Insert Group link to the t_group_links table --->
            <cfquery name="add_link" datasource="#application.dsn#">
                INSERT INTO t_group_links
                (mid, gid, url, url_text, url_desc, date_created)
                VALUES
                (#client.mid#, #form.gid#, '#form.url#', '#form.url_text#', '#form.url_desc#', CURRENT_TIMESTAMP)
            </cfquery>	 
     
            <cfoutput>
                <cflocation url="../groups/index.cfm?fa=links&gid=#form.gid#&added=1">
            </cfoutput>		
		<cfelse>
            <cfquery name="up_link" datasource="#application.dsn#">
                UPDATE t_group_links
                SET url = '#form.url#',
					url_text = '#form.url_text#',
					url_desc = '#form.url_desc#'
					WHERE id = #form.link_id#
            </cfquery>	 
     
            <cfoutput>
                <cflocation url="../groups/index.cfm?fa=links&gid=#form.gid#&updated=1">
            </cfoutput>				
		</cfif>
						
	</cfif>
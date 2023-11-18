                    <cfoutput>	
						<tr>
                        	<td class="column_header">
                            	<a href="index.cfm?fa=my_feedback&page=#url.page#&sort=1&f=#url.f#&asc_1=#url.asc_1#" class="columnlink">Choice Description</a>
								<cfif url.sort eq 1>
									<cfif url.asc_1 eq 0>
										<img src="images/arrow_sort_down.gif" />
									<cfelse>
										<img src="images/arrow_sort_up.gif" />
									</cfif>
								</cfif>
                            </td>
                        	<td class="column_header" nowrap="nowrap">
                            	<a href="index.cfm?fa=my_feedback&page=#url.page#&sort=2&f=#url.f#&asc_1=#url.asc_1#" class="columnlink">Date Created</a>
								<cfif url.sort eq 2>
									<cfif url.asc_1 eq 0>
										<img src="images/arrow_sort_down.gif" />
									<cfelse>
										<img src="images/arrow_sort_up.gif" />
									</cfif>
								</cfif>
                            </td>
                        	<td class="column_header" nowrap="nowrap">
                            	<a href="index.cfm?fa=my_feedback&page=#url.page#&sort=3&f=#url.f#&asc_1=#url.asc_1#" class="columnlink">Created By</a>
								<cfif url.sort eq 3>
									<cfif url.asc_1 eq 0>
										<img src="images/arrow_sort_down.gif" />
									<cfelse>
										<img src="images/arrow_sort_up.gif" />
									</cfif>
								</cfif>
                            </td>
                         </tr>
					</cfoutput>
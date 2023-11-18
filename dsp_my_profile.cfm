<meta name="robots" content="noindex" />
<meta name="googlebot" content="index" />

<cfparam name="form.gender" default="">
<cfparam name="form.marital_status" default="">
<cfparam name="url.updated" default=0>
<cfparam name="url.extension" default=0>
<cfparam name="url.dimensions" default=0>
<cfparam name="url.filesize" default=0>
<cfparam name="url.eSettings" default=0>
<cfparam name="url.p" default=0>


		<cfif client.mid eq 0>
			<cflocation url="index.cfm?fa=login&p=1">
		</cfif>

  <script type="text/javascript">
//<![CDATA[        
						bkLib.onDomLoaded(function() { nicEditors.allTextAreas() });  
						//]]>
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
	</script>  


		<cfquery name="profile" datasource="#application.dsn#" maxrows="1">
			SELECT id, first_name, last_name, username, email_address, password, country, zip_code, dob, gender, marital_status, cultural_heritage,
            			children, hobbies, profession, image, quote, details, email_requests, email_requests_g, email_requests_t
			FROM t_members
			WHERE id = #client.mid#
		</cfquery>	

		<cfquery name="dp" datasource="#application.dsn#" maxrows="1">
			SELECT id, mid, d_first_name, d_last_name, d_username, d_email_address, d_country, d_zip_code, d_dob, d_gender, d_marital_status, d_cultural_heritage,
            			d_children, d_hobbies, d_profession, d_image, d_quote, d_details
			FROM t_profile_display
			WHERE mid = #client.mid#
		</cfquery>
        
        	<cfif client.orgid neq 0>
                <cfquery name="org" datasource="#application.dsn#">
                    SELECT m.mid, m.orgid, o.org_name
                    FROM t_member_orgs m INNER JOIN
                    		t_orgs o ON m.orgid = o.orgid
                        WHERE m.orgid = #client.orgid#
                        	AND m.mid = #client.mid#
                </cfquery>	                
            </cfif>
            
				
                <cfquery name="cats" datasource="#application.dsn#">
                    SELECT c.id, c.cat_name
                    FROM t_categories c 
                </cfquery>	
			

				<cfinclude template="udfs/arrayFind.cfm">
				
 				<cfquery name="cats_m" datasource="#application.dsn#">
 					SELECT id, mid, cat_id
					FROM  t_member_cats
					WHERE (mid = #client.mid#)
				</cfquery>
				
				<cfset catList = ValueList(cats_m.cat_id)>
				<cfset catArrayList = ListToArray(catList)>
			
				 	
<body onLoad="MM_preloadImages('images/btn_save_changes_hover.gif')">			

<cfoutput>

<form action="components/act_Members.cfm" name="FrontPage_Form1" onSubmit="return formValidator(this)" method="post">
		
		<table width="100%" border="0" cellspacing="2" cellpadding="5" class="dkblue12" bgcolor="FFFFFF">
			<tr> 
				<td class="header" colspan="3">
					<span class="header_orange">My</span> Profile     
				</td>
			</tr>	 
               	<cfif url.updated eq 1>
                    <tr> 
                        <td class="alert_text" colspan="3">
                       		<br>
                            <span class="stars">***</span> Your profile has been updated! <span class="stars">***</span>
                            <br><br>
                        </td>
                    </tr>
                </cfif>		
			  <cfif url.extension eq 1>
                  <tr> 
                      <td class="alert_text" colspan="3">
                          <span class="red_stars">***</span> The images need to be .jpg, .gif, or a .png files.<span class="red_stars">***</span>
                      </td>
                  </tr> 
              </cfif>   
              <cfif url.dimensions eq 1>
                  <tr> 
                      <td class="alert_text" colspan="3">
                          <span class="red_stars">***</span> The image cannot be more than 600 pixels width and 600 pixels height. It will be re-sized to 75px by 75px when displayed.<span class="red_stars">***</span>
                      </td>
                  </tr> 
              </cfif>   
              <cfif url.filesize eq 1>
                  <tr> 
                      <td class="alert_text" colspan="3">
                          <span class="red_stars">***</span> The image has to be under 200k. Please resize the image, or save with lower resolution. <span class="red_stars">***</span>
                      </td>
                  </tr> 
              </cfif> 
               	<cfif url.eSettings eq 1>
                    <tr> 
                        <td class="alert_text" colspan="3">
                       		<br>
                            <span class="stars">***</span> Your Email Settings have been updated! <span class="stars">***</span>
                            <br><br>
                        </td>
                    </tr>
                </cfif>	
            <tr> 
				<td class="column_header">
					 <strong>Field Names</strong>
				</td>
                <td class="column_header">
					 <strong>Current Profile Info</strong>
				</td>
                <td class="column_header">
					 <strong>Display on Profile</strong>
				</td>
			</tr>	 			  
 			<tr>
				<td class="form_instruct">
					First Name:
				</td>
				<td align="left">
					<input type="text" name="first_name" size="30" value="#profile.first_name#">&nbsp; &nbsp; &nbsp; | &nbsp; <a href="index.cfm?fa=profile&mid=#client.mid#" class="bodylink">Preview My Profile</a>
				</td>
                <td align="center">
                	<input type="checkbox" name="d_first_name" <cfif dp.d_first_name eq 1>checked</cfif> value="1"> 
                </td>
			</tr>
			<tr>
				<td class="form_instruct">
					Last Name:
                   

				</td>
				<td align="left">
					<input type="text" name="last_name" size="30" value="#profile.last_name#">
				</td>
                <td align="center">
                	<input type="checkbox" name="d_last_name" <cfif dp.d_last_name eq 1>checked</cfif> value="1"> 
                </td>
			</tr>	
 			<tr>
				<td class="form_instruct">
					Username:
				</td>
				<td align="left">
					<input type="text" name="username" size="20" value="#profile.username#">
				</td>
                <td align="center">
                	<input type="checkbox" name="d_username" disabled="disabled" checked> 
                    <br>
                    <span class="dkblue10">required</span>
                </td>
			</tr>
			<tr>
				<td class="form_instruct">
					Password:
				</td>
				<td align="left">
					<input type="password" name="password" size="20" value="#profile.password#">
				</td>
			</tr>	
			<tr>
				<td class="form_instruct">
					Email Address:
				</td>
				<td align="left">
					<input type="text" name="email_address" size="30" value="#profile.email_address#">
				</td>
                <td align="center">
                	<input type="checkbox" name="d_email_address" <cfif dp.d_email_address eq 1>checked</cfif> value="1"> 
                </td>
			</tr>
			<tr>
				<td class="form_instruct">
					Country:
				</td>
				<td align="left">
                
<select name="country" size="1">
 <option value="#profile.country#">#profile.country#</option>
 <option value="0">Choose Country</option>
 <option value="US">United States</option>
 <option value="AF">Afghanistan</option>
 <option value="AL">Albania</option>
 <option value="DZ">Algeria</option>
 <option value="AD">Andorra</option>
 <option value="AO">Angola</option>
 <option value="AI">Anguilla</option>
 <option value="AQ">Antartica</option>
 <option value="AG">Antigua and Barbuda</option>
 <option value="AR">Argentina</option>
 <option value="AM">Armenia</option>
 <option value="AW">Aruba</option>
 <option value="AU">Australia</option>
 <option value="AT">Austria</option>
 <option value="AZ">Azerbaijan</option>
 <option value="BS">Bahamas</option>
 <option value="BH">Bahrain</option>
 <option value="BD">Bangladesh</option>
 <option value="BB">Barbados</option>
 <option value="BY">Belarus</option>
 <option value="BE">Belgium</option>
 <option value="BZ">Belize</option>
 <option value="BJ">Benin</option>
 <option value="BM">Bermuda</option>
 <option value="BT">Bhutan</option>
 <option value="BO">Bolivia</option>
 <option value="BA">Bosnia-Herzegovina</option>
 <option value="BW">Botswana</option>
 <option value="BV">Bouvet Island</option>
 <option value="BR">Brazil</option>
 <option value="IO">British Indian Ocean Territory</option>
 <option value="BN">Brunei Darussalam</option>
 <option value="BG">Bulgaria</option>
 <option value="BF">Burkina Faso</option>
 <option value="BI">Burundi</option>
 <option value="KH">Cambodia</option>
 <option value="CM">Cameroon</option>
 <option value="CA">Canada</option>
 <option value="CV">Cape Verde</option>
 <option value="KY">Cayman Islands</option>
 <option value="CF">Central African Republic</option>
 <option value="TD">Chad</option>
 <option value="CL">Chile</option>
 <option value="CN">China</option>
 <option value="CX">Christmas Island</option>
 <option value="CC">Cocos (Keeling) Islands</option>
 <option value="CO">Colombia</option>
 <option value="KM">Comoros</option>
 <option value="CG">Congo</option>
 <option value="CK">Cook Islands</option>
 <option value="CR">Costa Rica</option>
 <option value="CI">Cote D'Ivoire</option>
 <option value="HR">Croatia</option>
 <option value="CU">Cuba</option>
 <option value="CY">Cyprus</option>
 <option value="CZ">Czech Republic</option>
 <option value="DK">Denmark</option>
 <option value="DJ">Djibouti</option>
 <option value="DM">Dominica</option>
 <option value="DO">Dominican Republic</option>
 <option value="TP">East Timor</option>
 <option value="EC">Ecuador</option>
 <option value="EG">Egypt</option>
 <option value="SV">El Salvador</option>
 <option value="GQ">Equatorial Guinea</option>
 <option value="EE">Estonia</option>
 <option value="ET">Ethiopia</option>
 <option value="FO">Faeroe Islands</option>
 <option value="FK">Falkland Islands (Malvinas)</option>
 <option value="FJ">Fiji</option>
 <option value="FI">Finland</option>
 <option value="FR">France</option>
 <option value="GF">French Guiana</option>
 <option value="PF">French Polynesia</option>
 <option value="TF">French Southern Territories</option>
 <option value="GA">Gabon</option>
 <option value="GM">Gambia</option>
 <option value="GE">Georgia</option>
 <option value="DE">Germany</option>
 <option value="GH">Ghana</option>
 <option value="GI">Gibraltar</option>
 <option value="GR">Greece</option>
 <option value="GL">Greenland</option>
 <option value="GD">Grenada</option>
 <option value="GP">Guadeloupe</option>
 <option value="GT">Guatemala</option>
 <option value="GG">Guernsey, C.I.</option>
 <option value="GN">Guinea</option>
 <option value="GW">Guinea-Bissau</option>
 <option value="GY">Guyana</option>
 <option value="HT">Haiti</option>
 <option value="HM">Heard and McDonald Islands</option>
 <option value="HN">Honduras</option>
 <option value="HK">Hong Kong</option>
 <option value="HU">Hungary</option>
 <option value="IS">Iceland</option>
 <option value="IN">India</option>
 <option value="ID">Indonesia</option>
 <option value="IR">Iran (Islamic Republic of)</option>
 <option value="IQ">Iraq</option>
 <option value="IE">Ireland</option>
 <option value="IM">Isle of Man</option>
 <option value="IL">Israel</option>
 <option value="IT">Italy</option>
 <option value="JM">Jamaica</option>
 <option value="JP">Japan</option>
 <option value="JE">Jersey, C.I.</option>
 <option value="JO">Jordan</option>
 <option value="KZ">Kazakhstan</option>
 <option value="KE">Kenya</option>
 <option value="KI">Kiribati</option>
 <option value="KP">Korea, Dem. People's Rep of</option>
 <option value="KR">Korea, Republic of</option>
 <option value="KW">Kuwait</option>
 <option value="KG">Kyrgyzstan</option>
 <option value="LA">Lao Peoples Democratic Republi</option>
 <option value="LV">Latvia</option>
 <option value="LB">Lebanon</option>
 <option value="LS">Lesotho</option>
 <option value="LR">Liberia</option>
 <option value="LY">Libyan Arab Jamahiriya</option>
 <option value="LI">Liechtenstein</option>
 <option value="LT">Lithuania</option>
 <option value="LU">Luxembourg</option>
 <option value="MO">Macau</option>
 <option value="MG">Madagascar</option>
 <option value="MW">Malawi</option>
 <option value="MY">Malaysia</option>
 <option value="MV">Maldives</option>
 <option value="ML">Mali</option>
 <option value="MT">Malta</option>
 <option value="MH">Marshall Islands</option>
 <option value="MQ">Martinique</option>
 <option value="MR">Mauritania</option>
 <option value="MU">Mauritius</option>
 <option value="MX">Mexico</option>
 <option value="FM">Micronesia, Fed. States of</option>
 <option value="MD">Moldova, Republic of</option>
 <option value="MC">Monaco</option>
 <option value="MN">Mongolia</option>
 <option value="MS">Montserrat</option>
 <option value="MA">Morocco</option>
 <option value="MZ">Mozambique</option>
 <option value="MM">Myanmar</option>
 <option value="NA">Namibia</option>
 <option value="NR">Nauru</option>
 <option value="NP">Nepal</option>
 <option value="AN">Netherland Antilles</option>
 <option value="NL">Netherlands</option>
 <option value="NT">Neutral Zone (Saudi/Iraq)</option>
 <option value="NC">New Caledonia</option>
 <option value="NZ">New Zealand</option>
 <option value="NI">Nicaragua</option>
 <option value="NE">Niger</option>
 <option value="NG">Nigeria</option>
 <option value="NU">Niue</option>
 <option value="NF">Norfolk Island</option>
 <option value="MP">Northern Mariana Islands</option>
 <option value="NO">Norway</option>
 <option value="OM">Oman</option>
 <option value="PK">Pakistan</option>
 <option value="PW">Palau</option>
 <option value="PA">Panama</option>
 <option value="PZ">Panama Canal Zone</option>
 <option value="PG">Papua New Guinea</option>
 <option value="PY">Paraguay</option>
 <option value="PE">Peru</option>
 <option value="PH">Philippines</option>
 <option value="PN">Pitcairn</option>
 <option value="PL">Poland</option>
 <option value="PT">Portugal</option>
 <option value="PR">Puerto Rico</option>
 <option value="QA">Qatar</option>
 <option value="RE">Reunion</option>
 <option value="RO">Romania</option>
 <option value="RU">Russian Federation</option>
 <option value="RW">Rwanda</option>
 <option value="KN">Saint Kitts and Nevis</option>
 <option value="LC">Saint Lucia</option>
 <option value="WS">Samoa</option>
 <option value="SM">San Marino</option>
 <option value="ST">Sao Tome and Principe</option>
 <option value="SA">Saudi Arabia</option>
 <option value="SN">Senegal</option>
 <option value="SC">Seychelles</option>
 <option value="SL">Sierra Leone</option>
 <option value="SG">Singapore</option>
 <option value="SK">Slovakia</option>
 <option value="SI">Slovenia</option>
 <option value="SB">Solomon Islands</option>
 <option value="SO">Somalia</option>
 <option value="ZA">South Africa</option>
 <option value="ES">Spain</option>
 <option value="LK">Sri Lanka</option>
 <option value="SH">St. Helena</option>
 <option value="PM">St. Pierre and Miquelon</option>
 <option value="VC">St. Vincent and the Grenadines</option>
 <option value="SD">Sudan</option>
 <option value="SR">Suriname</option>
 <option value="SJ">Svalbard and Jan Mayen Islands</option>
 <option value="SZ">Swaziland</option>
 <option value="SE">Sweden</option>
 <option value="CH">Switzerland</option>
 <option value="SY">Syrian Arab Republic</option>
 <option value="TW">Taiwan</option>
 <option value="TJ">Tajikistan</option>
 <option value="TZ">Tanzania, United Republic of</option>
 <option value="TH">Thailand</option>
 <option value="TG">Togo</option>
 <option value="TK">Tokelau</option>
 <option value="TO">Tonga</option>
 <option value="TT">Trinidad and Tobago</option>
 <option value="TN">Tunisia</option>
 <option value="TR">Turkey</option>
 <option value="TM">Turkmenistan</option>
 <option value="TC">Turks and Caicos Islands</option>
 <option value="TV">Tuvalu</option>
 <option value="AE">U.A.E.</option>
 <option value="UM">U.S.Minor Outlying Islands</option>
 <option value="UG">Uganda</option>
 <option value="UA">Ukraine</option>
 <option value="GB">United Kingdom</option>
 <option value="UY">Uruguay</option>
 <option value="UZ">Uzbekistan</option>
 <option value="VU">Vanuatu</option>
 <option value="VA">Vatican City State</option>
 <option value="VE">Venezuela</option>
 <option value="VN">Viet Nam</option>
 <option value="VG">Virgin Islands (British)</option>
 <option value="WF">Wallis and Futuna Islands</option>
 <option value="EH">Western Sahara</option>
 <option value="YE">Yemen, Republic of</option>
 <option value="YU">Yugoslavia</option>
 <option value="ZR">Zaire</option>
 <option value="ZM">Zambia</option>
 <option value="ZW">Zimbabwe</option>
 
 </select>




				</td>
                <td align="center">
                	<input type="checkbox" name="d_country" <cfif dp.d_country eq 1>checked</cfif> value="1"> 
                </td>
			</tr>	
			<tr>
				<td class="form_instruct">
					Postal/Zip Code:
				</td>
				<td align="left">
					<input type="text" name="zip_code" size="10" value="#profile.zip_code#">
				</td>
                <td align="center">
                	<input type="checkbox" name="d_zip_code" <cfif dp.d_zip_code eq 1>checked</cfif> value="1"> 
                </td>
			</tr> 
			<tr>
				<td class="form_instruct">
					Gender:
				</td>
				<td align="left">
					<input type="radio" name="gender" value="male" <cfif profile.gender eq "male">checked</cfif>> Male  &nbsp; &nbsp; 
					<input type="radio" name="gender" value="female" <cfif profile.gender eq "female">checked</cfif>>Female &nbsp; &nbsp; 
				</td>
                <td align="center">
                	<input type="checkbox" name="d_gender" <cfif dp.d_gender eq 1>checked</cfif> value="1"> 
                </td>
			</tr>				
			<tr>				
				<td class="form_instruct" nowrap>
					Marital Status:
				</td>
				<td align="left">
					<input type="radio" name="marital_status" value="single" <cfif profile.marital_status eq "single">checked</cfif>> Single  &nbsp; &nbsp; 
					<input type="radio" name="marital_status" value="in a relationship" <cfif profile.marital_status eq "in a relationship">checked</cfif>> In a Relationship &nbsp; &nbsp; 
					<input type="radio" name="marital_status" value="married" <cfif profile.marital_status eq "married">checked</cfif>> Married &nbsp; &nbsp; 
					<input type="radio" name="marital_status" value="separated" <cfif profile.marital_status eq "separated">checked</cfif>> Separated &nbsp; &nbsp; 
				</td>
                <td align="center">
                	<input type="checkbox" name="d_marital_status" <cfif dp.d_marital_status eq 1>checked</cfif> value="1"> 
                </td>
			</tr>	

			<tr>
				<td class="form_instruct" nowrap>
					Cultural Heritage:
				</td>
				<td align="left">
					<select name="cultural_heritage" size="1">
                   		 <option value="#profile.cultural_heritage#"> #profile.cultural_heritage#</option>
						<option value="0"> Select...</option>
						<option value="Combined Heritage"> Combined Heritage</option>
						<option value="American"> American</option>
						<option value="African"> African</option>
                        <option value="African American"> African American</option>
						<option value="Hispanic"> Hispanic</option>
						<option value="Hispanic"> Latin American</option>
						<option value="Asian"> Asian</option>
						<option value="Middle Eastern"> Middle Eastern</option>
						<option value="Pacific Islander"> Pacific Islander</option>
						<option value="European"> European</option>
						<option value="Eastern European"> Eastern European</option>
						<option value="Austrailian"> Australian</option>
						<option value="Canadian"> Canadian</option>
						<option value="Indian"> Indian</option>
                        <option value="Brazilian"> Brazilian</option>
						<option value="Native American"> Native American</option>
						<option value="Other"> Other</option>
					</select>
				</td>
                <td align="center">
                	<input type="checkbox" name="d_cultural_heritage" <cfif dp.d_cultural_heritage eq 1>checked</cfif> value="1"> 
                </td>
			</tr>	
			<tr>
				<td class="form_instruct" nowrap>
					Number of Children:
				</td>
				<td align="left">
					<input type="text" name="children" size="2" value="#profile.children#">
				</td>
                <td align="center">
                	<input type="checkbox" name="d_children" <cfif dp.d_children eq 1>checked</cfif> value="1"> 
                </td>
			</tr>		
			<tr>
				<td class="form_instruct" nowrap>
					Hobbies:
				</td>
				<td align="left">
					<input type="text" name="hobbies" size="55" value="#profile.hobbies#" maxlength="150"><br>
				</td>
                <td align="center">
                	<input type="checkbox" name="d_hobbies" <cfif dp.d_hobbies eq 1>checked</cfif> value="1"> 
                </td>
			</tr>	
			<tr>
				<td class="form_instruct" nowrap>
					Business or Profession:
				</td>
				<td align="left">
					<input type="text" name="profession" size="30" value="#profile.profession#" maxlength="100"><br>
				</td>
                <td align="center">
                	<input type="checkbox" name="d_profession" <cfif dp.d_profession eq 1>checked</cfif> value="1"> 
                </td>
			</tr>	
            
			<tr>
				<td class="form_instruct">
					Date of Birth:
				</td>
				<td align="left">
					<select name="birth_month" >  <option value="#datePart('m',profile.dob)#" selected> #datePart('m',profile.dob)# </option> <option value="01"> January</option> <option value="02"> February</option> <option value="03"> March</option> <option value="04"> April</option> <option value="05"> May</option> <option value="06"> June</option> <option value="07"> July</option> <option value="08"> August</option> <option value="09"> September</option> <option value="10"> October</option> <option value="11"> November</option> <option value="12"> December</option> </select> 

<select name="birth_day" > <option value="#datePart('d',profile.dob)#" selected>#datePart('d',profile.dob)#</option> <option value="01"> 01</option> <option value="02"> 02</option> <option value="03"> 03</option> <option value="04"> 04</option> <option value="05"> 05</option> <option value="06"> 06</option> <option value="07"> 07</option> <option value="08"> 08</option> <option value="09"> 09</option> <option value="10"> 10</option> <option value="11"> 11</option> <option value="12"> 12</option> <option value="13"> 13</option> <option value="14"> 14</option> <option value="15"> 15</option> <option value="16"> 16</option> <option value="17"> 17</option> <option value="18"> 18</option> <option value="19"> 19</option> <option value="20"> 20</option> <option value="21"> 21</option> <option value="22"> 22</option> <option value="23"> 23</option> <option value="24"> 24</option> <option value="25"> 25</option> <option value="26"> 26</option> <option value="27"> 27</option> <option value="28"> 28</option> <option value="29"> 29</option> <option value="30"> 30</option> <option value="31"> 31</option> </select> 

<select name="birth_year" > <option value="#datePart('yyyy',profile.dob)#" selected>#datePart('yyyy',profile.dob)#</option><option value="1920"> 1920</option><option value="1921"> 1921</option><option value="1922"> 1922</option><option value="1923"> 1923</option><option value="1924"> 1924</option><option value="1925"> 1925</option><option value="1926"> 1926</option><option value="1927"> 1927</option><option value="1928"> 1928</option> <option value="1928"> 1928</option> <option value="1929"> 1929</option> <option value="1930"> 1930</option> <option value="1931"> 1931</option> <option value="1932"> 1932</option> <option value="1933"> 1933</option> <option value="1934"> 1934</option> <option value="1935"> 1935</option> <option value="1936"> 1936</option> <option value="1937"> 1937</option> <option value="1938"> 1938</option> <option value="1939"> 1939</option> <option value="1940"> 1940</option> <option value="1941"> 1941</option> <option value="1942"> 1942</option> <option value="1943"> 1943</option> <option value="1944"> 1944</option> <option value="1945"> 1945</option> <option value="1946"> 1946</option> <option value="1947"> 1947</option> <option value="1948"> 1948</option> <option value="1949"> 1949</option> <option value="1950"> 1950</option> <option value="1951"> 1951</option> <option value="1952"> 1952</option> <option value="1953"> 1953</option> <option value="1954"> 1954</option> <option value="1955"> 1955</option> <option value="1956"> 1956</option> <option value="1957"> 1957</option> <option value="1958"> 1958</option> <option value="1959"> 1959</option> <option value="1960"> 1960</option> <option value="1961"> 1961</option> <option value="1962"> 1962</option> <option value="1963"> 1963</option> <option value="1964"> 1964</option> <option value="1965"> 1965</option> <option value="1966"> 1966</option> <option value="1967"> 1967</option> <option value="1968"> 1968</option> <option value="1969"> 1969</option> <option value="1970"> 1970</option> <option value="1971"> 1971</option> <option value="1972"> 1972</option> <option value="1973"> 1973</option> <option value="1974"> 1974</option> <option value="1975"> 1975</option> <option value="1976"> 1976</option> <option value="1977"> 1977</option> <option value="1978"> 1978</option> <option value="1979"> 1979</option> <option value="1980"> 1980</option> <option value="1981"> 1981</option> <option value="1982"> 1982</option> <option value="1983"> 1983</option> <option value="1984"> 1984</option> <option value="1985"> 1985</option> <option value="1986"> 1986</option> <option value="1987"> 1987</option> <option value="1988"> 1988</option> <option value="1989"> 1989</option> <option value="1990"> 1990</option> <option value="1991"> 1991</option> <option value="1992"> 1992</option> <option value="1993"> 1993</option> <option value="1994"> 1994</option> <option value="1995"> 1995</option> <option value="1996"> 1996</option> <option value="1997"> 1997</option> <option value="1998"> 1998</option> <option value="1999"> 1999</option> <option value="2000"> 2000</option> <option value="2001"> 2001</option> <option value="2002"> 2002</option> <option value="2003"> 2003</option> <option value="2004"> 2004</option> <option value="2005"> 2005</option> <option value="2006"> 2006</option> <option value="2007"> 2007</option> <option value="2008"> 2008</option> <option value="2009"> 2009</option> <option value="2010"> 2010</option> </select> 
	
				</td>
                <td align="center">
                	<input type="checkbox" name="d_dob" <cfif dp.d_dob eq 1>checked</cfif> value="1"> 
                </td>
			</tr>	

       	
			<tr> 
				<td class="submit" colspan="3">

                 
                    
					<input type="hidden" name="function" value="updateMember">
				
			<a href="javascript:;" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('saveChanges2','','images/btn_save_changes_hover.gif',1)"><input type="image" src="images/btn_save_changes.gif" alt="Save Changes" name="saveChanges2" id="saveChanges2" width="187" height="45" border="0"></a>
				</td>
			</tr>	
			<tr>
				<td colspan="2">&nbsp;
				
				</td>
			</tr>				
		</table>
	</form>		

		<!--- Upload image and personal details --->
 	
		<table width="100%" border="0" cellspacing="1" cellpadding="5" class="dkblue12" bgcolor="FFFFFF">
			<tr> 
				<td class="header" colspan="2">
					Upload Profile Picture & Details
				</td>
			</tr>
       <form action="actions/act_upload.cfm" method="post" enctype="multipart/form-data">
           <tr> 
              <td class="form_instruct" width="25%">
                     Upload Image                       
                  	<br>
                 <span class="stars">***</span> <span class="dkblue12"> (Image will be displayed at <strong>75 pixels width</strong> by <strong>75 pixels height</strong>)</span>
              </td>
              <td class="form_input"> 
                  <table class="dkblue12">
                  	  <tr>
                    	<td align="left">
                          <input type="file" name="upload_image" size="40" /><br />
                          browse for image
                          <br /><br />
                          <input type="text" name="quote" size="40" maxlength="100" value="#profile.quote#"/><br />
                          optional quote
                       </td>
                     	<td align="center">
                        	<cfif profile.image neq "">
                            	<img src="media/#client.mid#/#profile.image#" width="75" height="75"><br>
                                (current image)
                            </cfif>
                        </td>
                      </tr>
                  </table>
               
              </td>
          </tr>
			<tr> 
				<td colspan="2" class="submit">
                    
					<input type="hidden" name="function" value="updateProfile">
				
				<a href="javascript:;" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('saveChanges1','','images/btn_save_changes_hover.gif',1)"><input type="image" src="images/btn_save_changes.gif" alt="Save Changes" name="saveChanges1" id="saveChanges1" width="187" height="45" border="0"></a>
				</td>
			</tr>
			<tr>
				<td colspan="2">&nbsp;
				
				</td>
			</tr>	
			
       </form>
       
       
       <cfform action="components/act_Members.cfm" method="post" name="detailsForm">
           <tr> 
              <td class="form_instruct" width="25%">
                  <p class="small-spacer">&nbsp;</p>
                     Additional Details     
                     <br>                 
                  	<span class="dkblue10">
                    (To be dispayed on Profile)
                    <br><br>
                    </span>
              </td>
              <td class="basic_td"> 
              	
                    <cftextarea name="details" cols="63" rows="10" richtext="true" toolbar="Basic">#profile.details#</cftextarea>
					<br>
					Your Profile Details go here.
              </td>
          </tr>    
			<tr> 
				<td colspan="2" class="submit">                    
					<input type="hidden" name="function" value="updateDetails">
					<a href="javascript:;" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('saveChanges5','','images/btn_save_changes_hover.gif',1)"><input type="image" src="images/btn_save_changes.gif" alt="Save Changes" name="saveChanges5" id="saveChanges5" width="187" height="45" border="0"></a>
				</td>
			</tr>
         </cfform>
        </table>
        <br>
 		<table width="100%" border="0" cellspacing="1" cellpadding="5" class="dkblue12" bgcolor="FFFFFF">
        <form action="actions/act_emailSettings.cfm" method="post" name="email">
			<tr> 
				<td class="header" colspan="2">
					Email Settings
				</td>
			</tr>    
			<tr> 
            	<td bgcolor="FFFFFF" align="center">    
            		<input type="checkbox" name="email_requests" value="1" <cfif profile.email_requests eq 1>checked</cfif>>
                </td>
				<td bgcolor="FFFFFF">                    
					  Yes, Email me when other members need feedback on new Choices/Decisions 
                      <br>
                      that are in the <strong>CATEGORIES</strong> I have selected in my "Category Preferences" below.
				</td>
			</tr>
			<tr> 
            	<td bgcolor="FFFFFF" align="center"> 
            		<input type="checkbox" name="email_requests_g" value="1" <cfif profile.email_requests_g eq 1>checked</cfif>> 
                </td>
				<td bgcolor="FFFFFF">                    
					Yes, Email me when other members need feedback on new Choices/Decisions 
                    <br>
                    that are sent out to <strong>GROUPS</strong> that I have been added to.
				</td>
			</tr>
			<tr> 
            	<td bgcolor="FFFFFF" align="center"> 
                	<input type="checkbox" name="email_requests_t" value="1" <cfif profile.email_requests_t eq 1>checked</cfif>>
                </td>
				<td bgcolor="FFFFFF">                    
					Yes, Email me when other members need feedback on new Choices/Decisions 
                    <br> 
                    that are sent out to <strong>TARGETED MEMBERS</strong> that I meet the criteria for.
				</td>
			</tr>
			<tr> 
				<td colspan="2" class="submit">                    
					<input type="hidden" name="function" value="emailRequests">
					<a href="javascript:;" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('saveChanges3','','images/btn_save_changes_hover.gif',1)"><input type="image" src="images/btn_save_changes.gif" alt="Save Changes" name="saveChanges3" id="saveChanges3" width="187" height="45" border="0"></a>
				</td>
			</tr>
        </form>
       </table>              
       <br>
         <table width="100%" border="0" cellspacing="1" cellpadding="5" class="dkblue12" bgcolor="FFFFFF">
              <form action="actions/act_Cats.cfm" method="post" name="cats">
                  <tr> 
                      <td class="header" colspan="4">
                          Category Preferences
                      </td>
                  </tr>    
                  <tr>
                      <td  bgcolor="##e1f5ff" nowrap colspan="4">
                          Please check the categories would you like to give feedback on below, and click on "Submit."
                      </td>
                  </tr>
                      <td align="left">
                          <cfloop query="cats" startrow="1" endrow="10">
                             <input type="checkbox" name="#cats.id#" value="1" <cfif arrayFind(catArrayList,cats.id) neq 0>CHECKED</cfif>> &nbsp; #cats.cat_name#<br>
                          </cfloop>
                      </td>
                      <td align="left">
                          <cfloop query="cats" startrow="11" endrow="20">
                             <input type="checkbox" name="#cats.id#" value="1" <cfif arrayFind(catArrayList,cats.id) neq 0>CHECKED</cfif>> &nbsp; #cats.cat_name#<br>
                          </cfloop>
                      </td> 
                      <td align="left">
                          <cfloop query="cats" startrow="21" endrow="30">
                             <input type="checkbox" name="#cats.id#" value="1" <cfif arrayFind(catArrayList,cats.id) neq 0>CHECKED</cfif>> &nbsp; #cats.cat_name#<br>
                          </cfloop>
                      </td>       
                      <td align="left">
                          <cfloop query="cats" startrow="31" endrow="40">
						  		<cfif cats.cat_name neq "R-Rated">
                             		<input type="checkbox" name="#cats.id#" value="1" <cfif arrayFind(catArrayList,cats.id) neq 0>CHECKED</cfif>> &nbsp; #cats.cat_name#<br>
								<cfelse>
									<cfif DateDiff("yyyy", profile.dob, dateFormat(now(),"mm/dd/yyyy")) gte 18>
										<input type="checkbox" name="#cats.id#" value="1" <cfif arrayFind(catArrayList,cats.id) neq 0>CHECKED</cfif>> &nbsp; #cats.cat_name#<br>
									</cfif>	
								</cfif>	
                          </cfloop>
                      </td>    
                  </tr>	

                  <tr> 
                      <td colspan="4" class="submit">                    
                          <input type="hidden" name="function" value="chooseCats">
                          <a href="javascript:;" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('saveChanges4','','images/btn_save_changes_hover.gif',1)"><input type="image" src="images/btn_save_changes.gif" alt="Save Changes" name="saveChanges4" id="saveChanges4" width="187" height="45" border="0"></a>
                      </td>
                  </tr>
              </form>
          </table>  
        <br>
 		<table width="100%" border="0" cellspacing="1" cellpadding="5" class="dkblue12" bgcolor="FFFFFF">
            <tr>
                <td colspan="2" class="basic_td">
                    <p class="med-spacer">&nbsp;</p>
                </td>
            </tr>
            <tr> 
				<td class="form_instruct">
					Cancel Membership
				</td>
                <td class="form_input">      
					If for any reason you want to cancel your membership click on the link below.
					<br><br>             
                    <a href="actions/act_cancelMembership.cfm" class="bodylink" onClick="return confirm('Are you sure you want to cancel your Membership? All your choices & feedback will be lost.')">Cancel Membership</a> 
                </td>
            </tr>
            <tr>
                <td colspan="2" class="basic_td">
                    <p class="med-spacer">&nbsp;</p>
                </td>
            </tr>
       </table>
       
               


        
   </cfoutput>
</body>
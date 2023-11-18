
<script type="javascript">
 function checkUsername() {
    var uvalue = document.getElementById("username").value;
    if(uvalue.length < 4) { status(''); return; }
    Spry.Utils.loadURL("GET","userchecker.cfm?username="+encodeURIComponent(uvalue), false, usercheck);
      
 }
 
 function usercheck(request) {
   var result = request.xhRequest.responseText;
     
   if(result == 0) status("Username not available!");
    else status('');
 }
 
 
 function status(str) {
     var resultblock = document.getElementById("resultblock");
      resultblock.innerHTML = str;    
 }
</script>



  <form id="userform" action="null.html" method="post">
 <h2>Register</h2>
<table width="600" border="0">
    <tr valign="top">
          <td align="right" width="200">username (min 4 characters)</td>
       <td width="400"><input type="text" id="username" name="username" onKeyUp="checkUsername()">
        <span id="resultblock" class="error"></span></td>
   </tr>
      <tr>
         <td align="right">password</td>
         <td><input type="password" name="password"></td>
    </tr>
     <tr>
         <td align="right">confirm password</td>
         <td><input type="password2" name="password2"></td>
     </tr>
    <tr>
         <td> </td>
        <td><input type="button" value="Fake Submit"></td>
 </tr>
</table>
</form> 
<cfsetting showdebugoutput=false>
 
 <cfparam name="url.username" default="bob">
 
  <cfset takennames="victor,jack,ashley,gloria,nikki">

 <cfif listFindNoCase(takennames, url.username)>
      <cfset available = 0>
 <cfelse>
      <cfset available = 1>
  </cfif>
  
  <cfoutput>#available#</cfoutput>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:fb="http://www.facebook.com/2008/fbml">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>MakeMyChoice</title>
  </head>
  <body>
    <p><fb:login-button perms="email,user_birthday" autologoutlink="true"></fb:login-button></p>
    <p><fb:like></fb:like></p>

    <div id="fb-root"></div>
    <script>
      window.fbAsyncInit = function() {
        FB.init({appId: '124300240957990', status: true, cookie: true,
                 xfbml: true});
      };
      (function() {
        var e = document.createElement('script');
        e.type = 'text/javascript';
        e.src = document.location.protocol +
          '//connect.facebook.net/en_US/all.js';
        e.async = true;
        document.getElementById('fb-root').appendChild(e);
		
		
		FB.api(
				  {
					method: 'fql.query',
					query: 'SELECT name FROM user WHERE uid=5526183'
				  },
				  function(response) {
					alert('Name is ' + response[0].name);
				  }
				);

		
      }());
    </script>
  </body>
</html>
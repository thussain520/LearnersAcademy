<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Learner's Academy Login</title>

  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  
  <link rel="stylesheet" href="resources/adminlte.min.css">

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>  
    <script>
    
        function LoginCheck()
        {
		    var user = $("#username").val()
		    var pass = $("#password").val();
		    if(user == "" || pass == "")
	    	{
		    	alert("Please fill all fields");
	    		return;
	    	}
		    $.ajax({
		    	  type: "POST",
		          url: "AjaxProcess.jsp",
		          data: {act:"LoginCheck", username:user, password: pass},
		          success:function(success){
		            if(success.trim() != "login invalid")
	            	{
		            	var jData = JSON.parse(success);
		            	var formObj = document.createElement("form");
		            	var uname = document.createElement("input"); 
		                var url = "AdminHome.jsp";
		                document.body.appendChild(formObj);
		                formObj.action = url;
		                formObj.method = "post";
		                
		                uname.type="hidden";
		                uname.value=jData.uname;
		                uname.name="user_name";
		                formObj.appendChild(uname);  
		                formObj.submit();
	            		
	            	}
		            else
	            	{
	            		alert("Invalid Username or Password");
	            	}
		          }
		    });
        }
    
    </script>
</head>

<body class="hold-transition login-page">

<div class="login-box">
  <!-- /.login-logo -->
  <div class="card card-outline card-primary">
    <div class="card-header text-center">
      <a href="" class="h1">Learner's Academy</a>
    </div>
    <div class="card-body">
      <p class="login-box-msg">Sign in to start your session</p>

      <form action="../../index3.html" method="post">
        <div class="input-group mb-3">
          <input type="text" id="username" class="form-control" required placeholder="Username">
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fa fa-user"></span>
            </div>
          </div>
        </div>
        <div class="input-group mb-3">
          <input type="password" id="password" class="form-control" required placeholder="Password">
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fa fa-lock"></span>
            </div>
          </div>
        </div>
        <div class="row">
          
          <!-- /.col -->
          <div class="col-4">
            <button type="button" onclick="javascript:LoginCheck();"  class="btn btn-primary btn-block">Sign In</button>
          </div>
          <!-- /.col -->
        </div>
      </form>

    </div>
    <!-- /.card-body -->
  </div>
  <!-- /.card -->
</div>
<!-- /.login-box -->

<!-- jQuery -->

<!-- Bootstrap 4 -->

<!-- AdminLTE App -->

</body>
</html>

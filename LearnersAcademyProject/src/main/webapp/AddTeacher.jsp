<%@page import="java.util.Date"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.util.List"%>
<%@page import="javax.persistence.NoResultException"%>
<%@page import="org.hibernate.Query"%>
<%@page import="org.hibernate.Session"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.learnersacademy.ConnectUtility" %> 
<%
String adminName = null;
if(session.getAttribute("user")!=null)
{
	adminName = session.getAttribute("user").toString();
}
else
{
	response.sendRedirect("index.jsp");
}
%>    
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Add New Teacher | Learners Academy</title>
  
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>  
  <link rel="stylesheet" href="resources/adminlte.min.css">
  
  <script>
    
        function AddTeacher()
        {
		    var teacherName = $("#addTeacherId").val()
		    var username = $("#addUsernameId").val()
		    var password = $("#addPasswordId").val()
		    if(teacherName == "" || username == "" || password == "")
	    	{
		    	alert("Please fill all fields");
	    		return;
	    	}
		    $.ajax({
		    	  type: "POST",
		          url: "AjaxProcess.jsp",
		          data: {act:"AddTeacher", teacherName: teacherName, username:username, password: password},
		          success:function(response){
		            if(response.trim() == "success")
	            	{
	            		window.location.reload(true);
	            	}
		            else
	            	{
		            	alert("There is an error in saving new teacher");
	            	}
		          }
		    });
        }
    
    </script>
  
</head>
<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">

  
  <div class="preloader flex-column justify-content-center align-items-center">
    <img class="animation__shake" src="resources/Loading.gif" alt="Learners Academy" height="60" width="60">
  </div>

  
  <nav class="main-header navbar navbar-expand navbar-white navbar-light">
    
    <ul class="navbar-nav ml-auto">
      
    
  </nav>
  
  <aside class="main-sidebar sidebar-dark-primary elevation-4">
      
    <%
    	
    %>

    
    <div class="sidebar">
      
      <div class="user-panel mt-3 pb-3 mb-3 d-flex">
        
        <div class="info">
          <a href="AdminHome.jsp" class="d-block">Welcome <%= adminName %></a>
        </div>
      </div>

      
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          
          <li class="nav-item menu-open">
            
            <ul class="nav nav-treeview">
              
            </ul>
          </li>
          
          <li class="nav-item">
            <a href="AddClass.jsp" class="nav-link">
              <i class="fa fa-circle nav-icon"></i>
              <p>Add Class</p>
            </a>
          </li>


          <li class="nav-item">
            <a href="AddTeacher.jsp" class="nav-link">
              <i class="fa fa-circle nav-icon"></i>
              <p>Add Teacher</p>
            </a>
          </li>
          <li class="nav-item">
            <a href="AddSubject.jsp" class="nav-link">
              <i class="fa fa-circle nav-icon"></i>
              <p>Add Subject</p>
            </a>
          </li>

          <li class="nav-item">
            <a href="AddSubToClass.jsp" class="nav-link">
              <i class="fa fa-circle nav-icon"></i>
              <p>Add Subjects to Class</p>
            </a>
          </li>

          <li class="nav-item">
            <a href="AssTeacherToClass.jsp" class="nav-link">
              <i class="fa fa-circle nav-icon"></i>
              <p>Assign Teacher to Class</p>
            </a>
          </li>
          <li class="nav-item">
            <a href="AddStudent.jsp" class="nav-link">
              <i class="fa fa-circle nav-icon"></i>
              <p>Add Student</p>
            </a>
          </li>
          <li class="nav-item">
            <a href="Logout.jsp" class="nav-link">
              <i class="fa fa-circle nav-icon"></i>
              <p>Signout</p>
            </a>
          </li>
        </ul>
      </nav>
    
    </div>
    
  </aside>

  
  <div class="content-wrapper">
    
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0"></h1>
          </div>
          
        </div>
      </div>
    </div>
    <section class="content">
      <div class="container-fluid">
        <div class="row">
          <!-- left column -->
          <div class="col-md-12">
            
            <div class="card card-primary">
              <div class="card-header">
                <h3 class="card-title">Add New Teacher</h3>
              </div>
              <!-- /.card-header -->
              <!-- form start -->
              <form id="quickForm">
                <div class="card-body">
                  <div class="form-group">
                    <input type="text" name="addTeacher" class="form-control" id="addTeacherId" placeholder="Enter New Teacher Name">
                  </div>
                  <div class="form-group">
                    <input type="text" name="addPasswordr" class="form-control" id="addUsernameId" placeholder="Enter New Teacher Password">
                  </div>
                  <div class="form-group">
                    <input type="text" name="addUsername" class="form-control" id="addPasswordId" placeholder="Enter New Teacher Username">
                  </div>
                  <button type="button" onclick="javascript:AddTeacher();" class="btn btn-primary">Add Teacher</button>
                </div>
                
              </form>
            </div>
            <!-- /.card -->
            </div>
          <!--/.col (left) -->
          <!-- right column -->
          <div class="col-md-6">

          </div>
          <!--/.col (right) -->
        </div>
        <!-- /.row -->
      </div><!-- /.container-fluid -->
    </section>
    <section class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-12">
            <div class="card">
              <div class="card-header">
                <h3 class="card-title">List of all available teachers</h3>
              </div>
              <!-- /.card-header -->
              <div class="card-body">
                <table id="example2" class="table table-bordered table-hover">
                  <thead>
                  <tr>
                    <th>Teacher Name</th>
                    <th>Username</th>
                    <th>Password</th>
                    <th>Added By</th>
                    <th>Add Date</th>
                  </tr>
                  </thead>
                  <tbody>
                 <%
                 
                 Session sessionObj = ConnectUtility.getSessionFactory().openSession();
                 Query query=sessionObj.createQuery("select u.name, u.username, u.password, u1.name, u.creationDate from Users as u JOIN u.createdBy as u1 INNER JOIN u.role as r where r.role='teacher'");
                 List<Object[]> list = query.getResultList();
                 for(Object[] c : list)
                 {
                	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
          			Date date = sdf.parse(c[4].toString());
                 %> 
                 
                  <tr>
                    <td><%=c[0].toString() %></td>
                    <td><%=c[1].toString() %></td>
                    <td><%=c[2].toString() %></td>
                    <td><%=c[3].toString() %></td>
                    <td><%=sdf.format(date) %></td>
                  </tr>
                  <%
                 }
                 sessionObj.close();
                  %>
                  </tbody>
                  
                </table>
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->

            
            <!-- /.card -->
          </div>
          <!-- /.col -->
        </div>
        <!-- /.row -->
      </div>
      <!-- /.container-fluid -->
    </section>
    
  </div>
  
  <aside class="control-sidebar control-sidebar-dark">
    
  </aside>
  
</div>


<script src="resources/adminlte.js"></script>

</body>
</html>

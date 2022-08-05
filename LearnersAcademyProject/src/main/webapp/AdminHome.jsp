<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
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
  <title>Admin Home | Learners Academy</title>
  
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>  
  <link rel="stylesheet" href="resources/adminlte.min.css">
  
  
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
            <h1 class="m-0">Welcome to Learner's Academy LMS System</h1><br/>
            <h3>Please select an option from the menu</h3>
          </div>
         
        </div>
      </div>
    </div>
  </div>
  
  <aside class="control-sidebar control-sidebar-dark">
    
  </aside>
  
</div>


<script src="resources/adminlte.js"></script>

</body>
</html>

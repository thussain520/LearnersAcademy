<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.util.List"%>
<%@page import="javax.persistence.NoResultException"%>
<%@page import="org.hibernate.Query"%>
<%@page import="org.hibernate.Session"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.learnersacademy.ConnectUtility, com.learnersacademy.Classes" %> 
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
  <title>Add Subject to Class | Learners Academy</title>
  
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>  
  <link rel="stylesheet" href="resources/adminlte.min.css">
  
  <script>
    
        function AddSubject()
        {
        	var classId = $("#classId").val()
		    var subjectId = $("#subjectId").val()
		    $.ajax({
		    	  type: "POST",
		          url: "AjaxProcess.jsp",
		          data: {act:"AddSubjectToClass", classId: classId, subjectId: subjectId},
		          success:function(response){
		            if(response.trim() != "no data" || response.trim() != "error")
	            	{
	            		$("#tableId").html(response.trim());
	            	}
		            else
	            	{
		            	alert("There is an error or no data found");
	            	}
		          }
		    });
        }
        function loadSubjects()
        {
		    var classId = $("#classId").val()
		    if(classId.value == "select")
	    	{
	    		alert("Please select class to load assigned subjects");
	    		return;
	    	}
		    
		    $.ajax({
		    	  type: "POST",
		          url: "AjaxProcess.jsp",
		          data: {act:"loadAssSubjects", classId: classId},
		          success:function(response){
		        	  if(response.trim() != "no data" || response.trim() != "error")
	            	  {
	            		  $("#tableId").html(response.trim());
	            	  }
		              else
	            	  {
		            	  alert("There is an error or no data found");
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
                <h3 class="card-title">Add Subjects to a Class</h3>
              </div>
              <!-- /.card-header -->
              <!-- form start -->
              <form id="quickForm">
                <div class="card-body">
                	<div class="col-12 col-sm-6">
	                	<div class="form-group">
	                	<%
	                	Session sessionObj = ConnectUtility.getSessionFactory().openSession();
	                	Query query=sessionObj.createQuery("select classId, className from Classes");
	                	List<Object[]> clist = query.getResultList();
	                	query = sessionObj.createQuery("select subId, subName from Subjects");
	                	List<Object[]> slist = query.getResultList();
	                	%>
			                <label>Select Class</label>
			                	<select class="form-control select2 select2-danger" id="classId" data-dropdown-css-class="select2-danger" onchange="loadSubjects();" style="width: 100%;">
			                	<%
			                		for(Object [] clas : clist)	
			                		{
			                	%>
			                			<option value="<%=clas[0] %>"> <%=clas[1] %></option>
			                	<%
			                		}
			                	%>	
			                </select>
	                	</div>
		            </div>
                 	<div class="col-12 col-sm-6">
		                <div class="form-group">
		                  <label>Select Subject</label>
		                  <select class="form-control select2 select2-danger" id="subjectId" data-dropdown-css-class="select2-danger" style="width: 100%;" onchange="loadSubjects(this)">
		                  		<%
			                		for(Object [] subject : slist)	
			                		{
			                	%>
			                			<option value="<%=subject[0] %>"> <%=subject[1] %></option>
			                	<%
			                		}
			                	%>	
		                  </select>
		                </div>
              		</div>
                  <button type="button" onclick="javascript:AddSubject();" class="btn btn-primary">Add Subject</button>
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
                <h3 class="card-title">List of assigned classes and subjects</h3>
              </div>
              <!-- /.card-header -->
              <div class="card-body">
                <table id="example2" class="table table-bordered table-hover">
                  <thead>
                  <tr>
                    <th>Sr. No.</th>
                    <th>Class Name</th>
                    <th>Assigned Subject</th>
                    <th>Added By</th>
                    <th>Add Date</th>
                  </tr>
                  </thead>
                  <tbody id="tableId">
	                  
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

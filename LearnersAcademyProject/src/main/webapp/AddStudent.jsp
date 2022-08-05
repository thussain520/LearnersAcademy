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
  <title>Add New Student | Learners Academy</title>
  
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>  
  <link rel="stylesheet" href="resources/adminlte.min.css">
  
  <script>
    
        function AddStudent()
        {
		    var studentName = $("#addStudentId").val()
		    var username = $("#addUsernameId").val()
		    var password = $("#addPasswordId").val()
		    if(studentName == "" || username == "" || password == "")
	    	{
		    	alert("Please fill all fields");
	    		return;
	    	}
		    $.ajax({
		    	  type: "POST",
		          url: "AjaxProcess.jsp",
		          data: {act:"AddStudent", studentName: studentName, username:username, password: password},
		          success:function(response){
		            if(response.trim() == "success")
	            	{
	            		window.location.reload(true);
	            	}
		            else
	            	{
		            	alert("There is an error in saving new student");
	            	}
		          }
		    });
        }
        function updateClass(obj, studentId)
        {
		    if(obj.value == "select")
	    	{
	    		alert("Please select valid class");
	    		return;
	    	}
		    
		    $.ajax({
		    	  type: "POST",
		          url: "AjaxProcess.jsp",
		          data: {act:"updateStudentClass", classId: obj.value, studentId: studentId},
		          success:function(response){
		            if(response.trim() == "success")
	            	{
		            	alert("Class is assigned to this student successfully!");
	            		window.location.reload(true);
	            	}
		            else
	            	{
		            	alert("There is an error in saving new student");
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
                <h3 class="card-title">Add New Student</h3>
              </div>
              <!-- /.card-header -->
              <!-- form start -->
              <form id="quickForm">
                <div class="card-body">
                  <div class="form-group">
                    <input type="text" name="addStudent" class="form-control" id="addStudentId" placeholder="Enter New Student Name">
                  </div>
                  <div class="form-group">
                    <input type="text" name="addUsername" class="form-control" id="addUsernameId" placeholder="Enter New Student Password">
                  </div>
                  <div class="form-group">
                    <input type="text" name="addPassword" class="form-control" id="addPasswordId" placeholder="Enter New Student Username">
                  </div>
                  <button type="button" onclick="javascript:AddStudent();" class="btn btn-primary">Add Student</button>
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
                <h3 class="card-title">List of all available students</h3>
              </div>
              <!-- /.card-header -->
              <div class="card-body">
                <table id="example2" class="table table-bordered table-hover">
                  <thead>
                  <tr>
                    <th>Sr. No.</th>
                    <th>Student Name</th>
                    <th>Username</th>
                    <th>Password</th>
                    <th>Added By</th>
                    <th>Add Date</th>
                    <th>Update Class</th>
                  </tr>
                  </thead>
                  <tbody>
                 <%
                 
                 Session sessionObj = ConnectUtility.getSessionFactory().openSession();
                 Query query=sessionObj.createQuery("select u.name, u.username, u.password, u1.name, u.creationDate, u.userId, u.classId from Users as u JOIN u.createdBy as u1 INNER JOIN u.role as r where r.role='student'");
                 try{
	                 List<Object[]> list = query.getResultList();
	                 Query query1=sessionObj.createQuery("From Classes");
	                 List<Classes> lists = (List<Classes>)query1.list(); 
	                 int count = 1;
	                 
	                 for(Object[] c : list)
	                 {
	                	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	          			Date date = sdf.parse(c[4].toString());
	                 %> 
	                 
	                  <tr>
	                  	<td><%=count %></td>
	                    <td><%=c[0].toString() %></td>
	                    <td><%=c[1].toString() %></td>
	                    <td><%=c[2].toString() %></td>
	                    <td><%=c[3].toString() %></td>
	                    <td><%=sdf.format(date) %></td>
	                    <td>
	                    <select onchange="updateClass(this, <%=c[5].toString() %>);" class="form-control select2 select2-danger" data-dropdown-css-class="select2-danger" style="width: 100%;">
	                    <option value="select"> Select Class</option>
	                    <%
	                    	int cId = 0;
	                    	if(c[6] !=null)
	                    	{
	                    		cId = Integer.parseInt(c[6].toString());
	                    	}
	                    	for(Classes clas : lists)
	                    	{
	                    		if(cId == clas.getClassId())
	                    		{
	                    %>
	                    	<option selected="true" value="<%=clas.getClassId() %>">
	                    		<%=clas.getClassName() %>
	                    	</option>
	                   	<%
	                    		}
	                    		else
	                    		{
	                    %>
	                    	<option value="<%=clas.getClassId() %>">
	                    		<%=clas.getClassName() %>
	                    	</option>
	                    <%			
	                    		}
	                   		}
	                   	%>
	                    </select>
	                    </td>
	                  </tr>
	                  <%
	                  count++;
	                 }
                 }catch(Exception e)
                 {
                	 e.printStackTrace();
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

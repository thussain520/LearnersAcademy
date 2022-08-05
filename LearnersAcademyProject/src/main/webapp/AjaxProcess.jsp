<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.util.List"%>
<%@page import="javax.persistence.NoResultException"%>
<%@page import="org.hibernate.Query"%>
<%@page import="java.text.SimpleDateFormat"%> 
<%@page import="org.hibernate.Session"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.learnersacademy.Users, com.learnersacademy.ConnectUtility, com.learnersacademy.Classes, com.learnersacademy.Roles, com.learnersacademy.Subjects, com.learnersacademy.TeacherInfo, com.learnersacademy.SubjectInfo" %>  

<%
Session sessionObj = ConnectUtility.getSessionFactory().openSession();
if(request.getParameter("act").equals("LoginCheck"))
{
	Query query=sessionObj.createQuery("select r.role, u.name, u.userId from Users as u INNER JOIN u.role as r where u.username=:username and u.password=:password");
    query.setParameter("username", request.getParameter("username"));
    query.setParameter("password", request.getParameter("password"));
    try{
	    Object[] list = (Object[]) query.getSingleResult();
	    
	     if(list != null) {
	    	
	       if(list[0].toString().equals("admin"))
	       {
	    	   String ss = "{\"act\": \"success\", \"uname\" : \""+list[1].toString()+"\"}"; 
	    	   JSONParser parser =  new JSONParser();
	    	   session.setAttribute("user", list[1].toString());
	    	   session.setAttribute("userId", list[2].toString());
	    	   out.print(parser.parse(ss));
	       }
	       else
	       {
	    	   out.print("login invalid");
	       }
	    	
	    }else {
	       out.print("login invalid");
	    }
    }
    catch(NoResultException e)
    {
    	e.printStackTrace();
    	out.print("login invalid");
    }
    sessionObj.close();
}
else if(request.getParameter("act").equals("AddClass"))
{
	Classes clas = new Classes();
	clas.setClassName(request.getParameter("className"));
	clas.setUserId(Integer.parseInt(session.getAttribute("userId").toString()));
	try{
		Transaction txn = sessionObj.beginTransaction();
		sessionObj.save(clas);
		txn.commit();
		out.print("success");
	}
	catch(Exception e)
	{
		out.print("error");
		e.printStackTrace();
	}
	sessionObj.close();
}
else if(request.getParameter("act").equals("AddTeacher"))
{
	Users user = new Users();
	user.setName(request.getParameter("teacherName"));
	user.setUsername(request.getParameter("username"));
	user.setPassword(request.getParameter("password"));
	user.setcBy(Integer.parseInt(session.getAttribute("userId").toString()));
	Query query=sessionObj.createQuery("select roleId from Roles where role='teacher'");
	Integer roleId = Integer.parseInt(query.getSingleResult().toString());
	if(roleId != 0)
		user.setRoleId(roleId);
	
	try{
		Transaction txn = sessionObj.beginTransaction();
		sessionObj.save(user);
		txn.commit();
		out.print("success");
	}
	catch(Exception e)
	{
		out.print("error");
		e.printStackTrace();
	}
	sessionObj.close();
}
else if(request.getParameter("act").equals("AddStudent"))
{
	Users user = new Users();
	user.setName(request.getParameter("studentName"));
	user.setUsername(request.getParameter("username"));
	user.setPassword(request.getParameter("password"));
	user.setcBy(Integer.parseInt(session.getAttribute("userId").toString()));
	Query query=sessionObj.createQuery("select roleId from Roles where role='student'");
	Integer roleId = Integer.parseInt(query.getSingleResult().toString());
	if(roleId != 0)
		user.setRoleId(roleId);
	
	try{
		Transaction txn = sessionObj.beginTransaction();
		sessionObj.save(user);
		txn.commit();
		out.print("success");
	}
	catch(Exception e)
	{
		out.print("error");
		e.printStackTrace();
	}
	sessionObj.close();
}
else if(request.getParameter("act").equals("AddSubject"))
{
	Subjects subject = new Subjects();
	subject.setSubName(request.getParameter("subjectName"));
	
	subject.setUserId(Integer.parseInt(session.getAttribute("userId").toString()));
	
	try{
		Transaction txn = sessionObj.beginTransaction();
		sessionObj.save(subject);
		txn.commit();
		out.print("success");
	}
	catch(Exception e)
	{
		out.print("error");
		e.printStackTrace();
	}
	sessionObj.close();
}

else if(request.getParameter("act").equals("updateStudentClass"))
{	
	
	try{
		Transaction txn = sessionObj.beginTransaction();
		Query query = sessionObj.createQuery("update Users set classId=:cid, cBy=:uid where userId=:sid");
		query.setParameter("cid", Integer.parseInt(request.getParameter("classId")));
		query.setParameter("uid", Integer.parseInt(session.getAttribute("userId").toString()));
		query.setParameter("sid", Integer.parseInt(request.getParameter("studentId")));
		int count = query.executeUpdate();
		txn.commit();
		if(count >0)
			out.print("success");
		else 
			out.print("no update");
	}
	catch(Exception e)
	{
		out.print("error");
		e.printStackTrace();
	}
	sessionObj.close();
}
else if(request.getParameter("act").equals("loadSubjects"))
{	
	String resp = loadClassSubjects(Integer.parseInt(request.getParameter("classId")));
	out.print(resp);
}
else if(request.getParameter("act").equals("AssignSubToTeacher"))
{	
	
	try{
		TeacherInfo tinfo = new TeacherInfo();
		tinfo.setClassId(Integer.parseInt(request.getParameter("classId")));
		tinfo.setSubId(Integer.parseInt(request.getParameter("subjectId")));
		tinfo.setUserId(Integer.parseInt(request.getParameter("teacherId")));
		tinfo.setcBy(Integer.parseInt(session.getAttribute("userId").toString()));
		Transaction txn = sessionObj.beginTransaction();
		sessionObj.save(tinfo);
		txn.commit();
		String resp = loadTeacherAssClass(Integer.parseInt(request.getParameter("teacherId")));
		out.print(resp);
	}
	catch(Exception e)
	{
		out.print("error");
		e.printStackTrace();
	}
	sessionObj.close();
}
else if(request.getParameter("act").equals("AddSubjectToClass"))
{	
	
	try{
		SubjectInfo sinfo = new SubjectInfo();
		sinfo.setClassId(Integer.parseInt(request.getParameter("classId")));
		sinfo.setSubId(Integer.parseInt(request.getParameter("subjectId")));
		sinfo.setcBy(Integer.parseInt(session.getAttribute("userId").toString()));
		Transaction txn = sessionObj.beginTransaction();
		sessionObj.saveOrUpdate(sinfo);
		txn.commit();
		String resp = loadSubjectsofClass(Integer.parseInt(request.getParameter("classId")));
		out.print(resp);
	}
	catch(Exception e)
	{
		out.print("error");
		e.printStackTrace();
	}
	sessionObj.close();
}
else if(request.getParameter("act").equals("loadAssSubjects"))
{
	String resp = loadSubjectsofClass(Integer.parseInt(request.getParameter("classId")));
	out.print(resp);
}
else if(request.getParameter("act").equals("loadTeacherAssClass"))
{
	String resp = loadTeacherAssClass(Integer.parseInt(request.getParameter("teacherId")));
	out.print(resp);
}
%>
<%!
public String loadSubjectsofClass(int classId)
{
	try{
		Connection con = ConnectUtility.getConnection();
		Statement stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery("select c.className, s.subName, u.name, si.creationDate from subjectinfo si JOIN classes c on c.classId=si.classId JOIN subjects s on s.subId=si.subId JOIN users u on u.userId=si.createdBy where si.classId="+classId);
		String resp = "";
		int count = 1;
		while(rs.next())
		{
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date date = sdf.parse(rs.getString(4));
			resp+= "<tr>"
					+ "<td> " + count + " </td>"
					+ "<td> " + rs.getString(1) + " </td>"
					+ "<td>" + rs.getString(2) + "</td>"
					+ "<td>" + rs.getString(3) + "</td>"
					+ "<td>" + sdf.format(date) + "</td>"
					+ "</tr>";
			count++;		
		}
		con.close();
		if(resp != "")
		{
			return resp;
		}
		else
		{
			return "no data";
		}
	}catch(Exception e){
		e.printStackTrace();
		return "no data";
	}
}
public String loadClassSubjects(int classId)
{
	try{
		Connection con = ConnectUtility.getConnection();
		Statement stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery("select s.subId, s.subName from subjectinfo si JOIN subjects s on s.subId=si.subId where si.classId="+classId);
		String resp = "";
		int count = 1;
		while(rs.next())
		{
			resp+= "<option value=" + rs.getInt(1) + "> " + rs.getString(2) + "</option>";
			count++;		
		}
		con.close();
		if(resp != "")
		{
			return resp;
		}
		else
		{
			return "<option>no data</option>";
		}
	}catch(Exception e){
		e.printStackTrace();
		return "error";
	}
}
public String loadTeacherAssClass(int teacherId)
{
	try{
		Connection con = ConnectUtility.getConnection();
		Statement stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery("select u1.name, c.className, s.subName, u.name, ti.creationDate from teacherinfo ti JOIN classes c on c.classId=ti.classId JOIN subjects s on s.subId=ti.subId JOIN users u on u.userId=ti.createdBy JOIN users u1 on u1.userId = ti.userId where ti.userId="+teacherId);
		String resp = "";
		int count = 1;
		while(rs.next())
		{
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date date = sdf.parse(rs.getString(5));
			resp+= "<tr>"
					+ "<td> " + count + " </td>"
					+ "<td> " + rs.getString(1) + " </td>"
					+ "<td>" + rs.getString(2) + "</td>"
					+ "<td>" + rs.getString(3) + "</td>"
					+ "<td>" + rs.getString(4) + "</td>"
					+ "<td>" + sdf.format(date) + "</td>"
					+ "</tr>";
			count++;		
		}
		con.close();
		if(resp != "")
		{
			return resp;
		}
		else
		{
			return "no data";
		}
	}catch(Exception e){
		e.printStackTrace();
		return "no data";
	}
}
%>
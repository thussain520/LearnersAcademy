<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Logout....</title>
</head>
<body>
<%

if(session.getAttribute("user")!=null)
{
	session.removeAttribute("user");
	response.sendRedirect("index.jsp");
}
else
{
	out.print("<h2>There is no logged in user, please login!</h2>");
}
	
%>
</body>
</html>
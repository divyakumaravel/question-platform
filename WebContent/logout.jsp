<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
	HttpSession se = request.getSession(false);
	Connection con = (Connection) se.getAttribute("con");
	con.close();
		session.invalidate();
		response.sendRedirect("index.jsp");
	%>
</body>
</html>
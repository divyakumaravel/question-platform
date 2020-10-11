<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import= "java.util.Date" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>

</head>

<body>
	<%
		System.out.println("Started save.jsp");
		HttpSession se = request.getSession(false);
		Connection con = (Connection) se.getAttribute("con");
		System.out.println("Established Connection");
		String email = (String)se.getAttribute("ecode");
		System.out.println(email);
		
		try { 
			String title = request.getParameter("title");
			String tag = request.getParameter("tag");
			String quest = request.getParameter("quest");
			String desc = request.getParameter("desc");
			String id = request.getParameter("id");
			System.out.println(title);
			System.out.println(tag);
			System.out.println(quest);
			System.out.println(desc);
			
			
			PreparedStatement ps = con.prepareStatement(
					"update quests set title= ?, tag=?, quest=?, qdesc=? where questid=?");
			ps.setString(1,title);
			ps.setString(2,tag);
			ps.setString(3,quest);
			ps.setString(4,desc);
			ps.setInt(5, Integer.parseInt(id));
			ps.executeUpdate();
			
		} catch (Exception ex) {
			System.out.println(ex);
		} finally {
			if (con == null) {
				response.sendRedirect("index.jsp");
			}
		}
	%>

</body>
</html>
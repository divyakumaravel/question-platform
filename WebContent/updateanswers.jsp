<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import = "java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
		System.out.println("Started save.jsp");
		HttpSession se = request.getSession(false);
		Connection con = (Connection) se.getAttribute("con");
		System.out.println("Established Connection");
		
		
		try { 
			String answer = request.getParameter("answer");
			String aid = request.getParameter("aid");
			String qid = request.getParameter("qid");
			
	
			System.out.println(answer);
			System.out.println(qid);
			System.out.println(aid);
			
			
			PreparedStatement ps = con.prepareStatement(
					"update answers set answer = ? where questid like ? and answerid like ?");
			ps.setString(1,answer);
			ps.setString(2,qid);
			ps.setString(3,aid);
			
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
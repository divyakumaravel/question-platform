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
		int max=0;
		try { 
		    Date date = new Date();
			PreparedStatement pst= con.prepareStatement("select max(questid) from quests");
			ResultSet rs= pst.executeQuery();
			if(rs.next()){
				max= (rs.getInt(1));
			}
			max++;
			String id = request.getParameter("id");
			
			
			PreparedStatement ps = con.prepareStatement(
					"delete from quests where questid=?");
			ps.setString(1, id);

			ps.executeUpdate();
			response.sendRedirect("dashboard.jsp");

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
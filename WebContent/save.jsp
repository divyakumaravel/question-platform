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
			String title = request.getParameter("title");
			String tag = request.getParameter("tag");
			String quest = request.getParameter("quest");
			String desc = request.getParameter("desc");
			System.out.println(title);
			System.out.println(tag);
			System.out.println(quest);
			System.out.println(desc);
			System.out.println(max);
			
			PreparedStatement ps = con.prepareStatement(
					"insert into quests values(?,?,?,?,?,?,?)");
			ps.setString(1, email);
			ps.setTimestamp(2, new java.sql.Timestamp(date.getTime()));
			ps.setString(3, title);
			ps.setString(4, tag);
			ps.setString(5, quest);
			ps.setString(6, desc);
			ps.setInt(7, max);

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
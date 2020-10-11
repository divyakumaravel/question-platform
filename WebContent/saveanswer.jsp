<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import= "java.util.Date" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
		HttpSession se = request.getSession(false);
		Connection con = (Connection) se.getAttribute("con");
		String email = (String)se.getAttribute("ecode");
		System.out.println(con);
		System.out.println(email);
		int max=0;
		try { 
		    Date date = new Date();
			PreparedStatement pst= con.prepareStatement("select max(answerid) from answers");
			ResultSet rs= pst.executeQuery();
			if(rs.next()){
				max= (rs.getInt(1));
			}
			max++;
			String id = request.getParameter("qno");
			String answer = request.getParameter("answer");
			System.out.println(id);
			System.out.println(answer);
			
			System.out.println("max"+max);
			
			PreparedStatement ps = con.prepareStatement(
					"insert into answers values(?,?,?,?,?)");
			ps.setInt(1, Integer.parseInt(id));
			ps.setTimestamp(5, new java.sql.Timestamp(date.getTime()));
			ps.setString(3, email);
			ps.setString(4, answer);
			ps.setInt(2, max);

			ps.executeUpdate();
	
		} catch (Exception ex) {
			response.sendRedirect("dashboard.jsp");
		} finally {
			if (con == null) {
				response.sendRedirect("index.jsp");
			}
		}
	%>

</body>
</html>
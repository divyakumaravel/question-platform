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
		
		HttpSession se = request.getSession(false);
		Connection con = (Connection) se.getAttribute("con");
		System.out.println("Established Connection");
		String aid=request.getParameter("aid");
		String qid=request.getParameter("qid");
		try { 
		    			
			PreparedStatement ps = con.prepareStatement(
					"delete from answers where questid like ? and answerid like ?");
			ps.setString(1, qid);
			ps.setString(2, aid);

			ps.executeUpdate();
			response.sendRedirect("https://deploy-task.herokuapp.com/answer.jsp?hiddenvalue="+qid);

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
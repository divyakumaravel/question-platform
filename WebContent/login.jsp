<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
		try {
			int userCount = 0;
			String designation = null;
			String ecode = request.getParameter("ecode");
			String pwd = request.getParameter("pass");
			HttpSession email=request.getSession();
			email.setAttribute("ecode", ecode);
			Class.forName("com.mysql.jdbc.Driver").newInstance(); 
			Connection con = DriverManager.getConnection("jdbc:mysql://qbct6vwi8q648mrn.cbetxkdyhwsb.us-east-1.rds.amazonaws.com:3306/k572z5xcefkpq851","xul6mgyyepfryqzd","x1hvkv9qwal846ad");
			Statement st = con.createStatement();
			HttpSession connection=request.getSession();
			connection.setAttribute("con", con);
			ResultSet rs = null;
			rs = st.executeQuery("select count(*) from users where email='" + ecode + "'");
			if (rs.next()) {
				userCount = rs.getInt(1);
			}
			if (userCount == 1) {
				rs = st.executeQuery("select pass from users where email='" + ecode + "'");
				if (rs.next()) {
					String pass = rs.getString(1);
					if (pass.equals(pwd))

					{
						response.sendRedirect("dashboard.jsp");
					} else

					{
	%>
	<script>
	location = "LoginPage.html";
	alert("Invalid Username or Password!!!");
	</script>
	<%
		}
				}
			} else {
	%>

	<script>
	location = "LoginPage.html";
	alert("Invalid Username or Password!!!");
	</script>
	<%
		}
		} catch (SQLException ex) {
			throw ex;	
		}
	%>
</body>
</html>
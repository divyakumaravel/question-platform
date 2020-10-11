<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.servlet.http.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	try{
		int userCount = 0;
		int update = 0;
		String designation = null;
		String ecode = request.getParameter("ecode");
		String pwd = request.getParameter("pass");
		HttpSession empcode = request.getSession();
		empcode.setAttribute("ecode", ecode);
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection con = DriverManager.getConnection("jdbc:mysql://qbct6vwi8q648mrn.cbetxkdyhwsb.us-east-1.rds.amazonaws.com:3306/k572z5xcefkpq851","xul6mgyyepfryqzd","x1hvkv9qwal846ad");
		HttpSession connection = request.getSession();
		connection.setAttribute("con", con);
		PreparedStatement pst = con.prepareStatement("insert into users values(?,?)");
		pst.setString(1,ecode);
		pst.setString(2,pwd);
		update= pst.executeUpdate();
		if(update!=0){
			response.sendRedirect("dashboard.jsp");
		}
		else{
			%>
			<script>
			location="signup.html";
			alert("Could not process request.. Try again");
			</script>
			<%
		}
	}catch(Exception ex){
		%>
		<script>
		location="signup.html";
		alert("Could not process request.. Try again");
		</script>
		<%
	}
	
%>

</body>
</html>
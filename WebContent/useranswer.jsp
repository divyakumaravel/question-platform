<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>ROOT QUOTIENT TASK</title>
<meta charset="utf-8">
<link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style>
.logout {
	width: 150%;
	height: 30%;
	color: black;
	background-color: white;
	font-size: 15px;
	border: none;
}

select {
	border: none;
	width: 250px;
	height: 35px;
}

.wrapper {
	margin-top: 3%;
}

th,td {
	padding: 10px;
}
</style>
<script>

</script>
</head>

<body>

<div class="container"><br>
<ul class="nav nav-tabs">
	<li><a data-toggle="tab" href="#dboard">Dashboard</a></li>
	<li class="active"><a data-toggle="tab" href="#ans">Answers</a></li>
	<li>
	<li><a href="home.jsp">All Posts</a>
	<li><a href="signup.html">Sign up</a>
	<li><a href="index.html">Login</a>
	</li>
	
</ul>
<div class="tab-content">
<div id="dboard" class="tab-pane fade">
<h2>Dashboard</h2>
</div>

<div id="ans" class="tab-pane fade in active">
<br><br>
<%
Class.forName("com.mysql.jdbc.Driver").newInstance(); 
Connection con = DriverManager.getConnection("jdbc:mysql://qbct6vwi8q648mrn.cbetxkdyhwsb.us-east-1.rds.amazonaws.com:3306/k572z5xcefkpq851","xul6mgyyepfryqzd","x1hvkv9qwal846ad");

	int id = Integer.parseInt(request.getParameter("hiddenvalue"));
	PreparedStatement pst1 = con
			.prepareStatement("Select * from answers where questid='"+id+"' order by(creationtime) desc");
	ResultSet rss1 = pst1.executeQuery();
	while (rss1.next()) {
%> 
<label style="font-size: 12px">Creator: <%=rss1.getString(3)%></label>&nbsp;
<label style="font-size: 12px"><%=rss1.getTimestamp(5)%></label><br>
<p style="font-size: 23px"><%=rss1.getString(4)%></p>
<br>

<hr>
<%
con.close();
	}
%>
</div>

</div>

</div>

</body>
</html>

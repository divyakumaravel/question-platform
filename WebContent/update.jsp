<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>ROOT QUOTIENT TASK</title>
<meta charset="utf-8">
<link rel="icon" type="image/png" href="images/icons/favicon.ico" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script>
	function updatefun() {
		console.log('started saving...');
		var title = document.getElementById("title").value;
		var tag = document.getElementById("tag").value;
		var quest = document.getElementById("quest").value;
		var desc = document.getElementById("desc").value;
		var id = document.getElementById("upqid").value;
		console.log(title);
		console.log(tag);
		console.log(quest);
		console.log(id);
		$("#output").load("updatequest.jsp", {
			"title" : title,
			"tag" : tag,
			"quest" : quest,
			"desc" : desc,
			"id" : id
		});
		if (confirm('Update Successful')) {
			window.location.reload(true);
		}
	}
</script>
</head>
<body>
<%
	HttpSession se = request.getSession(false);
	Connection con = (Connection) se.getAttribute("con");
	String email = (String) se.getAttribute("ecode");
	String id = request.getParameter("id");
try{
	PreparedStatement pst = con
			.prepareStatement("Select * from quests where creator='"
					+ email + "' and questid='" + id
					+ "' order by(docreate) desc");
	ResultSet rs = pst.executeQuery();
	while (rs.next()) {
%>
<form onsubmit="updatefun()">
<table cellpadding="10">
	<tr>
		<td><label>Title</label></td>
		<td>&nbsp;<input type="text" value="<%=rs.getString(3)%>" id="title"
			required></td>
	</tr>
	
	<tr>
	<td>
	<br>	
	</td>
	</tr>
	
	<tr>
	<td><label>Tag</label></td>
	<td>&nbsp;<input type="text" value="<%=rs.getString(4)%>" id="tag"
		required></td>
	</tr>
	
	<tr>
	<td>
	<br>	
	</td>
	</tr>

	<tr>
		<td><label>Question</label></td>
		<td>&nbsp;<textarea rows="2" cols="50" id="quest" required><%=rs.getString(5)%></textarea></td>
	</tr>
	
	<tr>
	<td>
	<br>	
	</td>
	</tr>
	
	<tr>
		<td><label>Description</label></td>
		<td>&nbsp;<textarea rows="4" cols="50" id="desc" required><%=rs.getString(6)%></textarea></td>
	</tr>
	<tr>
		<td><input type="hidden" value="<%=id%>" id="upqid"></td>
	</tr>
</table>

<input type="submit"></form>
<div id="output"></div>
<%
	}
	}catch(Exception ex){
		throw ex;
	}finally{
		if (con == null) {
			response.sendRedirect("index.jsp");
		}
	}
%>

</body>
</html>
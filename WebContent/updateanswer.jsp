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
		var answer = document.getElementById("answer").value;
		var aid = document.getElementById("upaid").value;
		var qid = document.getElementById("upqid").value;
		console.log(answer);
		console.log(aid);
		console.log(qid);
		$("#output").load("updateanswers.jsp", {
			"answer" : answer,
			"aid" : aid,
			"qid" : qid
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
	try{
	String aid = request.getParameter("aid");
	String qid = request.getParameter("qid");
	System.out.println(aid);
	System.out.println(qid);
	PreparedStatement pst = con
			.prepareStatement("Select * from answers where questid='"
					+ qid + "' and answerid='" + aid
					+ "' order by(creationtime) desc");
	ResultSet rs = pst.executeQuery();
	while (rs.next()) {
%>
<form onsubmit="updatefun()">
<table cellpadding="10">	
	<tr>
		<td><label>Answer</label></td>
		<td>&nbsp;<textarea rows="4" cols="50" id="answer" required><%=rs.getString(4)%></textarea></td>
	</tr>
	<tr>
		<td><input type="hidden" value="<%=aid%>" id="upaid"></td>
		<td><input type="hidden" value="<%=qid%>" id="upqid"></td>
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
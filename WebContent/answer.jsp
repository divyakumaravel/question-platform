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
.column {
	float: left;
	width: 50%;
	padding: 10px;
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
	function show() {
		if (document.getElementById('create').style.display == 'none') {
			document.getElementById('create').style.display = 'block';
		} else if (document.getElementById('create').style.display == 'block') {
			document.getElementById('create').style.display = 'none';
		}
	}
	

	function save() {
		console.log('started saving...');
		var answer = document.getElementById("answer").value;
		var qno = document.getElementById("qno").value;
		$("#output").load("saveanswer.jsp", {
			"answer" : answer,
			"qno" : qno
		});
		location.href="dashboard.jsp"; 
	}
</script>
</head>

<body>

<div class="container"><br>
<ul class="nav nav-tabs">
	<li><a data-toggle="tab" href="#dboard">Dashboard</a></li>
	<li class="active"><a data-toggle="tab" href="#allanswer">All
	Answers</a></li>
	<li><a data-toggle="tab" href="#myans">Manage Answers</a></li>
	<li><a href="dashboard.jsp">All Posts</a></li>
	<li>
	<a>
	<form action="logout.jsp"><input style="border:none;color:black;background:none" type="submit"
		value="Logout"></form></a>
	</li>
</ul>
<div class="tab-content">
<div id="dboard" class="tab-pane fade">
<h2>Dashboard</h2>
</div>

<div id="allanswer" class="tab-pane fade in active">
<br><br>
<%
HttpSession se = request.getSession(false);
Connection con = (Connection) se.getAttribute("con");
String email = (String) se.getAttribute("ecode");
try{
	
	int id = Integer.parseInt(request.getParameter("hiddenvalue"));
	PreparedStatement pst1 = con.prepareStatement("Select * from answers where questid='"+id+"' order by(creationtime) desc");
	ResultSet rss1 = pst1.executeQuery();
	while (rss1.next()) {
%> <label style="font-size: 12px">Creator: <%=rss1.getString(3)%></label>&nbsp;
<label style="font-size: 12px"><%=rss1.getTimestamp(5)%></label><br>
<p style="font-size: 23px"><%=rss1.getString(4)%></p>
<br>

<hr>
<%
	}
%>
</div>

<div id="myans" class="tab-pane fade">
<div class="column">
<br>
<button onclick="show()">New Answer</button>
<div style="display: none" id="create">
<form onsubmit="save()">
<table>
	<tr>
		<td><label> Answer </label></td>
		<td><textarea rows="4" cols="80" id="answer" required></textarea></td>
	</tr>
</table>
<input type="hidden" value=<%=id %> id="qno">
<input type="submit"></form>
</div><br><br>
<%
PreparedStatement pst2 = con.prepareStatement("Select * from answers where questid='"+id+"' and creator='"+email+"' order by(creationtime) desc");
ResultSet rss2 = pst2.executeQuery();
while (rss2.next()) {
	%> 
	<label style="font-size: 12px">Creator: <%=rss2.getString(3)%></label>&nbsp;
	<label style="font-size: 12px"><%=rss2.getTimestamp(5)%></label><br>
	<p style="font-size: 23px"><%=rss2.getString(4)%></p>
	<br>
	<button value="<%=rss2.getString(2) %>" id="<%=rss2.getString(1) %>" onclick="showframe(this.value,this.id)" style="border: none; color: blue; font-size: 20px; background: none"><i
	class="fa fa-pencil-square-o" aria-hidden="true"></i></button>
<a href="deleteanswer.jsp?aid=<%=rss2.getString(2)%>&qid=<%=rss2.getString(1)%>"
	style="border: none; color: blue; font-size: 20px; background: none"><i class="fa fa-trash" aria-hidden="true"></i></a>
	
	<hr>
<%
	}
%>
<div id="output"></div>

</div>
</div>
<div class="column">
<iframe id="uframe" src="#" width="100%" height="800" style="border:none; display:none"></iframe>
</div>
<script>
function showframe(ansvalue,qvalue){
	console.log("ans"+ansvalue);
	console.log("qval"+qvalue);
	var path="https://deploy-task.herokuapp.com/updateanswer.jsp?aid="+ansvalue+"&qid="+qvalue;
	console.log("Path"+path);
	document.getElementById("uframe").src = path;
	if(document.getElementById("uframe").style.display=='none'){
		document.getElementById("uframe").style.display='block';
	}else{
		document.getElementById("uframe").style.display='none';
	}
}
</script>
</div>

</div>
<%
}catch(Exception ex){
	response.sendRedirect("dashboard.jsp");
}finally{
	if (con==null){
		response.sendRedirect("index.jsp");
	}
}
	%>
</body>
</html>

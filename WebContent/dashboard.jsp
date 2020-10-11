<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
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
<style>
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

.column {
	float: left;
	width: 50%;
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
		var title = document.getElementById("qtitle").value;
		var tag = document.getElementById("qtag").value;
		var quest = document.getElementById("quest").value;
		var desc = document.getElementById("qdesc").value;
		$("#output").load("save.jsp", {
			"title" : title,
			"tag" : tag,
			"quest" : quest,
			"desc" : desc
		});
		location="dashboard.jsp";
		window.location.reload();
	}
</script>
</head>

<body>

<div class="container"><br>
<ul class="nav nav-tabs">
	<li><a data-toggle="tab" href="#dboard">Dashboard</a></li>
	<li class="active"><a data-toggle="tab" href="#allpost">All
	Posts</a></li>
	<li><a data-toggle="tab" href="#mypost">Manage Posts</a></li>
	<li><a>
	<form action="logout.jsp"><input
		style="border: none; color: black; background: none" type="submit"
		value="Logout"></form>
	</a></li>
</ul>
<div class="tab-content">
<div id="dboard" class="tab-pane fade">
<h2>Dashboard</h2>
</div>

<div id="allpost" class="tab-pane fade in active"><br>
<br>
<%
	HttpSession se = request.getSession(false);
	Connection con = (Connection) se.getAttribute("con");
	try {

		String email = (String) se.getAttribute("ecode");
		PreparedStatement ps = con.prepareStatement("Select * from quests order by(docreate) desc");
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
%> <label style="font-size: 25px"><%=rs.getString(3)%></label> <br>
<label style="font-size: 12px">Creator: <%=rs.getString(1)%></label>&nbsp;
<label style="font-size: 12px"><%=rs.getTimestamp(2)%></label><br>
<p style="font-size: 23px"><%=rs.getString(4)%></p>
<br>
<p style="font-size: 20px"><%=rs.getString(5)%></p>
<form action="answer.jsp"><input type="hidden"
	value=<%=rs.getInt(7)%> name="hiddenvalue">
<button type="Submit"
	style="border: none; color: blue; font-size: 20px; background: none"><i
	class="fa fa-eye" aria-hidden="true"></i></button>
</form>
<hr>
<%
	}
%>
</div>

<div id="mypost" class="tab-pane fade"><br>
<div class="column">
<button onclick="show()">Create Quest</button><br>
<%
	PreparedStatement pst = con.prepareStatement("Select * from quests where creator='"
						+ email + "' order by(docreate) desc");
		System.out.println(email);
		ResultSet rss = pst.executeQuery();
		while (rss.next()) {
%> <label style="font-size: 25px"><%=rss.getString(3)%></label> <br>
<label style="font-size: 12px">Creator: <%=rss.getString(1)%></label>&nbsp;
<label style="font-size: 12px"><%=rss.getTimestamp(2)%></label><br>
<p style="font-size: 23px"><%=rss.getString(4)%></p>
<br>
<p style="font-size: 20px"><%=rss.getString(5)%></p>
<a href="answer.jsp?hiddenvalue=<%=rss.getString(7)%>"
	style="border: none; color: blue; font-size: 20px; background: none"><i
	class="fa fa-eye" aria-hidden="true"></i></a>
<button value="<%=rss.getString(7) %>" onclick="showframe(this.value)" style="border: none; color: blue; font-size: 20px; background: none"><i
	class="fa fa-pencil-square-o" aria-hidden="true"></i></button>
<a href="delete.jsp?id=<%=rss.getString(7)%>"
	style="border: none; color: blue; font-size: 20px; background: none"><i class="fa fa-trash" aria-hidden="true"></i></a>
<hr>
<%
	}
%>
<div id="output"></div>
</div>

<div class="column" >

<div style="display: none" id="create">
<form onsubmit="save()">
<table>
	<tr>
		<td><label> Title </label></td>
		<td><input type="text" required id="qtitle"></td>
	</tr>
	<tr>
		<td><label> Tags </label></td>
		<td><input type="text" id="qtag"></td>
	</tr>
	<tr>
		<td><label> Question </label></td>
		<td><textarea rows="2" cols="60" id="quest" required></textarea></td>
	</tr>
	<tr>
		<td><label> Description </label></td>
		<td><textarea rows="4" cols="60" id="qdesc" required></textarea></td>
	</tr>
</table>
<input type="submit"></form>
</div><br>
<iframe id="uframe" src="#" width="100%" height="800" style="border:none; display:none"></iframe></div>

<script>
function showframe(value){
	console.log(value);
	var path="https://deploy-task.herokuapp.com/update.jsp?id="+value;
	console.log(path);
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
</div>


<%
	} catch (Exception ex) {
throw ex;
	} finally {
		if (con == null) {
			response.sendRedirect("index.jsp");
		}
	}
%>
</body>
</html>

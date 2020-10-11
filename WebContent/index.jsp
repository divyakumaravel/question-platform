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
var request=new XMLHttpRequest();  
function searchInfo(){  
var name=document.vinform.name.value;  
var url="search.jsp?val="+name;  
  
try{  
request.onreadystatechange=function(){  
if(request.readyState==4){  
var val=request.responseText;  
document.getElementById('mylocation').innerHTML=val;  
}  
}//end of function  
request.open("GET",url,true);  
request.send();  
}catch(e){alert("Unable to connect to server");}  
}  
</script>  
<script>
	function show() {
		if (document.getElementById('create').style.display == 'none') {
			document.getElementById('create').style.display = 'block';
		} else if (document.getElementById('create').style.display == 'block') {
			document.getElementById('create').style.display = 'none';
		}
	}
	function showanswer() {
		if (document.getElementById('answerdiv').style.display == 'none') {
			document.getElementById('answerdiv').style.display = 'block';
		} else if (document.getElementById('answerdiv').style.display == 'block') {
			document.getElementById('answerdiv').style.display = 'none';
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
		console.log(title);
		console.log(tag);
		console.log(quest);
	}
</script>
</head>

<body>

<div class="container"><br>
<ul class="nav nav-tabs">
	<li><a data-toggle="tab" href="#dboard">Dashboard</a></li>
	<li class="active"><a data-toggle="tab" href="#allpost">All
	Posts</a></li>
	
	<li>
	<a href="signup.html">Signup</a>
	
	</li>
	<li>
	<a href="LoginPage.html">Login</a>
	</li>
	
</ul>
<div class="tab-content">
<div id="dboard" class="tab-pane fade">
<h2>Dashboard</h2>
</div>

<div id="allpost" class="tab-pane fade in active">
<br>
<form name="vinform">  
<input type="text" name="name" onkeyup="searchInfo()">  
</form>  
  
<span id="mylocation"></span>  
<br>
<%
Class.forName("com.mysql.jdbc.Driver").newInstance(); 
Connection con = DriverManager.getConnection("jdbc:mysql://qbct6vwi8q648mrn.cbetxkdyhwsb.us-east-1.rds.amazonaws.com:3306/k572z5xcefkpq851","xul6mgyyepfryqzd","x1hvkv9qwal846ad");
try{
	
	PreparedStatement ps = con
			.prepareStatement("Select * from quests order by(docreate) desc");
	ResultSet rs = ps.executeQuery();
	while (rs.next()) {
%> <label style="font-size: 25px"><%=rs.getString(3)%></label> <br>
<label style="font-size: 12px">Creator: <%=rs.getString(1)%></label>&nbsp;
<label style="font-size: 12px"><%=rs.getTimestamp(2)%></label><br>
<p style="font-size: 23px"><%=rs.getString(4)%></p>
<br>
<p style="font-size: 20px"><%=rs.getString(5)%></p>
<form action="useranswer.jsp">
<input type="hidden" value=<%=rs.getInt(7) %> name="hiddenvalue">
<button type="Submit" style="border:none; color:blue; font-size:20px; background:none"><i class="fa fa-eye" aria-hidden="true"></i></button>
</form>


<hr>
<%
con.close();
	}
%>
</div>

</div>

</div>
<%
}catch(Exception ex){throw ex;
}
	%>
</body>
</html>

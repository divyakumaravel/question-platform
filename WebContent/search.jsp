<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%@ page import="java.sql.*" %>  
<%  
String name=request.getParameter("val");  
if(name==null||name.trim().equals("")){  
out.print("<p>Please enter tag/title!</p>");  
}else{  
try{  
	Class.forName("com.mysql.jdbc.Driver").newInstance(); 
	Connection con = DriverManager.getConnection("jdbc:mysql://zy4wtsaw3sjejnud.cbetxkdyhwsb.us-east-1.rds.amazonaws.com:3306/srlutv7rf4drkf0c","q1r9hg1cnxyf7tlj","sy04x4998cntmi3s");
PreparedStatement ps=con.prepareStatement("select * from quests where tag like '"+name+"' or title like '"+name+"'");  
ResultSet rss=ps.executeQuery();  
  
if(!rss.isBeforeFirst()) {      
 out.println("<p>No Record Found! <br> Try entering the Tag or Title of the question</p>");   
}else{    
	while (rss.next()) {
		%> <br><br><div style="border: 1px solid black"><label style="font-size: 25px"><%=rss.getString(3)%></label> <br>
		<label style="font-size: 12px">Creator: <%=rss.getString(1)%></label>&nbsp;
		<label style="font-size: 12px"><%=rss.getTimestamp(2)%></label><br>
		<p style="font-size: 23px"><%=rss.getString(4)%></p>
		<br>
		<p style="font-size: 20px"><%=rss.getString(5)%></p>
		<form action="useranswer.jsp">
<input type="hidden" value=<%=rss.getInt(7) %> name="hiddenvalue">
<button type="Submit" style="border:none; color:blue; font-size:20px; background:none"><i class="fa fa-eye" aria-hidden="true"></i></button>
</form><br>
		</div>
		<%
			}  }
con.close();  
}catch(Exception e){out.print(e);}  
}//end of else  
%>  
</body>
</html>
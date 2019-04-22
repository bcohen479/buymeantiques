<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<!--LEANNE WROTE THIS CODE  -->
<meta charset="ISO-8859-1">
<title>Questions</title>






<body>
<br>
	<form method="post" action="view.jsp">
	<select name="email" size=1>
	<%
	List<String> list = new ArrayList<String>(); 
	

	try{
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	
	String query="SELECT * FROM Emails";
	Statement stmt=con.createStatement();
	ResultSet res=stmt.executeQuery(query);
	while (res.next()){
		%>
		
			<option value="<%=res.getInt("eid")%>">Subject:<%=res.getString("subject")%></option>
		<%} %>
		
		<%
	res.close();
	stmt.close();
	}catch (Exception e) {
		out.print("Error: "+ e);
	}
	%>
	</form>
<br>
</body>
</html>
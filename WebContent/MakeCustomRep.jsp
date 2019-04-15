<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<% 
ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();	
String email = request.getParameter("email");   
String uname=request.getParameter("username");

Statement stmt = con.createStatement();
ResultSet account = stmt.executeQuery("select * from Users where user_name='" + uname + "' and email='" + email + "'");
if(account.next()){
	PreparedStatement ps= con.prepareStatement("UPDATE Users Set status=? where user_name= ?");
	ps.setString(1, "customrep");
	ps.setString(2, uname);
	ps.executeUpdate();
	out.print("<a href=Admin.jsp>Success!! Go back to Admin</a>");
}
else{
	out.print("<a href=createUser.jsp>Must create user account first</a>");
}
%>
</body>
</html>
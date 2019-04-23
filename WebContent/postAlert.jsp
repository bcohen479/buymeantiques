<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Post alerts</title>
</head>
<body>



<%
	System.out.println(session.getAttribute("userID"));
	List<String> list = new ArrayList<String>();
	
	try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		
		Statement stmt = con.createStatement();
		
		int user = Integer.parseInt(session.getAttribute("userID").toString());
		
		String category = request.getParameter("category");
		String name = request.getParameter("Name");
		String color = request.getParameter("Color");
		String style = request.getParameter("Style");
		String manufacturer = request.getParameter("Manufacturer");

		String inserQuery = "INSERT INTO Emails (from, datetime, to, content, subject, eid) VALUES (?,?);";
		
		PreparedStatement ps = con.prepareStatement(inserQuery);
		ps.setInt(1, user);
		ps.setString(2, "you have an alert for new item");
		ps.setString(2, category);
		ps.setString(3, name);
		ps.setString(4, color);
		ps.setString(5, style);
		ps.setString(6, manufacturer);
		
		ps.executeUpdate();
		
		con.close();
		
	
	}catch (Exception e) {
		out.print("Error: "+ e);
	}
	%>

</body>
</html>
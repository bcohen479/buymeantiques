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
		
		String category = request.getParameter("Category");
		String name = request.getParameter("name");
		String color = request.getParameter("color");
		String style = request.getParameter("style");
		String manufacturer = request.getParameter("manufacturer");
		
		System.out.println(color);

		String inserQuery = "SELECT * FROM Items WHERE manufacturer = '" + manufacturer + "' AND color = '" + color + "' AND style = '" + style + "';";
		Statement stmt1 = con.createStatement();
		
		ResultSet rs = stmt1.executeQuery(inserQuery);
		
		/* ps.setInt(1, user);
		ps.setString(2, "you have an alert for new item");
		ps.setString(2, category);
		ps.setString(3, name);
		ps.setString(4, color);
		ps.setString(5, style);
		ps.setString(6, manufacturer); */

		
		if (rs.next()){
			out.println("Item Exists");
			
		} else {
			out.println("Thanks! your intersted item has been saved and we will notify you when this item will be available again.");
		}
		
		//ps.executeUpdate();
		
		con.close();
		
	
	}catch (Exception e) {
		out.print("Error: "+ e);
	}
	%>

</body>
</html>
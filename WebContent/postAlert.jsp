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
		
		
		String name = request.getParameter("name");
		String color = request.getParameter("color");
		String manufacturer = request.getParameter("manufacturer");
		
		System.out.println(color);
		System.out.println(name);
		System.out.println(manufacturer);

		String inserQuery = "SELECT manufacturer,color,name FROM Items WHERE manufacturer = '" + manufacturer + "' AND color = '" + color + "' AND name = '" + name + "';";
		Statement stmt1 = con.createStatement();
		
		ResultSet rs = stmt1.executeQuery(inserQuery);
		
		
		if (rs.isBeforeFirst()){
			out.println("Item Exists");
			out.println("Please return to the auction list your item will be waiting for you there and you can bid as much as you want.. ENJOY!..");
			
		} else {
			
			out.println("Thanks! Your intersted item has been saved and we will notify you when this item will be available again.");
		}
		
		//ps.executeUpdate();
		
		con.close();
		
		
		
		
		
	
	}catch (Exception e) {
		out.print("Error: "+ e);
	}
	%>
	
	
	<td><a href="homepage.jsp">Home Page</a></td>

</body>
</html>
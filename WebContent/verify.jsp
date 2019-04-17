<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Verify</title>
</head>
<body>
<%
	List<String> list = new ArrayList<String>();

	try{
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		
		//Create a SQL statement
		Statement stmt = con.createStatement();
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String query = "SELECT user_ID, password, status FROM Users WHERE user_name = '" + username + "';";
		
		ResultSet result = stmt.executeQuery(query);
		if(!result.next()){
		out.print("No account under this username."+
		"  <a href=login.jsp>Try again</a> or <a href=index.jsp> create new account</a>");
		}
			
		
		else{
			String pw = result.getString("password");
			int id = result.getInt(1);
			String status= result.getString(3);
			if(pw.equals(password)){
				session.setAttribute("userID", id);
				session.setAttribute("userName", username);
				session.setAttribute("status", status);
			    response.sendRedirect(response.encodeURL("homepage.jsp"));
			}
			else{
				out.print("<a href=login.jsp>Username and Password don't match. Try again </a>");
			}
		}
	}catch (Exception e) {
		out.print("Error: "+ e);
	}

%>
</body>
</html>
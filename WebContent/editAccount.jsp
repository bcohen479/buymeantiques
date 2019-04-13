<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Account</title>
</head>
<body>
Search BY:
<form method="post" action= "findandEditAccount1.jsp">
		<select name="f" size=1>
			<option value="email">Email</option>
			<option value="user_name">User Name</option>
		</select>&nbsp;<br>
		

		<input type= "text", name="attribute", required>
				<br>
				
				
				Change:
				<select name="updatethisfield" size=1>
			<option value="email">Email</option>
			<option value="user_name">User Name</option>
			<option value="password">Password</option>
		</select>&nbsp;<br>
				New Value</td><td><input type="text" name="updated">
				<br>
				<button type="submit" >Update</button>
	
				
				</form>
</body>
</html>
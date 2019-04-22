<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<!--OLIVER WROTE THIS CODE  -->
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login | BuyMeAntiques</title>
</head>
<body>
Login
<br>

<form method="post" action="verify.jsp">
	<table>
	<tr>    
	<td>Username</td><td><input type="text" name="username"></td>
	</tr>
	<tr>
	<td>Password</td><td><input type="password" name="password"></td>
	</tr>
	</table>
	<input type="submit" value="login">
</form>
<br>
Don't have an account? <a href="index.jsp">Sign Up</a>

</body>
</html>
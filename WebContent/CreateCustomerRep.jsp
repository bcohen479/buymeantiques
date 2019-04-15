<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create Customer Representative Account</title>
</head>
<body>
<form method="post" action="MakeCustomRep.jsp">
<table>
	<tr>    
	<td>User name</td><td><input type="text" name="username"></td>
	</tr>
	<tr>
	<td> Email Address </td><td><input type="text" name="email"></td>
</table>
<Input type= "submit", value="Make Customer Representative" >
</form>


</body>
</html>
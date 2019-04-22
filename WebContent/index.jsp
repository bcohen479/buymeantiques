<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<!--OLIVER WROTE THIS CODE  -->
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript">

function BothFieldsIdenticalCaseSensitive() {
	var pw = document.newUserForm.password.value;
	var confirmation = document.newUserForm.confirmPassword.value;
	if(pw == confirmation) { return true; }
	alert("Passwords do not match...");
	return false;
}

</script>


<title>Sign Up | BuyMeAntiques</title>
</head>
<body>

Create an account
<br>
<form name="newUserForm" method="post" action="createUser.jsp">
	<table>
	<tr>    
	<td>Username</td><td><input type="text" name="username" required></td>
	</tr>
	<tr>
	<td>Email</td><td><input type="text" name="email" required></td>
	</tr>
	<tr>
	<td>Password</td><td><input type="text" name="password" required></td>
	</tr>
	<tr>
	<td>Confirm Password</td><td><input type="text" name="confirmPassword" required></td>
	</tr>
	</table>
	<input type="submit" value="Create Account" onclick="return BothFieldsIdenticalCaseSensitive();">
</form>
<br>
Have an account? <a href="login.jsp">Login</a>

</body>
</html>
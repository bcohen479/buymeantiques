<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<!--LEANNE WROTE THIS CODE  -->


<head>
<meta charset="ISO-8859-1">

<title>successfully logged in. Will be replaced by the homepage</title>
</head>
<body>
<p> 
Welcome <%=session.getAttribute("userName")%> 
<a href="homepage.jsp">Home Page</a> 
<a href="logout.jsp">Log out</a>

</p>
</body>
</html>
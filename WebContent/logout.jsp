<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>logout</title>
</head>
<body>
<p>Thank you for shopping <%=session.getAttribute("user") %><br>
You are now being logged out</p>  
<%session.invalidate();
response.sendRedirect(response.encodeURL("index.jsp"));%>
</body>
</html>
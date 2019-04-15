<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>


<style>
.admin_a{
  display : block;
}
.enduser_a{
 display: none;
}
.customrep_a{
display:none;}

.admin_b{
  display : block;
}
.enduser_b{
 display: none;
}
.customrep_b{
display:block;}
</style>


<head>
<meta charset="ISO-8859-1">

<title>successfully logged in. Will be replaced by the homepage</title>
</head>
<body>
<p> 
Welcome <%=session.getAttribute("userName")%> 
<a href="homepage.jsp">Home Page</a> 
<a href="logout.jsp">Log out</a>

<div id= status, class= <%= session.getAttribute("status")+"_a"%>>
<a href="Admin.jsp">Administrative functions</a>
</div>
<div id= status, class=<%=session.getAttribute("status")+"_b" %>>
<a href="CustomerRep.jsp">Customer Representative Functions</a>
</div>
</p>
</body>
</html>
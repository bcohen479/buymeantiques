<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.util.Date, java.text.*, java.time.format.DateTimeFormatter.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Alerts | Buymeantiques| Create Alert for specific item</title>
</head>
<body>
<br>
<h2>Hello <%=session.getAttribute("userName") %> Here You Can Create Alerts for any item you want</h2>
<h3>Please enter Name, Manufacturer and color</h3>



<section class="container">
    <div class="register">
      <h1>Set an Alert</h1>
      <form method="post" action="postAlert.jsp">
      
       
     
       <p><label for="name"> Name </label></p>
        <p><input id="name" type="text" name="name" value=""></p>
     
    	 <p><label for="color"> Color </label></p>
        <p><input id="color" type="text" name="color" value=""></p>
     
     
        <p><label for="manufacturer"> Manufacturer </label></p>
        <p><input id="manufacturer" type="text" name="manufacturer" value=""></p>

        
        
        <p class="submit"><input type="submit" value="Set Alert"></p>
      </form>
      
    </div>
</section>


</body>
</html>
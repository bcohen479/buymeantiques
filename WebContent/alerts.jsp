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
<title>Alerts | Buymeantiques</title>
<!--OLIVER GILAN WROTE THE CODE IN THIS FILE  -->
</head>
<body>
<br>
<h2>Alerts for <%=session.getAttribute("userName") %></h2>
<a href="createAlert.jsp">Create Alert</a>
	<br>

	<table cellspacing="10">
	<tr>
		<td>Alert Name</td>
		<td>Auction ID</td>
	</tr>
	<tr>
	</tr>
	
	
	
<%
	System.out.println(session.getAttribute("userID"));
	List<String> list = new ArrayList<String>();

	try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		
		int user = (Integer) session.getAttribute("userID");
		String username = session.getAttribute("userName").toString();
		String query="SELECT * FROM Alerts WHERE user_ID = "+user+";";
		Statement stmt=con.createStatement();
		ResultSet res=stmt.executeQuery(query);
	
		while (res.next()){
			
			String alertName = res.getString("name"); 
/* 			String date = res.getDate("end_date").toString();
 */			int auc = res.getInt("auction_ID");
 			System.out.println(alertName);
			System.out.println("auc:" + auc);

			%>
			<tr>
			<td><%=alertName%></td>
			<td><a href="aucprofile.jsp?value=<%=auc%>"><%=auc%></a></td>
<%-- 			<td><%=date %></td>
 --%>
		
		<% }
		res.close();
		stmt.close();
	}catch (Exception e) {
		out.print("Error: "+ e);
	}
	%>
			</table>
			
			<br>
			<td><a href="homepage.jsp">Home Page</a></td>
</body>
</html>
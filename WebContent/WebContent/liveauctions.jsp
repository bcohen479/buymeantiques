<%  
/*
This will be the homepage of all current live auctions. 
This will allow users to browse through these auctions. 
There are a number of different links on this page that allow for different search and sort functionalities.
*/

%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Live Auctions</title>
</head>
<body>
<br>
<form name="search bar" method="post" action="namesearch.jsp">
<table>
<tr>
<td>Search by Name</td><td> <input type="text" name="namsearch"></td>
<td><a href="namesearch.jsp">Search</a></td>
</tr>
</table>
</form>
<form name="search bar2" method="post" action="mansearch.jsp">
<table>
<tr>
<td>Search by Manufacturer</td><td> <input type="text" name="mansearch"></td>
<td><a href="mansearch.jsp">Search</a></td>
</tr>
</table>
</form>
<form name="search bar3" method="post" action="colsearch.jsp">
<table>
<tr>
<td>Search by Color</td><td> <input type="text" name="colsearch"></td>
<td><a href="colsearch.jsp">Search</a></td>
</tr>
</table>
</form>
<form name="search bar4" method="post" action="profile.jsp">
<table>
<tr>
<td>Search For a User by UserID</td><td> <input type="text" name="userID"></td>
<td><a href="profile.jsp">Search</a></td>
</tr>
</table>
</form>
<form name="search bar5" method="post" action="aucprofile.jsp">
<table>
<tr>
<td>Search For a Auction by AucID</td><td> <input type="text" name="aucID"></td>
<td><a href="aucprofile.jsp">Search</a></td>
</tr>
</table>
</form>
<form name="search bar6" method="post" action="similar.jsp">
<table>
<tr>
<td>Search For Similar Items by Auction ID</td><td> <input type="text" name="aucID2"></td>
<td><a href="similar.jsp">Search</a></td>
</tr>
</table>
</form>

<br>
<table>
<tr>
<td><a href="EndDate.jsp">Sort by End Date</a></td>
<td><a href="CurrentPrice.jsp">Sort by Price Lo to Hi</a></td>
<td><a href="CurrentPriceDesc.jsp">Sort by Price Hi to Lo</a></td>
</tr>
<tr>
<td>Auction ID</td>
<td>End Date</td>
<td>Current Price</td>
<td>Seller</td>
<td>Item</td>
<td>Color</td>
<td>Style</td>
</tr>
<%
	List<String> list = new ArrayList<String>();

	try{
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	
	String query="SELECT * FROM Live_Auction";
	Statement stmt=con.createStatement();
	ResultSet res=stmt.executeQuery(query);
	while (res.next()){
		%>
		<tr>
		<td><%=res.getInt("auction_ID")%></td>
		<td><%=res.getDate("end_date")%></td>
		<td><%=res.getInt("current_price")%></td>
		<td><%=res.getString("seller")%></td>
		
	<%
		String query2="SELECT * FROM Items WHERE Items.item_ID='"+res.getInt("item_ID")+ "';";
		Statement stmt2=con.createStatement();
		ResultSet res2=stmt2.executeQuery(query2);
		while (res2.next()){
		%>
		<td><%=res2.getString("name")%></td>
		<td><%=res2.getString("color")%></td>
		<td><%=res2.getString("style")%></td>
		</tr>
		<%
		}
	}
	%>
	</table>
	<%res.close();
	stmt.close();
	}catch (Exception e) {
		out.print("Error: "+ e);
	}
	%>
</body>
</html>
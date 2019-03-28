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

<table>
<tr><td>Similar Auctions</td></tr>
<tr>
<td>Seller</td>
<td>Date</td>
<td>Price</td>
<td>Item</td>
<td>Color</td>
<td>Style</td>
</tr>
<%
	List<String> list = new ArrayList<String>();

	try{
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	String searchval=request.getParameter("aucID2");
	String query="SELECT * FROM Complete_Auction,Items WHERE Complete_Auction.item_ID=Items.item_ID AND Complete_Auction.auction_ID='"+searchval+"';";
	Statement stmt=con.createStatement();
	ResultSet res=stmt.executeQuery(query);
	while (res.next()){
		%>
		<tr>
		<td><%=res.getInt("Complete_Auction.seller")%></td>
		<td><%=res.getDate("Complete_Auction.date")%></td>
		<td><%=res.getInt("Complete_Auction.price")%></td>
		<td><%=res.getString("Items.name")%></td>
		<td><%=res.getString("Items.color")%></td>
		<td><%=res.getString("Items.style")%></td>
	<%
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
<%/* This allows to users to search for all items that have the same name as a particular item.
*/ %>
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
<tr><td><a href="homepage.jsp">Back to Homepage</a></td></tr>
<tr><td><a href="liveauctions.jsp">Back to Advanced Search</a></td></tr>
<tr><td>Similar Auctions</td></tr>
<tr>
<td>Title</td>
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
	String query="SELECT * FROM Live_Auction, Items WHERE Live_Auction.item_ID=Items.item_ID AND Live_Auction.auction_ID IN (SELECT DISTINCT Live_Auction.auction_ID FROM Live_Auction,Items WHERE Live_Auction.end_date>=(NOW()-INTERVAL 1 MONTH) AND Live_Auction.item_ID IN(SELECT Items.item_ID FROM Items WHERE Items.name IN( SELECT Items.name FROM Live_Auction, Items WHERE Items.item_ID=Live_Auction.item_ID AND Live_Auction.title='"+searchval+"')));";

	Statement stmt=con.createStatement();
	ResultSet res=stmt.executeQuery(query);
	while (res.next()){
		%>
		<tr>
		<td><a href="aucprofile.jsp?value=<%=res.getInt("auction_ID")%>&val2=<%=res.getString("seller")%>"><%=res.getString("title")%></td></a>
		<td><%=res.getInt("Live_Auction.seller")%></td>
		<td><%=res.getDate("Live_Auction.end_date")%></td>
		<td><%=res.getInt("Live_Auction.current_price")%></td>
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
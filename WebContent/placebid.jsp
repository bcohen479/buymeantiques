<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.util.*, java.time.*, java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Place Bid | Buymeantiques</title>
</head>
<body>
 	<%
		
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			String aucID = request.getParameter("aucID");
			String aucTitle = request.getParameter("aucTitle");
			int bidderID = (Integer) session.getAttribute("userID");
			double currentPrice = -1.0;
			
			String query = "SELECT MAX(price) FROM Bids WHERE Bids.auction_ID = '" + aucID + "';";
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			if(rs.next()){
				currentPrice = rs.getDouble(1);
			}
			

	%>
	Place Bid for Auction:  <%=aucTitle%>
<form name="newBidForm" method="post" action="createbid.jsp">
	<table>
	<tr>    
	<td>Current Price: </td><td> <%=currentPrice %></td>
	</tr>
	<tr>
	<td>Your Bid: </td><td><input type="number" name="bidPrice" required></td>
	</tr>
	</table>
	<input type="hidden" id="bidder" name="bidder" value="<%=bidderID %>">
	<input type="hidden" id="auctionID" name="auction" value="<%=aucID %>">

	<input type="submit" value="PLACE BID">
</form>


</body>
</html>
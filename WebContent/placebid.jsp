<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.util.*, java.time.*, java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html>
<head>
<!--OLIVER WROTE THIS CODE  -->
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Place Bid | Buymeantiques</title>
</head>
<body>
<script type="text/javascript">

function resCheck() {
    if (document.getElementById('setHidden').checked) {
        document.getElementById('hiddenIn').style.display = 'block';
        document.getElementById('radioH').style.display = 'block';
    }if(document.getElementById('noHidden').checked){
    	docdocument.getElementById('setHidden').checked = false;
    	document.getElementById('hiddenIn').style.display = 'none';
    	docdocument.getElementById('noHidden').checked = false;
    	document.getElementById('radioH').style.display = 'none';
    }

}

</script>
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
	<tr>
		<td><input type="radio" id="setHidden" onclick="javascript:resCheck();">Set Hidden Upper Bid</td>
	<tr id="hiddenIn" style="display: none" >
		<td>Your Upper Bid Limit: </td><td><input type="number" name="hiddenPrice" value="0.00"></td>
 	</tr>
	</table>
	<input type="hidden" id="bidder" name="bidder" value="<%=bidderID %>">
	<input type="hidden" id="auctionID" name="auction" value="<%=aucID %>">
	<input type="submit" value="PLACE BID">
</form>


</body>
</html>
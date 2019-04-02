<%
/* This allows a user to see another users bidding history. */
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

<table>
<tr><td><a href="liveauctions.jsp">Back to All Live Auctions</a></td></tr>
<tr><td>Previous Auction Participation</td></tr>
<tr>
<td>Auction ID</td>
<td>Date</td>
<td>Price</td>
</tr>
<%
	List<String> list = new ArrayList<String>();

	try{
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	String searchval=request.getParameter("userID");
	String query="SELECT * FROM Bids Where Bids.bidder='"+searchval+"';";
	Statement stmt=con.createStatement();
	ResultSet res=stmt.executeQuery(query);
	while (res.next()){
		%>
		<tr>
		<td><%=res.getInt("auction_ID")%></td>
		<td><%=res.getDate("datetime")%></td>
		<td><%=res.getInt("price")%></td>
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
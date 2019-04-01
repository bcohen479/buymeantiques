<%/* This allows to users to sort all live aucitons based on the end date.
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
<a href="liveauctions.jsp">Sort by Auction ID  </a>
<a href="CurrentPrice.jsp">Sort by Price Lo to Hi </a>
<a href="CurrentPriceDesc.jsp">Sort by Price Hi to Lo </a>
<table>
<tr>
<td>Auction ID</td>
<td>End Date</td>
<td>Current Price</td>
<td>Item</td>
<td>Color</td>
<td>Style</td>
</tr>
<%
	List<String> list = new ArrayList<String>();

	try{
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	String query="SELECT * FROM Live_Auction ORDER BY end_date";
	Statement stmt=con.createStatement();
	ResultSet res=stmt.executeQuery(query);
//	String query2="SELECT * FROM Items,Live_Auction WHERE Items.item_ID=Live_Auction.item_ID;";
	//Statement stmt2=con.createStatement();
	//ResultSet res2=stmt2.executeQuery(query2);
	while (res.next()){
		%>
		<tr>
		<td><%=res.getInt("auction_ID")%></td>
		<td><%=res.getDate("end_date")%></td>
		<td><%=res.getInt("current_price")%></td>
		
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
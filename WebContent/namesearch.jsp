<%/* This allows to users to search for all items of a particular name.
*/ %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--BEN WROTE THIS CODE  -->
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Live Auctions</title>
</head>
<body>
<table>
<tr>
<td><a href="homepage.jsp">Back to Homepage</a></td></tr>
<tr>
<td><a href="liveauctions.jsp">Back to Advanced Search</a></td>
</tr>
<tr>
<td>Title</td>
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
	String searchval=request.getParameter("namsearch");
	String query="SELECT * FROM Live_Auction WHERE Live_Auction.end_date>NOW() AND Live_Auction.item_ID IN (SELECT item_ID FROM Items WHERE Items.name='"+searchval+"');";
	Statement stmt=con.createStatement();
	ResultSet res=stmt.executeQuery(query);
	while (res.next()){
		%>
		<tr>
		<td><a href="aucprofile.jsp?value=<%=res.getInt("auction_ID")%>&val2=<%=res.getString("seller")%>"><%=res.getString("title")%></td></a>
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
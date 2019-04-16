<%/*
This page shows the history of bids for any auction.
*/%>


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

<table cellspacing="5" style="table-layou:fixed">
<%
	List<String> auction = new ArrayList<String>();
	String aucID = request.getParameter("value");
	
	try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		

		if(aucID != null){
			//System.out.print("Welcome "+session.getAttribute("userName"));;
			System.out.println("id: "+aucID);
			String seller = request.getParameter("val2");
			System.out.println(seller);
			String aucQuery = "SELECT * FROM Live_Auction WHERE auction_ID='"+aucID+"';";
			Statement statement = con.createStatement();
			ResultSet rs = statement.executeQuery(aucQuery);
			while(rs.next()){
				%>
				<tr><h3><%=rs.getString("title")%></h3></tr>
				<br>
				<br>
				<p>Description : <%=rs.getString("description") %></p>
				<tr><a href="placebid.jsp?aucID=<%=aucID%>&aucTitle=<%=rs.getString("title")%>"><h5>PLACE BID</h5></a>
				<tr><td>Seller: <%=seller%></td></tr>
				<tr><td>Current Price: $<%=rs.getInt("current_price") %></td></tr>
				<tr><td>End Date: <%=rs.getDate("end_date").toString()%></td></tr>
				<%-- <tr><td>Description : <%=rs.getString("description") %></td></tr> --%>
				
			<%
			}
			statement.close();
			rs.close();
		}
	}catch (Exception e) {
		out.print("Error: "+ e);
	}
%>

<br>
<tr><td>Auction History</td></tr>
<tr>
<td>Bidder ID</td>
<td>Date</td>
<td>Price</td>
</tr>
<%
	List<String> list = new ArrayList<String>();

	try{
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	
	String query="SELECT * FROM Bids WHERE Bids.auction_ID='"+aucID+"';";
	Statement stmt=con.createStatement();
	ResultSet res=stmt.executeQuery(query);
	while (res.next()){
		%>
		<tr>
		<td><%=res.getInt("Bids.bidder")%></td>
		<td><%=res.getDate("Bids.datetime")%></td>
		<td><%=res.getInt("Bids.price")%></td>
		</tr>
	<%
	}
	%>
	<tr><td><a href="homepage.jsp">Back to home</a></td></tr>
	</table>
	
	Forum<br><br>
	<table>
	<tr>
<td>User</td>
<td>Question</td>
<td>Answer</td>
</tr>
	<%
		ApplicationDB d= new ApplicationDB();
		Connection Conn= d.getConnection();
		
		String q="SELECT Users.user_name, Question, Answer FROM Questions JOIN Users ON Questions.Asker=Users.User_ID WHERE Questions.Auction_ID= "+aucID;
		ResultSet R=stmt.executeQuery(q);
		
		while(R.next()){
		%>
		<tr>
		<td><%=R.getString("Users.user_name")%></td>
		<td><%=R.getString("Question")%></td>
		<td><%=R.getString("Answer") %>
		</tr>	
	<% }%>	
		
	
	
	
	</table>
	<br>
	<form method=post, action="askQuestion.jsp">
	 Post Question <input type="text", name="q"> 
	 <input type="hidden", name="auctionID", value=<%=aucID %> display>
	<input type="submit", value="submit">
	</form>
	
	<% res.close();
	stmt.close();
	}catch (Exception e) {
		out.print("Error: "+ e);
	}%>
	

</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.util.Date, java.text.*, java.time.format.DateTimeFormatter.*, java.util.Calendar" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--OLIVER WROTE THIS CODE  -->
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Home | Buymeantiques</title>

<style>
.admin_a{
  display : block;
}
.enduser_a{
 display: none;
}
.customrep_a{
display:none;}

.admin_b{
  display : none;
}
.enduser_b{
 display: none;
}
.customrep_b{
display:block;}
</style>



</head>
<body>
<br>
<h2>Home</h2>
<table>
<tr>

<td><a href="profile.jsp">Profile</a></td>
 <td><a href="alerts.jsp">Alerts    </a> </td>
 <td><a href="logout.jsp">Log out</a><td>
<td>
<div id= status, class= <%= session.getAttribute("status")+"_a"%>>
<a href="Admin.jsp">Administrative functions</a>
</div></td><td>
<div id= status, class=<%=session.getAttribute("status")+"_b" %>>
<a href="CustomerRep.jsp">Customer Representative Functions</a>
</div></td>

</tr>
</table>
<br>

<a href="createAuctionForm.jsp">CREATE AUCTION</a> <br>
<a href="liveauctions.jsp">Advanced Search</a>
<br>
<table cellspacing="10">
<tr>
<td><a href="EndDate.jsp">Sort by End Date</a></td>
<td><a href="CurrentPrice.jsp">Sort by Price Lo to Hi</a></td>
<td><a href="CurrentPriceDesc.jsp">Sort by Price Hi to Lo</a></td>
</tr>
<tr>
<td>Title</td>
<td>End Date</td>
<td>Current Price</td>
<td>Seller</td>
<td>Item</td>
<td>Color</td>
<td>Style</td>
</tr>
<%
	System.out.println(session.getAttribute("userID"));

	List<String> list = new ArrayList<String>();
	Calendar c = Calendar.getInstance();

	try{
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	
	
	String query="SELECT * FROM Live_Auction";
	Statement stmt=con.createStatement();
	ResultSet res=stmt.executeQuery(query);

	while (res.next()){
		//Skip finished auctions
		Date currdate = new Date();
		Date aucEnd = res.getDate("end_date");
		c.setTime(aucEnd);
		c.add(Calendar.DAY_OF_MONTH, 1);
		Date e = c.getTime();
		if(aucEnd.before(currdate)){
			int id = res.getInt("auction_ID");
			int seller = res.getInt("seller");
			double price = res.getDouble("current_price");
			int item = res.getInt("item_ID");
			List<Integer> finished = new ArrayList<Integer>();
			String query2 = "SELECT * FROM Complete_Auction";
			Statement statement = con.createStatement();
			ResultSet rs = statement.executeQuery(query2);
			while(rs.next()){
				finished.add(rs.getInt("auction_ID"));
			}
			if(!finished.contains(id)){
				String getBuyer = "SELECT * FROM Bids WHERE auction_ID = "+id+" AND price="+price+";";
				Statement buyerState = con.createStatement();
				ResultSet buyers = buyerState.executeQuery(getBuyer);
				int buyer = -1;
				while(buyers.next()){
					buyer = buyers.getInt("bidder");
				}
				String insert = "INSERT INTO Complete_Auction(auction_ID, seller, buyer, item_ID, price, date)"
						+ "VALUES (?, ?, ?, ?, ?,?)";
				PreparedStatement ps = con.prepareStatement(insert);
				
				java.text.SimpleDateFormat sdf = 
					     new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				
				String currentTime = sdf.format(aucEnd);
				ps.setInt(1, id);
				ps.setInt(2, seller);
				ps.setInt(3, buyer);
				ps.setInt(4, item);
				ps.setDouble(5, price);
				ps.setString(6, aucEnd.toString());
				
				ps.executeUpdate();
				
				ps.close();
			}
			statement.close();
			continue;
		}
		
		int id = res.getInt("seller");
		
		String getUser="SELECT user_name FROM Users WHERE Users.user_ID='"+id+"';";
		Statement stmt3=con.createStatement();
		ResultSet resu=stmt3.executeQuery(getUser);
		String seller = "NA";
		while(resu.next()){
			seller = resu.getString("user_name");
		}
		int aucID = res.getInt("auction_ID");
		String title = res.getString("title");
		String date = res.getDate("end_date").toString();
		int price = res.getInt("current_price");
		%>
		<tr>
		
		<td><a href="aucprofile.jsp?value=<%=aucID%>&val2=<%=seller%>"><%=title%></a></td>
		<td><%=aucEnd.toString() %></td>
		<td><%=price %></td>
		<td><%=seller %></td>
		
		
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
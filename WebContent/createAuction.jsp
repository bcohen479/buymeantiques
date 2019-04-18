<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create Auction</title>
</head>
<body>
<%
	List<String> list = new ArrayList<String>();

		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			
			//Item details
			String itemType = request.getParameter("itemType");
			String itemName = request.getParameter("itemName");
			String itemManufacturer = request.getParameter("itemManufacturer");
			String itemYear = request.getParameter("itemDate");
			String itemColor = request.getParameter("itemColor");
			int itemId = 1;
			String query2 = "SELECT MAX(item_ID) FROM Items;";
			ResultSet iid = stmt.executeQuery(query2);
			if(iid.next()){
				itemId = iid.getInt(1) + 1;
			}
			
			
			//Auction details
			String aucDate = request.getParameter("auc_end");
			String aucName = request.getParameter("auc_title");
			String description = request.getParameter("description");
/* 			java.util.Date date = new java.text.SimpleDateFormat("dd/MM/yyyy").parse(aucDate);
 */			Double startingPrice = Double.parseDouble(request.getParameter("auc_startingPrice"));
			Double reservePrice = Double.parseDouble(request.getParameter("auc_reserve"));
			int aucId = 1;
			String query = "SELECT MAX(auction_ID) FROM Live_Auction;";
			ResultSet latest = stmt.executeQuery(query);
			if(latest.next()){
				aucId = latest.getInt(1) + 1;
			}
			
			int user = -1;
			if(session.getAttribute("userID")!=null){
				user = (Integer) session.getAttribute("userID");
			}

			//Make an insert statement
			String insertItem = "INSERT INTO Items(item_ID, name, manufacturer, date, color, style)"
					+ "VALUES (?, ?, ?, ?, ?, ?)";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(insertItem);
			System.out.println("WORKING: " + itemYear);
			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setInt(1, itemId);
			ps.setString(2, itemName);
			ps.setString(3, itemManufacturer);
			ps.setDate(4, java.sql.Date.valueOf(itemYear));
			ps.setString(5, itemColor);
			ps.setString(6, "");
			
			
			String insertItemType = "INSERT INTO Jewelry(item_ID, weight)" + "VALUES (?, ?)";
			if(itemType.matches("Tables")){
				insertItemType = "INSERT INTO Tables(item_ID, dimensions)" + "VALUES (?, ?)";
			}else if(itemType.matches("Chairs")){
				insertItemType = "INSERT INTO Chairs(item_ID, height)" + "VALUES (?, ?)";
			}
			PreparedStatement ps2 = con.prepareStatement(insertItemType);

			ps2.setInt(1, itemId);
			ps2.setString(2, "");
			//Run the query against the DB
 			try{
				ps.executeUpdate();
				ps2.executeUpdate();
 			    //response.sendRedirect(response.encodeURL("success.jsp"));
			}catch(SQLException ex){
				  System.out.println("FAILED INSERTING: " + ex);
				    	
			}
			ps.close();
			ps2.close();
			System.out.println("Item tables updated");
			
			String makeAuction = "INSERT INTO Live_Auction(auction_ID, item_ID, current_price, end_date, seller, min_price, title, description)"
					+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement aucPs = con.prepareStatement(makeAuction);
			aucPs.setInt(1, aucId);
			aucPs.setInt(2, itemId);
			aucPs.setDouble(3, startingPrice);
			aucPs.setDate(4, java.sql.Date.valueOf(aucDate));
			aucPs.setInt(5, user);
			aucPs.setDouble(6, reservePrice);
			aucPs.setString(7, aucName);
			aucPs.setString(8, description);
			
 			try{
				aucPs.executeUpdate();
			}catch(SQLException ex){
				  System.out.println("FAILED to make auction: " + ex);
			} 
			aucPs.close();
			System.out.println("Auction created\n");
			//Set Initial Bid
			int iniBid = -1;
			String queryBid = "SELECT MAX(bid_id) FROM Bids;";
			ResultSet latestBid = stmt.executeQuery(queryBid);
			if(latestBid.next()){
				iniBid = latestBid.getInt(1) + 1;
			}
			String initialBid = "INSERT INTO Bids(bid_id, auction_ID, bidder, datetime, price, reserve)"
					+ "VALUES(?, ?, ?, ?, ?, ?)";
			PreparedStatement bidPs = con.prepareStatement(initialBid);
			bidPs.setInt(1, iniBid);
			bidPs.setInt(2, aucId);
			bidPs.setInt(3, user);
			bidPs.setDate(4,java.sql.Date.valueOf(aucDate));
			bidPs.setDouble(5, startingPrice);
			bidPs.setDouble(6, reservePrice);
 			try{
				bidPs.executeUpdate();
			}catch(SQLException ex){
				  System.out.println("FAILED to make initial bid: " + ex);
			} 
			bidPs.close();
				
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			response.sendRedirect(response.encodeURL("homepage.jsp"));
			

		} catch (Exception e) {
			out.print("Error: "+ e);
		}
	%>
</body>
</html>
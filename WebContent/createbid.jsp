<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.util.Date, java.text.*, java.time.format.DateTimeFormatter" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Place Bid</title>
</head>
<body>
<%
	List<String> list = new ArrayList<String>();

		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			System.out.println("werk");
			int bidID = -1;
			int aucID = Integer.parseInt(request.getParameter("auction"));
			int userID = Integer.parseInt(request.getParameter("bidder"));
			double bid = Double.parseDouble(request.getParameter("bidPrice"));
			System.out.println("twerk");

			Date dt = new Date();
			SimpleDateFormat sdf = 
			     new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String currentTime = sdf.format(dt);
			System.out.println("werk");
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			String query = "SELECT MAX(bid_id) FROM Bids WHERE Bids.auction_ID = '" + aucID + "';";
			ResultSet rs = stmt.executeQuery(query);
			if(rs.next()){
				bidID = rs.getInt(1)+1;
			}
			
			String insert = "INSERT INTO Bids(auction_ID, bid_id, bidder, datetime, price)"
					+ "VALUES (?, ?, ?, ?, ?)";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(insert);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setInt(1, aucID);
			ps.setInt(2, bidID);
			ps.setInt(3, userID);
			ps.setString(4, currentTime);
			ps.setDouble(5, bid);
			
			ps.executeUpdate();
			
			
			con.close();
		    response.sendRedirect(response.encodeURL("homepage.jsp"));

		} catch (Exception e) {
			out.print("Error: "+ e);
		}
	%>
</body>
</html>
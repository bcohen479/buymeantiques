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
			int bidID = -1;
			int aucID = Integer.parseInt(request.getParameter("auction"));
			int userID = Integer.parseInt(request.getParameter("bidder"));
			double reserve = 0.00;
			double bid = Double.parseDouble(request.getParameter("bidPrice"));
			String res = request.getParameter("hiddenPrice");
			System.out.println("res:" + res);
			if(!res.matches("")){
				reserve = Double.parseDouble(request.getParameter("hiddenPrice"));
			}
	 /* 		if(request.getParameter("hiddenPrice")!=null){
				reserve = Double.parseDouble(request.getParameter("hiddenPrice"));
			} */
 
			Date dt = new Date();
			SimpleDateFormat sdf = 
			     new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String currentTime = sdf.format(dt);
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			String query = "SELECT MAX(bid_id) FROM Bids;";
			ResultSet rs = stmt.executeQuery(query);
			if(rs.next()){
				bidID = rs.getInt(1)+1;
			}
			
		/* 	String insert = "INSERT INTO Bids(auction_ID, bid_id, bidder, datetime, price, reserve)"
					+ "VALUES (?, ?, ?, ?, ?,?)"; */
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			/* PreparedStatement ps = con.prepareStatement(insert); */
			CallableStatement call = con.prepareCall("{call addBid(?, ?, ?, ?, ?, ?)}");

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			call.setInt(1, aucID);
			call.setInt(2, bidID);
			call.setInt(3, userID);
			call.setDouble(4, reserve);
			call.setString(5, currentTime);
			call.setDouble(6, bid);
			
			call.execute();
			
			
			con.close();
		    response.sendRedirect(response.encodeURL("homepage.jsp"));

		} catch (Exception e) {
			out.print("Error: "+ e);
		}
	%>
</body>
</html>
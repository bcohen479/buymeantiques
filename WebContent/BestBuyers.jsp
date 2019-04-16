<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Top Buyers</title>
</head>
<body>
<%
		List<String> list = new ArrayList<String>();

		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			String str = "SELECT Users.user_name AS uname, COUNT(Complete_Auction.Item_ID) AS bids_won, sum(Complete_Auction.price) As total_price FROM  (Complete_Auction JOIN Users ON Complete_Auction.seller= Users.user_ID) ORDER BY bids_won DESC";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);

			//Make an HTML table to show the results in:
			out.print("<table>");

			//make a row
			out.print("<tr><td>Customer</td><td>Total Auctions Won</td><td>Total Spent</td>");
			
			
			

			//parse out the results
			while (result.next()) {
				
				out.print("<tr>");
				
				out.print("<td>");
				
				out.print(result.getString("uname"));
				out.print("</td>");
				out.print("<td>");
				
				out.print(result.getInt("bids_won"));
				out.print("</td><td>");
				out.print("$"+result.getInt("total_price"));
				out.print("</td></tr>");

			}
			out.print("</table>");

			//close the connection.
			con.close();

		} catch (Exception e) {
			out.print("Error: "+ e);
		}
	%>

</body>
</html>
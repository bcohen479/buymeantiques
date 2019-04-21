<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Earnings Per</title>
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
			//Get the combobox from the index.jsp
			String attr = request.getParameter("attr");
			
			String str;
			
			if(!attr.equals("Items.Item_ID")){
				String n="";
				if(attr.equals("name")){
					n="Item";
				}
				else{
					n="Seller";
				}
				
			str = "SELECT "+attr+" AS"+n+", sum(Complete_Auction.price) AS 'Earnings' FROM ((Complete_Auction Join Items ON Complete_Auction.Item_ID=Items.Item_ID) Join Users ON Complete_Auction.seller=Users.user_ID) Group By "+attr;
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);

			//Make an HTML table to show the results in:
			out.print("<table>");

			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print(n);
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Earnings");
			out.print("</td>");
			
			out.print("</tr>");

			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//Print out current bar name:
				out.print(result.getString(n));
				out.print("</td>");
				out.print("<td>");
				//Print out current beer name:
				out.print(result.getString("Earnings"));
				out.print("</td>");
				out.print("</tr>");

			}
			out.print("</table>");
			}
			
		else{
			str= "SELECT sum(J.price) As Jewelry, sum(C.price) AS Chairs, sum(T.price) AS Tables From (Complete_Auction As C Join Chairs ON C.Item_ID=Chairs.Item_ID), (Complete_Auction As J Join Jewelry ON J.Item_ID=Jewelry.Item_ID), (Complete_Auction As T Join Tables On T.Item_ID=Tables.Item_ID)";
			ResultSet res = stmt.executeQuery(str);
			res.next();
			

			out.print("<table>");
			out.print("<tr><td>Item Type</td><td>Jewelry</td><td>Chairs</td></tr>");
			out.print("<tr><td>Earnings</td><td>");
			out.print(res.getInt("J"));
			out.print("</td><td>");
			out.print(res.getInt("C"));
			out.print("</td><td></tr></table>");
			
			
		}
			
			
			
			//close the connection.
			con.close();

		} catch (Exception e) {
			out.print("Error: "+ e);
		}
	%>
</body>
</html>
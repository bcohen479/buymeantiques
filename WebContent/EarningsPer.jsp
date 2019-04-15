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
			str = "SELECT "+attr+", sum(Complete_Auction.price) AS 'Earnings' FROM ((Complete_Auction Join Items ON Complete_Auction.Item_ID=Items.Item_ID) Join Users ON Complete_Auction.seller=Users.user_ID)";}
			else{
			str="Blah";
			}
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);

			//Make an HTML table to show the results in:
			out.print("<table>");

			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print(attr);
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
				out.print(result.getString(attr));
				out.print("</td>");
				out.print("<td>");
				//Print out current beer name:
				out.print(result.getString("Earnings"));
				out.print("</td>");
				out.print("</tr>");

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
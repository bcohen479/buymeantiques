<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Display results</title>
</head>
<body>
<% try {
	
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
			Statement stmt = con.createStatement();
			
			String val = request.getParameter("attribute");
			String field=request.getParameter("f");
			//out.print(field);
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "SELECT * FROM Live_Auction WHERE "+field+"= '"+val+ "'";			
			
			ResultSet res = stmt.executeQuery(str);
			
			
			//out.print(result.getInt("auction_ID"));
			//Make an HTML table to show the results in:
		if(res.next()){
			
			ResultSet result=stmt.executeQuery(str);
		
			out.print("<form method='post' action='findandEditAuction.jsp'>");
			out.print("<table>");
			out.print("<tr><h3>Search Results</h3></tr>");

			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			out.print("Select");
			out.print("</td>");
			
			
			out.print("<td>");
			//print out column header
			out.print("Auction ID");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Title");
			out.print("</td>");
			out.print("<td>");
			out.print("Seller");
			out.print("</td>");
			out.print("<td>");
			out.print("Item ID");
			out.print("</td>");
			
			out.print("</tr>");
			
			out.print("<tr>");
			
			


			//parse out the results
			
			while (result.next()) {
				//make a row
				
				//out.print("<tr>");
				out.print("<td>");
				out.print("<input type='radio' name=aucID value="+result.getInt("auction_ID")+" required>");
				out.print("</td>");
				
				
			
				out.print("<td>");
				out.print(result.getInt("auction_ID"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(result.getString("Title"));
				out.print("</td>");
				
				out.print("<td>");
				out.print(result.getInt("Seller"));
				out.print("</td>");
				
				
				//int i=
				out.print("<td>");
				out.print(result.getInt("item_ID"));
				out.print("</td>");
				
				
				
				out.print("</tr>");
			}
			out.print("</table><br>");
			out.print("<table>");
			out.print("<tr>");
			
			out.print("<input type='hidden', name='field' value="+field+">");
			out.print("<input type='hidden', name='val' value="+val+">");
			
			out.print("<td><button type='submit' name='remove' value='remove'> Delete selected Auction </button>   ");
			out.print("</td><td>");
			out.print("<button type='submit' name='showbids' value='showbids'> Show and Edit bids for this Auction</button>");
			
		
			out.print("</td></tr>");
			out.print("</table><table>");
			//out.print("<tr>");
			
			//out.print("</td></tr>");
			
			out.print("<tr>");
			
			
			out.print("<td>");
			out.print("Select Field to Change: ");
			out.print("<select name='changefield' size=1>"); 
			out.print("<option value='title'>Title</option>");
			out.print("<option value='description'>Description</option>");
			out.print("<option value='end_date'>End date</option>");
			out.print("<option value='min_price'> Minimum Price </option>");
		out.print("</select><br>");
			
			
			out.print("</td>");
			
			out.print("<td>");
			
			out.print("Enter new value:  ");
			out.print("</td>");
			out.print("<td>");
			out.print("<input type='text' name='updated'>");
			out.print("</td>");
			out.print("<td>");
			out.print("<br>");
			out.print("<button type='submit' name='whatf'>");
			out.print("Update");
			out.print("</button>");
			out.print("</td>");
			out.print("</tr>");
			
			
			//out.print("<input type='submit' value='submit'>");
			out.print("</table>");
			out.print("</form>");
}else{
	out.print("<a href=CustomerRep.jsp> No auctions matching your search were found.  Please try again </a>");}

			
			//close the connection.
			db.closeConnection(con);
		} catch (Exception e) {
			out.print(e);
		}
	%>
</body>
</html>
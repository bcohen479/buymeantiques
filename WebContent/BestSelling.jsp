<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

Best Selling:
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
			String num= request.getParameter("quant");
			String n="";
			if(attr.equals("name")){
				n="Item";
			}
			else{
				n="Seller";
			}
			String str = "SELECT "+attr+" AS "+n+
					", COUNT(Complete_Auction.Item_ID) AS 'Sales', SUM(Complete_Auction.price) AS 'Revenue' FROM ((Complete_Auction Join Items ON Complete_Auction.Item_ID=Items.Item_ID) Join Users ON Complete_Auction.seller=Users.user_ID) Group By "
						+attr+ " ORDER BY Sales DESC LIMIT "+num;
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
			out.print("Sales");
			out.print("</td>");
			out.print("<td>Revenue</td>");
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
				out.print(result.getString("Sales"));
				out.print("</td>");
				out.print("<td>"+result.getString("Revenue")+"</td>");
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
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>update the auction </title>
</head>
<body>



<%

		List<String> list = new ArrayList<String>();
		try {

			
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			Statement stmt = con.createStatement();
		
			int aid= Integer.parseInt(request.getParameter("aucID"));
			String checkclosed="Select * FROM Complete_Auction Where Auction_ID="+aid;
			ResultSet rs=stmt.executeQuery(checkclosed);
			if(rs.next()){
				out.print("This Auction is closed and cannot be edited.  <a href='DisplayAuctionsAsTable.jsp?f="+request.getParameter("field")+
						"&attribute="+request.getParameter("val")+"'>Go Back</a>");
			}else{
			//System.out.println(aid);
			if(request.getParameter("remove")!=null){
				String sql = "DELETE FROM Live_Auction WHERE auction_ID= ?";

				PreparedStatement ps = con.prepareStatement(sql);
				ps.setInt(1,aid);
				ps.executeUpdate();
				out.print("<tr>Auction has been removed.  <a href='DisplayAuctionsAsTable.jsp?f="+request.getParameter("field")+
						"&attribute="+request.getParameter("val")+"'>Go Back</a>");
			}else{
			if(request.getParameter("showbids")!=null){
				//out.print();
				String query="Select * From Bids where auction_ID="+aid;
				Statement smt= con.createStatement();
				ResultSet r= smt.executeQuery(query);
				out.print("<table>");
				out.print("<tr><td><h1> Bids for Auction #"+aid+"</h1></td>");
				out.print("<td><a href='DisplayAuctionsAsTable.jsp?f="+request.getParameter("field")+
						"&attribute="+request.getParameter("val")+"'>Go Back</a></td></tr>");
			
				out.print("<form method='post' action='Editbids.jsp'>");
				
				out.print("<tr>");
				out.print("<td> Select </td>");
				out.print("<td> Bidder ID </td>");
				out.print("<td> Bid Amount </td>");
				out.print("</tr>");
				while(r.next()){
					out.print("<tr>");
					out.print("<td>");
					out.print("<input type='radio' name=bid_ID value="+r.getInt("bid_ID")+">");
					out.print("</td>");
					
					
				
					out.print("<td>");
					out.print(r.getInt("bidder"));
					out.print("</td>");
					
					
					out.print("<td>");
					out.print(r.getString("price"));
					out.print("</td>");
					out.print("</tr>");
				
				}
				out.print("<br>");
				
				out.print("<tr>");
				out.print("<td>");
				out.print("Change Bid Amount");
				out.print("</td>");
				out.print("<td>");
				out.print("<input type='text' name='newbidamount'>");
				out.print("</td>");
				out.print("<td>");
				out.print("<button type='submit' name='newbid'> Change Bid </button>");
				out.print("</td></tr>");
				out.print("</table><table");
				out.print("<tr>");
				out.print("<button type='submit' name='remove' value='remove'> Delete selected Bid </button>");
				out.print("</tr>");
				out.print("</form>");
				
				
				out.print("</table");
			}else{
			String changeField= request.getParameter("changefield");
			System.out.println(changeField);
			//String operation= request.getParameter();
			//String strng= "Update Users Set password='"+request.getParameter("updated")+"' WHERE User_ID= "+uid;
			PreparedStatement ps=con.prepareStatement("Update Live_Auction Set "+ changeField+ "= ? WHERE auction_ID= ?");
			
			
			String s= request.getParameter("updated");
			System.out.println(s);
			ps.setString(1,s);
			
			ps.setInt(2, aid);
			ps.executeUpdate();
			ps.close();
			
	out.print("successfully updated.   ");
	out.print("<tr><a href='DisplayAuctionsAsTable.jsp?f="+request.getParameter("field")+
			"&attribute="+request.getParameter("val")+"'>Go Back</a>");
	
			}
		con.close();
		
			}} }catch (Exception e) {
			out.print("Error: "+ e);
		}
	%>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<!--LEANNE WROTE THIS CODE  -->
<meta charset="ISO-8859-1">
<title>Edit Bids</title>
</head>
<body>
<% 
		List<String> list = new ArrayList<String>();

		try {

			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			
			Statement stmt = con.createStatement();
			
			int bidid = Integer.parseInt(request.getParameter("bid_ID"));
			//String changefield=request.getParameter();
			
			//String str = "SELECT * FROM Bids WHERE bid_id= "+bidid;			
			//Run the query against the database.
			//ResultSet result = stmt.executeQuery(str);
			
			if(request.getParameter("remove")!=null){
				String sql = "DELETE FROM Bids WHERE bid_ID= ?";

				PreparedStatement ps = con.prepareStatement(sql);
				ps.setInt(1,bidid);
				ps.executeUpdate();
				ps.close();
			}
			else{ 
			
			PreparedStatement ps=con.prepareStatement("Update Bids Set price =? WHERE bid_ID= ?");
			ps.setString(1,request.getParameter("newbidamount"));
			ps.setInt(2, bidid);
			   ps.executeUpdate();
			    ps.close();
			}
			
				    
				 
			
			out.print("<a href='CustomerRep.jsp'> Success, go back to Customer Rep homepage </a>");
			


	
		con.close();
		
		} catch (Exception e) {
			out.print("Error: "+ e);
		}
	%>
</body>
</html>
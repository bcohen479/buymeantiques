<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!--WE ALL WROTE THIS CODE  -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Verify</title>
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
			String entity = request.getParameter("email");
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			String str = "SELECT * FROM Users WHERE email = " + entity;
			String all = "SELECT * FROM Users";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(all);

			//parse out the results
			while (result.next()) {
				String mailn = result.getString("email");
				if(mailn.equals(entity))
					list.add(mailn);

			}
			if(list.size()==0){
				int id = 0;
				String query = "SELECT MAX(user_ID) FROM Users;";
				out.println("working");
				ResultSet latest = stmt.executeQuery(query);
				if(latest.next()){
					id = latest.getInt(1) + 1;
				}
				
				String username = request.getParameter("username");
				String email = request.getParameter("email");
				String pw = request.getParameter("password");
				out.println("working2");
				//Make an insert statement for the Sells table:
				String insert = "INSERT INTO Users(user_ID, user_name, email, password, Status)"
						+ "VALUES (?, ?, ?, ?,?)";
				//Create a Prepared SQL statement allowing you to introduce the parameters of the query
				PreparedStatement ps = con.prepareStatement(insert);

				//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
				ps.setInt(1, id);
				ps.setString(2, username);
				ps.setString(3, email);
				ps.setString(4, pw);
				ps.setString(5, "enduser");
				//Run the query against the DB
				try{
					ps.executeUpdate();
				    session.setAttribute("userID", id);
					session.setAttribute("userName", username);
					session.setAttribute("status", "enduser");
				    response.sendRedirect(response.encodeURL("success.jsp"));}
				catch(SQLException ex){
				    	
				    	
				}
				//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				con.close();
				ps.close();

				out.print("Insert succeeded!");
				
				
			}else{
				out.println("An account already exists with that email...");
				response.sendRedirect(response.encodeRedirectURL("index.jsp"));
			}
/* 			out.print("</table>");
 */
			//close the connection.
			con.close();

		} catch (Exception e) {
			out.print("Error: "+ e);
		}
	%>
</body>
</html>
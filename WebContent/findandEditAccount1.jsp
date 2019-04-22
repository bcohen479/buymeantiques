<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<!--LEANNE WROTE THIS CODE  -->
<meta charset="ISO-8859-1">
<title>Insert title here</title>
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
			String val = request.getParameter("attribute");
			String f = request.getParameter("f");
			//String changefield=request.getParameter();
			
			String str = "SELECT * FROM Users WHERE "+f+"= '"+val+ "'";			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			if(!result.next()){
				out.print("No such user exists.  Please try agian or have user create new account");
			}
			else{ 
			int uid= result.getInt("User_ID");
			String changeField= request.getParameter("updatethisfield");
			//String strng= "Update Users Set password='"+request.getParameter("updated")+"' WHERE User_ID= "+uid;
			PreparedStatement ps=con.prepareStatement("Update Users Set "+ changeField+ "= ? WHERE User_ID= ?");
			ps.setString(1,request.getParameter("updated"));
			ps.setInt(2, uid);
			
			
				    
				    ps.executeUpdate();
				    ps.close();
			
			out.print(changeField + "has been changed for "+uid);
					out.print("<a href='CustomerRep.jsp'> Go back to Customer Representative Homepage </a>");


	
		con.close();
		}
		} catch (Exception e) {
			out.print("Error: "+ e);
		}
	%>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Home | Buymeantiques</title>
</head>
<body>
<br>
<h2>Home</h2>
<a href="profile.jsp">Profile</a>    <a href="#">Alerts    </a> <br>
<a href="liveauctions.jsp">Advanced Search</a>
<br>
<table cellspacing="10">
<tr>
<td><a href="EndDate.jsp">Sort by End Date</a></td>
<td><a href="CurrentPrice.jsp">Sort by Price Lo to Hi</a></td>
<td><a href="CurrentPriceDesc.jsp">Sort by Price Hi to Lo</a></td>
</tr>
<tr>
<td>Title</td>
<td>End Date</td>
<td>Current Price</td>
<td>Seller</td>
<td>Item</td>
<td>Color</td>
<td>Style</td>
</tr>
<%
	List<String> list = new ArrayList<String>();

	try{
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	
	String query="SELECT * FROM Live_Auction";
	Statement stmt=con.createStatement();
	ResultSet res=stmt.executeQuery(query);
	System.out.println("yeet");
/* 	int id = -1;
 *//*	int id = res.getInt("seller");
	System.out.println("BROKE");
	String getUser="SELECT user_name FROM Users WHERE Users.user_ID='"+id+"';";
	Statement stmt3=con.createStatement();
	ResultSet resu=stmt3.executeQuery(getUser);
	String seller = resu.getString("user_name");
	System.out.println(seller); */
	while (res.next()){
		int id = res.getInt("seller");
		System.out.println("BROKE");
		
		String getUser="SELECT user_name FROM Users WHERE Users.user_ID='"+id+"';";
		Statement stmt3=con.createStatement();
		ResultSet resu=stmt3.executeQuery(getUser);
		String seller = "NA";
		System.out.println(seller);
		while(resu.next()){
			seller = resu.getString("user_name");
		}
		System.out.println(seller); 
		String title = res.getString("title");
		String date = res.getDate("end_date").toString();
		int price = res.getInt("current_price");
		%>
		<tr>
		<td><a href="#"><%=title %></td></a>
		<td><%=date %></td>
		<td><%=price %></td>
		<td><%=seller %></td>
		
	<%
		String query2="SELECT * FROM Items WHERE Items.item_ID='"+res.getInt("item_ID")+ "';";
		Statement stmt2=con.createStatement();
		ResultSet res2=stmt2.executeQuery(query2);
		while (res2.next()){
		%>
		<td><%=res2.getString("name")%></td>
		<td><%=res2.getString("color")%></td>
		<td><%=res2.getString("style")%></td>
		</tr>
		<%
		}
	}
	%>
	</table>
	<%res.close();
	stmt.close();
	}catch (Exception e) {
		out.print("Error: "+ e);
	}
	%>
</body>
</html>
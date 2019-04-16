<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Inserting the question</title>
</head>
<body>
<%try{
	ApplicationDB db=new ApplicationDB();
	Connection Con= db.getConnection();
	Statement S= Con.createStatement();
	
	int askerid= (Integer) session.getAttribute("userID");
	//System.out.println(askerid);
	String question=request.getParameter("q");
	//System.out.println(question);
 	int aucID =Integer.parseInt(request.getParameter("auctionID"));
 	//System.out.println(aucID);

	
	int qq=1;
	
	String query = "SELECT MAX(Q_ID) FROM Questions;";
	ResultSet latest = S.executeQuery(query);
	if(latest.next()){
		qq = latest.getInt(1) + 1;
	}
	//out.println(qq);
	PreparedStatement ps= Con.prepareStatement("Insert Into Questions (Q_ID, Asker, Question, Auction_ID) values (?,?,?,?)");
	ps.setInt(1,qq);
	ps.setInt(2,askerid);
	ps.setString(3,question);
	ps.setInt(4,aucID);
	
	ps.executeUpdate();
	out.print("<a href= homepage.jsp>Go home</a>");
}

catch(Exception e) {
	out.print("Error: "+ e);
	
}
%>
</body>
</html>
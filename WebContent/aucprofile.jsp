<%/*
This page shows the history of bids for any auction.
*/%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Auction Profile</title>
<!--OLIVER WROTE MOST OF THE CODE IN THIS FILE. 
LEANNE WROTE THE BOTTOM PART DEALING WITH THE FORUM  -->
<script type="text/javascript">

function typeCheck() {
    if (document.getElementById('jewl').checked) {
        document.getElementById('ifJewelry').style.display = 'block';
        document.getElementById('ifTable').style.display = 'none';
    	document.getElementById('ifChair').style.display = 'none';
    }else if(document.getElementById('table').checked){
    	document.getElementById('ifTable').style.display = 'block';
    	document.getElementById('ifJewelry').style.display = 'none';
    	document.getElementById('ifChair').style.display = 'none';
    }
    else if(document.getElementById('chair').checked){
    	document.getElementById('ifJewelry').style.display = 'none';
    	document.getElementById('ifTable').style.display = 'none';
    	document.getElementById('ifChair').style.display = 'block';
    }

}



</script>
</head>
<body>

<table cellspacing="5" style="table-layou:fixed">
<%
	List<Integer> auction = new ArrayList<Integer>();
	String aucID = request.getParameter("value");
	
	try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		

		if(aucID != null){
			System.out.println("id: "+aucID);
/* 			String seller = request.getParameter("val2");
 */			String aucQuery = "SELECT * FROM Live_Auction JOIN Users ON seller = user_ID WHERE auction_ID='"+aucID+"';";
 			String compAuc = "SELECT * FROM Complete_Auction;";
			Statement statement = con.createStatement();
			ResultSet rs = statement.executeQuery(aucQuery);
			Statement s = con.createStatement();
			ResultSet ds = s.executeQuery(compAuc);
			while(rs.next()){
				while(ds.next()){
					auction.add(ds.getInt("auction_ID"));
					System.out.print(ds.getInt("auction_ID"));
				}

				%>
				<tr><h3><%=rs.getString("title")%></h3></tr>
				<br>
				<br>
				<p>Description : <%=rs.getString("description") %></p>
				<tr><td id="bidbutton" style=""><h5><a id="bidbutton" href="placebid.jsp?aucID=<%=aucID%>&aucTitle=<%=rs.getString("title")%>">PLACE BID</a></h5></td></tr>
				<tr><td>Seller: <%=rs.getString("user_name")%></td></tr>
				<tr><td>Current Price: $<%=rs.getInt("current_price") %></td></tr>
				<tr><td>End Date: <%=rs.getDate("end_date").toString()%></td></tr>
				<%-- <tr><td>Description : <%=rs.getString("description") %></td></tr> --%>
				
			<%
				if(auction.contains(Integer.parseInt(aucID))){
					System.out.println("CALLED");
					%>
					<script>
					function endCheck() {
						document.getElementByID('bidbutton').style.display = 'none';
					}
					</script>
					<% 
				}
			}
			statement.close();
			rs.close();
		}else{
			System.out.println("NULL");
		}
	}catch (Exception e) {
		out.print("Error: "+ e);
	}
%>

<br>
<tr><td>Auction History</td></tr>
<tr>
<td>Bidder ID</td>
<td>Date</td>
<td>Price</td>
</tr>
<%
	List<String> list = new ArrayList<String>();

	try{
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	
	String query="SELECT * FROM Bids WHERE Bids.auction_ID='"+aucID+"';";
	Statement stmt=con.createStatement();
	ResultSet res=stmt.executeQuery(query);
	while (res.next()){
		%>
		<tr>
		<td><%=res.getInt("Bids.bidder")%></td>
		<td><%=res.getDate("Bids.datetime")%></td>
		<td><%=res.getInt("Bids.price")%></td>
		</tr>
	<%
	}
	%>
	<tr><td><a href="homepage.jsp">Back to home</a></td></tr>
	</table>
	
	<h3>Forum</h3><br><br>
	<table>
	<tr>
<td>User</td>
<td>Question</td>
<td>Answer</td>
</tr>
	<%
		ApplicationDB d= new ApplicationDB();
		Connection Conn= d.getConnection();
		
		String q="SELECT Users.user_name, Question, Q_id, Answer FROM Questions JOIN Users ON Questions.Asker=Users.User_ID WHERE Questions.Auction_ID= "+aucID;
		ResultSet R=stmt.executeQuery(q);
		out.print("<form method=post, action=\"postResponse.jsp\">");
		while(R.next()){
		int qid=R.getInt("Q_id");
		String a="";
		if(R.getString("Answer")!=null&& R.getString("Answer").equals("")==false){
			a=R.getString("Answer");
		}else{
			if(session.getAttribute("status").equals("customrep")){
				a="<input type=text, name=ans required>"+"<input type=\"hidden\", name=\"qid\", value="+qid+
			"> <input type=\"hidden\", name=\"aid\", value="+aucID+
			"><input type=\"submit\" name=\"action\" value=\"Post Answer!\">";
			}
		}
		
		
		out.print("<tr><td>");
	
		out.print(R.getString("Users.user_name"));
		out.print("<td>"+R.getString("Question")+"</td><td>");
		out.print(a+"</td>");
		if(session.getAttribute("status").equals("customrep")){
			out.print("<td><input type=\"checkbox\" name=\"delete[]\" value="+
		qid+"></td>");
		}
		out.print("</tr>");
	 }
		if(session.getAttribute("status").equals("customrep")){
		out.print("<tr><td><input type=\"hidden\", name=\"aid\", value="+ aucID  +"><input type=\"submit\" name=\"action\" value=\"Delete Selected Questions\"></tr></td></form>");
		}
		out.print("</form>");
		%>
	
	
	
	</table>
	<br>
	<form method=post, action="askQuestion.jsp">
	 Post Question <input type="text" name="q"> 
	 <input type="hidden" name="auctionID" value=<%=aucID %>>
	<input type="submit" value="submit">
	</form>
	
	<% res.close();
	stmt.close();
	}catch (Exception e) {
		out.print("Error: "+ e);
	}%>
	

</body>
</html>
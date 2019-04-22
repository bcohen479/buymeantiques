<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Display results</title>
<script type="text/javascript"> 
function myfunction(){

var y=document.getElementById("nextPart");
y.style.display = "block";
var x = document.getElementById("mySelect").selectedIndex;

if(x===3){

document.getElementById("updateval").type = "number";
}

if(x===2){
document.getElementById("updateval").pattern = "[0-9]{4}-(0[1-9]|1[012])-(0[1-9]|1[0-9]|2[0-9]|3[01])";
document.getElementById("updateval").placeholder="YYYY-MM-DD";
}

}
</script>

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
			String str = "SELECT * FROM Live_Auction JOIN Users ON Live_Auction.seller=Users.user_ID WHERE "+field+"='"+val+ "'";			
			
			ResultSet res = stmt.executeQuery(str);
			
		if(res.next()){
			
			ResultSet result=stmt.executeQuery(str);%>
		
			<form method='post' action='findandEditAuction.jsp'>
			<table>
			<tr><h3>Search Results</h3></tr>
			<tr><td>Select</td>
			<td>Auction ID</td>
			<td>Title</td>
			<td>Seller</td>
			<td>Item ID</td></tr>
	<tr>
<% 
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
				out.print(result.getString("user_name"));
				out.print("</td>");
				
			
				
				out.print("<td>");
				out.print(result.getInt("item_ID"));
				out.print("</td>");
				
				
				
				out.print("</tr>");
			}
			out.print("</table><br><input type='hidden', name='field' value= "+field+
					"><input type='hidden', name='val' value="+val+">");
			
	
		
			
			
%>
<button type='submit' name='remove' value='remove'> Delete selected Auction </button>
<button type='submit' name='showbids' value='showbids'> Show and Edit bids for this Auction</button><br><br>
OR<br>
Select Field to Change
			<select name='changefield' size=1 id="mySelect"> 
			<option value='title' id="title">Title</option>
			<option value='description'id="description">Description</option>
			<option value='end_date'  id="end" >End date</option>
			<option value='min_price' id="min"> Minimum Price </option>
		</select><br>
<button type="button" onclick="myfunction()">Next</button>



<p id="nextPart" style="display: none"> 
Enter new value:
			
			<tr><input type='text' name='updated' id='updateval' pattern="" placeholder=""></tr>
			
			<br>
			<tr><button type= 'submit' name='whatf'>Update</button></tr>

</p>
</form><% 
		}
			else{
	out.print("<a href=CustomerRep.jsp> No auctions matching your search were found.  Please try again </a>");}

			
			//close the connection.
			db.closeConnection(con);
		} catch (Exception e) {
			out.print(e);
		}
	%>
</body>
</html>
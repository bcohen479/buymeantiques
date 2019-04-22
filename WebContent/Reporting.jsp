<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Generate Report | BuyMeAntiques</title>
</head>
<body>
<script type="text/javascript">

function ReportType() {
    if (document.getElementById('bs').checked) {
        document.getElementById('EP').style.display = 'block';
        document.getElementById('BS').style.display = 'none';
    	
    }else if(document.getElementById('ep').checked){
    	document.getElementById('BS').style.display = 'block';
    	document.getElementById('EP').style.display = 'none';
    }

}

</script>
<table><tr><h1>Generate Report</h1></tr></table>
<br>

<form method="post" action="GenerateSalesReport.jsp">
	<table>
	<tr><h3>
		Report Type
		</h3>
	</tr>
	<br>
	<tr>
		
			  <input type="radio" onclick="javascript:ReportType();" name="reportType" value="BestSelling" id="bs" required>Top Preforming<br>
			  <input type="radio" onclick="javascript:ReportType();" name="reportType" value="EarningsPer" id="ep" required>Earnings Per<br>
		
	</tr>
	</table>
	
	
<table id="EP" style="display: none">

<tr><td>Field to Report on: <td> </tr>
<tr><td>

<select name="attr" size=1>
			<option value="name AS Item">Item</option>
			<option value="Users.user_name AS seller">Seller</option>
			<option value="Users.user_name AS buyer">Buyer</option>
		</select>
		</td>
</tr>

<tr>
	<td>Rank By: </td>
	<td>
		<select name="sort" size=1>
			<option value="sum(Complete_Auction.price) AS 'Revenue'">Revenue Generated/Amount Spent</option>
			<option value="AVG(Complete_Auction.price) AS 'Average'">Average Price Per Sale</option>
			<option value="COUNT(Complete_Auction.Auction_ID) AS 'Sales'">Number of Sales</option></select>
	</td>
</tr>


<tr><td>Number of results to display: </td>
<td><select name="quant">
		<option value=1>1</option>
		<option value=2>2</option>
		<option value=3>3</option>
		<option value=5>5</option>
		<option value=10>10</option>
		<option value=20>20</option>
		<option value="No">No Limit</option>

	</select></td></tr>
<tr><td><input type="submit" value="submit"></td></tr>
</table>


<table id="BS" style="display: none">

<tr><td>Field to report on</td> </tr>
<tr>
<td>
<select name="reporton" size=1>
			<option value="name AS Item">Item</option>
			<option value="Users.user_name AS Seller">Seller</option>
			<option value="Items.Item_ID">Item type</option>
		</select>
		</td>
</tr>

<tr>
		<td>Fields to include in report:</td>
		<td>
		<input type="checkbox" name="exField[]" value="sum(Complete_Auction.price) AS Earnings"> Earnings<br>
  		<input type="checkbox" name="exField[]" value="AVG(Complete_Auction.price) AS Average"> Average Price Per Sale<br>
 		 <input type="checkbox" name="exField[]", value="COUNT(Complete_Auction.Auction_ID) AS Sales">Number of Sales</br>
		</td>
		</tr>
<tr>
		<td>
		Include Breakdown By (optional):</td><td>
		<input type="radio", name="GroupBy", value="time">Month
		<!-- <input type="radio", name="GroupBy", value=ItemType>Item Type -->
		</td></tr>
<tr>
<td>

<input type="radio", name="TotalEarnings", value=1> Display totals for BuyMeAntiques?</td></tr>
<tr><td><input type="submit" value="submit"></td></tr>
</table>

</body>
</html>
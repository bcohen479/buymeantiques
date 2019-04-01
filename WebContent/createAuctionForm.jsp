<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create Auction | BuyMeAntiques</title>
</head>
<body>
Add Auction details...
<br>

<form method="post" action="createAuction.jsp">
	<table>
	<tr>    
		<td>Auction title</td><td><input type="text" name="auc_title" required></td>
	</tr>
	<tr>
		<td>Set Item Details</td>
	</tr>
	<tr>
		<td>Item Type</td>
		<td>
<!-- 			<input list="Item_Types" name="itemType">
			  <datalist id="types">
			    <option value="Chair">
			    <option value="Jewelry">
			    <option value="Table">
			  </datalist> -->
			  <input type="radio" name="itemType" value="Chairs" checked>Chair<br>
			  <input type="radio" name="itemType" value="Tables">Table<br>
			  <input type="radio" name="itemType" value="Jewelry">Jewelry<br>
		</td>
	<tr>
		<td>Item Name</td><td><input type="text" name="itemName"></td>
	</tr>
	</tr>
	<tr>
		<td>Manufacturer</td><td><input type="text" name="itemManufacturer"></td>
	</tr>
	<tr>
		<td>Manufacturing Year</td><td><input type="text" name="itemDate"></td>
	</tr>
	<tr>
		<td>Color</td><td><input type="color" name="itemColor"></td>
	</tr>
	</tr>
	<tr>
		<td>End Date</td><td><input type="datetime-local" name="auc_end" required></td>
	</tr>
	<tr>
		<td>Set Starting Price</td><td><input type="number" name="auc_startingPrice" value = "0.00" step="any" required></td>
	</tr>
	<tr>
		<td>Set Target Minimum Price (Hidden)</td><td><input type="number" name="auc_reserve" value = "0.00"></td>
	</tr>
	<tr>
		<td>Auction Description:</td>
		<td> <textarea name="description" rows="10" cols="30">...</textarea>
	</tr>
	</table>
	<input type="submit" value="Create Auction">
</form>
<br>

</body>
</html>
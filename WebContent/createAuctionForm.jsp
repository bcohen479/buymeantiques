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
Login
<br>

Add auction details...
<form method="post" action="createAuction.jsp">
	<table>
	<tr>    
		<td>Auction title</td><td><input type="text" name="auc_title" required></td>
	</tr>
	<tr>
		<td>Set Item Details:
			<input list="Item_Types" name="itemType">
			  <datalist id="types">
			    <option value="Chair">
			    <option value="Jewelry">
			    <option value="Table">
			  </datalist>
		</td>
		<td>Item Name</td><td><input type="text" name="itemName"></td>
		<td>Manufacturer</td><td><input type="text" name="itemManufacturer"></td>
		<td>Manufacturing Year</td><td><input type="text" name="itemDate"></td>
		<td>Color</td><td><input type="color" name="itemColor"></td>
	</tr>
	<tr>
		<td>End Date</td><td><input type="datetime-local" name="auc_end" required></td>
	</tr>
	<tr>
		<td>Set Starting Price</td><td><input type="number" name="auc_startingPrice" value = "0.00" required></td>
	</tr>
	<tr>
		<td>Set Target Minimum Price (Hidden)</td><td><input type="number" name="auc_reserve" value = "0.00"></td>
	</tr>
	<tr>
		<td>Auction Description: <textarea name="description" rows="10" cols="30">
			...
			</textarea>
	</tr>
	</table>
	<input type="submit" value="Create Auction">
</form>
<br>
Don't have an account? <a href="index.jsp">Sign Up</a>

</body>
</html>
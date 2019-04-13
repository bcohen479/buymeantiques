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
Add Auction details...
<br>

<form method="post" action="createAuction.jsp">
	<table>
	<tr>    
		<td>Auction title</td><td><input type="text" maxlength="45" name="auc_title" required></td>
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
			  <input type="radio" onclick="javascript:typeCheck();" name="itemType" value="Chairs" id="chair">Chair<br>
			  <input type="radio" onclick="javascript:typeCheck();" name="itemType" value="Tables" id="table">Table<br>
			  <input type="radio" onclick="javascript:typeCheck();" name="itemType" value="Jewelry" id="jewl" >Jewelry<br>
		</td>
	<tr>
		<td>Item Name</td><td><input type="text" name="itemName"></td>
	</tr>
	<tr id="ifJewelry" style="display: none" >
		<td>Weight(g): </td>	<td><input type="text" name="jewlWeight"></td>
	</tr>
	<tr id="ifChair" style="display: none">
		<td>Height(ft): </td>	<td><input type="text" name="chairHeight"></td>
	</tr>
	<tr id="ifTable" style="display: none">
		<td>Dimensions(ft x ft x ft): </td>	<td><input type="text" name="tableDim"></td>
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
		<td> <textarea name="description" maxlength="500" rows="10" cols="30">...</textarea>
	</tr>
	</table>
	<input type="submit" value="Create Auction">
</form>
<br>

</body>
</html>
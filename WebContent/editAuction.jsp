<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<!--LEANNE WROTE THIS CODE  -->
<meta charset="ISO-8859-1">
<title>Edit Auction</title>
</head>
<body>

Search for Auction using:
<form method="post" action= "DisplayAuctionsAsTable.jsp">
		<select name="f" size=1>
			<option value="auction_ID"> Auction ID</option>
			<option value="seller">Seller</option>
			<option value="item_ID">Item ID</option>
			<option value="title"> Name </option>
		</select> as search criteria <br>
Enter chosen search criteria:
		<input type= "text", name="attribute", required>
			<input type="submit" value="submit">
				</form>

</body>
</html>
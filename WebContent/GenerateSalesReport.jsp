<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sales Reports</title>




</head>
<body>
Top Selling:
<br>
	<form method="post" action="BestSelling.jsp">
		<select name="attr" size=1>
			<option value="name">Item</option>
			<option value="Users.user_name">Seller</option>
		</select>&nbsp;<br>
		Top <input type="text", name="quant">
		</select>
		 <input type="submit" value="submit">
	</form>
<br>


<form method="post" action="BestBuyers.jsp">
<input type="submit", value="View Top Buyers">
</form>
<br>
Earnings Per:
<br>
	<form method="post" action="EarningsPer.jsp">
		<select name="attr" size=1>
			<option value="name">Item</option>
			<option value="Users.user_name">Seller</option>
			<option value="Items.Item_ID">Item type</option>
			<input type="submit" value="submit">
		</select>&nbsp;<br>
	</form>
<br>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sales Reports</title>




</head>
<body>
Best Selling:
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

Earnings Per:
<br>
	<form method="post" action="EarningsPer.jsp">
		<select name="attr" size=1>
			<option value="name">Item</option>
			<option value="Users.user_name">Seller</option>
			<option value="Items.Item_ID">Item type</option>
		</select>&nbsp;<br>
	</form>
<br>
</body>
</html>
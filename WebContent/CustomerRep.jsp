<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customer Representative Functions</title>
</head>
<body>

<table>

<tr><h3>Edit an account:</h3></tr>
<br>
<tr>
Search for the user by:
<form method="post" action= "findandEditAccount1.jsp">
		<select name="f" size=1>
			<option value="email">Email</option>
			<option value="user_name">User Name</option>
			<option value="user_ID"> User ID</option>
		</select>&nbsp;<br>
	</tr>	
<tr>
Enter Value	
	<input type= "text", name="attribute", required>
	<br><br>
</tr>				
<tr>				
Select field to change:
			<select name="updatethisfield" size=1>
			<option value="email">Email</option>
			<option value="user_name">User Name</option>
			<option value="password">Password</option>
		</select>&nbsp;<br></tr><tr>
				New Value<input type="text" name="updated">
				<br>
				<button type="submit" >Update</button>
	</tr>
				
				</form>
<br><br><br>				
<tr><h3>Search for Auction by:</h3>
<form method="post" action= "DisplayAuctionsAsTable.jsp">
		<select name="f" size=1>
			<option value="auction_ID"> Auction ID</option>
			<option value="seller">Seller ID</option>
			<option value="user_name">Seller Username</option>
			<option value="item_ID">Item ID</option>
			<option value="title"> Name </option>
		</select> as search criteria <br></tr><tr>
Enter chosen search criteria:
		<input type= "text", name="attribute", required>
			<input type="submit" value="submit">
	</tr>
		</form>
</table>		
</body>
</html>
</body>
</html>
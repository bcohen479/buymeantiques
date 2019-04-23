<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<!--LEANNE WROTE THIS CODE  -->
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>BuyMeAntiques| Reporting </title>
</head>
<body>
<a href="Reporting.jsp">Create another report</a><br>
<a href="homepage.jsp">Go home</a>
	<%
		List<String> list = new ArrayList<String>();

		try {

			//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
			
			//Create a SQL statement
	Statement stmt = con.createStatement();
			ResultSet result=null;
			//Get the combobox from the index.jsp
			if(request.getParameter("reportType").equals("BestSelling")){
				String attr = request.getParameter("attr");
				String n=attr.substring(attr.lastIndexOf(" ")+1);
				System.out.println(n);
				String joinby="seller";
				if(n.equals("buyer")){
					joinby=n;
				}
				String lim="";
				if(request.getParameter("quant").equals("No")){
				lim="";
				}
				else{
					lim="LIMIT "+request.getParameter("quant");
				}
				String criteria= request.getParameter("sort");
				System.out.println(criteria);
				String Alias=criteria.substring(criteria.indexOf("\'"));
				System.out.println(Alias);
				String Atrim=(Alias.substring(1,Alias.length()-1));
				list.add(n);
				list.add(Atrim);
				
				//need to make work for buyer
				String str = "SELECT "+attr+
						", "+criteria+" FROM ((Complete_Auction Join Items ON Complete_Auction.Item_ID=Items.Item_ID) Join Users ON Complete_Auction."+joinby+"=Users.user_ID) GROUP BY "
							+n+" ORDER BY "+Atrim+" DESC "+lim;
				//Run the query against the database.
				System.out.println(str);
				result = stmt.executeQuery(str);
				out.print("<table>");

				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td><h4>");
				//print out column header
				out.print(n);
				out.print("</h4></td>");
				//make a column
				out.print("<td><h4>"+Atrim+"</h4></td>");
				out.print("</tr>");

				//parse out the results
				while (result.next()) {
					//make a row
					out.print("<tr>");
					//make a column
					out.print("<td>");
					//Print out current bar name:
					out.print(result.getString(n));
					out.print("</td>");
					out.print("<td>");
					//Print out current beer name:
					out.print(result.getString(Atrim));
					out.print("</td>");
					//out.print("<td>"+result.getString("Revenue")+"</td>");
					out.print("</tr>");

				}
				out.print("</table>");
				
				
				//end paren for BestSelling
			}else if(request.getParameter("reportType").equals("EarningsPer")){
				System.out.println("HERE");
				String attr=request.getParameter("reporton");
				
				
				String n=attr.substring(attr.lastIndexOf(" ")+1);
				System.out.println(n);
			
				//Get the extra things to select
				String[]extra=request.getParameterValues("exField[]");
				if(extra==null){
					out.print("No fields were selected<br>");
				}else{
				String af="";
				List<String>aliases= new ArrayList<String>();
				if(!n.equals("Items.Item_ID")){
					aliases.add(n);
				}else{
					aliases.add("Item");
		
				}
				String a;
				for(int i=0; i<extra.length; i++){
					af=af+", "+extra[i];
					a=extra[i].substring(extra[i].lastIndexOf(" ")+1);
					aliases.add(a);
					}
					//System.out.println(af);
			
			String exG="";
			System.out.println(request.getParameter("GroupBy"));
		///	System.out.println(exG+"love");
			if(request.getParameter("GroupBy")!=null){
				exG=" ,Month, Year";
				af=", Month(Complete_Auction.date) AS Month, YEAR(Complete_Auction.date) AS Year"+af;
				aliases.add("Month");
				aliases.add("Year");
			}
			
			String st="";
		if(!request.getParameter("reporton").equals("Items.Item_ID")){
		st = "SELECT "+attr
				+af+" FROM ((Complete_Auction Join Items ON Complete_Auction.Item_ID=Items.Item_ID) Join Users ON Complete_Auction.seller=Users.user_ID) Group By "+n+exG;
		}
		else{
			st="(Select 'Chairs' As Item"+af+" FROM Complete_Auction JOIN Chairs ON Complete_Auction.item_ID=Chairs.item_ID) UNION "+
					"(Select 'Tables' As Item"+af+" FROM Complete_Auction JOIN Tables ON Complete_Auction.item_ID=Tables.item_ID) UNION "+
					"(Select 'Jewelry' As Item"+af+" FROM Complete_Auction JOIN Jewelry ON Complete_Auction.item_ID=Jewelry.item_ID)";
		}
		System.out.println(st);
		result = stmt.executeQuery(st);
		
		
		out.print("<table>");
		out.print("<tr>");
		ListIterator litr=aliases.listIterator();
		while(litr.hasNext()){
			out.print("<td><h4>");
			out.print(litr.next());
			out.print("</h4></td>");
		    }
		
		
		out.print("</tr>");
		while (result.next()) {
			
			out.print("<tr>");
			litr=aliases.listIterator();
			while(litr.hasNext()){
				out.print("<td>");
				String f= litr.next().toString();
				out.print(result.getObject(f));
				out.print("</td>");
			    }
			out.print("</tr>");

		}
		
		
			if(request.getParameter("TotalEarnings")!=null){
				String s="SELECT "+af.substring(1)+" FROM Complete_Auction";
				//System.out.println(s);
				result = stmt.executeQuery(s);
				out.print("<br><tr><td><strong>");
				out.print("Total for BuyMeAntiques");
				out.print("</strong></td>");
				while(result.next()){
					litr=aliases.listIterator();
					litr.next();
					while(litr.hasNext()){
						out.print("<td>");
						String f= litr.next().toString();
						out.print(result.getObject(f));
						out.print("</td>");
					    }
				}
				out.print("</tr>");
			}
				
			out.print("</table>");	
			}	
				
				//end paren for earningsPer

			
			con.close();
			//Make an HTML table to show the results in:
			}
		
		}catch (Exception e) {
			out.print("Error: "+ e);
			e.printStackTrace();
		}
	%>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<!--LEANNE WROTE THIS CODE  -->
<meta charset="ISO-8859-1">
<title>Insert Response into table</title>
</head>
<body>
<% 

ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();
String act=request.getParameter("action");


if(act.equals("Post Answer!")){
String ans = request.getParameter("ans");   
int crid= (Integer) session.getAttribute("userID");




	String qid=request.getParameter("qid");
	int q_id=Integer.parseInt(qid);
Statement stmt = con.createStatement();

	PreparedStatement ps= con.prepareStatement("UPDATE Questions Set Answer=?, CR=? where Q_ID= ?");
	ps.setString(1, ans);
	ps.setInt(2, crid);
	ps.setInt(3,q_id);
	ps.executeUpdate();

	out.print("<a href='aucprofile.jsp?value="+request.getParameter("aid")+
			"'>Go Back</a>");
}
else{
	if(request.getParameterValues("delete[]")!=null){
		String[]q=request.getParameterValues("delete[]");
	String clause="(";
	for(int i=0; i<q.length; i++){
		clause+=q[i]+",";
	}
		clause=clause.substring(0,clause.length()-1)+")";
	//out.print(clause);

	PreparedStatement p=con.prepareStatement("Delete From Questions WHERE Q_ID IN"+clause);
	//out.print("<a href=\"homepage.jsp\">Question Deleted</a>");
	p.executeUpdate();
	out.print("<a href='aucprofile.jsp?value="+request.getParameter("aid")+
		"'>Go Back</a>");
	}
	else{
		out.print("You gave me nothing to delete!");
	}
}
%>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import ="java.sql.*" %>
<%
/* WE ALL CONTRIBUTED TO THE CODE ON THIS FILE */
    String email = request.getParameter("emailaddress");   
    String fname = request.getParameter("fname");
    String lname=request.getParameter("lname");
    String uname=request.getParameter("username");
    String pwd=request.getParameter("password");
    Class.forName("com.mysql.jdbc.Driver");
    //change to our database
       Connection con=DriverManager.getConnection( "jdbc:mysql://antiqueinfo.chzn1rry3y6s.us-east-2.rds.amazonaws.com:3306/AntiqueInfo","Group15","336Group15"); 
    //Connection con=DriverManager.getConnection(  
    	//	"jdbc:mysql://antiqueinfo.chzn1rry3y6s.us-east-2.rds.amazonaws.com:3306/AntiqueInfo","Group15","336Group15"); 
    Statement stmt = con.createStatement();
    ResultSet rs;
    //not sure if we will need to keep a "UserID field
    String creation = "INSERT INTO User"
    		+ "(user_name, password,email)  VALUES"
    		+ "(?,?,?)";
    PreparedStatement preparedStatement = con.prepareStatement(creation);
    preparedStatement.setString(1, uname);
    preparedStatement.setString(2, pwd);
    preparedStatement.setString(3, email);
   // preparedStatement.setString(4, fname);
   // preparedStatement.setString(5,lname);
    //should get rid of this
    //preparedStatement.setInt(6,7727);
    
    
    try{
    preparedStatement .executeUpdate();
    session.setAttribute("user", uname);
    response.sendRedirect(response.encodeURL("success.jsp"));}
    catch(SQLException ex){
    	if(ex.getSQLState().startsWith("23")){
    		Statement s1= con.createStatement();
    	    ResultSet r1;
    	    r1 = s1.executeQuery("select * from User where email='" + email+"'");
    	    Statement s2=con.createStatement();
    	    ResultSet r2;
    	    r2= s2.executeQuery("select * from User where user_name='" + uname+"'");
    	    if (r1.next()) {
    		out.println("Duplicate email. Sign in to account <a href='login.jsp'>try again</a>");
    	}else{
    		if(r2.next()){
    			out.println("Username is taken.  <a href='createaccount.jsp'>Please choose another </a>");}
    		}
    	}
    	else{
    		ex.printStackTrace();
    		out.println("Oh snap");
    	}
    	
    }


%>
<%@page import="project.ConnectionProvider" %>
<%@page import="java.sql.*" %>


<%

String customer_email=request.getParameter("email");
String Security_Question=request.getParameter("Security_Question");
String customer_answer=request.getParameter("customer_answer");
String new_password=request.getParameter("password");
String customer_password2=request.getParameter("customer_password2");
String passwordHash = "";
int check=0;

try{

Connection con=ConnectionProvider.getCon();

	if (new_password.equals(customer_password2)){

		

		// Hash 
		String queryHash = "SELECT SHA2(?, 256) AS password_hash";
		PreparedStatement ps1 = con.prepareStatement(queryHash);
		ps1.setString(1, new_password);
		ResultSet rs1 = ps1.executeQuery();

		if (rs1.next()) {
		    passwordHash = rs1.getString("password_hash");
		}

		
		

PreparedStatement pst = con.prepareStatement("SELECT * FROM customer WHERE email=? AND Security_Question=? AND customer_answer=?");
pst.setString(1, customer_email);
pst.setString(2, Security_Question);
pst.setString(3, customer_answer);
ResultSet rs = pst.executeQuery();



while(rs.next()){
	check = 1;


PreparedStatement ps2 = con.prepareStatement("UPDATE customer SET password=? WHERE email=?");
ps2.setString(1, passwordHash);
ps2.setString(2, customer_email);
ps2.executeUpdate();

	
if (pst != null) {
    try {
        pst.close();
    } catch (SQLException e) {
    	System.out.print(e);
    }
}	

if (ps2 != null) {
    try {
        ps2.close();
    } catch (SQLException e) {
    	System.out.print(e);
    }
}

if (ps1 != null) {
    try {
        ps1.close();
    } catch (SQLException e) {
    	System.out.print(e);
    }
}

if (rs1 != null) {
    try {
        rs1.close();
    } catch (SQLException e) {
    	System.out.print(e);
    }
}
if (con != null) {
	try {
	      con.close();
	  } catch (SQLException e) {
	  	System.out.print(e);
	  }
}
	
	
	response.sendRedirect("forgotpassword.jsp?msg=done");
}
	}
else {
	
	response.sendRedirect("forgotpassword.jsp?msg=invalidPassword");
	
}
	
	
if (check==0){
	
	response.sendRedirect("forgotpassword.jsp?msg=invalid");
}

 
}
catch(Exception e)  {
	System.out.print(e);
	
}

%>
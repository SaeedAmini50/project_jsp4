<%@ page import="java.sql.*" 
import="project.ConnectionProvider"%>

 <%


 String email=session.getAttribute("email").toString();
 int total_price_order= 0 ;
 int total= 0 ;
 int order_ID= 0 ;
 int quantity_item= 0 ;
 int price_item= 0 ;
 int item_ID= 0 ;
 int product_ID= 0 ;
 int shipment_ID=0;
 int payment_ID=0;
 String status="bill";
try {
	
	
Connection con = ConnectionProvider.getCon();

int customer_ID=0;




PreparedStatement ps=con.prepareStatement("SELECT * FROM customer WHERE email = ?");
ps.setString(1, email);
ResultSet rs = ps.executeQuery();

while(rs.next()){
	
	customer_ID=rs.getInt(1);

}
if (rs != null) {
    try {
        rs.close();
    } catch (SQLException e) {
    	System.out.print(e);
    }
}

PreparedStatement ps1 = con.prepareStatement("SELECT SUM(total_price_cart) FROM product INNER JOIN cart INNER JOIN customer ON product.product_ID=cart.product_ID AND customer.customer_ID=cart.customer_ID WHERE customer.customer_ID=?");
ps1.setInt(1, customer_ID);
ResultSet rs1 = ps1.executeQuery();

		
while (rs1.next()){
	total=rs1.getInt(1);
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


PreparedStatement ps2 = con.prepareStatement("SELECT MAX(payment_ID) FROM payment");
ResultSet rs2 = ps2.executeQuery();

	while(rs2.next()){
		
		payment_ID=rs2.getInt(1); 
	}		
	
	
	  if (rs2 != null) {
          try {
             rs2.close();
          } catch (SQLException e) {
          	System.out.print(e);
          }
      }

	  PreparedStatement ps3 = con.prepareStatement("select max(shipment_ID) from shipment;");
	  ResultSet rs3 = ps3.executeQuery();
	  
while(rs3.next()){

shipment_ID=rs3.getInt(1); 
}

if (rs3 != null) {
    try {
        rs3.close();
    } catch (SQLException e) {
    	System.out.print(e);
    }
}


	
	PreparedStatement ps4 = con.prepareStatement("INSERT INTO orders (total_price_order, customer_ID, payment_ID, shipment_ID, order_date) VALUES (?, ?, ?, ?, NOW())");
	ps4.setDouble(1, total);
	ps4.setInt(2, customer_ID);
	ps4.setInt(3, payment_ID);
	ps4.setInt(4, shipment_ID);
	ps4.executeUpdate();	
	
	

	  PreparedStatement ps41 = con.prepareStatement("select max(order_ID) from orders;");
	  ResultSet rs4 = ps41.executeQuery();
	  

	while(rs4.next()){
		 order_ID=rs4.getInt(1);
		   
	   }
	  if (ps41 != null) {
          try {
              ps41.close();
          } catch (SQLException e) {
          	System.out.print(e);
          }
      } 
	  if (rs4 != null) {
          try {
              rs4.close();
          } catch (SQLException e) {
          	System.out.print(e);
          }
      }
	
	
	
	  PreparedStatement ps5 = con.prepareStatement("SELECT * FROM product INNER JOIN cart INNER JOIN customer ON product.product_ID=cart.product_ID AND customer.customer_ID=cart.customer_ID WHERE customer.customer_ID=?");
	  ps5.setInt(1, customer_ID);
	  ResultSet rs5 = ps5.executeQuery();
	  
	  PreparedStatement ps6 =null;
	  while(rs5.next()){
		   
		   quantity_item=rs5.getInt(12);
		   price_item=rs5.getInt(2);
		   product_ID=rs5.getInt(8);

		   
		   ps6 = con.prepareStatement("INSERT INTO order_item (quantity_item, price_item, product_ID, order_ID) VALUES (?, ?, ?, ?)");
		   ps6.setInt(1, quantity_item);
		   ps6.setDouble(2, price_item);
		   ps6.setInt(3, product_ID);
		   ps6.setInt(4, order_ID);
		   ps6.executeUpdate();
		
	   }	

	  if (ps6 != null) {
          try {
              ps6.close();
          } catch (SQLException e) {
          	System.out.print(e);
          }
      }
	  if (rs5 != null) {
          try {
              rs5.close();
          } catch (SQLException e) {
          	System.out.print(e);
          }
      }
	  

	  PreparedStatement ps7 = con.prepareStatement("select max(item_ID) from order_item;");
	  ps5.setInt(1, customer_ID);
	  ResultSet rs6 = ps7.executeQuery();
	  
	 
		while(rs6.next()){
			 item_ID=rs6.getInt(1);
			   
		   }
		
		
		  if (rs6 != null) {
	            try {
	                rs6.close();
	            } catch (SQLException e) {
	            	System.out.print(e);
	            }
	        }
		  
		  
		  
		  
		  if (ps != null) {
	            try {
	                ps.close();
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
		
	
	response.sendRedirect("bill.jsp?order_ID="+order_ID+"&item_ID="+item_ID);
}

catch(Exception e){
	
	System.out.print(e);
}
 
 
 
 
 
 
 %>
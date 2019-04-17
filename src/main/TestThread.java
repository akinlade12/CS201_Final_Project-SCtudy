package main;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class TestThread extends Thread{
	
	private int LocationID;
	
	public TestThread(int LocationID) {
		this.LocationID = LocationID;
	}
	
	public void run() {
		Connection conn = null;
	    Statement st = null;
	    ResultSet rs = null;
	    PreparedStatement ps = null;
	    int currentTableSize = 0;
	    
	    try {
	    	
	    	Class.forName("com.mysql.cj.jdbc.Driver");
	    	conn = DriverManager.getConnection("jdbc:mysql://localhost/Sctudy?user=root&password=Toyosi12");
	    	
	    	ps=conn.prepareStatement("SELECT * from reviews");       
	    	rs = ps.executeQuery();
	    	while(rs.next()) {
	    		currentTableSize += 1;
	    	}
	    	System.out.println("current table size = " + currentTableSize);
	    } catch (SQLException sqle) {
	    	System.out.println (sqle.getMessage());
	    } catch (ClassNotFoundException cnfe) {
	    	System.out.println (cnfe.getMessage());
	    } 
	
		
		try {
			while(true) {
				int tableSize = 0;
				sleep(500);
				ps=conn.prepareStatement("SELECT * from reviews");       
				rs = ps.executeQuery();
		    	while(rs.next()) {
		    		tableSize += 1;
		    	}
		    	System.out.println("table size = " + tableSize);
				if(tableSize > currentTableSize) {
					//check if new review if for your specific study spot
					ps=conn.prepareStatement("SELECT * from reviews WHERE reviewID=?");  
					ps.setInt(1, tableSize);
					rs = ps.executeQuery();
					rs.next();
					int reviewLocation = rs.getInt("locationID");
					if(reviewLocation == this.LocationID) {
						
						System.out.println(rs.getString("review"));
					}
				}
			}
		} catch (InterruptedException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}catch (SQLException sqle) {
			System.out.println (sqle.getMessage());
		}finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (st != null) {
					st.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException sqle) {
				System.out.println(sqle.getMessage());
			}
		}
	}
	public static void main (String [] args) {
		Thread t = new TestThread(1);
		t.start();
	}
		
}

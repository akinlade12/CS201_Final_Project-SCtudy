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
	private volatile Boolean done;
	public volatile Boolean check;
	private String username;
	private String review;
	private int rating;
	public TestThread(int LocationID) {
		this.LocationID = LocationID;
		done = false;
		check = false;
	}
	public Boolean getDone() {
		return done;
	}
	public void setDone(Boolean d) {
		done = d;
	}
	public Boolean getCheck() {
		return check;
	}
	public void setCheck(Boolean c) {
		check = c;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getReview() {
		return review;
	}
	public void setReview(String review) {
		this.review = review;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	public void run() {
		Connection conn = null;
	    Statement st = null;
	    ResultSet rs = null;
	    PreparedStatement ps = null;
	    int currentTableSize = 0;
	    
	    try {
	    	
	    	Class.forName("com.mysql.cj.jdbc.Driver");
	    	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Sctudy?user=root&password=root");
	    	
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
			while(!done) {
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
						review = rs.getString("review");
						rating = rs.getInt("rating");
						int userID = rs.getInt("userID");
						
						
						ps = conn.prepareStatement("SELECT username from users where userID=?"); //get users
						ps.setInt(1, userID);
						rs = ps.executeQuery();
						if(rs.next()) {
							username = (rs.getString("username"));
						}
						check = true;
					}
					currentTableSize = tableSize;
				}
			}
			System.out.println("done");
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
//	@SuppressWarnings("deprecation")
//	public static void main (String [] args) {
//		Thread t = new TestThread(1);
//		t.start();
//		while(true) {
//			double i = Math.random();
//			System.out.println(i);
//			if(i > 0.99)
//				break;
//		}
//		t.stop();
//	}
		
}

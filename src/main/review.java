package main;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class review
 */
@WebServlet("/review")
public class review extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public review() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub]
		HttpSession session = request.getSession();
		String nextPage = "/details.jsp";
		Double rating = Double.parseDouble(request.getParameter("rating"));
		Connection conn = null;
	    Statement st = null;
	    ResultSet rs = null;
	    ResultSet rs2 = null;
	    PreparedStatement ps = null;
	    int spaceID = Integer.parseInt(request.getParameter("spaceID"));
	    Double currRating = Double.parseDouble(request.getParameter("ratingT"));
	    int userRating = Integer.parseInt((request.getParameter("rating")));
	    String review = request.getParameter("reviewT");
	    Double numbRatings = 0.0;
	    int userID = -1;
	    
	    String username = "Username";
		if (session.getAttribute("loggedIn") != null) {
			username = (String) session.getAttribute("username");
		}
	    System.out.println(username);
	    try {
	    	
	    	Class.forName("com.mysql.cj.jdbc.Driver");
	        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Sctudy?user=root&password=root");
	    	st = conn.createStatement();
	    	rs = st.executeQuery("SELECT * from studySpaces");
	    	while(rs.next()) {
	    		
	    		if((int)rs.getObject(1) == spaceID) {
	    			numbRatings =  rs.getDouble("numRatings");
	    			currRating = rs.getDouble("rating");
	    			currRating = (((numbRatings) * currRating) + userRating) / (numbRatings + 1.0);			
	    		}
	    		
	    	}
	    	
	    	ps=conn.prepareStatement("UPDATE studySpaces set rating=?, numRatings=?");
	    	ps.setDouble(1,currRating); 
	    	ps.setDouble(2, numbRatings + 1.0);       
	    	ps.executeUpdate();
	    	
	    } catch (SQLException sqle) {

	    	System.out.println (sqle.getMessage());
	    } catch (ClassNotFoundException cnfe) {
	    	System.out.println (cnfe.getMessage());
	    } finally {
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
	    
	    try {
	    	Class.forName("com.mysql.cj.jdbc.Driver");
	        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Sctudy?user=root&password=root");
	    	
	    	st = conn.createStatement();
	    	rs2 = st.executeQuery("SELECT * from users");
	    	while(rs2.next()) {
	    		if (rs2.getString("username").contentEquals(username)) {
	    			userID = rs2.getInt("userID");
	    			break;
	    		}
	    	}
	    	
	    	ps = conn.prepareStatement("INSERT INTO reviews(userID,locationID,review,rating) VALUES(?,?,?,?)");
	    	System.out.println(userID);
	    	ps.setInt(1, userID); 
	    	ps.setInt(2,spaceID);
	    	ps.setString(3, review);
	    	ps.setInt(4, userRating);
	    	ps.executeUpdate();
	    	
	    } catch (SQLException sqle) {
	    	System.out.println (sqle.getMessage());
	    } catch (ClassNotFoundException cnfe) {
	    	System.out.println (cnfe.getMessage());
	    } finally {
	    	try {
	    		if (rs2 != null) {
	    			rs2.close();
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

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

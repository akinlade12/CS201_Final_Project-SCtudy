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
	    Double userRating = Double.parseDouble(request.getParameter("rating"));
	    String review = request.getParameter("reviewT");
	    Double numbRatings = 0.0;
	    String userID = "";
	    String photoURL = "";
	    
	    String username = "Username";
		if (session.getAttribute("loggedIn") != null) {
			username = (String) session.getAttribute("username");
		}
	    
	    try {
	    	
	    	Class.forName("com.mysql.cj.jdbc.Driver");
	        conn = DriverManager.getConnection("jdbc:mysql://localhost/Sctudy?user=root&password=Toyosi12");
	    	st = conn.createStatement();
	    	rs = st.executeQuery("SELECT * from studySpaces");
	    	while(rs.next()) {
	    		
	    		if((int)rs.getObject(1) == spaceID) {
	    			numbRatings = (Double) rs.getObject(15);
	    			currRating = (Double) rs.getObject("overallRating");
	    			currRating = (((numbRatings) * currRating) + userRating) / (numbRatings + 1.0);
	    			photoURL = (String) rs.getObject(3);
	    			

	    			
	    		}
	    		
	    	}
	    	
	    	ps=conn.prepareStatement("UPDATE studySpaces set overallRating = ?, numberRatings = ? ");
	    	ps.setString(1,Double.toString(currRating)); 
	    	ps.setString(2, Double.toString(numbRatings + 1.0));       
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
	        conn = DriverManager.getConnection("jdbc:mysql://localhost/Sctudy?user=root&password=Toyosi12");
	    	
	    	st = conn.createStatement();
	    	rs2 = st.executeQuery("SELECT * from users");
	    	while(rs2.next()) {
	    		if ((String)rs2.getObject("username") == username) {
	    			userID = (String) rs2.getObject("userID");
	    		}
	    		
	    		ps = conn.prepareStatement("INSERT INTO reviews(userID,locationID,review,reviewPhotoURL,overallRating) VALUES(?,?,?,?,?)");
		    	ps.setString(1, userID); 
		    	ps.setString(2,Integer.toString(spaceID));
		    	ps.setString(3, review);
		    	ps.setString(4,photoURL);
		    	ps.setString(5, Double.toString(currRating));
		    	ps.executeUpdate();
	    	}
	    	
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
		
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher(nextPage);
	    dispatch.forward(request, response);	
	    
	    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

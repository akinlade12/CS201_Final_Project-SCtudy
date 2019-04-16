package main;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



/**
 * Servlet implementation class hack
 */
@WebServlet("/hack")
public class hack extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public hack() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session=request.getSession();
		
		Vector<StudySpace> spaces = (Vector<StudySpace>) session.getAttribute("studySpaces"); //coming from results
		if(spaces != null) {
			String i = request.getParameter("index");
			if(i != null) {
				int index = Integer.parseInt(i);
				session.setAttribute("currentStudySpot", spaces.get(index));
			    if(session.getAttribute("user") != null) { //only checking if logged in
			    	int userID = (int) session.getAttribute("user");
			    	Connection conn = null; //checking to see if spot has been favorited
					PreparedStatement ps = null;
					ResultSet rs = null;
					try {
						Class.forName("com.mysql.cj.jdbc.Driver"); //throws classNotFound exception 
						conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sctudy?user=root&password=root&serverTimezone=UTC");		
						ps = conn.prepareStatement("SELECT locationID from favorites WHERE locationID=? AND userID = ?");
						int loc = ((StudySpace) session.getAttribute("currentStudySpot")).getLocationID();
						ps.setInt(1, loc);
						ps.setInt(2, userID);
						rs = ps.executeQuery();
						if(rs.next()) {
							request.setAttribute("favorited", true);
						}
						else
							request.setAttribute("favorited", false);
						
					} catch (SQLException sqle) {
						sqle.printStackTrace();
					} catch (ClassNotFoundException cnfe) {
						cnfe.printStackTrace();
					} 
					finally {
						try {
							if(ps != null) { ps.close(); }
							if(conn != null) { conn.close(); }
						}catch (SQLException sqle) {
							sqle.printStackTrace();
						}
					}
			    }
			    
				RequestDispatcher dispatch = getServletContext().getRequestDispatcher("/details.jsp");
			    dispatch.forward(request, response);
			    return;
			}
		}
		
		Vector<StudySpace> favorites = (Vector<StudySpace>) session.getAttribute("favorites"); //coming from profile
		if(favorites != null) {
			String i = request.getParameter("indexfav");
			if(i != null) {
				int index = Integer.parseInt(i);
				session.setAttribute("currentStudySpot", favorites.get(index));
			    if(session.getAttribute("user") != null) { //only checking if logged in
			    	int userID = (int) session.getAttribute("user");
			    	Connection conn = null; //checking to see if spot has been favorited
					PreparedStatement ps = null;
					ResultSet rs = null;
					try {
						Class.forName("com.mysql.cj.jdbc.Driver"); //throws classNotFound exception 
						conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sctudy?user=root&password=root&serverTimezone=UTC");		
						ps = conn.prepareStatement("SELECT locationID from favorites WHERE locationID=? AND userID = ?");
						int loc = ((StudySpace) session.getAttribute("currentStudySpot")).getLocationID();
						ps.setInt(1, loc);
						ps.setInt(2, userID);
						rs = ps.executeQuery();
						if(rs.next()) {
							request.setAttribute("favorited", true);
						}
						else
							request.setAttribute("favorited", false);
						
					} catch (SQLException sqle) {
						sqle.printStackTrace();
					} catch (ClassNotFoundException cnfe) {
						cnfe.printStackTrace();
					} 
					finally {
						try {
							if(ps != null) { ps.close(); }
							if(conn != null) { conn.close(); }
						}catch (SQLException sqle) {
							sqle.printStackTrace();
						}
					}
			    }
			    
				RequestDispatcher dispatch = getServletContext().getRequestDispatcher("/details.jsp");
			    dispatch.forward(request, response);
			    return;
			}
		}
		
		String action = request.getParameter("action");
		if (action.equalsIgnoreCase("checkStatus")) {
			boolean loggedIn = (Boolean) session.getAttribute("loggedIn");
			response.getWriter().write(Boolean.toString(loggedIn));
		} else if (action.equalsIgnoreCase("signOut")) {
			
	        session.setAttribute("user", null); 
	        session.setAttribute("username", null);
	        session.setAttribute("loggedIn", false);
	        
			response.getWriter().write(Boolean.toString(false));
			
		} else if (action.equalsIgnoreCase("favorite")) {
			System.out.println("Here");
			Connection conn = null;
			PreparedStatement ps = null;
			try {
				Class.forName("com.mysql.cj.jdbc.Driver"); //throws classNotFound exception 
				conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sctudy?user=root&password=root&serverTimezone=UTC");		
				ps = conn.prepareStatement("INSERT INTO sctudy.favorites (userID, locationID) VALUES  (?, ?)");
				int user = (int) session.getAttribute("user");
				String userID = Integer.toString(user);
				int loc = ((StudySpace) session.getAttribute("currentStudySpot")).getLocationID();
				String locationID = Integer.toString(loc);
				ps.setString(1, userID);
				ps.setString(2, locationID);
				ps.execute();
				response.getWriter().write("Unfavorite");
			} catch (SQLException sqle) {
				sqle.printStackTrace();
			} catch (ClassNotFoundException cnfe) {
				cnfe.printStackTrace();
			} 
			finally {
				try {
					if(ps != null) { ps.close(); }
					if(conn != null) { conn.close(); }
				}catch (SQLException sqle) {
					sqle.printStackTrace();
				}
			}
			
		} else if (action.equalsIgnoreCase("Unfavorite")) {
			System.out.println("no here");
			Connection conn = null;
			PreparedStatement ps = null;
			try {
				Class.forName("com.mysql.cj.jdbc.Driver"); //throws classNotFound exception 
				conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sctudy?user=root&password=root&serverTimezone=UTC");		
				ps = conn.prepareStatement("DELETE FROM sctudy.favorites WHERE userID=? AND locationID=?");
				int user = (int) session.getAttribute("user");
				int loc = ((StudySpace) session.getAttribute("currentStudySpot")).getLocationID();
				ps.setInt(1, user);
				ps.setInt(2, loc);
				ps.execute();
				response.getWriter().write("Favorite");
			} catch (SQLException sqle) {
				sqle.printStackTrace();
			} catch (ClassNotFoundException cnfe) {
				cnfe.printStackTrace();
			} 
			finally {
				try {
					if(ps != null) { ps.close(); }
					if(conn != null) { conn.close(); }
				}catch (SQLException sqle) {
					sqle.printStackTrace();
				}
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

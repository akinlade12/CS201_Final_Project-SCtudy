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
 * Servlet implementation class profile
 */
@WebServlet("/profile")
public class profile extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private static final String SQL_USERNAME = "root";
	private static final String SQL_PASSWORD = "bigOfor201";
	private static String errorMessage;
	
	Connection conn;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public profile() {
        super();
		try {
    		System.out.println("> Establishing database connection...");
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sctudy?user=" + SQL_USERNAME + "&password=" + SQL_PASSWORD + "&useSSL=false");
		} catch (ClassNotFoundException | SQLException e) {
			System.out.println("> FATAL ERROR: Failed to establish database connection.");
			e.printStackTrace();
		}
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	
	public int calculateRating (int locationID) {
		PreparedStatement ps = null;
		int ratingTotal = 0; 
		int numberOfRatings = 0; 
		
		try {
			ps = conn.prepareStatement("SELECT * FROM sctudy.reviews WHERE userID=?");			
			ps.setInt(1, locationID);
			
			ResultSet rs = ps.executeQuery();
			
			while (rs.next()) {
				numberOfRatings++;
				ratingTotal += rs.getInt("rating");
			}
			
			
		} catch (SQLException sqle) {
			sqle.printStackTrace();
		} 
		
		if (ratingTotal == 0) {
			return 0; 
		}
		else {
			int rating = ratingTotal/numberOfRatings;
			return rating;
		}
	}
	
	public StudySpace constructStudySpace (int locationID) {
		StudySpace favorite = new StudySpace(); 
		
		PreparedStatement ps = null;
		int ratingTotal = 0; 
		int numberOfRatings = 0; 
		
		try {
			ps = conn.prepareStatement("SELECT * FROM sctudy.studySpaces WHERE locationID=?");			
			ps.setInt(1, locationID);
			
			ResultSet rs = ps.executeQuery();
			
			while (rs.next()) {				
				favorite.setName(rs.getString("sName"));
				System.out.println("name: " + favorite.getName());
				
				favorite.setLocationID(rs.getInt("locationID"));
				System.out.println("locationID: " + favorite.getLocationID());
				
				favorite.setLongitude(rs.getDouble("longitude"));
				System.out.println("longitude: " + favorite.getLongitude());
				
				favorite.setLatitude(rs.getDouble("latitude"));
				System.out.println("latitude: " + favorite.getLatitude());
				
				favorite.setPhotoURL(rs.getString("photoURL"));
				System.out.println("photoURL: " + favorite.getPhotoURL());
				
				favorite.setOutlet(rs.getString("outletAvailability"));
				System.out.println("outletAvailability: " + favorite.getOutlet());
				
				favorite.setSeats(rs.getString("seatingTypes"));
				System.out.println("seatingTypes: " + favorite.getSeats());
				
				favorite.setLights(rs.getString("lightSource"));
				System.out.println("lightSource: " + favorite.getLights());
				
				favorite.setNoise(rs.getInt("noiseLevel"));
				System.out.println("noiseLevel: " + favorite.getNoise());
				
				favorite.setOutside(rs.getBoolean("indoorOutdoor"));
				System.out.println("indoorOutdoor: " + favorite.getOutside());
				
				favorite.setCafe(rs.getBoolean("cafeAvailability"));
				System.out.println("cafe: " + favorite.getCafe());

				favorite.setHourOpen(rs.getString("hourOpen"));
				System.out.println("hourOpen: " + favorite.getHourOpen());

				favorite.setHourClose(rs.getString("hourClose"));
				System.out.println("hourClose: " + favorite.getHourClose());

				favorite.setPhone(rs.getString("phoneNumber"));
				System.out.println("phone: " + favorite.getPhone());

				favorite.setAddress(rs.getString("address"));
				System.out.println("address: " + favorite.getAddress());

				favorite.setBuilding(rs.getString("buildingCode"));
				System.out.println("buildingCode: " + favorite.getBuilding());
				
				int rating = calculateRating(favorite.getLocationID());
				favorite.setRating(rating);
				System.out.println("rating: " + favorite.getRating());
			}
			
			
		} catch (SQLException sqle) {
			sqle.printStackTrace();
		} 
		
		return favorite;
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		// commenting out for testing : 
		// int userID = Integer.parseInt((String)  session.getAttribute("user"));
		int userID = 1;
		
		Vector<StudySpace> favorites = new Vector<StudySpace>();
		
		PreparedStatement ps = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); //throws classNotFound exception 
			ps = conn.prepareStatement("SELECT * FROM sctudy.favorites WHERE userID=?");			
			ps.setInt(1, userID);
			
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				int locationID = rs.getInt("locationID");
				
				StudySpace newFavorite = constructStudySpace(locationID);
				
				favorites.add(newFavorite);
			}
			
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
		
		System.out.println("reached the end! :) you got it sweetie");

		session.setAttribute("favorites", favorites);
		
		RequestDispatcher rd = request.getRequestDispatcher("profile.jsp");
		rd.forward(request, response);
		return;
	}

}

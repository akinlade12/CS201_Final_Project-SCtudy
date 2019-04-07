package main;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class submit
 */
@WebServlet("/submit")
public class submit extends HttpServlet {       
	private static final long serialVersionUID = 1L;
	
	private static final String SQL_USERNAME = "root";
	private static final String SQL_PASSWORD = "bigOfor201";
	private static String errorMessage;
	
	Connection conn;
       
    /**
     * @return 
     * @see HttpServlet#HttpServlet()
     */
    public void Submit() {
		try {
    		System.out.println("> Establishing database connection...");
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/weathermeister?user=" + SQL_USERNAME + "&password=" + SQL_PASSWORD + "&useSSL=false");
		} catch (ClassNotFoundException | SQLException e) {
			System.out.println("> FATAL ERROR: Failed to establish database connection.");
		}
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TO-DO: ERROR HANDLING ! 
		
		String submitField = request.getParameter("submitField");
		String latitude = request.getParameter("latitude");
		String longitude = request.getParameter("longitude");
		String outletAvailability = request.getParameter("outletAvailability");
		String seatingTypes = request.getParameter("seatingTypes");
		String lightingTypes = request.getParameter("lightingTypes");
		String noiseLevel = request.getParameter("noiseLevel");
		String indoorOutdoor = request.getParameter("indoorOutdoor");
		String cafeAvailability = request.getParameter("cafeAvailability");
		String hourOpen = request.getParameter("hourOpen");
		String hourClose = request.getParameter("hourClose");
		
		boolean cafeBool = true; 
		if (cafeAvailability.contains("No")) {
			cafeBool = false; 
		}
		
		boolean indoorOutdoorBool = true; 
		if (indoorOutdoor.contains("Indoor")) {
			indoorOutdoorBool = false; 
		}

//		MADE THIS MAP JUST IN CASE WE NEEDED TO PASS DATA AROUND :) 
//		Map<String, String> dataMap = new HashMap<String, String>();
//		dataMap.put("submitField", submitField);
//		dataMap.put("outletAvailability", outletAvailability);
//		dataMap.put("seatingTypes", seatingTypes);
//		dataMap.put("lightingTypes", lightingTypes);
//		dataMap.put("noiseLevel", noiseLevel);
//		dataMap.put("indoorOutdoor", indoorOutdoor);
//		dataMap.put("cafeAvailability", cafeAvailability);
//		dataMap.put("hourOpen", hourOpen);
//		dataMap.put("hourClose", hourClose);

		PreparedStatement st = null;
		ResultSet rs = null;
		
		try {
			st = conn.prepareStatement("insert into studySpaces (sName, latitude, longitude,"
					+ "seatingTypes, lightSource, noiseLevel, cafeAvailability, hourOpen,"
					+ "hourClose, indoorOutdoor, outletAvailability) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
			st.setString(1, submitField);
			st.setDouble(2, Double.parseDouble(latitude));
			st.setDouble(3, Double.parseDouble(longitude));
			st.setString(4, seatingTypes);
			st.setString(5, lightingTypes);
			st.setInt(6, Integer.parseInt(noiseLevel));
			st.setBoolean(7, cafeBool);
			st.setString(8, hourOpen);
			st.setString(9, hourClose);
			st.setBoolean(10, indoorOutdoorBool);
			st.setString(11, outletAvailability);
		}
		catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		finally {
			try {
				if (st != null)
					st.close();
				if (rs != null)
					rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		RequestDispatcher rd = request.getRequestDispatcher("index1.jsp");
		rd.forward(request, response);
		return;
	}
}

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
	private static final String SQL_PASSWORD = "root";
	private static String errorMessage;
	
	Connection conn;
       
    /**
     * @return 
     * @see HttpServlet#HttpServlet()
     */
    public submit() {
		try {
    		System.out.println("> Establishing database connection...");
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sctudy?user=" + SQL_USERNAME + "&password=" + SQL_PASSWORD + "&useSSL=false");
		} catch (ClassNotFoundException | SQLException e) {
			System.out.println("> FATAL ERROR: Failed to establish database connection.");
		}
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    
    public void addToServer (Map<String, String> map) {
		boolean cafeBool = true; 
		if (map.get("cafeAvailability").contains("No")) {
			cafeBool = false; 
		}
		
		boolean indoorOutdoorBool = true; 
		if (map.get("indoorOutdoor").contains("Indoor")) {
			indoorOutdoorBool = false; 
		}
		
		PreparedStatement st = null;
		ResultSet rs = null;
		
		String query = "insert into studySpaces (sName, photoURL, latitude, longitude,"
				+ "seatingTypes, lightSource, noiseLevel, cafeAvailability, hourOpen,"
				+ "hourClose, indoorOutdoor, outletAvailability, phoneNumber, address, buildingCode) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		
		try {
			st = conn.prepareStatement(query);
			st.setString(1, map.get("submitField"));
			System.out.println("got submit field: " + map.get("submitField"));
			st.setString(2, map.get("photoURL"));
			st.setDouble(3, Double.parseDouble(map.get("latitude")));
			st.setDouble(4, Double.parseDouble(map.get("longitude")));
			st.setString(5, map.get("seatingTypes"));
			st.setString(6, map.get("lightingTypes"));
			st.setInt(7, Integer.parseInt(map.get("noiseLevel")));
			st.setBoolean(8, cafeBool);
			st.setString(9, map.get("hourOpen"));
			st.setString(10, map.get("hourClose"));
			st.setBoolean(11, indoorOutdoorBool);
			st.setString(12, map.get("outletAvailability"));
			st.setString(13, map.get("phoneNumber"));
			st.setString(14, map.get("address"));
			st.setString(15, map.get("buildingCode"));
			
			st.execute();
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
		
		System.out.println("Yay ya did it!");
   	
    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TO-DO: ERROR HANDLING ! 
		// print statements for debugging purposes :)  just to check that we're getting sent the right data
		
		String submitField = request.getParameter("submitField");
		System.out.println("submit field: " + submitField);
		
		String latitude = request.getParameter("latitude");
		System.out.println("latitude: " + latitude);

		String longitude = request.getParameter("longitude");
		System.out.println("longitude: " + longitude);

		String photoURL = request.getParameter("photoURL");
		System.out.println("photoURL: " + photoURL);

		String address = request.getParameter("address");
		System.out.println("address: " + address);

		String buildingCode = request.getParameter("buildingCode");
		System.out.println("building code: " + buildingCode);

		String outletAvailability = request.getParameter("outletsForm");
		System.out.println("outlet availability: " + outletAvailability);

		String seatingTypes = request.getParameter("seatsForm");
		System.out.println("seating types: " + seatingTypes);

		String lightingTypes = request.getParameter("lightsForm");
		System.out.println("lighting types: " + lightingTypes);

		String noiseLevel = request.getParameter("noiseForm");
		System.out.println("noise level: " + noiseLevel);

		String indoorOutdoor = request.getParameter("inOrOutForm");
		System.out.println("indoor outdoor: " + indoorOutdoor);

		String cafeAvailability = request.getParameter("cafeForm");
		System.out.println("cafe: " + cafeAvailability);

		String hourOpen = request.getParameter("hourOpenForm");
		System.out.println("hour open: " + hourOpen);

		String hourClose = request.getParameter("hourCloseForm");
		System.out.println("hour close: " + hourClose);

		String phoneNumber = request.getParameter("phoneNumber");
		System.out.println("phone number: " + phoneNumber);
		

//		MADE THIS MAP JUST IN CASE WE NEEDED TO PASS DATA AROUND :) 
		Map<String, String> dataMap = new HashMap<String, String>();
		dataMap.put("submitField", submitField);
		dataMap.put("latitude", latitude);
		dataMap.put("longitude", longitude);
		dataMap.put("photoURL", photoURL);
		dataMap.put("addreess", address);
		dataMap.put("buildingCode", buildingCode);
		dataMap.put("outletAvailability", outletAvailability);
		dataMap.put("seatingTypes", seatingTypes);
		dataMap.put("lightingTypes", lightingTypes);
		dataMap.put("noiseLevel", noiseLevel);
		dataMap.put("indoorOutdoor", indoorOutdoor);
		dataMap.put("cafeAvailability", cafeAvailability);
		dataMap.put("hourOpen", hourOpen);
		dataMap.put("hourClose", hourClose);
		dataMap.put("phoneNumber", phoneNumber);	
		
		// potential way of dealing with blank fields !! 
//		for (Map.Entry<String,String> entry : dataMap.entrySet()) {
//            String key = entry.getKey();
//            if (dataMap.get(entry.getValue()) == null) {
//            	dataMap.replace(key, "No bugs!");
//            }
//		}
		
		addToServer(dataMap);
		
		System.out.println("Got here!");
		
		try {
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		RequestDispatcher rd = request.getRequestDispatcher("index1.jsp");
		rd.forward(request, response);
		return;
	}
}

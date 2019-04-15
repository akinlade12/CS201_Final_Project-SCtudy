package main;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import main.StudySpace;

/**
 * Servlet implementation class Index
 */
@WebServlet("/Index")
public class Index extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Index() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String nextPage = "/results.jsp";
		Connection conn = null;
	    Statement st = null;
	    ResultSet rs = null;
	    ResultSet rs2 = null;
	    
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

		String outlets = request.getParameter("outletsForm");
		System.out.println("outlet availability: " + outlets);

		String seats = request.getParameter("seatsForm");
		System.out.println("seating types: " + seats);

		String lights = request.getParameter("lightsForm");
		System.out.println("lighting types: " + lights);

		String noise = request.getParameter("noiseForm");
		System.out.println("noise level: " + noise);

		String inOrOut = request.getParameter("inOrOutForm");
		System.out.println("indoor outdoor: " + inOrOut);

		String cafe = request.getParameter("cafeForm");
		System.out.println("cafe: " + cafe);

		String hoursOpen = request.getParameter("hourOpenForm");
		System.out.println("hour open: " + hoursOpen);

		String hoursClose = request.getParameter("hourCloseForm");
		System.out.println("hour close: " + hoursClose);

		String phoneNumber = request.getParameter("phoneNumber");
		System.out.println("phone number: " + phoneNumber);
		
//	    String outlets = (String) request.getParameter("outletsForm");
//	    String seats = (String) request.getParameter("seatsForm");
//	    String lights = (String) request.getParameter("lightsForm");
//	    String noise = (String) request.getParameter("noiseForm");
//	    String inOrOut = (String) request.getParameter("inOrOutForm");
//	    String cafe = (String) request.getParameter("cafeForm");
//	    String hoursOpen = (String) request.getParameter("hoursOpenForm");
//	    String hoursClose = (String) request.getParameter("hoursCloseForm");
	    String outletsReq = (String) request.getParameter("outletsBoxForm");
		System.out.println("outlets req: " + outletsReq);
	   
	    String seatsReq = (String) request.getParameter("seatsBoxForm");
		System.out.println("seats req: " + seatsReq);

	    String lightsReq = (String) request.getParameter("lightsBoxForm");
		System.out.println("lights req: " + lightsReq);

	    String noiseReq = (String) request.getParameter("noiseBoxForm");
		System.out.println("noise req: " + noiseReq);

	    String inOrOutReq = (String) request.getParameter("inOrOutBoxForm");
		System.out.println("in or out req: " + inOrOutReq);

	    String cafeReq = (String) request.getParameter("cafeBoxForm");
		System.out.println("cafe req: " + cafeReq);

	    String hoursOpenReq = (String) request.getParameter("hoursOpenBoxForm");
		System.out.println("hours open req: " + hoursOpenReq);

	    String hoursCloseReq = (String) request.getParameter("hoursCloseBoxForm");
		System.out.println("hours close req: " + hoursCloseReq);

	    Vector<StudySpace> studySpaces = new Vector<>();
	    // Following vectors' indices correspond to id of study space in database
	    // For each study space, determine if study space matches all parameters that the user submitted
	    Vector<Boolean> allParamsV = new Vector<>();
	    // For each study space, determine whether there was a required parameter that didn't match with the study space
	    Vector<Boolean> dontAddV = new Vector<>();
	    // For each study space, determine the number of parameters match with the user's search
	    Vector<Integer> numbMatches = new Vector<>();
	    try {
	    	Class.forName("com.mysql.cj.jdbc.Driver");
	        conn = DriverManager.getConnection("jdbc:mysql://localhost/Sctudy?user=root&password=bigOfor201");
	    	
	    	st = conn.createStatement();
	    	rs = st.executeQuery("SELECT * from studySpaces");
	    	while(rs.next()) {
	    		// changes to true if desired parameter is required but study space does not have parameter
	    		Boolean dontAdd = false;
	    		// changes to false if all parameters are not meant
	    		Boolean allParams = true;
	    		// if no study spaces return allParams = true then return all spaces that have the highest number of matches
	    		int numbOfParams = 0;
	            
	    		// if user did not select parameter then ignore
	            if (!seats.contains("Choose")) {
	            	// if user selected parameter does not match the study space's parameter, allParams is false
		            if(!rs.getString("seatingTypes").contains(seats)) {
		            	allParams = false;
		            	// if they dont match and it is a required parameter, then do not add study spot to vector
		            	if(seatsReq.equals("true")) {
		            		dontAdd = true;
		            	}
		            } else {
		            	numbOfParams++;
		            }
	            }
	            if (!lights.contains("Choose")) {
		            if(!rs.getString("lightSource").contains(lights)) {
		            	allParams = false;
		            	if(lightsReq.equals("true")) {
		            		dontAdd = true;
		            	}
		            } else {
		            	numbOfParams++;
		            }
	            }
	            if (!noise.contains("Choose")) {
		            if(rs.getInt("noiseLevel") != Integer.parseInt(noise)) {
		            	allParams = false;
		            	if(noiseReq.equals("true")) {
		            		dontAdd = true;
		            	}
		            } else {
		            	numbOfParams++;
		            }
	            }
	            if (!cafe.contains("Choose")) {
		            if(cafe.contains("Yes") && !rs.getBoolean("cafeAvailability")) {
		            	allParams = false;
		            	if(cafeReq.equals("true")) {
		            		dontAdd = true;
		            	}
		            } else {
		            	numbOfParams++;
		            }
	            }
	            // FIX TO FIND RANGE
	            if (!hoursOpen.contains("Choose")) {
		            if(!rs.getObject("hourOpen").equals(hoursOpen)) {
		            	allParams = false;
		            	if(hoursOpenReq.equals("true")) {
		            		dontAdd = true;
		            	}
		            } else {
		            	numbOfParams++;
		            }
	            }
	            
	            // FIX TO FIND RANGE
	            if (hoursClose.contains("Choose")) {

		            if(!rs.getObject("hourClose").equals(hoursClose)) {
		            	allParams = false;
		            	if(hoursCloseReq.equals("true")) {
		            		dontAdd = true;
		            	}
		            } else {
		            	numbOfParams++;
		            }
	            }
	            if (!inOrOut.contains("Choose")) {

		            if(!rs.getBoolean("indoorOutdoor") && inOrOut.contains("Oudoor")) {
		            	allParams = false;
		            	if(inOrOutReq.equals("true")) {
		            		dontAdd = true;
		            	}
		            } else {
		            	numbOfParams++;
		            }
	            }
	            if (!outlets.contains("Choose")) {

		            if(!rs.getString("outletAvailability").contains(outlets)) {
		            	allParams = false;
		            	if(outletsReq.equals("true")) {
		            		dontAdd = true;
		            	}
		            } else {
		            	numbOfParams++;
		            }
	            }
	            
	            numbMatches.add(numbOfParams);
	            allParamsV.add(allParams);
	            dontAddV.add(dontAdd);
	    	}
	    	
	    	Boolean completeMatch = false;
	    	// vector of studySpaceId's that will be submitted to results page
	    	Vector<Integer> studySpaceIds = new Vector<>();
	    	// first loop through allParamsV to determine if there are any study spaces that completely match with user's search
	    	for(int i = 0; i < allParamsV.size(); i++) {
	    		if(allParamsV.get(i)) {
	    			studySpaceIds.add(i + 1);
	    			// if there is a complete match, we will not loop through to determine the study space with the highest number of matches
	    			completeMatch = true;
	    		}
	    	}
	    	// variable used to get all study spaces with highest number of matched parameters
	    	int maxMatches = 0;
	    	// if there is not a study space with a complete match, loop through numbMatches vector to find study spaces with highest number of matches
	    	if(!completeMatch) {
	    		for(int i = 0; i < dontAddV.size(); i++) {
	    			// if the user's required parameter does not match with the study space, we will not add it to the study space vector 
	    			if(!dontAddV.get(i)) {
	    				if(numbMatches.get(i) > maxMatches) {
	    					maxMatches = numbMatches.get(i);
	    				}
	    			}
	    			else {
	    				
	    			}
	    		}
	    		// loop through again to add all study spaces with maxMatches
	    		for(int i = 0; i < dontAddV.size(); i++) {
	    			if(!dontAddV.get(i))
	    			if(maxMatches == numbMatches.get(i)) {
	    				//StudySpace ss = new StudySpace();
		    			studySpaceIds.add(i + 1);
	    			}
	    		}
	    	}
	    	
	    	rs2 = st.executeQuery("SELECT * from studySpaces");
	    	
	    	// loop through database again and create StudySpace objects for each id in studySpaceIds vector
	    	while(rs2.next()) {
	    		
	    		if(studySpaceIds.contains(rs2.getObject(1))) {
	    		StudySpace ss = new StudySpace((String)rs2.getObject("sName"),(double)rs2.getObject("longitude"), (double)rs2.getObject("latitude"),(String)rs2.getObject("photoURL"),
	    				(String)rs2.getObject("outletAvailability"),(String)rs2.getObject("seatingTypes"),(String)rs2.getObject("lightSource"), (int)rs2.getObject("noiseLevel"),(Boolean)rs2.getObject("indoorOutdoor"),(Boolean)rs2.getObject("cafeAvailability"), 
	    				(String)rs2.getObject("hourOpen"), (String)rs2.getObject("hourClose"),(String)rs2.getString("phoneNumber"), (String)rs2.getString("address"), (String) rs2.getString("buildingCode"), (double)rs2.getObject("rating"), (int)rs2.getObject("locationID"));
	    			studySpaces.add(ss);
	    		}
	    		
	    	}
	    	//TEST TO CHECK STUDY SPACES
	    	for (int i = 0; i < studySpaces.size(); i++) {
	    		System.out.println(i + ": " + studySpaces.get(i).getName());
	    	}
	    	
	    	// set session variable to studySpaces vector
	    	session.setAttribute("studySpaces", studySpaces);
	    	
	    } catch (SQLException sqle) {
	    	System.out.println (sqle.getMessage());
    		sqle.printStackTrace();

	    } catch (ClassNotFoundException cnfe) {
	    	System.out.println (cnfe.getMessage());
    		cnfe.printStackTrace();

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
	    		sqle.printStackTrace();
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

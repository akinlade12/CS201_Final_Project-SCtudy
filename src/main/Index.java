

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
		String nextPage = "/index.jsp";
		Connection conn = null;
	    Statement st = null;
	    ResultSet rs = null;
	    ResultSet rs2 = null;
	    String outlets = (String) request.getParameter("outletsForm");
	    String seats = (String) request.getParameter("seatsForm");
	    String lights = (String) request.getParameter("lightsForm");
	    String noise = (String) request.getParameter("noiseForm");
	    String inOrOut = (String) request.getParameter("inOrOutForm");
	    String cafe = (String) request.getParameter("cafeForm");
	    String hoursOpen = (String) request.getParameter("hoursOpenForm");
	    String hoursClose = (String) request.getParameter("hoursCloseForm");
	    String outletsReq = (String) request.getParameter("outletsBoxForm");
	    String seatsReq = (String) request.getParameter("seatsBoxForm");
	    String lightsReq = (String) request.getParameter("lightsBoxForm");
	    String noiseReq = (String) request.getParameter("noiseBoxForm");
	    String inOrOutReq = (String) request.getParameter("inOrOutBoxForm");
	    String cafeReq = (String) request.getParameter("cafeBoxForm");
	    String hoursOpenReq = (String) request.getParameter("hoursOpenBoxForm");
	    String hoursCloseReq = (String) request.getParameter("hoursCloseBoxForm");
	    Vector<StudySpace> studySpaces = new Vector<>();
	    Vector<Boolean> allParamsV = new Vector<>();
	    Vector<Boolean> dontAddV = new Vector<>();
	    Vector<Integer> numbMatches = new Vector<>();
	    try {
	    	Class.forName("com.mysql.cj.jdbc.Driver");
	        conn = DriverManager.getConnection("jdbc:mysql://localhost/Sctudy?user=root&password=Toyosi12");
	    	
	    	st = conn.createStatement();
	    	rs = st.executeQuery("SELECT * from studySpaces");
	    	while(rs.next()) {
	    		Boolean dontAdd = false;
	    		Boolean allParams = true;
	    		int numbOfParams = 0;
	            
	            if (!seats.equals("Choose...")) {
		            if(!rs.getObject(6).equals(seats)) {
		            	allParams = false;
		            	if(seatsReq.equals("true")) {
		            		dontAdd = true;
		            	}
		            } else {
		            	numbOfParams++;
		            }
	            }
	            if (!lights.equals("Choose...")) {
		            if(!rs.getObject(7).equals(lights)) {
		            	allParams = false;
		            	if(lightsReq.equals("true")) {
		            		dontAdd = true;
		            	}
		            } else {
		            	numbOfParams++;
		            }
	            }
	            if (!noise.equals("Choose...")) {

		            if(!rs.getObject(8).equals(noise)) {
		            	allParams = false;
		            	if(noiseReq.equals("true")) {
		            		dontAdd = true;
		            	}
		            } else {
		            	numbOfParams++;
		            }
	            }
	            if (!cafe.equals("Choose...")) {

		            if(!rs.getObject(9).equals(cafe)) {
		            	allParams = false;
		            	if(cafeReq.equals("true")) {
		            		dontAdd = true;
		            	}
		            } else {
		            	numbOfParams++;
		            }
	            }
	            if (!hoursOpen.equals("Choose...")) {

		            if(!rs.getObject(10).equals(hoursOpen)) {
		            	allParams = false;
		            	if(hoursOpenReq.equals("true")) {
		            		dontAdd = true;
		            	}
		            } else {
		            	numbOfParams++;
		            }
	            }
	            if (!hoursClose.equals("Choose...")) {

		            if(!rs.getObject(11).equals(hoursClose)) {
		            	allParams = false;
		            	if(hoursCloseReq.equals("true")) {
		            		dontAdd = true;
		            	}
		            } else {
		            	numbOfParams++;
		            }
	            }
	            if (!inOrOut.equals("Choose...")) {

		            if(!rs.getObject(12).equals(inOrOut)) {
		            	allParams = false;
		            	if(inOrOutReq.equals("true")) {
		            		dontAdd = true;
		            	}
		            } else {
		            	numbOfParams++;
		            }
	            }
	            if (!outlets.equals("Choose...")) {

		            if(!rs.getObject(13).equals(outlets)) {
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
	    	Vector<Integer> studySpaceIds = new Vector<>();
	    	for(int i = 0; i < allParamsV.size(); i++) {
	    		if(allParamsV.get(i)) {
	    			studySpaceIds.add(i + 1);
	    			completeMatch = true;
	    		}
	    	}
	    	int maxMatches = 0;
	    	if(!completeMatch) {
	    		for(int i = 0; i < dontAddV.size(); i++) {
	    			if(!dontAddV.get(i)) {
	    				if(numbMatches.get(i) > maxMatches) {
	    					maxMatches = numbMatches.get(i);
	    				}
	    			}
	    			else {
	    				
	    			}
	    		}
	    		for(int i = 0; i < dontAddV.size(); i++) {
	    			if(!dontAddV.get(i))
	    			if(maxMatches == numbMatches.get(i)) {
	    				//StudySpace ss = new StudySpace();
		    			studySpaceIds.add(i + 1);
	    			}
	    		}
	    	}
	    	
	    	rs2 = st.executeQuery("SELECT * from studySpaces");
	    	
	    	while(rs2.next()) {
	    		
	    		if(studySpaceIds.contains(rs2.getObject(1))) {
	    		StudySpace ss = new StudySpace((String)rs2.getObject(2),(double)rs2.getObject(5), (double)rs2.getObject(4),(String)rs2.getObject(3),
	    				(String)rs2.getObject(13),(String)rs2.getObject(6),(String)rs2.getObject(7), (int)rs2.getObject(8),(Boolean)rs2.getObject(12),(Boolean)rs2.getObject(9), 
	    				(String)rs2.getObject(10), (String)rs2.getObject(11),"not in database", "not in database", "not in database", (double)rs2.getObject(14));
	    			studySpaces.add(ss);
	    		}
	    		
	    	}
	    	
	    	session.setAttribute("studySpaces", studySpaces);
	    	
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

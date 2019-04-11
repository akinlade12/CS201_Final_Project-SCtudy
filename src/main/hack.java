package main;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mysql.cj.x.protobuf.MysqlxDatatypes.Scalar.String;

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
		
		String action = request.getParameter("action");
		if (action.equalsIgnoreCase("checkStatus")) {
			boolean loggedIn = session.getAttribute("loggedIn");
			response.getWriter().write(Boolean.toString(loggedIn));
		} else if (action.equalsIgnoreCase("signOut")) {
			
	        session.setAttribute("user", null); 
	        session.setAttribute("username", null);
	        session.setAttribute("loggedIn", false);
	        
			response.getWriter().write(Boolean.toString(false));
		} else if (action.equalsIgnoreCase("favorite")) {
			Connection conn = null;
			PreparedStatement ps = null;
			try {
				Class.forName("com.mysql.cj.jdbc.Driver"); //throws classNotFound exception 
				conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sctudy?user=root&password=rhYdgpK1998!&serverTimezone=UTC");		
				ps = conn.prepareStatement("INSERT INTO sctudy.favorites (userID, locationID) VALUES  (?, ?)");
				String userID = session.getAttribute("user");
				int loc = session.getAttribute("currentStudySpot").getLocationID;
				String locationID = Integer.toString(loc);
				ps.setString(1, userID);
				ps.setString(2, locationID);
				ps.execute();
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
package main;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class login
 */
@WebServlet("/login")
public class login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("in login.java");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); //throws classNotFound exception 
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sctudy?user=root&password=root&serverTimezone=UTC");		
			ps = conn.prepareStatement("SELECT * FROM sctudy.users WHERE username=?");
			ps.setString(1, username);
			ResultSet rs = ps.executeQuery();
			if(!rs.next()) {
				//no matching username
				response.getWriter().write("0");
			}
			String databaseP = rs.getString("uPassword");
			if (!databaseP.contentEquals(password)) {
				//okay username, check password
				response.getWriter().write("2");
			}
			else {
				//correct username and password, get user number
				Integer userNum = rs.getInt("userID");
				String about = rs.getString("about");
				
				HttpSession session=request.getSession();
		        session.setAttribute("user", userNum); 
		        session.setAttribute("username", username);
		        session.setAttribute("loggedIn", true);
		        session.setAttribute("about", about);
		        response.getWriter().write("1");

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
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

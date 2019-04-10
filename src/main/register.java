package main;


import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class register
 */
@WebServlet("/register")
public class register extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public register() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//connect to SQL
		System.out.println("in register.java");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			//FileIO fio = new FileIO(getServletContext().getRealPath("/weather.txt")); replace with json parse
			Class.forName("com.mysql.cj.jdbc.Driver"); //throws classNotFound exception 
			System.out.println("in try block");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sctudy?user=root&password=rhYdgpK1998!&serverTimezone=UTC");		
			ps = conn.prepareStatement("SELECT * FROM sctudy.users WHERE username=?");
			ps.setString(1, username);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				System.out.println("username taken");
				response.getWriter().write("0");
			}
			else {
				//okay username and password
				System.out.println("try to insert into database");
				ps = conn.prepareStatement("INSERT INTO sctudy.users (username, uPassword) VALUES (?, ?)");
				ps.setString(1, username);
				ps.setString(2,  password);
				ps.execute();
				//get user number
				ps = conn.prepareStatement("SELECT userID FROM sctudy.users WHERE username=?");
				ps.setString(1, username);
				rs = ps.executeQuery();
				rs.next();
				Integer userNum = rs.getInt("userID");
				
				System.out.println("set session variables");
				HttpSession session=request.getSession();
		        session.setAttribute("user", userNum); 
		        session.setAttribute("username", username);
		        session.setAttribute("loggedIn", true);
		        
		        response.getWriter().write("1");
		        //RequestDispatcher dispatch = getServletContext().getRequestDispatcher("/index.jsp");
		        //dispatch.forward(request, response);
		        //session.getAttribute("user") will return user number
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

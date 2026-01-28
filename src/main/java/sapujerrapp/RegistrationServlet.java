package sapujerrapp;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import model.UserDAO;

/**
 * Servlet implementation class RegistrationServlet
 */
@WebServlet("/RegistrationServlet")
public class RegistrationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    @EJB
	UserDAO dao; 
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegistrationServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("index.html");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		
		PrintWriter out = response.getWriter();
		
		out.write("<html><head><title>Registration</title></head><body>");
		
		boolean success = false;
		try {
			success = dao.registerUser(name, password, email, phone);
		}
		catch(Exception e) {
			success = false;
		}
		if(success) {
			out.write("<h1>Successfully registered your account!<h1>");
		}
		else {
			out.write("<h1>Failed to register your account.<h1>");
			out.write("<p>HELLO</p>");			
			out.write("<a href='signup.jsp'>Click here to try again.</a>");
		}
		out.write("</body></html>");
		out.close();
	}

}

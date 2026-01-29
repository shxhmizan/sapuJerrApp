package sapujerrapp;

import jakarta.ejb.EJB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import model.UserDAO;
import model.UserEntity;
import model.DriverEntity;
import model.StudentEntity;

/**
 * Servlet implementation class RegistrationServlet
 */
@WebServlet("/RegistrationServlet")
public class RegistrationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    @EJB
	private UserDAO dao; 
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
		String type = request.getParameter("type");
		
		PrintWriter out = response.getWriter();
		
		RequestDispatcher rd = request.getRequestDispatcher("signup.jsp");
		
		try {
			UserEntity user = dao.registerUser(name, password, email, phone,type);
			if(user != null) {
				if(type.equals("driver")) {
					String licenseNo = request.getParameter("licence_number");
					DriverEntity driver = dao.registerDriver(user, licenseNo);
					
					if(driver != null) {
						response.sendRedirect("login.jsp"); return;
					}
				}
				else {
					String matricNo = request.getParameter("matric_number");
					String faculty = request.getParameter("faculty");
					
					StudentEntity student = dao.registerStudent(user, matricNo, faculty);
					
					if(student != null) {
						response.sendRedirect("login.jsp"); return;
					}
				}
			}
			request.setAttribute("errmsg", "Unable to register user");
			rd.forward(request, response);
		}
		catch(Exception e) {
			System.out.println(e);
			request.setAttribute("errmsg", e + "<br>" + e.getMessage());
			rd.forward(request, response);
		}
	}

}

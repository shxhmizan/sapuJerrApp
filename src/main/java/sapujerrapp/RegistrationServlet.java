package sapujerrapp;

import jakarta.ejb.EJB;
import jakarta.persistence.EntityExistsException;
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
import model.DriverDAO;
import model.DriverEntity;
import model.StudentDAO;
import model.StudentEntity;

/**
 * Servlet implementation class RegistrationServlet
 */
@WebServlet("/RegistrationServlet")
public class RegistrationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    @EJB
	private UserDAO dao; 
    
    @EJB
    private DriverDAO driverDao;
    
    @EJB
    private StudentDAO studentDao;
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
		response.sendRedirect(App.Pages.Index.link);
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
		
		String licenseNo = request.getParameter("licence_number");
		
		String matricNo = request.getParameter("matric_number");
		String faculty = request.getParameter("faculty");
		
		FormValidator formValidator = new FormValidator();
		
		formValidator.require(name, "User Name")
		.require(password, "Password")
		.require(email,"Email")
		.require(phone,"Phone Number")
		.numericField(phone, "Phone Number")
		.require(type,"User Type");
		
		if(type.equals("driver")) {
			formValidator.require(licenseNo, "License Number");
		}
		
		else if(type.equals("student")) {
			formValidator.require(matricNo, "Matric Number")
			.require(faculty, "Faculty");
		}
		else {
			formValidator.addErrorMessage("User type is invalid.");
		}
		
		if(!formValidator.validate()) {
			formValidator.redirectWithErrors(request, response, App.Pages.Registration.link);
			return;
		}
		HttpSession session = request.getSession();

		try {
			UserEntity user = dao.registerUser(name, password, email, phone,type);
			if(user != null) {
				if(type.equals("driver")) {
					DriverEntity driver = driverDao.registerDriver(user, licenseNo);
					
					if(driver != null) {
						App.setFlashMessage(session, "Registration successful, please login.");
						response.sendRedirect(App.Pages.Login.link); return;
					}
				}
				else {
					StudentEntity student = studentDao.registerStudent(user, matricNo, faculty);
					
					if(student != null) {
						App.setFlashMessage(session, "Registration successful, please login.");
						response.sendRedirect(App.Pages.Login.link); return;
					}
				}
			}
			App.setFlashMessage(session, "System failed to register user, registration aborted.");
		}
		catch(EntityExistsException ee) {
			App.setFlashMessage(session, "Duplicate credentials found, please try a different username or email address.");
		}
		catch(Exception e) {
			System.out.println(e);
			App.setFlashMessage(session, "System encountered exception while registering user, registration aborted.");
		}
		response.sendRedirect(App.Pages.Registration.link);
	}

}

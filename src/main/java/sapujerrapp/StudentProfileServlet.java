package sapujerrapp;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.DriverDAO;
import model.DriverEntity;
import model.StudentDAO;
import model.StudentEntity;
import model.UserDAO;
import model.UserEntity;

import java.io.IOException;

/**
 * Servlet implementation class StudentProfileServlet
 */
@WebServlet("/StudentProfileServlet")
public class StudentProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	@EJB
	UserDAO dao;
	
	@EJB
	StudentDAO studentDao;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StudentProfileServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserEntity user = App.getUser(request.getSession(), dao);
		StudentEntity student = studentDao.getStudentData(user);
		request.setAttribute("student", student);
		request.getRequestDispatcher(App.Pages.StudentProfileJSP.link).forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String matricNo = request.getParameter("matric_number");
		String faculty = request.getParameter("faculty");
		String password = request.getParameter("password");
		String passwordConfirm = request.getParameter("password_confirm");
		
		FormValidator formValidator = new FormValidator();
		formValidator.require(name, "Name")
		.require("email", "Email")
		.require(phone, "Phone Number")
		.require(matricNo, "Matric Number")
		.require(faculty, "Faculty")
		;
		
		String newPass = null;
		String newPassConfirm = null;
		if(password != null && password.trim().length() > 0) {
			newPass = password.trim();
		}
		if(passwordConfirm != null && passwordConfirm.trim().length() > 0) {
			newPassConfirm = password.trim();
		}
		if(newPass != null && newPassConfirm != null && ! newPass.equals(newPassConfirm)) {
			formValidator.addErrorMessage("New passwords do not match.");
		}
		if(formValidator.isInvalid()) {
			formValidator.redirectWithErrors(request, response, App.Pages.DriverProfileJSP.link);
			return;
		}
		UserEntity user = App.getUser(request.getSession(), dao);
		StudentEntity student = studentDao.getStudentData(user);
		
		if(! dao.updateUser(user,name,email,phone,newPass) || ! studentDao.updateStudent(student,matricNo,faculty)) {
			App.setFlashMessage(request.getSession(), "Error while updating your profile");
		}
		
		user = App.getUser(request.getSession(), dao);
		student = studentDao.getStudentData(user);
		
		request.setAttribute("student", student);
		request.getRequestDispatcher(App.Pages.StudentProfileJSP.link).forward(request, response);
	}

}

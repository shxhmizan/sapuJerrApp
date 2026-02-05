package sapujerrapp;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.DriverDAO;
import model.DriverEntity;
import model.UserDAO;
import model.UserEntity;

import java.io.IOException;

/**
 * Servlet implementation class DriverProfileServlet
 */
@WebServlet("/DriverProfileServlet")
public class DriverProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@EJB
	UserDAO dao;
	
	@EJB
	DriverDAO driverDao;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DriverProfileServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserEntity user = App.getUser(request.getSession(), dao);
		DriverEntity driver = driverDao.getDriverData(user);
		request.setAttribute("driver", driver);
		request.getRequestDispatcher(App.Pages.DriverProfileJSP.link).forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String licenseNo = request.getParameter("license_number");
		String password = request.getParameter("password");
		String passwordConfirm = request.getParameter("password_confirm");
		
		FormValidator formValidator = new FormValidator();
		formValidator.require(name, "Name")
		.require("email", "Email")
		.require(phone, "Phone Number")
		.require(licenseNo, "License Number");
		
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
		DriverEntity driver = driverDao.getDriverData(user);
		
		if(! dao.updateUser(user,name,email,phone,newPass) || ! driverDao.updateDriver(driver,licenseNo)) {
			App.setFlashMessage(request.getSession(), "Error while updating your profile");
		}
		
		user = App.getUser(request.getSession(), dao);
		driver = driverDao.getDriverData(user);
		
		request.setAttribute("driver", driver);
		request.getRequestDispatcher(App.Pages.DriverProfileJSP.link).forward(request, response);
	}

}

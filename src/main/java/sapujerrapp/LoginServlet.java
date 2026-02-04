package sapujerrapp;

import jakarta.ejb.EJB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.UserDAO;
import model.UserEntity;

import java.io.IOException;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	@EJB
	private UserDAO dao; 
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(App.userLoggedIn(request.getSession())){
			UserEntity user = App.getUser(request.getSession(), dao);
			if(user.getUserType().equals(UserEntity.UserType.student)) {
				response.sendRedirect(App.Pages.StudentDashboard.link);
				return;
			}
			else if(user.getUserType().equals(UserEntity.UserType.driver)) {
				response.sendRedirect(App.Pages.DriverDashboard.link);
				return;
			}
		}
		response.sendRedirect(App.Pages.Login.link);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		FormValidator formValidator = new FormValidator();
		
		boolean formValid = formValidator.require(username, "User Name")
		.require(password, "Password")
		.validate();
		
		if(!formValid) {
			formValidator.redirectWithErrors(request, response, App.Pages.Login.link);
			return;
		}
		
		HttpSession session = request.getSession();
		try {
			UserEntity user = dao.loginUser(username, password);
			if(user != null) {
				App.setUser(session, user);
				response.sendRedirect(App.Pages.Splash.link);
				/*if(user.getUserType().equals(UserEntity.UserType.student))
					response.sendRedirect(App.Pages.StudentDashboard.link);
				else response.sendRedirect(App.Pages.DriverDashboard.link);
				*/
			}
			else {
				App.setFlashMessage(session, "Invalid username or password.");
				response.sendRedirect(App.Pages.Login.link);
			}
		}
		catch(Exception e) {
			System.out.print(e);
			App.setFlashMessage(session, "Sorry, an error occured. please try again.");
			response.sendRedirect(App.Pages.Login.link);
		}
	}

}

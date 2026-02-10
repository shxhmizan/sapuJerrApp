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
import java.util.List;

/**
 * Servlet implementation class DriverDashboardServlet
 */
@WebServlet("/DriverDashboardServlet")
public class DriverDashboardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	@EJB
	UserDAO dao;
	
	@EJB
	DriverDAO driverDao;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DriverDashboardServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserEntity user = App.getUser(request.getSession(), dao);
		DriverEntity driver = driverDao.getDriverData(user);
		
		List<Integer> stats = driverDao.getDriverStats(driver);
		request.setAttribute("stats", stats);
		request.getRequestDispatcher(App.Pages.DriverDashboardJSP.link).forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

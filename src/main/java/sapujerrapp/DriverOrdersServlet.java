package sapujerrapp;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.BookingDAO;
import model.BookingEntity;
import model.DriverDAO;
import model.DriverEntity;
import model.UserDAO;
import model.UserEntity;

import java.io.IOException;
import java.util.List;

/**
 * Servlet implementation class DriverOrdersServlet
 */
@WebServlet("/DriverOrdersServlet")
public class DriverOrdersServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	@EJB
	UserDAO dao;
	
	@EJB
	DriverDAO driverDao;
	
	@EJB
	BookingDAO bookingDao;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DriverOrdersServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserEntity user = App.getUser(request.getSession(), dao);
		DriverEntity driver = driverDao.getDriverData(user);
		
		List<BookingEntity> bookings = bookingDao.getUserBookingsWithStatus(user, BookingEntity.BookingStatus.ACCEPTED);
		request.setAttribute("bookings", bookings);
		request.setAttribute("driver", driver);
		request.getRequestDispatcher(App.Pages.DriverOrdersJSP.link).forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request,response);
	}

}

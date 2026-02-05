package sapujerrapp;

import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.BookingDAO;
import model.BookingEntity;
import model.StudentDAO;
import model.StudentEntity;
import model.UserDAO;
import model.UserEntity;

import java.io.IOException;
import java.util.List;

/**
 * Servlet implementation class StudentBookingHistoryServlet
 */
@Stateless
@WebServlet("/StudentBookingHistoryServlet")
public class StudentBookingHistoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	@EJB
	UserDAO userDao;
	
	@EJB
	BookingDAO bookingDao;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StudentBookingHistoryServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if(! App.userLoggedIn(session)) {
			response.sendRedirect(App.Pages.Login.link);
			return;
		}
		
		UserEntity user = App.getUser(session, userDao);
		
		if(! user.getUserType().equals(UserEntity.UserType.student)) {
			response.sendRedirect(App.Pages.DriverDashboard.link);
			return;
		}
		try {
			List<BookingEntity> bookings = bookingDao.getUserBookingsWithStatus(user,BookingEntity.BookingStatus.COMPLETED,BookingEntity.BookingStatus.CANCELLED);
			
			request.setAttribute("bookings", bookings);
			request.getRequestDispatcher(App.Pages.StudentBookingHistoryJSP.link).forward(request, response);
			return;
		}
		catch(Exception e) {
			System.out.println(e);
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
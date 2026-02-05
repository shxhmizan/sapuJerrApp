package sapujerrapp;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.BookingEntity;
import model.NotificationDAO;
import model.NotificationEntity;
import model.UserDAO;
import model.UserEntity;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Servlet implementation class NotificationServlet
 */
@WebServlet("/NotificationServlet")
public class NotificationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@EJB
	UserDAO userDao;
	
	@EJB
	NotificationDAO notiDao;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NotificationServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserEntity user = App.getUser(request.getSession(),userDao);
		
		List<NotificationEntity> notifications = notiDao.getDriverBookingNotifications(user);
		ArrayList<NotificationEntity> newReq = new ArrayList<>();
    	ArrayList<NotificationEntity> cancelled = new ArrayList<>();
    	ArrayList<NotificationEntity> other = new ArrayList<>();
    	
    	if(notifications != null) notifications.forEach( (NotificationEntity n)->{
    		switch(n.getBooking().getStatus()) {
    			case BookingEntity.BookingStatus.UPCOMING:
    				newReq.add(n);
    				break;
    			case BookingEntity.BookingStatus.CANCELLED:
    				cancelled.add(n);
    				break;
    			default:
    				other.add(n);
    		}
    	});
		
		request.setAttribute("notifications", other);
		request.setAttribute("new", newReq);
		request.setAttribute("cancelled", cancelled);
		request.getRequestDispatcher(App.Pages.DriverNotificationsJSP.link).forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
